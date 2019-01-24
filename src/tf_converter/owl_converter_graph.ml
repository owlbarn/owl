open Owl_converter_types
open Owl_converter_attr
open Owl_converter_utils

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  (* make_nodedef is the CORE operation here!!! *)
  let make_nodedef node =
    let name = Owl_graph.name node in
    let attr : Symbol.Shape.Type.attr  = Owl_graph.attr node in
    let op_name = Symbol.op_to_str attr.op in
    let input = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents node)
    in
    let attr = [| make_attr_pair "EmptyKey" |] in
    let device = Some "cpu:0" in
    {
      name   = name;
      op     = op_name;
      input  = input;
      attr   = attr;
      device = device;
    }


  let add_nodedef graphdef nodedef =
    graphdef.nodes <- Array.append graphdef.nodes [|nodedef|]


  let create () =
    let node = {
        name  = "";
        op    = "Noop";
        input = [|""|];
        attr  = [| make_attr_pair "EmptyATTRKV"|];
        device = None
      }
    in
    { nodes = [|node|] }


  let node_to_string n = n.name

  let to_string graphdef =
    let node_arr = Array.map (fun n ->
      node_to_string n
    ) graphdef.nodes
    in
    let nodes_str = array_to_string (fun s -> s) node_arr in
    Printf.sprintf "graph_def {%s}" nodes_str

end
