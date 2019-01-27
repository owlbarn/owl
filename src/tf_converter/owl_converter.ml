(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_graph

module TFsaver = Owl_converter_saver
module TFcolls = Owl_converter_collection


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  module TFmeta  = Owl_converter_meta.Make (G)
  module TFgraph = Owl_converter_graph.Make (G)


  let make_tf_cgraph () =
    {
      tfmeta  = TFmeta.create  ();
      tfgraph = TFgraph.create ();
      tfsaver = TFsaver.create ();
      tfcolls = TFcolls.create 2
    }


  let to_string m =
    (TFmeta.to_string  m.tfmeta)  ^
    (TFgraph.to_string m.tfgraph) ^
    (TFsaver.to_string m.tfsaver) ^
    (TFcolls.to_string m.tfcolls)


  (* we need to specify rules about naming of model and output node(s) *)
  let parse_cgraph (graph : G.graph) =

    (* 1st iteration : owl_cgraph *)
    let tfgraph = TFgraph.create () in
    let outputs = G.get_outputs graph in
    iter_ancestors (fun node ->
      let tfnode, name_update = TFgraph.make_tfnodes node in
      (* name_update : string * string; meaning, whoever uses me as his input, now change it to one of my subnodes .*)
      TFgraph.add_tfnodes tfgraph tfnode name_update
    ) outputs;

    (* 2nd iteration : change tf_nodes's input nodes' names
     * according to tfgraph.nametbl *)


    (* 3nd iteration : tf_cgraph *)
    let tfmeta  = TFmeta.create () in
    let tfsaver = TFsaver.create () in

    let tfcolls = TFcolls.create 2 in
    let _tfcoll_var = TFcolls.get_coll tfcolls 0 in
    let _tfcoll_var_train = TFcolls.get_coll tfcolls 1 in

    (*
    initialise saver nodes to tfsaver {
      saverv2 and three nodes; control_dep and const;
      restore and three nodes;
      a restore_all node;
    }

    Array.iter ( fun tfnode ->
      let opname = tfnode.op_name in
      if not (TFmeta.mem_op tfmeta op_name) then (
        let op_attr =
        let tfop = TFmeta.opdef_from_attr op_attr in
        Metadef.add_op tfmeta opdef
      )

      if tfnode is variable:
        connect it to saver node
        create an assign node to tfgraph
          and connect to this varv2, restorev2, and restore_all
        add variable to collections

    ) tfgraph.nodes;

    let tfcoll_result = TFcoll.create ()
    add the output nodes to tfcoll_result *)
    tfmeta, tfgraph, tfsaver, tfcolls


  let convert graph =
    let tfmeta, tfgraph, tfsaver, tfcolls = parse_cgraph graph in
    let tf_cgraph = make_tf_cgraph () in
    tf_cgraph.tfmeta  <- tfmeta;
    tf_cgraph.tfgraph <- tfgraph;
    tf_cgraph.tfsaver <- tfsaver;
    tf_cgraph.tfcolls <- tfcolls;
    let pb_txt = to_string tf_cgraph in
    pb_txt

end
