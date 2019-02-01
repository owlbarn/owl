(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_graph

module TFcolls = Owl_converter_collection
module TFnode  = Owl_converter_node


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
      tfcolls = TFcolls.create [|""|]
    }


  let to_string m =
    (TFmeta.to_string  m.tfmeta)  ^
    (TFgraph.to_string m.tfgraph) ^
    (TFsaver.to_string m.tfsaver) ^
    (TFcolls.to_string m.tfcolls)


  (* Need to specify rules about naming of model and output node(s) *)
  let parse_cgraph (graph : G.graph) =

    let outputs = G.get_outputs graph in

    (* 0th iteration: name each node *)
    iter_ancestors (fun node ->
      let id = Owl_graph.id node in
      Owl_graph.set_name node (Printf.sprintf "owlnode%d" id)
    ) outputs;

    (* build a Hashtbl: the inputs of each node *)

    (* 1st iteration : on owl_cgraph *)
    let tfgraph = TFgraph.create () in
    iter_ancestors (fun node ->
      let tfnode, name_update = TFgraph.make_tfnodes node in
      TFgraph.add_tfnodes tfgraph tfnode name_update
    ) outputs;

    (* 2nd iteration : change tf_nodes's input nodes' names
     * according to tfgraph.nametbl *)

    (*TODO: update previous hashtbl *)

    (* 3nd iteration : on tf_cgraph; surely can be combined with the 2nd iter *)
    let tfmeta  = TFmeta.create () in
    let tfsaver = TFsaver.create () in
    TFsaver.add_savernodes tfsaver tfgraph;
    let tfcolls = TFcolls.create [|"var"; "var_train"|] in

    Array.iter (fun tfnode ->
      let opname = TFnode.get_op_name tfnode in
      if not (TFmeta.mem_opdef tfmeta opname) then (
        let tfop = TFnode.get_opdef tfnode in
        TFmeta.add_opdef tfmeta tfop
      );
      if (TFmeta.is_var tfnode) then (
        TFsaver.add_link tfsaver tfgraph (TFnode.get_name tfnode);
        TFcolls.update tfcolls "var" (TFnode.get_name tfnode);
        TFcolls.update tfcolls "var_train" (TFnode.get_name tfnode) (* simply take all variables as trainable *)
      )
    ) tfgraph.nodes;

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
