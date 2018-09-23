(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make
  (E : Owl_types_computation_engine.Sig)
  = struct

  module Engine = Owl_computation_engine.Flatten (E)
  module Neural = Owl_neural_generic.Make (Engine)

  open Neural
  open Algodiff


  (** Naive compilation functions, need to pass in loss function *)

  let compile_simple network input_shape loss_fun =
    Graph.init network;
    Graph.mkpar network
    |> Owl_utils.aarr_map (fun v -> Engine.var_arr "" ~shape:(unpack_arr v |> Engine.shape) |> pack_arr)
    |> Graph.update network;

    (* derive the computation graph in reverse mode *)
    let x = Engine.var_arr "x" ~shape:input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Engine.shape in
    let y = Engine.var_arr "y" ~shape:output_shape |> pack_arr in
    let loss = loss_fun y y' in
    let z = Graph.(backward network loss) in
    let pri = Owl_utils_array.flatten (fst z) in
    let adj = Owl_utils_array.flatten (snd z) in

    (* assign loss variable name *)
    Owl_graph.set_name (unpack_elt loss |> Engine.elt_to_node) "loss";

    (* assign input variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "x%i" i in
      Owl_graph.set_name b s
    ) pri;

    (* assign output variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "x%i'" i in
      Owl_graph.set_name b s
    ) adj;

    let xt = unpack_arr x in
    let yt = unpack_arr y in
    let pri = Array.map unpack_arr pri in
    let adj = Array.map unpack_arr adj in
    xt, yt, pri, adj


  (** Shallow compilation functions, includes only gradient *)

  let compile_shallow (params : Params.typ) network full_size =
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
      Engine.eval_arr [| v |];
      let u = Engine.var_arr "" ~shape:(Engine.shape v) in
      Engine.(assign_arr u (unpack_arr v));
      Algodiff.pack_arr u
    )
    |> Graph.update network;

    (* derive the computation graph in forward mode *)
    let x = Engine.var_arr "x" ~shape:input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Engine.shape in
    let y = Engine.var_arr "y" ~shape:output_shape |> pack_arr in

    let loss = loss_fun y y' in
    let loss = Maths.(loss / (_f (Mat.row_num y |> float_of_int))) in

    (* derive the computation graph in reverse mode *)
    let z = Graph.(backward network loss) in
    let pri = Owl_utils_array.flatten (fst z) in
    let adj = Owl_utils_array.flatten (snd z) in

    (* assign loss variable name *)
    Owl_graph.set_name (unpack_elt loss |> Engine.elt_to_node) "loss";

    (* assign input variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "x%i" i in
      Owl_graph.set_name b s
    ) pri;

    (* assign output variable names *)
    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "x%i'" i in
      Owl_graph.set_name b s
    ) adj;

    (* freeze the graph *)
    let a0 = [| unpack_elt loss |> Engine.elt_to_node |] in
    let a1 = Array.map (fun v -> unpack_arr v |> Engine.arr_to_node) pri in
    let a2 = Array.map (fun v -> unpack_arr v |> Engine.arr_to_node) adj in
    let a3 = Owl_utils_array.(a0 @ a1 @ a2) in
    (* FIXME: experimental *)
    Engine.freeze_ancestors a3;

    (* return key parameters *)
    x, y, pri, adj, loss


  (** Deep compilation functions, includes gs, us, ps, ch, and new weights *)

  let compile_deep (params : Params.typ) network full_size =
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
      Engine.eval_arr [| v |];
      let u = Engine.var_arr "" ~shape:(Engine.shape v) in
      Engine.(assign_arr u (unpack_arr v));
      Algodiff.pack_arr u
    )
    |> Graph.update network;

    (* derive the computation graph in forward mode *)

    let x = Engine.var_arr "x" ~shape:input_shape |> pack_arr in
    let y' = Graph.forward network x |> fst in
    let output_shape = unpack_arr y' |> Engine.shape in
    let y = Engine.var_arr "y" ~shape:output_shape |> pack_arr in

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
    Owl_graph.set_name (unpack_elt loss |> Engine.elt_to_node) "loss";

    (* derive the computation graph in reverse mode *)

    let z = Graph.(backward network loss) in
    let ws = Owl_utils_array.flatten (fst z) in
    let gs' = Owl_utils_array.flatten (snd z) in

    (* assign input/output variable names *)

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "ws%i" i in
      Owl_graph.set_name b s
    ) ws;

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "gs'%i'" i in
      Owl_graph.set_name b s
    ) gs';

    (* allocate variables for optimisation engine *)

    let gs = Array.mapi (fun i w ->
      let name = Printf.sprintf "gs%i" i in
      let shape = Engine.shape (unpack_arr w) in
      Engine.var_arr name ~shape |> pack_arr
    ) ws
    in

    let ps = Array.mapi (fun i w ->
      let name = Printf.sprintf "ps%i" i in
      let shape = Engine.shape (unpack_arr w) in
      Engine.var_arr name ~shape |> pack_arr
    ) ws
    in

    let us = Array.mapi (fun i w ->
      let name = Printf.sprintf "us%i" i in
      let shape = Engine.shape (unpack_arr w) in
      Engine.var_arr name ~shape |> pack_arr
    ) ws
    in

    let ch = Array.mapi (fun i w ->
      let name1 = Printf.sprintf "cha%i" i in
      let name2 = Printf.sprintf "chb%i" i in
      let shape = Engine.shape (unpack_arr w) in
      let ch1 = Engine.var_arr name1 ~shape |> pack_arr in
      let ch2 = Engine.var_arr name2 ~shape |> pack_arr in
      [|ch1; ch2|]
    ) ws
    in

    (* calculate the new weights of the network *)

    (* clip the gradient if necessary *)
    let gs' = Array.map clip_fun gs' in
    (* calculate gradient descent *)
    let ps' = Owl_utils_array.map4 (grad_fun (fun a -> a)) ws gs ps gs' in
    (* update gcache if necessary *)
    let ch' = Owl_utils_array.map2 upch_fun gs' ch in
    (* adjust direction based on learning_rate *)
    let us' =
      Owl_utils_array.map3 (fun p' g' c ->
        (* FIXME: 999 is just place holder *)
        Maths.(p' * rate_fun 999 g' c)
      ) ps' gs' ch'
    in
    (* adjust direction based on momentum *)
    let us' = Owl_utils_array.map2 momt_fun us us' in
    (* update the weight *)
    let ws' = Owl_utils_array.map2 (fun w u -> Maths.(w + u)) ws us' in

    (* assign output variable names *)

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "ws'%i" i in
      Owl_graph.set_name b s
    ) ws';

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "ps'%i" i in
      Owl_graph.set_name b s
    ) ps';

    Array.iteri (fun i a ->
      let b = unpack_arr a |> Engine.arr_to_node in
      let s = Printf.sprintf "us'%i" i in
      Owl_graph.set_name b s
    ) us';

    Array.iteri (fun i a ->
      let c0 = unpack_arr a.(0) |> Engine.arr_to_node in
      let c1 = unpack_arr a.(1) |> Engine.arr_to_node in
      let s0 = Printf.sprintf "cha'%i" i in
      let s1 = Printf.sprintf "chb'%i" i in
      Owl_graph.set_name c0 s0;
      Owl_graph.set_name c1 s1;
    ) ch';

    (* contruct a computation graph with inputs and outputs *)

    let network_name = Graph.get_network_name network in
    let ch, ch' = Owl_utils_array.(flatten ch, flatten ch') in
    let _to_nodes = Array.map (fun v -> unpack_arr v |> Engine.arr_to_node) in
    let raw_i = Owl_utils_array.(ws @ gs @ ps @ us @ ch) |> _to_nodes in
    let raw_o = Owl_utils_array.(ws' @ gs' @ ps' @ us' @ ch') |> _to_nodes in
    let param_i, param_o = Engine.remove_unused_iopair raw_i raw_o in
    let output = Array.append param_o [| unpack_elt loss |> Engine.elt_to_node |] in
    let cgraph = Engine.make_graph ~input:param_i ~output network_name in
    Engine.make_iopair cgraph param_i param_o;

    (* initialise values of remaining variables *)

    Owl_utils.aarr_iter (fun x ->
      let y = Algodiff.unpack_arr x in
      let shape = Engine.shape y in
      Engine.assign_arr y (Engine.A.zeros shape)
    ) [|gs; ps; us; ch|];

    (* return key parameters *)

    loss, x, y, cgraph


  let make_eval_fun loss xt yt cgraph =
    let xt = Algodiff.unpack_arr xt in
    let yt = Algodiff.unpack_arr yt in

    let _eval xt' yt' =
      let xt' = Algodiff.unpack_arr xt' in
      let yt' = Algodiff.unpack_arr yt' in
      Engine.eval_arr [|xt'; yt'|];
      let xt' = Engine.unpack_arr xt' in
      let yt' = Engine.unpack_arr yt' in
      Engine.unsafe_assign_arr xt xt';
      Engine.unsafe_assign_arr yt yt';
      Engine.eval_graph cgraph;
      loss
    in
    _eval


  let make_update_fun cgraph =
    let _update () = Engine.update_iopair cgraph in
    _update


  let train ?state ?params network x y =
    let params = match params with
      | Some p -> p
      | None   -> Params.default ()
    in

    let network_name = Graph.get_network_name network in
    Owl_log.info "compile network %s into static graph ..." network_name;

    (* compile network into static graph *)
    let x_size = (unpack_arr x |> Engine.shape).(0) in
    let loss, xt, yt, cgraph = compile_deep params network x_size in
    let eval = make_eval_fun loss xt yt cgraph in
    let update = make_update_fun cgraph in
    let save _fname = () in

    (* Experimental: optimise graph structure *)
    Engine.save_graph cgraph (network_name ^ "_raw.cgd");
    Engine.optimise cgraph;
    Engine.save_graph cgraph (network_name ^ "_opt.cgd");

    Owl_log.info "start training %s ..." network_name;
    Optimise.minimise_compiled_network ?state params eval update save x y


  (* Multi-input/output version of ``model``. *)
  let model_inputs ?(optimise=true) ?(batch_size=1) network =
    (* TOFIX: the next line creates useless Copy nodes for constant values,
     * because Copy is an operation in CG *)
    let network = Graph.copy network in
    let network_name = Graph.get_network_name network in
    Owl_log.info "compile network %s into static graph ..." network_name;

    let input_shapes = Graph.input_shapes network in
    let inputs = Array.mapi (fun i sh ->
                     Engine.var_arr ("input_" ^ string_of_int i)
                       ~shape:(Array.append [|batch_size|] sh)
                     |> pack_arr) input_shapes
    in
    let outputs, _ = Graph.forward_inputs network inputs in

    let _to_nodes = Array.map (fun v -> unpack_arr v |> Engine.arr_to_node) in
    let i, o = _to_nodes inputs, _to_nodes outputs in
    let cgraph = Engine.make_graph ~input:i ~output:o network_name in

    if optimise then (
      Engine.optimise cgraph
    );

    (fun xt' ->
      let xt = Array.map (fun x -> Algodiff.unpack_arr x) inputs in
      let xt' = Array.map (fun x' -> Algodiff.unpack_arr x') xt' in
      Engine.eval_arr xt';
      let xt' = Array.map (fun x' -> Engine.unpack_arr x') xt' in
      Array.iter2 (fun x x' -> Engine.unsafe_assign_arr x x') xt xt';
      Engine.eval_graph cgraph;
      outputs
    )


  (* ``model network`` transforms the network into a computation graph and
  optimises it. Returns a function that takes the input of the network as an
  argument and returns the output. *)
  let model ?optimise ?batch_size network =
    let eval = model_inputs ?optimise ?batch_size network in
    fun xt' -> (eval [|xt'|]).(0)


end

(* Make functor ends *)
