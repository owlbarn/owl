(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph

module Make
  (Optimiser : Owl_computation_optimiser_sig.Sig)
  = struct

  module Optimiser = Optimiser

  open Optimiser

  open Optimiser.Operator.Symbol

  open Optimiser.Operator.Symbol.Shape.Type

  open Optimiser.Operator.Symbol.Shape.Type.Device


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

  (* print shape for ndarrays, whilst value for scalars *)
  let shape_or_value x =
    let shape = (attr x).shape in
    if is_assigned x = true then (
      match shape.(0) with
      | Some s -> (
          if Array.length s = 0 then
            Printf.sprintf "v:%g" (node_to_elt x |> elt_to_float)
          else
            Printf.sprintf "s:%s" (shape_to_str shape)
        )
      | None   -> Printf.sprintf "s:%s" (shape_to_str shape)
    )
    else
      Printf.sprintf "s:%s" (shape_to_str shape)


  let _block_colour b_id =
    (* lazy attempt to generate distinguishable colours *)
    let h = float ((b_id * 283) mod 360) /. 360. in
    let s = 0.4 in
    let v = 1. in
    Printf.sprintf "%.3f %.1f %.0f" h s v


  let graph_to_dot graph =
    let edge_s = fold_in_edges (fun a u v ->
        Printf.sprintf "%s%i -> %i;\n" a (id u) (id v)
    ) "" graph.output
    in
    let node_s = fold_ancestors (fun a n ->
      let svs = shape_or_value n in
      let b_id = get_block_id n in
      Printf.sprintf "%s%i [ label=\"{{#%i | { %s | %s }} | r:%i; %s; b:%i }\""
        a (id n) (id n) (name n) (op_to_str (attr n).op) (refnum n) svs b_id ^
        (if is_reusable n && b_id <> -1 then
           let col = _block_colour b_id in
           Printf.sprintf "style=filled fillcolor=\"%s\"" col
         else "") ^
          "];\n"
    ) "" graph.output
    in
    Printf.sprintf "digraph CG {\nnode [shape=record];\n%s%s}" edge_s node_s


  let graph_to_trace graph =
    let u_nodes = Owl_utils_stack.make () in
    let v_nodes = Owl_utils_stack.make () in
    iter_in_edges (fun u v ->
      Owl_utils_stack.push u_nodes (node_to_str u);
      Owl_utils_stack.push v_nodes (node_to_str v);
    ) graph.output;
    let u_strings = Owl_utils_stack.to_array u_nodes in
    let v_strings = Owl_utils_stack.to_array v_nodes in
    let u_longest = Owl_utils.longest_string u_strings in
    let u_strings = Owl_utils.pad_strings `Right u_longest u_strings in
    Owl_utils_array.fold2 (fun acc u v ->
      Printf.sprintf "%s%s -> %s\n" acc u v
    ) "" u_strings v_strings


  let save_graph graph fname =
    let data = (graph, A.number) in
    Owl_io.marshal_to_file data fname


  let load_graph fname =
    let graph, num_typ = Owl_io.marshal_from_file fname in
    if num_typ <> A.number then
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
    let value = get_value x in
    assert (Array.length value > 0);
    value_to_arr value.(0)


  let get_node_elt_val x =
    let value = get_value x in
    assert (Array.length value > 0);
    value_to_elt value.(0)


  let set_node_arr_val x v = set_value x [| v |]


  let set_node_elt_val x v = set_value x [| v |]


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
      with _exn -> safe_pair := false
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
      Owl_utils_array.filter2_split (fun i _o -> degree i <> 0) input output
    in
    new_i, new_o


  let init_inputs f graph =
    Array.iter (fun v -> set_value v [| f v |]) graph.input


  let optimise graph = optimise_nodes graph.output


end

(* Make functor ends *)
