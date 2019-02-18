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
    match ns with
    | h :: _ -> h
    | []     -> failwith (Printf.sprintf "cannot get node %s from graph" name)


  (* "value" field only used by const node? Leave it here for now. Could be empty. *)
  let get_const_value (attr : Symbol.Shape.Type.attr) =
    if (Array.length attr.value > 0) then (
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


  let _make_uniform_initialiser name shp =
    let shp_str = Owl_utils_array.to_string ~sep:"," string_of_int shp in
    let tensor_content = Owl_converter_utils.serialise_tensor_content
      "int32" shp_str
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
    (* let init = get_tfnode "init" in
    let init_inputs = get_inputs init in
    set_inputs init (Array.append init_inputs [|aname|]); *)
    (Array.append [|var; read; assign|] initialisers),
    (name, aname)


  let _make_axis_const name axes =
    let aname = name ^ "/reduction_indices" in
    let anode = if (Array.length axes <= 1) then (
      let atensor = ATTR_Tensor (make_tftensor ~int_val:axes "DT_INT32" [||]) in
      TFConst (TFConst.create ~dtype:"DT_INT32" aname [||] atensor)
    ) else (
      let axes_str = Owl_utils_array.to_string ~sep:"," string_of_int axes in
      let tensor_content = Owl_converter_utils.serialise_tensor_content
        "int32" axes_str in
      let atensor = ATTR_Tensor (make_tftensor ~tensor_content
        "DT_INT32" [|Array.length axes|]) in
      TFConst (TFConst.create ~dtype:"DT_INT32" aname
        [|Array.length axes|] atensor)
    ) in
    anode, aname


  let make_sum_nodes name inputs shp axes keepdims =
    let anode, aname = _make_axis_const name axes in
    let inputs = Array.append inputs [|aname|] in
    let rnode = TFSum (TFSum.create ~keepdims name inputs shp) in
    [|rnode; anode|], ("", "")


  let make_max_nodes name inputs shp axes keepdims =
    let anode, aname = _make_axis_const name axes in
    let inputs = Array.append inputs [|aname|] in
    let rnode = TFMax (TFMax.create ~keepdims name inputs shp) in
    [|rnode; anode|], ("", "")


  let make_min_nodes name inputs shp axes keepdims =
    let anode, aname = _make_axis_const name axes in
    let inputs = Array.append inputs [|aname|] in
    let rnode = TFMin (TFMin.create ~keepdims name inputs shp) in
    [|rnode; anode|], ("", "")


  let make_log_nodes name inputs shp base =
    let cname = name ^ "/log_base" in
    let ctensor = ATTR_Tensor (make_tftensor ~int_val:[|base|] "DT_INT32" [||]) in
    let cnode = TFConst (TFConst.create ~dtype:"DT_INT32" cname [||] ctensor) in

    let lname2 = name ^ "/log_2" in
    let lnode2 = TFLog (TFLog.create lname2 [|cname|] [||]) in
    let lname1 = name ^ "/log_1" in
    let lnode1 = TFLog (TFLog.create lname1 inputs shp) in

    let dname = name ^ "/div" in
    let dnode = TFDiv (TFDiv.create dname [|lname1; lname2|] shp) in

    [|dnode; lnode1; lnode2; cnode|], (name, dname)


  let _make_stack_for_stridedslice name arr =
    let tensor_content = Owl_converter_utils.serialise_tensor_content "int32"
      (Owl_utils_array.to_string ~sep:"," string_of_int arr)
    in
    let shp = [| Array.length arr |] in
    let stensor = ATTR_Tensor (make_tftensor ~tensor_content "DT_INT32" shp) in
    TFConst (TFConst.create ~dtype:"DT_INT32" name shp stensor)


  (* TODO: shrink for get operation *)
  let make_stridedslice_nodes name inputs out_shp begins ends strides shrink =
    let name0 = name ^ "/stack_0" in
    let name1 = name ^ "/stack_1" in
    let name2 = name ^ "/stack_2" in
    let stack0 = _make_stack_for_stridedslice name0 begins in
    let stack1 = _make_stack_for_stridedslice name1 ends in
    let stack2 = _make_stack_for_stridedslice name2 strides in

    let inputs = Array.append inputs [|name0; name1; name2|] in
    let ss = TFStridedSlice (TFStridedSlice.create name inputs out_shp
      0 0 0 0 shrink) in (* tmp: dummy numbers *)
    [|ss; stack0; stack1; stack2|], ("", "")


  let make_reshape_nodes name inputs shp =
    let shp_str = Owl_utils_array.to_string ~sep:"," string_of_int shp in
    let tensor_content = Owl_converter_utils.serialise_tensor_content
      "int32" shp_str
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


  let _get_input_shape owlnode =
    let inode = (Owl_graph.parents owlnode).(0) in
    let iattr : Symbol.Shape.Type.attr = Owl_graph.attr inode in
    match iattr.shape.(0) with
    | Some s -> s
    | None   -> failwith "Owlnode output shape cannot be None"


  (* Be aware of those operation that does not have same input and output shapes. Also, the l2norm here is NOT tf.math.l2_normalize. *)
  let make_l2norm_sqr_nodes name inputs inp_shp out_shp axes keepdims =
    let sqrname = name ^ "/square" in
    let sqrnode = TFSquare (TFSquare.create sqrname inputs inp_shp) in

    let sumname = name ^ "/sum" in
    let sumnodes, _ = make_sum_nodes sumname [|sqrname|] out_shp axes keepdims in
    (* TODO: this does not look like a good systen design -- I acutally need to know how make_sum_nodes works *)
    (Array.append sumnodes [|sqrnode|]), (name, sumname)


  let make_l2norm_nodes name inputs inp_shp out_shp axes keepdims =
    let sqrnodes, (_, uname) = make_l2norm_sqr_nodes name inputs
      inp_shp out_shp axes keepdims in
    let sname = name ^ "/sqrt" in
    let snode = TFSqrt (TFSqrt.create sname [|uname|] out_shp) in
    (Array.append [|snode|] sqrnodes), (name, sname)


  let make_l1norm_nodes name inputs inp_shp out_shp axes keepdims =
    let aname = name ^ "/abs" in
    let anode = TFAbs (TFAbs.create aname inputs inp_shp) in

    let sumname = name ^ "/sum" in
    let sumnodes, _ = make_sum_nodes sumname [|aname|] out_shp axes keepdims in
    (Array.append sumnodes [|anode|]), (name, sumname)


  let make_ofarray_2d_nodes name inputs out_shp shp =
    if (Array.length shp = 1) then (
      [| TFPack (TFPack.create name inputs out_shp 0) |], ("", "")
    ) else if (Array.length shp = 2) then (
      let a = shp.(0) in
      let b = shp.(1) in
      let nodes = Array.make a (TFNoop (TFNoop.create "" [||])) in
      let names = Array.make a "" in
      for i = 0 to a - 1 do
        let nname = Printf.sprintf "%s-%d" name i in
        let ninpt = Array.sub inputs (i * b) b in
        nodes.(i) <- TFPack (TFPack.create nname ninpt [|out_shp.(1)|] 0);
        names.(i) <- nname
      done;
      let nnode2d = TFPack (TFPack.create name names out_shp 1) in
      (Array.append [|nnode2d|] nodes), ("", "")
    ) else (
      failwith "OfArray: dimensions larger than 2 is not supported yet"
    )


  (* The logic of how one owl node turned into multiple tfnodes is implemented
   * here.
   * Currently return node array and "name_update" : string * string; meaning,
   * whoever uses me as his input, now change it to one of my subnodes.
   * About the `attr.shape.(0)` and `(attr.value).(0)` below, currently only
   * `draw` operation in owl CGraph returns two outputs, so I'll stick with
   * this tmp solution for now.
   *
   * NOTE: Another thing is that, even if tfgraph is taken in as a paramter,
   * that still doesn't ensure a node have global access -- in Sum's case, it
   * needs access to its parents, which are not put into tfgraph yet.
   *)
  let make_tfnodes _tfgraph node =
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
    match attr.op with
    | Abs                 -> [| TFAbs (TFAbs.create name inputs out_shp)|], ("", "")
    | Scalar_Abs          -> [| TFAbs (TFAbs.create name inputs out_shp)|], ("", "")
    | Neg                 -> [| TFNeg (TFNeg.create name inputs out_shp)|], ("", "")
    | Scalar_Neg          -> [| TFNeg (TFNeg.create name inputs out_shp)|], ("", "")
    | Exp                 -> [| TFExp (TFExp.create name inputs out_shp)|], ("", "")
    | Scalar_Exp          -> [| TFExp (TFExp.create name inputs out_shp)|], ("", "")
    | Log                 -> [| TFLog (TFLog.create name inputs out_shp)|], ("", "")
    | Log2                -> make_log_nodes name inputs out_shp 2
    | Log10               -> make_log_nodes name inputs out_shp 10
    | Scalar_Log          -> [| TFLog (TFLog.create name inputs out_shp)|], ("", "")
    | Scalar_Log2         -> make_log_nodes name inputs out_shp 2
    | Scalar_Log10        -> make_log_nodes name inputs out_shp 10
    | Sqr                 -> [| TFSquare (TFSquare.create name inputs out_shp)|], ("", "")
    | Scalar_Sqr          -> [| TFSquare (TFSquare.create name inputs out_shp)|], ("", "")
    | Sqrt                -> [| TFSqrt (TFSqrt.create name inputs out_shp)|], ("", "")
    | Scalar_Sqrt         -> [| TFSqrt (TFSqrt.create name inputs out_shp)|], ("", "")
    | Sin                 -> [| TFSin (TFSin.create name inputs out_shp)|], ("", "")
    | Cos                 -> [| TFCos (TFCos.create name inputs out_shp)|], ("", "")
    | Tan                 -> [| TFTan (TFTan.create name inputs out_shp)|], ("", "")
    | Sinh                -> [| TFSinh (TFSinh.create name inputs out_shp)|], ("", "")
    | Cosh                -> [| TFCosh (TFCosh.create name inputs out_shp)|], ("", "")
    | Tanh                -> [| TFTanh (TFTanh.create name inputs out_shp)|], ("", "")
    | Asin                -> [| TFAsin (TFAsin.create name inputs out_shp)|], ("", "")
    | Acos                -> [| TFAcos (TFAcos.create name inputs out_shp)|], ("", "")
    | Atan                -> [| TFAtan (TFAtan.create name inputs out_shp)|], ("", "")
    | Asinh               -> [| TFAsinh (TFAsinh.create name inputs out_shp)|], ("", "")
    | Acosh               -> [| TFCosh (TFCosh.create name inputs out_shp)|], ("", "")
    | Atanh               -> [| TFAtanh (TFAtanh.create name inputs out_shp)|], ("", "")
    | Scalar_Sin          -> [| TFSin (TFSin.create name inputs out_shp)|], ("", "")
    | Scalar_Cos          -> [| TFCos (TFCos.create name inputs out_shp)|], ("", "")
    | Scalar_Tan          -> [| TFTan (TFTan.create name inputs out_shp)|], ("", "")
    | Scalar_Sinh         -> [| TFSinh (TFSinh.create name inputs out_shp)|], ("", "")
    | Scalar_Cosh         -> [| TFCosh (TFCosh.create name inputs out_shp)|], ("", "")
    | Scalar_Tanh         -> [| TFTanh (TFTanh.create name inputs out_shp)|], ("", "")
    | Scalar_Asin         -> [| TFAsin (TFAsin.create name inputs out_shp)|], ("", "")
    | Scalar_Acos         -> [| TFAcos (TFAcos.create name inputs out_shp)|], ("", "")
    | Scalar_Atan         -> [| TFAtan (TFAtan.create name inputs out_shp)|], ("", "")
    | Scalar_Asinh        -> [| TFAsinh (TFAsinh.create name inputs out_shp)|], ("", "")
    | Scalar_Acosh        -> [| TFCosh (TFCosh.create name inputs out_shp)|], ("", "")
    | Scalar_Atanh        -> [| TFAtanh (TFAtanh.create name inputs out_shp)|], ("", "")
    | Sigmoid             -> [| TFSigmoid (TFSigmoid.create name inputs out_shp)|], ("", "")
    | Scalar_Sigmoid      -> [| TFSigmoid (TFSigmoid.create name inputs out_shp)|], ("", "")
    | Dot (a, b, _, _)    -> [| TFMatMul (TFMatMul.create name inputs out_shp a b) |], ("", "")
    | Add                 -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "") (* TODO: actually, it will be translated to TFBiasAdd in DNN example; need to investigate if any condition is included. *)
    | ScalarAdd           -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "")
    | Scalar_Add          -> [| TFAdd (TFAdd.create name inputs out_shp) |], ("", "") (* what's the difference? *)
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
    | Scalar_Div          -> [| TFDiv (TFDiv.create name inputs out_shp) |], ("", "")
    | Pow                 -> [| TFPow (TFPow.create name inputs out_shp) |], ("", "")
    | Scalar_Pow          -> [| TFPow (TFPow.create name inputs out_shp) |], ("", "")
    | Relu                -> [| TFRelu (TFRelu.create name inputs out_shp) |], ("", "")
    | Scalar_Relu         -> [| TFRelu (TFRelu.create name inputs out_shp) |], ("", "")
    | L2NormSqr'          ->
      let input_shp = _get_input_shape node in
      let axes = Owl_utils_array.range 0 (Array.length input_shp - 1) in
      make_l2norm_sqr_nodes name inputs input_shp out_shp axes false
    | L2norm'             ->
      let input_shp = _get_input_shape node in
      let axes = Owl_utils_array.range 0 (Array.length input_shp - 1) in
      make_l2norm_nodes name inputs input_shp out_shp axes false
    | L1norm'             ->
      let input_shp = _get_input_shape node in
      let axes = Owl_utils_array.range 0 (Array.length input_shp - 1) in
      make_l1norm_nodes name inputs input_shp out_shp axes false
    | Conv2d (p, s)       ->
      let s = [|1; s.(0); s.(1); 1|] in
      [| TFConv2D (TFConv2D.create name inputs out_shp p s) |], ("", "")
    | MaxPool1d (p, s, k) ->
      let s = [|1; s.(0); 1|] in
      let k = [|1; k.(0); 1|] in
      [| TFMaxPool (TFMaxPool.create name inputs out_shp p s k) |], ("", "")
    | AvgPool1d (p, s, k) ->
      let s = [|1; s.(0); 1|] in
      let k = [|1; k.(0); 1|] in
      [| TFAvgPool (TFAvgPool.create name inputs out_shp p s k) |], ("", "")
    | MaxPool2d (p, s, k) ->
      let s = [|1; s.(0); s.(1); 1|] in
      let k = [|1; k.(0); k.(1); 1|] in
      [| TFMaxPool (TFMaxPool.create name inputs out_shp p s k) |], ("", "")
    | AvgPool2d (p, s, k) ->
      let s = [|1; s.(0); s.(1); 1|] in
      let k = [|1; k.(0); k.(1); 1|] in
      [| TFAvgPool (TFAvgPool.create name inputs out_shp p s k) |], ("", "")
    | Sum a               -> make_sum_nodes name inputs out_shp [|a|] true
    | SumReduce a         -> make_sum_nodes name inputs out_shp a true
    | Sum'                ->
      let input_shape = _get_input_shape node in
      let axes = Owl_utils_array.range 0 (Array.length input_shape - 1) in
      make_sum_nodes name inputs out_shp axes false
    | Max a               -> make_max_nodes name inputs out_shp [|a|] true
    | Max'                ->
      let input_shape = _get_input_shape node in
      let axes = Owl_utils_array.range 0 (Array.length input_shape - 1) in
      make_max_nodes name inputs out_shp axes false
    | Min a               -> make_min_nodes name inputs out_shp [|a|] true
    | Min'                ->
      let input_shape = _get_input_shape node in
      let axes = Owl_utils_array.range 0 (Array.length input_shape - 1) in
      make_min_nodes name inputs out_shp axes false
    | OfArray shp         -> make_ofarray_2d_nodes name inputs out_shp shp
    (* Only support 1-dim array for now; may need to find a more proper tensorlfow operation *)
    | Var                 -> [| TFPlaceholder (TFPlaceholder.create name out_shp) |], ("", "")
    | Const               ->
      let value = get_const_value attr in
      [| TFConst (TFConst.create ~dtype:"DT_FLOAT" name out_shp value) |], ("", "")
    | Reshape s           -> make_reshape_nodes name inputs s
    | Ones _              -> make_variable_nodes attr.op name out_shp
    | Zeros _             -> make_variable_nodes attr.op name out_shp
    | Uniform _           -> make_variable_nodes attr.op name out_shp
    | Get i               ->
      let b = i in let e = i in
      let len = Array.length i in
      let s = Array.make len 1 in
      let shinrk_mask = (2. ** (float_of_int len) |> int_of_float) - 1 in
      make_stridedslice_nodes name inputs out_shp b e s shinrk_mask
    | GetSlice i          -> (* be carefull when index contains less item than the full length *)
      let input_shp = _get_input_shape node in
      let b, e, s = Owl_converter_utils.get_slice_param i input_shp in
      make_stridedslice_nodes name inputs out_shp b e s 0
    | _                   -> let err = Printf.sprintf "unsupported operation: %s" (Symbol.op_to_str attr.op) in failwith err


  (* not a very good name... *)
  let expand_tfgraph tfgraph owlnode =
    let tfnodes, name_update = make_tfnodes tfgraph owlnode in
    add_tfnodes tfgraph tfnodes name_update


  let to_pbtxt graphdef =
    let node_str = Owl_utils_array.to_string ~sep:"\n" (fun n ->
      to_pbtxt n
    ) graphdef.nodes
    in
    let version_str = Printf.sprintf "versions {\nproducer: %s\n}\n" graphdef.version in
    Printf.sprintf "graph_def {\n%s%s}\n" node_str version_str

end
