open Owl_converter_types
open Owl_graph

module Saverdef = Owl_converter_saver
module Colldef  = Owl_converter_collection


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  module Metadef  = Owl_converter_meta.Make (G)
  module Graphdef = Owl_converter_graph.Make (G)

  (* val convert : G.graph -> metagraph *)

  let make_meta_graph () = {
    meta_info   = Metadef.create ();
    graph_def   = Graphdef.create ();
    saver_def   = Saverdef.create ();
    collections = Colldef.create ()
    }


  let to_string m =
    (Metadef.to_string  m.meta_info) ^
    (Graphdef.to_string m.graph_def) ^
    (Saverdef.to_string m.saver_def) ^
    (Colldef.to_string  m.collections)


  (* the core step *)
  let parse_cgraph (graph : G.graph) =

    let metadef  = Metadef.create () in
    let graphdef = Graphdef.create () in

    let outputs = G.get_outputs graph in

    iter_ancestors (fun node ->
      let attr : Symbol.Shape.Type.attr = Owl_graph.attr node in
      let op = attr.op in
      let op_str = Symbol.op_to_str op in

      if not (Metadef.mem_op metadef op_str) then (
        let opdef = Metadef.opdef_from_attr attr in
        Metadef.add_op metadef opdef
      );

      let nodedef = Graphdef.make_nodedef node in
      Graphdef.add_nodedef graphdef nodedef

    ) outputs;

    let saverdef = Saverdef.create () in
    let colldef  = Colldef.create () in

    metadef, graphdef, saverdef, colldef


  let convert graph =
    let meta, graph, saver, collections = parse_cgraph graph in

    let tf_graph = make_meta_graph () in
    tf_graph.meta_info   <- meta;
    tf_graph.graph_def   <- graph;
    tf_graph.saver_def   <- saver;
    tf_graph.collections <- collections;

    let pb_txt = to_string tf_graph in
    pb_txt

end


(*
- code format
- variable names are not informative and consistent
- collection_pair is useless
- used array_to_string from owl
- current code is still too simple to see problems
*)
