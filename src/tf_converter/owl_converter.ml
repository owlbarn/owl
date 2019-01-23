open Owl_converter_types

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  (* val convert : G.graph -> metagraph *)

  let make_meta_graph () = {
    meta_info   = Owl_converter_meta.create ();
    graph_def   = Owl_converter_graph.create ();
    saver_def   = Owl_converter_saver.create ();
    collections = Owl_converter_collection.create ()
    }


  let to_string m =
    (Owl_converter_meta.to_string m.meta_info) ^
    (Owl_converter_graph.to_string m.graph_def) ^
    (Owl_converter_saver.to_string m.saver_def) ^
    (Owl_converter_collection.to_string m.collections)


  (* the core step *)
  let parse_cgraph _graph =
    (* dummy *)
    Owl_converter_meta.create (),
    Owl_converter_graph.create (),
    Owl_converter_saver.create (),
    Owl_converter_collection.create ()

    (* ops = set: op
    nodes = [| typ:node |]
    variables = [|typ: string |]
    for each node:
      create an op and add to its op to ops if not yet;
      create a node and add to nodes;
    create a series of saver nodes to
    saver = make_server
    collections = ...
    *)


  (* dummy function to avoid compilation complain *)
  let _graph_to_dot = G.graph_to_dot


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
