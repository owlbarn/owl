(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr
open Owl_converter_utils

module D = Owl_converter_db

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  let create () =
    { nodes = [||] }


  let preprocess_cgraph _owl_graph =
    (* G.copy owl_graph *)
    ()


  let get_extra_attr (owl_attr : Symbol.Shape.Type.attr) =
    let shape = owl_attr.shape in
    let output_shape = Array.map (fun s ->
      match s with
      | Some s -> ATTR_Shape s
      | None   -> ATTR_Shape [||]
    ) shape
    in
    let output_shape = ATTR_List output_shape in
    let output_attr  = ("_output_shape", output_shape) in
    let type_attr    = ("dtype", ATTR_String "DT_FLOAT") in
    [|output_attr; type_attr|]


  let make_nodedef (owl_node : Symbol.Shape.Type.attr Owl_graph.node) =
    let name = Owl_graph.name owl_node in
    let attr = Owl_graph.attr owl_node in
    let op_name = Symbol.op_to_str attr.op in
    let input = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents owl_node)
    in
    let attr_pair_array = D.get_node_attr op_name in
    let extra_attrs = get_extra_attr attr in
    let new_attrs = match attr_pair_array with
    | Some a -> Array.append a extra_attrs
    | None   -> extra_attrs
    in
    let device = Some "cpu:0" in
    {
      name    = name;
      op_name = op_name;
      input   = input;
      node_attr = Some new_attrs;
      device  = device;
    }


  let add_nodedef graphdef nodedef =
    graphdef.nodes <- Array.append graphdef.nodes [|nodedef|]


  let node_to_string (n : nodedef) =
    let attr_str = match n.node_attr with
    | Some attrs ->
        map_then_combine_string (fun (k, v) ->
          let value_str = attrvalue_to_string v in
          Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {%s}}" k value_str
        ) attrs
    | None       -> ""
    in
    Printf.sprintf "node {\nname: \"%s\"\nop: \"%s\"\n%s\n}\n"
      n.name n.op_name attr_str


  let to_string graphdef =
    let node_str = map_then_combine_string (fun n ->
      node_to_string n
    ) graphdef.nodes
    in
    Printf.sprintf "graph_def {\n%s}\n" node_str

end



(*
module Make = sig

  module G : Owl_computation_graph_sig.Sig

  include Owl_computation_operator_sig.Sig

  val create : unit -> graphdef

  val make_nodedef : Symbol.Shape.Type.attr Owl_graph.node -> nodedef

  val add_nodedef : graphdef -> nodedef -> unit

  val to_string : graphdef -> string

end

*)
