(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_graph

module TFcolls = Owl_converter_collection

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  module TFmeta  = Owl_converter_meta.Make (G)
  module TFgraph = Owl_converter_graph.Make (G)
  module TFsaver = Owl_converter_saver.Make (G)

  type tf_cgraph = {
    mutable tfmeta  : tfmeta;
    mutable tfgraph : TFgraph.tfgraph;
    mutable tfsaver : tfsaver;
    mutable tfcolls : tfcolls
  }

  let make_tf_cgraph () =
    {
      tfmeta  = TFmeta.create  ();
      tfgraph = TFgraph.create ();
      tfsaver = TFsaver.create ();
      tfcolls = TFcolls.create ();
    }


  let to_pbtxt m =
    (TFmeta.to_pbtxt  m.tfmeta)  ^
    (TFgraph.to_pbtxt m.tfgraph) ^
    (TFsaver.to_pbtxt m.tfsaver) ^
    (TFcolls.to_pbtxt m.tfcolls)


  (* Need to specify rules about naming of model and output node(s) *)
  let parse_cgraph (graph : G.graph) =

    let outputs = G.get_outputs graph in

    (* 0th iterations: name each node
     * assumes all of a nodes' children are properly named *)
    iter_ancestors (fun node ->
      let id = Owl_graph.id node in
      Owl_graph.set_name node (Printf.sprintf "owlnode%d" id);
    ) outputs;

    (* 1st iteration : on owl_cgraph *)
    let tfgraph = TFgraph.create () in
    iter_ancestors (fun node ->
      let tfnode, name_update = TFgraph.make_tfnodes node in
      TFgraph.add_tfnodes tfgraph tfnode name_update
    ) outputs;

    (* 2nd iteration : change tf_nodes's input nodes' names
     * according to tfgraph.nametbl *)
    Array.iter (fun tfnode ->
      let inputs = Owl_converter_node.get_inputs tfnode in
      Array.iteri (fun i x ->
        try (
          let replace = Hashtbl.find tfgraph.nametbl x in
          inputs.(i) <- replace
        ) with Not_found -> ()
      ) inputs;
      Owl_converter_node.set_inputs tfnode inputs
    ) tfgraph.nodes;


    (* 3nd iteration : on tf_cgraph; surely can be combined with the 2nd iter *)
    let tfmeta  = TFmeta.create () in
    let tfsaver = TFsaver.create () in
    TFsaver.add_savernodes tfsaver tfgraph;

    let tfcolls = TFcolls.create () in
    TFcolls.add_byteslist tfcolls "var";
    TFcolls.add_byteslist tfcolls "var_train";
    TFcolls.add_nodelist tfcolls "result";

    Array.iter (fun tfnode ->
      let opname = Owl_converter_node.get_op_name tfnode in
      if not (TFmeta.mem_opdef tfmeta opname) then (
        let tfop = Owl_converter_node.get_opdef tfnode in
        TFmeta.add_opdef tfmeta tfop
      );
      if (TFmeta.is_var tfnode) then (
        TFsaver.add_link tfsaver tfgraph tfnode;
        (* How the strings are serialised here is not clear yet. Need to find out.*)
        (* TFcolls.update tfcolls "var" (Owl_converter_node.get_name tfnode);
        TFcolls.update tfcolls "var_train" (Owl_converter_node.get_name tfnode) *)
      )
    ) tfgraph.nodes;

    (* NOTE: how to decide the id of the node?!! *)
    (* also, need to specify it's update_string/update_byte/.... *)
    let output_names = Array.map (fun n ->
      (Owl_graph.name n) ^ ":0" (* therefore, temporary hack on id *)
    ) outputs
    in
    TFcolls.update_nodelist tfcolls "result" output_names;

    tfmeta, tfgraph, tfsaver, tfcolls


  (* Things not yet considered:
   * - "unknown rank" of shape of RestoreV2 node; may need to change def
   * - track id of each node (foobar:0)
   * - how to construct collections bytelist
   * - the "device" attr needs to be printed out for save/restore nodes
   * - some seemingly unimportant attr of nodes like "default_value"
   *)
  let convert graph =
    let tfmeta, tfgraph, tfsaver, tfcolls = parse_cgraph graph in
    let tf_cgraph = make_tf_cgraph () in
    tf_cgraph.tfmeta  <- tfmeta;
    tf_cgraph.tfgraph <- tfgraph;
    tf_cgraph.tfsaver <- tfsaver;
    tf_cgraph.tfcolls <- tfcolls;
    let pb_txt = to_pbtxt tf_cgraph in
    pb_txt

end
