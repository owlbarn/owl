(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
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


  let _make_uniform_initialiser name shp =
    let shp_str = Owl_utils_array.to_string ~sep:"," string_of_int shp in
    let tensor_content = Owl_converter_utils.serialise_tensor_content
      "int32" shp_str |> Bytes.of_string
    in
    let tvalue = make_tftensor ~tensor_content "DT_INT32" [|Array.length shp|] in
    let sname = name ^ "/shape" in
    let shape = TFConst (TFConst.create ~dtype:"DT_INT32" sname [|Array.length shp|] (ATTR_Tensor tvalue)) in

    (* RandomUniform node *)
    let ru_name = name in
    let ru = TFRandomUniform (TFRandomUniform.create ru_name [|sname|] shp 0 0) in

    (* max const *)
    let mc_name = name ^ "/max" in
    let mc_tensor = ATTR_Tensor (make_tftensor
      ~float_val:[|0.0852802842855|] "DT_FLOAT" [||])
    in
    let mc = TFConst (TFConst.create ~dtype:"DT_FLOAT" mc_name [||] mc_tensor) in

    (* min const *)
    let mic_name = name ^ "/min" in
    let mic_tensor = ATTR_Tensor (make_tftensor
      ~float_val:[|-0.0852802842855|] "DT_FLOAT" [||])
    in
    let mic = TFConst (TFConst.create ~dtype:"DT_FLOAT" mic_name [||] mic_tensor) in

    (* sub *)
    let sub_name = name ^ "/sub" in
    let sub = TFSub (TFSub.create sub_name [|mc_name; mic_name|] [||]) in

    (* mul *)
    let mul_name = name ^ "/mul" in
    let mul = TFMul (TFMul.create mul_name [|ru_name; sub_name|] shp) in

    (* add *)
    let add_name = name ^ "/add" in
    let add = TFAdd (TFAdd.create add_name [|mul_name; mic_name|] shp) in

    [|add; mul; ru; shape; sub; mc; mic|]


  let _make_initialisers (op : Symbol.Shape.Type.op) name =
    match op with
    | Ones shp    ->
      let tvalue = make_tftensor ~float_val:[|1.|] "DT_FLOAT" shp in
      [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name shp (ATTR_Tensor tvalue)) |]
    | Zeros shp   ->
      let tvalue = make_tftensor ~float_val:[|0.|] "DT_FLOAT" shp in
      [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name shp (ATTR_Tensor tvalue)) |]
    | Uniform shp -> _make_uniform_initialiser (name ^ "/random_uniform") shp
    | _           -> failwith "Initialiser not implemented."


  let make_variable_nodes op name out_shp =

    let initialisers = _make_initialisers op name in
    let iname = (get_name initialisers.(0)) in

    let vname = Printf.sprintf "%s/variable" name in
    let var = TFVariable (TFVariable.create vname out_shp "DT_FLOAT") in

    let rname = name ^ "/read" in
    let read = TFIdentity (TFIdentity.create ~cls:[|vname|] rname [|vname|]
      out_shp "DT_FLOAT")
    in

    let aname = name ^ "/assign" in
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


  let make_reshape_nodes name inputs shp =
    let shp_str = Owl_utils_array.to_string ~sep:"," string_of_int shp in
    let tensor_content = Owl_converter_utils.serialise_tensor_content
      "int32" shp_str |> Bytes.of_string
    in
    let stensor = ATTR_Tensor (make_tftensor ~tensor_content
      "DT_INT32" [|Array.length shp|])
    in
    let sname = name ^ "/shape" in
    let snode = TFConst (TFConst.create ~dtype:"DT_INT32" sname
      [|Array.length shp|] stensor) in

    let inputs = Array.append inputs [|sname|] in
    let rnode = TFReshape (TFReshape.create name inputs shp) in
    [|rnode; snode|], ("", "")


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

    (* "value" field only used by const node? Leave it here for now. Could be empty. *)
    let value = if (Array.length attr.value > 0) then (
      let v = (attr.value).(0) in
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
    ) else ATTR_Nil
    in
    match attr.op with
    | Neg                 -> [| TFNeg (TFNeg.create name inputs out_shp)|], ("", "")
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
    | Conv2d (p, s)       ->
      let s = [|1; s.(0); s.(1); 1|] in
      [| TFConv2D (TFConv2D.create name inputs out_shp p s) |], ("", "")
    | MaxPool2d (p, s, k) ->
      let s = [|1; s.(0); s.(1); 1|] in
      let k = [|1; k.(0); k.(1); 1|] in
      [| TFMaxPool (TFMaxPool.create name inputs out_shp p s k) |], ("", "")
    | Sum a               -> [| TFSum (TFSum.create name ~axis:[|a|] inputs out_shp) |], ("", "")
    | SumReduce a         -> [| TFSum (TFSum.create name ~axis:a inputs out_shp) |], ("", "")
    | Sum'                -> [| TFSum (TFSum.create name inputs out_shp) |], ("", "")
    | Var                 -> [| TFPlaceholder (TFPlaceholder.create name out_shp) |], ("", "")
    | Const               -> [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name out_shp value) |], ("", "")
    | Reshape s           -> make_reshape_nodes name inputs s
    | Ones _              -> make_variable_nodes attr.op name out_shp
    | Zeros _             -> make_variable_nodes attr.op name out_shp
    | Uniform _           -> make_variable_nodes attr.op name out_shp
    | Get i               -> make_stridedslice_nodes i name inputs out_shp
    | _                   -> let err = Printf.sprintf "unsupported operation: %s" (Symbol.op_to_str attr.op) in failwith err


  let to_pbtxt graphdef =
    let node_str = Owl_utils_array.to_string ~sep:"\n" (fun n ->
      to_pbtxt n
    ) graphdef.nodes
    in
    let version_str = Printf.sprintf "versions {\nproducer: %s\n}\n" graphdef.version in
    Printf.sprintf "graph_def {\n%s%s}\n" node_str version_str

end
