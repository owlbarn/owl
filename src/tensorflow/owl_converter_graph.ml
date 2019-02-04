(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr
open Owl_converter_node


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  module Device = G.Optimiser.Operator.Symbol.Shape.Type.Device

  type tfgraph = {
    mutable nodes   : tfnode array;
    mutable version : string;
    mutable nametbl : (string, string) Hashtbl.t
  }


  let create () =
    {
      nodes    = [||];
      version  = "27";
      nametbl  = (Hashtbl.create 20)
    }


  let add_tfnodes tfgraph tfnodes name_update =
    tfgraph.nodes <- Array.append tfgraph.nodes tfnodes;
    let n_old, n_new = name_update in
    Hashtbl.add tfgraph.nametbl n_old n_new


  (* a bad implementation *)
  let get_tfnode tfgraph name =
    let nodes = Array.to_list tfgraph.nodes in
    let ns = List.filter (fun n -> (get_name n) = name) nodes in
    List.hd ns


  (* Rule: the output node that every one should connect to is put in the first element of returned array. *)
  let _make_initialisers (op : Symbol.Shape.Type.op) name =
    match op with
    | Ones shp ->
      let tvalue = make_tftensor ~float_val:[|1.|] "DT_FLOAT" shp in
      [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name shp (ATTR_Tensor tvalue)) |]
    | _ -> failwith "Initialiser not implemented."


  (* TODO: increase name id in order rather than randomly *)
  let make_variable_nodes op name out_shp =

    let initialisers = _make_initialisers op name in
    let iname = (get_name initialisers.(0)) in

    let vname = Printf.sprintf "%s/%s" name name in
    let var = TFVariable (TFVariable.create vname out_shp "DT_FLOAT") in

    let rname = name ^ "/read" ^ (Random.int 100 |> string_of_int) in
    let read = TFIdentity (TFIdentity.create rname [|vname|]
      out_shp "DT_FLOAT" name)
    in

    let aname = name ^ "/Assign" ^ (Random.int 100 |> string_of_int) in
    let assign = TFAssign (TFAssign.create ~refv:vname
      ~value:iname aname out_shp "DT_FLOAT")
    in

    (* RULE: only one node is named "init" in the whole graph *)
    (* TODO: How can I get another node from the graph? I.E. gloabal view for each node; or at least some nodes. This is an important decision to make. *)
    (* let init = get_tfnode "init" in
    let init_inputs = get_inputs init in
    set_inputs init (Array.append init_inputs [|aname|]); *)

    (Array.append [|var; read; assign|] initialisers),
    (name, aname)


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
    (* "value" only used by const node? *)
    let v = (attr.value).(0) in
    let value =
      if (Device.is_arr v) then (
        let arr = Device.value_to_arr v in
        let shp = Device.A.shape arr in
        let float_val = [|0.|] in (* should be G.A.to_array arr *)
        let tensor = make_tftensor ~float_val "DT_FLOAT" shp in
        ATTR_Tensor tensor
      ) else if (Device.is_elt v) then (
        let float_val = [| (Device.value_to_float v) |] in
        let tensor = make_tftensor ~float_val "DT_FLOAT" [||] in
        ATTR_Tensor tensor
      ) else (
        ATTR_Nil
      )
    in
    match attr.op with
    | Dot (a, b, _, _)    -> [| TFMatMul (TFMatMul.create name inputs out_shp a b) |], ("", "")
    | Add                 -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "")
    | ScalarAdd           -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "")
    | AddScalar           -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "")
    | Sub                 -> [| TFSub (TFSub.create name inputs out_shp) |], ("", "")
    | ScalarSub           -> [| TFSub (TFSub.create name inputs out_shp) |], ("", "")
    | SubScalar           -> [| TFSub (TFSub.create name inputs out_shp) |], ("", "")
    | Mul                 -> [| TFMul (TFMul.create name inputs out_shp) |], ("", "")
    | MulScalar           -> [| TFMul (TFMul.create name inputs out_shp) |], ("", "")
    | ScalarMul           -> [| TFMul (TFMul.create name inputs out_shp) |], ("", "")
    | Div                 -> [| TFDiv (TFDiv.create name inputs out_shp) |], ("", "")
    | DivScalar           -> [| TFDiv (TFDiv.create name inputs out_shp) |], ("", "")
    | ScalarDiv           -> [| TFDiv (TFDiv.create name inputs out_shp) |], ("", "")
    | Relu                -> [| TFRelu (TFRelu.create name inputs out_shp) |], ("", "")
    | Conv2d (p, s)       -> [| TFConv2D (TFConv2D.create name inputs out_shp p s) |], ("", "")
    | MaxPool2d (p, s, k) -> [| TFMaxPool (TFMaxPool.create name inputs out_shp p s k) |], ("", "")
    | Var                 -> [| TFPlaceholder (TFPlaceholder.create name out_shp) |], ("", "")
    | Const               -> [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name out_shp value) |], ("", "")
    | Ones _              -> make_variable_nodes attr.op name out_shp
    | _                   -> failwith "unsupported operation"


  (* for debugging *)
  let to_dot _nodes = ()


  let to_pbtxt graphdef =
    let node_str = Owl_converter_utils.map_then_combine_string ~sep:"\n" (fun n ->
      to_pbtxt n
    ) graphdef.nodes
    in
    let version_str = Printf.sprintf "versions {\nproducer: %s\n}\n" graphdef.version in
    Printf.sprintf "graph_def {\n%s%s}\n" node_str version_str

end
