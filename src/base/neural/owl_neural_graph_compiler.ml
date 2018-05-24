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
  

  let compile network input_shape loss_fun =
    let x = Lazy.var_arr ~name:"x" input_shape |> pack_arr in

    Graph.init network;
    Graph.mkpar network
    |> Owl_utils.aarr_map (fun v -> Lazy.var_arr ~name: "" (unpack_arr v |> Lazy.shape) |> pack_arr)
    |> Graph.update network;

    (* derive the computation graph in reverse mode *)
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


end
