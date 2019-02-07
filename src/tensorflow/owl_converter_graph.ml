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


  (* Graph version is NOT tensorflow version;
   * defined by TF_GRAPH_DEF_VERSION in core/public/version.h
   *)
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


  (* a bad implementation; maybe change to Hashtbl later? *)
  let get_tfnode tfgraph name =
    let nodes = Array.to_list tfgraph.nodes in
    let ns = List.filter (fun n -> (get_name n) = name) nodes in
    List.hd ns


  let _make_initialisers (op : Symbol.Shape.Type.op) name =
    match op with
    | Ones shp ->
      let tvalue = make_tftensor ~float_val:[|1.|] "DT_FLOAT" shp in
      [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name shp (ATTR_Tensor tvalue)) |]
    | _ -> failwith "Initialiser not implemented."


  let make_variable_nodes op name out_shp =

    let initialisers = _make_initialisers op name in
    let iname = (get_name initialisers.(0)) in

    let vname = Printf.sprintf "%s/%s" name name in
    let var = TFVariable (TFVariable.create vname out_shp "DT_FLOAT") in

    let rname = name ^ "/read" in
    let read = TFIdentity (TFIdentity.create rname [|vname|]
      out_shp "DT_FLOAT" name)
    in

    let aname = name ^ "/Assign" in
    let assign = TFAssign (TFAssign.create ~refv:vname
      ~value:iname aname out_shp "DT_FLOAT")
    in

    (* TODO: How can I get another node from the graph? I.E. gloabal view for each node; or at least some nodes. This is an important decision to make. *)
    (* let init = get_tfnode "init" in
    let init_inputs = get_inputs init in
    set_inputs init (Array.append init_inputs [|aname|]); *)
    (Array.append [|var; read; assign|] initialisers),
    (name, aname)


  (* TODO *)
  let make_sum_nodes = ()


  (* NOTE: out_shp and shape are not the same thing *)
  let _make_stack_for_stridedslice ?(_content=None) name shp_len =
    let dummy_tensor_content = Bytes.create 1 in (* tmp *)
    let shp = [| shp_len |] in
    let stensor = ATTR_Tensor (make_tftensor
      ~tensor_content:dummy_tensor_content
      "DT_INT32" shp)
    in
    TFConst (TFConst.create ~dtype:"DT_INT32" name shp stensor)


  (* TODO: the computation details are tmp and wrong *)
  let make_stridedslice_nodes _index name inputs out_shp =
    let shp_len = Array.length out_shp - 1 in
    let name0 = name ^ "/stack_0" in
    let name1 = name ^ "/stack_1" in
    let name2 = name ^ "/stack_2" in
    let stack0 = _make_stack_for_stridedslice name0 shp_len in
    let stack1 = _make_stack_for_stridedslice name1 shp_len in
    let stack2 = _make_stack_for_stridedslice name2 shp_len in

    let inputs = Array.append inputs [|name0; name1; name2|] in
    let ss = TFStridedSlice (TFStridedSlice.create name inputs out_shp
      0 0 0 0 0) in (* tmp: dummy numbers!!! *)
    [|ss; stack0; stack1; stack2|], ("", "")


  (* The logic of how one owl node turned into multiple tfnodes is implemented
   * here.
   * Currently return node array and "name_update" : string * string; meaning,
   * whoever uses me as his input, now change it to one of my subnodes.
   * About the `attr.shape.(0)` and `(attr.value).(0)` below, currently only
   * `draw` operation in owl CGraph returns two outputs, so I'll stick with
   * this tmp solution for now.
   *)
  let make_tfnodes node =
    let name = Owl_graph.name node in
    let attr : Symbol.Shape.Type.attr = Owl_graph.attr node in
    let inputs = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents node)
    in
     (* tmp: only uses the first output *)
    let out_shp = attr.shape.(0) in
    let out_shp =
      match out_shp with
      | Some s -> s
      | None   -> [||]
    in
    (* "value" field only used by const node? Leave it here for now. *)
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
    | Sum a               -> [| TFSum (TFSum.create name ~axis:[|a|] inputs out_shp) |], ("", "")
    | SumReduce a         -> [| TFSum (TFSum.create name ~axis:a inputs out_shp) |], ("", "")
    | Sum'                -> [| TFSum (TFSum.create name inputs out_shp) |], ("", "")
    | Var                 -> [| TFPlaceholder (TFPlaceholder.create name out_shp) |], ("", "")
    | Const               -> [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name out_shp value) |], ("", "")
    | Ones _              -> make_variable_nodes attr.op name out_shp
    | Get i               -> make_stridedslice_nodes i name inputs out_shp
    | _                   -> failwith "unsupported operation"


  let to_pbtxt graphdef =
    let node_str = Owl_utils_array.to_string ~sep:"\n" (fun n ->
      to_pbtxt n
    ) graphdef.nodes
    in
    let version_str = Printf.sprintf "versions {\nproducer: %s\n}\n" graphdef.version in
    Printf.sprintf "graph_def {\n%s%s}\n" node_str version_str

end
