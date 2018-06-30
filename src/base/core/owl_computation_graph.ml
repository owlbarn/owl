(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_graph


module Make
  (A : Ndarray_Algodiff)
  (D : Computation_Device)
  = struct

  include Owl_computation_symbol.Make (A) (D)
  include Owl_computation_operator.Make (A) (D)
  include Owl_computation_optimiser.Make (A) (D)


  type graph = {
    mutable name   : string;                         (* name of the graph *)
    mutable input  : attr node array;                (* input nodes of the graph *)
    mutable output : attr node array;                (* output nodes of the graph *)
    mutable iopair : (attr node * attr node) array;  (* input and output loopback pairs *)
    mutable iosafe : bool array;                     (* whether it is safe to use unsafe_assign_arr *)
    mutable random : attr node array;                (* rvs automatically invalidate themselves *)
    mutable htbl   : (string, attr node) Hashtbl.t;  (* node name to node mapping *)
    mutable device : device                          (* device-dependent field *)
  }


  (* utility functions *)

  let graph_to_dot x = Symbol.nodes_to_dot x.output


  let save_graph graph fname =
    let data = (graph, number) in
    Owl_io.marshal_to_file data fname


  let load_graph fname =
    let graph, num_typ = Owl_io.marshal_from_file fname in
    if num_typ <> number then
      failwith "load_graph: inconsistent type."
    else
      graph, num_typ


  let collect_rvs output =
    let stack = Owl_utils_stack.make () in
    Owl_graph.iter_ancestors (fun v ->
      let op_typ = get_operator v in
      if is_random_variable op_typ then
        Owl_utils_stack.push stack v
    ) output;
    Owl_utils_stack.to_array stack


  let invalidate_rvs graph =
    Array.iter invalidate_graph graph.random


  (* core graph functions *)

  let make_graph ~input ~output name =
    (* check all the inputs must be variables *)
    assert (Array.for_all is_var input);
    (* set outputs' memory as not reusable *)
    Array.iter (fun x -> set_reuse x false) output;
    (* create hash table to store input/output names *)
    let input_output = Array.append input output in
    let htbl_size = Array.length input_output in
    let htbl = Hashtbl.create htbl_size in
    (* add nodes' name into the hash table  *)
    Array.iter (fun x ->
      let n_name = Owl_graph.name x in
      let x_name =
        if n_name = "" then Printf.sprintf "n#%i" (id x)
        else n_name
      in
      (* nodes name must be unique in inputs and outputs *)
      if Hashtbl.mem htbl x_name = true then (
        Owl_log.warn "nodes are both input and output: %s" (node_to_str x);
        let saved_node = Hashtbl.find htbl x_name in
        assert (saved_node == x);
      )
      else
        Hashtbl.add htbl x_name x
    ) input_output;
    (* freeze the graph to avoid memory leak *)
    freeze_ancestors output;
    (* empty io pairing by default *)
    let iopair = [| |] in
    let iosafe = [| |] in
    (* collect all the random variables *)
    let random = collect_rvs output in
    (* create a device dependent field *)
    let device = make_device () in
    (* return the graph record *)
    { name; input; output; iopair; iosafe; random; htbl; device }


  let get_inputs x = x.input


  let get_outputs x = x.output


  (* manipulate input and output pairs *)

  let get_node_arr_val x =
    let value = (attr x).value in
    assert (Array.length value > 0);
    value_to_arr value.(0)


  let get_node_elt_val x =
    let value = (attr x).value in
    assert (Array.length value > 0);
    value_to_elt value.(0)


  let set_node_arr_val x v = (attr x).value <- [| v |]


  let set_node_elt_val x v = (attr x).value <- [| v |]


  let is_iopair_safe i o =
    let safe_pair = ref true in
    let pass_by_o = ref false in
    let branching = ref 0 in
    let _ =
      try Owl_graph.iter_descendants (fun v ->
        branching := Pervasives.max !branching (refnum v);
        if v == o then pass_by_o := true;
        assert (not (!branching > 1 && !pass_by_o));
      ) [|i|]
      with exn -> safe_pair := false
    in
    !safe_pair


  let make_iopair graph input output =
    assert (Array.length input = Array.length output);
    let iopair = Array.map2 (fun i o -> (i, o)) input output in
    let iosafe = Array.map2 (fun i o -> is_iopair_safe i o) input output in
    graph.iopair <- iopair;
    graph.iosafe <- iosafe


  let update_iopair graph =
    Array.iteri (fun idx (i, o) ->
      if is_arr i = true then (
        let o_val = get_node_arr_val o in
        let i_arr = node_to_arr i in
        (* make sure the original data will never be modified. *)
        if graph.iosafe.(idx) = true then
          unsafe_assign_arr i_arr o_val
        else
          assign_arr i_arr o_val
      )
      else (
        let i_elt = node_to_elt i in
        let o_val = get_node_elt_val o in
        assign_elt i_elt o_val
      )
    ) graph.iopair


  let remove_unused_iopair input output =
    let new_i, new_o =
      Owl_utils_array.filter2_split (fun i o -> degree i <> 0) input output
    in
    new_i, new_o


  let init_inputs f graph =
    Array.iter (fun v -> (attr v).value <- [| f v |]) graph.input


  let optimise graph = optimise_nodes graph.output



end
