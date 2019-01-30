(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr
open Owl_converter_node

module U = Owl_converter_utils


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  module Device = G.Optimiser.Operator.Symbol.Shape.Type.Device

  type tfgraph = {
    mutable nodes   : tfnode array;
    mutable nametbl : (string, string) Hashtbl.t
  }


  let create () =
    {
      nodes   = [||];
      nametbl = (Hashtbl.create 20)
    }


  (* The logic of how one owl node turned into multiple tfnodes is implemented
   * here.
   * Currently return node array and "name_update" : string * string; meaning,
   * whoever uses me as his input, now change it to one of my subnodes. Need to
   * think about how the input relation be updated later.
   *)
  let make_tfnodes node =
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
    | Dot (a, b, _, _)    -> [| TFMatMul (TFMatMul.create name inputs out_shp a b) |], ("", "")
    | AddScalar           -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "")
    | ScalarMul           -> [| TFMul (TFMul.create name inputs out_shp) |], ("", "")
    | Relu                -> [| TFRelu (TFRelu.create name inputs out_shp) |], ("", "")
    | Conv2d (p, s)       -> [| TFConv2D (TFConv2D.create name inputs out_shp p s) |], ("", "")
    | MaxPool2d (p, s, k) -> [| TFMaxPool (TFMaxPool.create name inputs out_shp p s k) |], ("", "")
    | Var                 -> [| TFPlaceholder (TFPlaceholder.create name out_shp) |], ("", "")
    | Const               -> [| TFConst (TFConst.create name out_shp value) |], ("", "")
    | _                   -> failwith "unsupported operation"


  let add_tfnodes tfgraph tfnodes name_update =
    tfgraph.nodes <- Array.append tfgraph.nodes tfnodes;
    let n_old, n_new = name_update in
    Hashtbl.add tfgraph.nametbl n_old n_new


  let get_tfnode tfgraph name =
    let nodes = Array.to_list tfgraph.nodes in
    let ns = List.filter (fun n -> (get_name n) = name) nodes in
    List.hd ns


  (* for debugging *)
  let to_dot _nodes = ()


  let to_string graphdef =
    let node_str = U.map_then_combine_string (fun n ->
      to_pbtxt n
    ) graphdef.nodes
    in
    Printf.sprintf "graph_def {\n%s}\n" node_str

end
