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

  module Device = G.Optimiser.Operator.Symbol.Shape.Type.Device


  let create () =
    {
      nodes   = [||];
      nametbl = (Hashtbl.create 20)
    }


  let add_tfnodes tfgraph tfnodes name_update =
    tfgraph.nodes <- Array.append tfgraph.nodes tfnodes;
    let n_old, n_new = name_update in
    Hashtbl.add tfgraph.nametbl n_old n_new


  let make_owlnode node =
    let name = Owl_graph.name node in
    let attr : Symbol.Shape.Type.attr = Owl_graph.attr node in
    let inputs = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents node)
    in
    let out_shp = attr.shape.(0) in (* tmp: only uses the first output *)
    let out_shp =
      match out_shp with
      | Some s -> s
      | None   -> [||]
    in
    let v = (attr.value).(0) in
    let value =
      if (Device.is_arr v) then (
        let arr = Device.value_to_arr v in
        let shp = Device.A.shape arr in
        let float_val = [|0.|] in (* should be G.A.to_array arr *)
        let tensor = make_tftensor ~float_val "DT_FLOAT" shp in
        ATTR_Tensor tensor
      ) else if (Device.is_elt v) then (
        ATTR_Float (Device.value_to_float v)
      ) else (
        ATTR_Nil
      )
    in
    match attr.op with
    | Dot (a, b, _, _)    -> OwlDot (OwlDot.create name inputs out_shp a b)
    | AddScalar           -> OwlAddScalar (OwlAddScalar.create name inputs out_shp)
    | ScalarMul           -> OwlScalarMul (OwlScalarMul.create name inputs out_shp)
    | Relu                -> OwlRelu (OwlRelu.create name inputs out_shp)
    | Conv2d (p, s)       -> OwlConv2d (OwlConv2d.create name inputs out_shp p s)
    | MaxPool2d (p, s, k) -> OwlMaxPool2d (OwlMaxPool2d.create name inputs out_shp p s k)
    | Var                 -> OwlVar (OwlVar.create name out_shp)
    | Ones shape          -> OwlOnes (OwlOnes.create name inputs out_shp shape)
    | Const               -> OwlConst (OwlConst.create name out_shp value)
    | _                   -> failwith "unsupported operation"


  let make_tfnodes (node : Symbol.Shape.Type.attr Owl_graph.node) =
    let owl_node = make_owlnode node in
    make_tfnodes owl_node


  (* an ugly impl. *)
  let get_tfnode tfgraph name =
    let nodes = Array.to_list tfgraph.nodes in
    let ns = List.filter (fun n -> n.name = name) nodes in
    List.hd ns


  let get_tfnode_input (tfnode : tfnode) = tfnode.input


  let set_tfnode_input (tfnode : tfnode) input = tfnode.input <- input


  let get_tfnode_tfattr (tfnode : tfnode) = tfnode.node_attr


  let set_tfnode_tfattr (tfnode : tfnode) attr = tfnode.node_attr <- attr


  let get_tfnode_device (tfnode : tfnode) = tfnode.device


  let set_tfnode_device (tfnode : tfnode) device = tfnode.device <- device


  (* for debugging *)
  let tfnodes_to_dot _nodes = ()


  let tfnode_to_string n =
    let attr_str = map_then_combine_string (fun (k, v) ->
      let value_str = tfattrvalue_to_string v in
      Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {%s}}\n" k value_str
    ) n.node_attr
    in
    let inputs_str = map_then_combine_string (fun v ->
      Printf.sprintf "input : %s\n" v
    ) n.input
    in
    Printf.sprintf "node {\nname: \"%s\"\nop: \"%s\"\n%s\n%s\n}\n"
      n.name n.op_name inputs_str attr_str


  let to_string graphdef =
    let node_str = map_then_combine_string (fun n ->
      tfnode_to_string n
    ) graphdef.nodes
    in
    Printf.sprintf "graph_def {\n%s}\n" node_str

end
