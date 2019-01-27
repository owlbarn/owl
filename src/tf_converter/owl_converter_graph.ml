(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr
open Owl_converter_utils
open Owl_converter_node
(* open Owl_computation_type *)


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator


  let create () = {
    nodes   = [||];
    nametbl = (Hashtbl.create 20)
  }


  let add_tfnodes tfgraph tfnodes name_update =
    tfgraph.nodes   <- Array.append tfgraph.nodes tfnodes;
    let n_old, n_new = name_update in
    Hashtbl.add tfgraph.nametbl n_old n_new


  let make_owlnode node =
    let name = Owl_graph.name node in
    let attr : Symbol.Shape.Type.attr = Owl_graph.attr node in
    let inputs = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents node)
    in
    let out_shp = attr.shape.(0) in
    match attr.op with
    | Dot (a, b, _, _) -> OwlDot (OwlDot.create name inputs out_shp a b)
    | AddScalar        -> OwlAddScalar (OwlAddScalar.create name inputs out_shp)
    | ScalarMul        -> OwlScalarMul (OwlScalarMul.create name inputs out_shp)
    | Ones shape       -> OwlOnes (OwlOnes.create name inputs out_shp shape)
    | Var              -> OwlVar (OwlVar.create name inputs out_shp)
    | Const            -> OwlConst (OwlConst.create name inputs out_shp)
    | _                -> failwith "unsupported operation"


  let make_tfnodes (node : Symbol.Shape.Type.attr Owl_graph.node) =
    let owl_node = make_owlnode node in
    make_tfnodes owl_node


  let tfnode_to_string n =
    let attr_str = map_then_combine_string (fun (k, v) ->
      let value_str = tfattrvalue_to_string v in
      Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {%s}}" k value_str
    ) n.node_attr
    in
    Printf.sprintf "node {\nname: \"%s\"\nop: \"%s\"\n%s\n}\n"
      n.name n.op_name attr_str


  let to_string graphdef =
    let node_str = map_then_combine_string (fun n ->
      tfnode_to_string n
    ) graphdef.nodes
    in
    Printf.sprintf "graph_def {\n%s}\n" node_str

end
