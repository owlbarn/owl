(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make
  (A : Ndarray_Mutable)
  = struct

  module Lazy = Owl_lazyy.Make (A)
  module Algodiff = Owl_algodiff_generic.Make (Lazy)
  module Neural = Owl_neural_generic.Make (Lazy)

  open Algodiff
  open Neural


  let compile_simple network input_shape loss_fun =
    Graph.init network;
    Graph.mkpar network
    |> Owl_utils.aarr_map (fun v -> Lazy.var_arr ~name: "" (unpack_arr v |> Lazy.shape) |> pack_arr)
    |> Graph.update network;

    (* derive the computation graph in reverse mode *)
    let x = Lazy.var_arr ~name:"x" input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Lazy.shape in
    let y = Lazy.var_arr ~name:"y" output_shape |> pack_arr in
    let loss = loss_fun y y' in
    let z = Graph.(backward network loss) in
    let pri = Owl_utils_array.flatten (fst z) in
    let adj = Owl_utils_array.flatten (snd z) in

    (* assign loss variable name *)
    Owl_graph.set_name (unpack_elt loss |> Lazy.elt_to_node) "loss";

    (* assign input variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "x%i" i in
      Owl_graph.set_name b s
    ) pri;

    (* assign output variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "x%i'" i in
      Owl_graph.set_name b s
    ) adj;

    let xt = unpack_arr x in
    let yt = unpack_arr y in
    let pri = Array.map unpack_arr pri in
    let adj = Array.map unpack_arr adj in
    xt, yt, pri, adj


  let compile (params : Graph.Optimise.Params.typ) network data =
    (* extract configurations of a network *)
    let loss_fun = Loss.run params.loss in

    (* infer input shape from batch size and network shape *)
    let batch = match params.batch with
      | Full       -> (Lazy.shape data).(0)
      | Mini n     -> n
      | Sample n   -> n
      | Stochastic -> 1
    in
    let network_shape = Graph.input_shape network in
    let input_shape = Array.append [|batch|] network_shape in

    Graph.init network;
    Graph.mkpar network
    |> Owl_utils.aarr_map (fun v ->
      let v = Algodiff.unpack_arr v in
      Lazy.eval_arr [| v |];
      let u = Lazy.var_arr ~name: "" (Lazy.shape v) in
      Lazy.(assign_arr u (unpack_arr v));
      pack_arr u
    )
    |> Graph.update network;

    (* derive the computation graph in reverse mode *)
    let x = Lazy.var_arr ~name:"x" input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Lazy.shape in
    let y = Lazy.var_arr ~name:"y" output_shape |> pack_arr in

    let loss = loss_fun y y' in
    let loss = Maths.(loss / (_f (Mat.row_num y |> float_of_int))) in

    let z = Graph.(backward network loss) in
    let pri = Owl_utils_array.flatten (fst z) in
    let adj = Owl_utils_array.flatten (snd z) in

    (* assign loss variable name *)
    Owl_graph.set_name (unpack_elt loss |> Lazy.elt_to_node) "loss";

    (* assign input variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "x%i" i in
      Owl_graph.set_name b s
    ) pri;

    (* assign output variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "x%i'" i in
      Owl_graph.set_name b s
    ) adj;

    x, y, pri, adj, loss


  let make_eval_fun xt yt pri adj loss xt_new yt_new =
    let xt_new = Algodiff.unpack_arr xt_new in
    let yt_new = Algodiff.unpack_arr yt_new in
    Lazy.eval_arr [|xt_new; yt_new|];
    let xt_new = Lazy.unpack_arr xt_new in
    let yt_new = Lazy.unpack_arr yt_new in
    Lazy.assign_arr (Algodiff.unpack_arr xt) xt_new;
    Lazy.assign_arr (Algodiff.unpack_arr yt) yt_new;
    Lazy.eval_arr (Array.map Algodiff.unpack_arr adj);
    loss, pri, adj


  let make_update_fun pri adj =
    Array.iter2 (fun u v ->
      let u = Algodiff.unpack_arr u in
      let v = Algodiff.unpack_arr v |> Lazy.unpack_arr in
      Lazy.assign_arr u v
    ) pri adj


  let train ?state ?params network x y =
    let params = match params with
      | Some p -> p
      | None   -> Graph.Optimise.Params.default ()
    in
    let xt, yt, pri, adj, loss = compile params network (Algodiff.unpack_arr x) in
    let eval = make_eval_fun xt yt pri adj loss in
    let update = make_update_fun in
    let save fname = () in

    let s = Lazy.to_dot Owl_utils_array.([|Algodiff.unpack_elt loss |> Lazy.elt_to_node|] @ (adj |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node))) in
    Owl_io.write_file "zzz.dot" s;

    Graph.Optimise.minimise_graph ?state params eval update save x y


end
