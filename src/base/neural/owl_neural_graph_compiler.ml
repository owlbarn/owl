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
  module Computation_Optimiser = Owl_computation_optimiser.Make (Lazy)

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


  (** Shallow compilation functions, includes only gradient *)


  let compile_shallow (params : Graph.Optimise.Params.typ) network full_size =
    (* extract configurations of a network *)
    let loss_fun = Loss.run params.loss in

    (* infer input shape from batch size and network shape *)
    let batch = match params.batch with
      | Full       -> full_size
      | Mini n     -> n
      | Sample n   -> n
      | Stochastic -> 1
    in
    let network_shape = Graph.input_shape network in
    let input_shape = Array.append [|batch|] network_shape in

    (* initialise the network weight *)
    Graph.init network;
    Graph.mkpar network
    |> Owl_utils.aarr_map (fun v ->
      let v = Algodiff.unpack_arr v in
      Lazy.eval_arr [| v |];
      let u = Lazy.var_arr ~name: "" (Lazy.shape v) in
      Lazy.(assign_arr u (unpack_arr v));
      Algodiff.pack_arr u
    )
    |> Graph.update network;

    (* derive the computation graph in forward mode *)
    let x = Lazy.var_arr ~name:"x" input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Lazy.shape in
    let y = Lazy.var_arr ~name:"y" output_shape |> pack_arr in

    let loss = loss_fun y y' in
    let loss = Maths.(loss / (_f (Mat.row_num y |> float_of_int))) in

    (* derive the computation graph in reverse mode *)
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

    (* freeze the graph *)
    let a0 = [| unpack_elt loss |> Lazy.elt_to_node |] in
    let a1 = Array.map (fun v -> unpack_arr v |> Lazy.arr_to_node) pri in
    let a2 = Array.map (fun v -> unpack_arr v |> Lazy.arr_to_node) adj in
    let a3 = Owl_utils_array.(a0 @ a1 @ a2) in
    (* FIXME: experimental *)
    Lazy.freeze_ancestors a3;

    (* return key parameters *)
    x, y, pri, adj, loss


  let make_eval_shallow xt yt ws gs' loss =
    let xt = Algodiff.unpack_arr xt in
    let yt = Algodiff.unpack_arr yt in

    let _eval xt' yt' =
      let xt' = Algodiff.unpack_arr xt' in
      let yt' = Algodiff.unpack_arr yt' in
      Lazy.eval_arr [|xt'; yt'|];
      let xt' = Lazy.unpack_arr xt' in
      let yt' = Lazy.unpack_arr yt' in
      Lazy.assign_arr xt xt';
      Lazy.assign_arr yt yt';
      Lazy.eval_arr (Array.map Algodiff.unpack_arr gs');
      loss, ws, gs'
    in
    _eval


  let make_update_shallow ws =
    let ws = Array.map Algodiff.unpack_arr ws in

    let _update ws' =
      Array.iter2 (fun u v ->
        Algodiff.unpack_arr v |> Lazy.unpack_arr |> Lazy.assign_arr u
      ) ws ws'
    in
    _update


  let train_shallow ?state ?params network x y =
    let params = match params with
      | Some p -> p
      | None   -> Graph.Optimise.Params.default ()
    in
    let x_size = (unpack_arr x |> Lazy.shape).(0) in
    let xt, yt, pri, adj, loss = compile_shallow params network x_size in
    let eval = make_eval_shallow xt yt pri adj loss in
    let update = make_update_shallow in
    let save fname = () in

    (* FIXME: for debug purpose *)
    let cgraph = Owl_utils_array.([|Algodiff.unpack_elt loss |> Lazy.elt_to_node|] @
      (adj |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node))) in
    let name = Neural.Graph.get_network_name network in
    let dot_raw = Lazy.to_dot cgraph in
    (* FIXME: experimental *)
    Computation_Optimiser.run cgraph;

    let dot_opt = Lazy.to_dot cgraph in
    Owl_io.write_file (name ^ "_raw.dot") dot_raw;
    Owl_io.write_file (name ^ "_opt.dot") dot_opt;

    Graph.Optimise.minimise_graph ?state params eval update save x y


  (** Deep compilation functions, includes gs, us, ps, ch, and new weights *)

  let compile_deep (params : Graph.Optimise.Params.typ) network full_size =
    (* extract configurations of a network *)

    let loss_fun = Loss.run params.loss in
    let grad_fun = Gradient.run params.gradient in
    let rate_fun = Learning_Rate.run params.learning_rate in
    let regl_fun = Regularisation.run params.regularisation in
    let momt_fun = Momentum.run params.momentum in
    let upch_fun = Learning_Rate.update_ch params.learning_rate in
    let clip_fun = Clipping.run params.clipping in

    (* infer input shape from batch size and network shape *)

    let batch = match params.batch with
      | Full       -> full_size
      | Mini n     -> n
      | Sample n   -> n
      | Stochastic -> 1
    in
    let network_shape = Graph.input_shape network in
    let input_shape = Array.append [|batch|] network_shape in

    (* initialise the network weight *)

    Graph.init network;
    Graph.mkpar network
    |> Owl_utils.aarr_map (fun v ->
      let v = Algodiff.unpack_arr v in
      Lazy.eval_arr [| v |];
      let u = Lazy.var_arr ~name: "" (Lazy.shape v) in
      Lazy.(assign_arr u (unpack_arr v));
      Algodiff.pack_arr u
    )
    |> Graph.update network;

    (* derive the computation graph in forward mode *)

    let x = Lazy.var_arr ~name:"x" input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Lazy.shape in
    let y = Lazy.var_arr ~name:"y" output_shape |> pack_arr in

    let loss = loss_fun y y' in
    let loss = Maths.(loss / (_f (Mat.row_num y |> float_of_int))) in
    (* add regularisation term if necessary *)
    let ws = Owl_utils_array.flatten (Graph.mkpri network) in
    let reg = match params.regularisation <> Regularisation.None with
      | true  -> Array.fold_left (fun a w -> Maths.(a + regl_fun w)) (_f 0.) ws
      | false -> _f 0.
    in
    let loss = Maths.(loss + reg) in
    (* assign loss variable name *)
    Owl_graph.set_name (unpack_elt loss |> Lazy.elt_to_node) "loss";

    (* derive the computation graph in reverse mode *)

    let z = Graph.(backward network loss) in
    let pri = Owl_utils_array.flatten (fst z) in
    let adj = Owl_utils_array.flatten (snd z) in

    (* assign input/output variable names *)

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "x%i" i in
      Owl_graph.set_name b s
    ) pri;

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "x%i'" i in
      Owl_graph.set_name b s
    ) adj;

    let ws, gs' = pri, adj in

    (* allocate variables for optimisation engine *)

    let gs = Array.mapi (fun i w ->
      let name = Printf.sprintf "gs%i" i in
      let shape = Lazy.shape (unpack_arr w) in
      Lazy.var_arr ~name shape |> pack_arr
    ) ws
    in

    let ps = Array.mapi (fun i w ->
      let name = Printf.sprintf "ps%i" i in
      let shape = Lazy.shape (unpack_arr w) in
      Lazy.var_arr ~name shape |> pack_arr
    ) ws
    in

    let us = Array.mapi (fun i w ->
      let name = Printf.sprintf "us%i" i in
      let shape = Lazy.shape (unpack_arr w) in
      Lazy.var_arr ~name shape |> pack_arr
    ) ws
    in

    let ch = Array.mapi (fun i w ->
      let name1 = Printf.sprintf "cha%i" i in
      let name2 = Printf.sprintf "chb%i" i in
      let shape = Lazy.shape (unpack_arr w) in
      let ch1 = Lazy.var_arr ~name:name1 shape |> pack_arr in
      let ch2 = Lazy.var_arr ~name:name2 shape |> pack_arr in
      [|ch1; ch2|]
    ) ws
    in

    (* calculate the new weights of the network *)

    (* clip the gradient if necessary *)
    let gs' = Array.map clip_fun gs' in
    (* calculate gradient descent *)
    let ps' = Checkpoint.(Owl_utils_array.map4 (grad_fun (fun a -> a)) ws gs ps gs') in
    (* update gcache if necessary *)
    let ch' = Owl_utils_array.map2 upch_fun gs' ch in
    (* adjust direction based on learning_rate *)
    let us' = Checkpoint.(
      Owl_utils_array.map3 (fun p' g' c ->
        (* FIXME: 999 is just place holder *)
        Maths.(p' * rate_fun 999 g' c)
      ) ps' gs' ch'
    )
    in
    (* adjust direction based on momentum *)
    let us' = Owl_utils_array.map2 momt_fun us us' in
    (* update the weight *)
    let ws' = Owl_utils_array.map2 (fun w u -> Maths.(w + u)) ws us' in

    (* assign output variable names *)

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "ws'%i" i in
      Owl_graph.set_name b s
    ) ws';

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "ps'%i" i in
      Owl_graph.set_name b s
    ) ps';

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Lazy.arr_to_node in
      let s = Printf.sprintf "us'%i" i in
      Owl_graph.set_name b s
    ) us';

    Array.iteri (fun i a ->
      let c0 = unpack_arr a.(0) |> Lazy.arr_to_node in
      let c1 = unpack_arr a.(1) |> Lazy.arr_to_node in
      let s0 = Printf.sprintf "cha'%i" i in
      let s1 = Printf.sprintf "chb'%i" i in
      Owl_graph.set_name c0 s0;
      Owl_graph.set_name c1 s1;
    ) ch';

    (* remove unused intermediate nodes *)

    let ch, ch' = Owl_utils_array.(flatten ch, flatten ch') in
    let gs, gs' = Owl_utils_array.filter2_split (fun g g' -> unpack_arr g |> Lazy.arr_to_node |> Owl_graph.degree <> 0) gs gs' in
    let ps, ps' = Owl_utils_array.filter2_split (fun p p' -> unpack_arr p |> Lazy.arr_to_node |> Owl_graph.degree <> 0) ps ps' in
    let us, us' = Owl_utils_array.filter2_split (fun u u' -> unpack_arr u |> Lazy.arr_to_node |> Owl_graph.degree <> 0) us us' in
    let ch, ch' = Owl_utils_array.filter2_split (fun c c' -> unpack_arr c |> Lazy.arr_to_node |> Owl_graph.degree <> 0) ch ch' in

    (* do not allow reusing memory to avoid re-evaluation *)

    Array.iter (fun g -> unpack_arr g |> Lazy.arr_to_node |> (fun x -> Lazy.set_reuse x false)) gs';
    Array.iter (fun p -> unpack_arr p |> Lazy.arr_to_node |> (fun x -> Lazy.set_reuse x false)) ps';
    Array.iter (fun u -> unpack_arr u |> Lazy.arr_to_node |> (fun x -> Lazy.set_reuse x false)) us';
    Array.iter (fun c -> unpack_arr c |> Lazy.arr_to_node |> (fun x -> Lazy.set_reuse x false)) ch';

    (* initialise values of remaining variables *)

    Array.iter (fun g ->
      let g = Algodiff.unpack_arr g in
      let shape = Lazy.shape g in
      Lazy.assign_arr g (A.zeros shape)
    ) gs;

    Array.iter (fun p ->
      let p = Algodiff.unpack_arr p in
      let shape = Lazy.shape p in
      Lazy.assign_arr p (A.zeros shape)
    ) ps;

    Array.iter (fun u ->
      let u = Algodiff.unpack_arr u in
      let shape = Lazy.shape u in
      Lazy.assign_arr u (A.zeros shape)
    ) us;

    Array.iter (fun c ->
      let c = Algodiff.unpack_arr c in
      let shape = Lazy.shape c in
      Lazy.assign_arr c (A.zeros shape)
    ) ch;

    (* freeze the graph *)

    let a0 = [| unpack_elt loss |> Lazy.elt_to_node |] in
    let a1 = Array.map (fun v -> unpack_arr v |> Lazy.arr_to_node) ws' in
    let a2 = Array.map (fun v -> unpack_arr v |> Lazy.arr_to_node) gs' in
    let a3 = Array.map (fun v -> unpack_arr v |> Lazy.arr_to_node) ps' in
    let a4 = Array.map (fun v -> unpack_arr v |> Lazy.arr_to_node) us' in
    let a5 = Owl_utils_array.(a0 @ a1 @ a2 @ a3 @ a4) in
    Lazy.freeze_ancestors a5;

    (* return key parameters *)

    loss, x, y, ws, gs, ps, us, ch, ws', gs', ps', us', ch'


  let make_eval_fun loss xt yt ws gs ps us ch ws' gs' ps' us' ch' =
    let xt = Algodiff.unpack_arr xt in
    let yt = Algodiff.unpack_arr yt in
    let ws' = Array.map Algodiff.unpack_arr ws' in
    let gs' = Array.map Algodiff.unpack_arr gs' in
    let ps' = Array.map Algodiff.unpack_arr ps' in
    let us' = Array.map Algodiff.unpack_arr us' in
    let ch' = Array.map Algodiff.unpack_arr ch' in
    let all = Owl_utils_array.(ws' @ gs' @ ps' @ us' @ ch') in

    let _eval xt' yt' =
      let xt' = Algodiff.unpack_arr xt' in
      let yt' = Algodiff.unpack_arr yt' in
      Lazy.eval_arr [|xt'; yt'|];
      let xt' = Lazy.unpack_arr xt' in
      let yt' = Lazy.unpack_arr yt' in
      Lazy.assign_arr xt xt';
      Lazy.assign_arr yt yt';
      Lazy.eval_arr all;
      loss
    in
    _eval


  let make_update_fun ws gs ps us ch ws' gs' ps' us' ch' =
    let ws = Array.map Algodiff.unpack_arr ws in
    let gs = Array.map Algodiff.unpack_arr gs in
    let ps = Array.map Algodiff.unpack_arr ps in
    let us = Array.map Algodiff.unpack_arr us in
    let ch = Array.map Algodiff.unpack_arr ch in
    let al = Owl_utils_array.(ws @ gs @ ps @ us @ ch) in

    let ws' = Array.map Algodiff.unpack_arr ws' in
    let gs' = Array.map Algodiff.unpack_arr gs' in
    let ps' = Array.map Algodiff.unpack_arr ps' in
    let us' = Array.map Algodiff.unpack_arr us' in
    let ch' = Array.map Algodiff.unpack_arr ch' in
    let al' = Owl_utils_array.(ws' @ gs' @ ps' @ us' @ ch') in

    let _update () =
      Array.iter2 (fun u v -> Lazy.assign_arr u (Lazy.unpack_arr v)) al al'
    in
    _update


  let train ?state ?params network x y =
    let params = match params with
      | Some p -> p
      | None   -> Graph.Optimise.Params.default ()
    in

    (* compile network into static graph *)
    let network_name = Neural.Graph.get_network_name network in
    Owl_log.info "compile network %s into static graph ..." network_name;
    let x_size = (unpack_arr x |> Lazy.shape).(0) in
    let loss, xt, yt, ws, gs, ps, us, ch, ws', gs', ps', us', ch' = compile_deep params network x_size in
    let eval = make_eval_fun loss xt yt ws gs ps us ch ws' gs' ps' us' ch' in
    let update = make_update_fun ws gs ps us ch ws' gs' ps' us' ch' in
    let save fname = () in

    (* Experimental: optimise graph structure *)
    Owl_log.info "optimise %s graph structure ..." network_name;
    let cgraph =
      Owl_utils_array.([|Algodiff.unpack_elt loss |> Lazy.elt_to_node|] @
      (ws' |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (gs' |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (ps' |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (us' |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (ch' |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (ws  |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (gs  |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (ps  |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (us  |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node)) @
      (ch  |> map (fun u -> Algodiff.unpack_arr u |> Lazy.arr_to_node))
      )
    in
    let name = Graph.get_network_name network in
    let dot_raw = Lazy.to_dot cgraph in

    Computation_Optimiser.run cgraph;

    let dot_opt = Lazy.to_dot cgraph in
    Owl_io.write_file (name ^ "_raw.dot") dot_raw;
    Owl_io.write_file (name ^ "_opt.dot") dot_opt;

    Owl_log.info "start training %s ..." network_name;
    Graph.Optimise.minimise_compiled_network ?state params eval update save x y


end

(* Make functor ends *)
