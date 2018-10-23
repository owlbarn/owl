(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph

(* Functor of making the symbols of a computation graph. *)

module Make
  (Shape : Owl_computation_shape_sig.Sig)
  = struct

  module Shape = Shape

  open Shape

  open Shape.Type

  open Shape.Type.Device

  (* string representation of symbols *)

  let op_to_str = function
    | Noop                                           -> "Noop"
    | Var                                            -> "Var"
    | Const                                          -> "Const"
    | Empty _shape                                   -> "Empty"
    | Zeros _shape                                   -> "Zeros"
    | Ones _shape                                    -> "Ones"
    | Create _shape                                  -> "Create"
    | Sequential _shape                              -> "Sequential"
    | Uniform _shape                                 -> "Uniform"
    | Gaussian _shape                                -> "Gaussian"
    | Bernoulli _shape                               -> "Bernoulli"
    | Init (_shape, _f)                              -> "Init"
    | Get _i                                         -> "Get"
    | Set _i                                         -> "Set"
    | GetSlice _slice                                -> "GetSlice"
    | SetSlice _slice                                -> "SetSlice"
    | Copy                                           -> "Copy"
    | Reset                                          -> "Reset"
    | Reshape _shape                                 -> "Reshape"
    | Reverse                                        -> "Reverse"
    | Tile _repeats                                  -> "Tile"
    | Repeat _repeats                                -> "Repeat"
    | Concatenate _axis                              -> "Concatenate"
    | Split (_axis, _parts)                          -> "Split"
    | Draw (_axis, _n)                               -> "Draw"
    | Map _f                                         -> "Map"
    | Fold (_axis, _f)                               -> "Fold"
    | Scan (_axis, _f)                               -> "Scan"
    | OneHot depth                                   -> Printf.sprintf "OneHot d:%i" depth
    | Delay _f                                       -> "Delay"
    | DelayArray (_shape, _f)                        -> "DelayArray"
    | Abs                                            -> "Abs"
    | Neg                                            -> "Neg"
    | Floor                                          -> "Floor"
    | Ceil                                           -> "Ceil"
    | Round                                          -> "Round"
    | Sqr                                            -> "Sqr"
    | Sqrt                                           -> "Sqrt"
    | Log                                            -> "Log"
    | Log2                                           -> "Log2"
    | Log10                                          -> "Log10"
    | Exp                                            -> "Exp"
    | Sin                                            -> "Sin"
    | Cos                                            -> "Cos"
    | Tan                                            -> "Tan"
    | Sinh                                           -> "Sinh"
    | Cosh                                           -> "Cosh"
    | Tanh                                           -> "Tanh"
    | Asin                                           -> "Asin"
    | Acos                                           -> "Acos"
    | Atan                                           -> "Atan"
    | Asinh                                          -> "Asinh"
    | Acosh                                          -> "Acosh"
    | Atanh                                          -> "Atanh"
    | Min axis                                       -> Printf.sprintf "Min axis:%i" axis
    | Max axis                                       -> Printf.sprintf "Max axis:%i" axis
    | Sum axis                                       -> Printf.sprintf "Sum axis:%i" axis
    | SumReduce _axis                                -> "SumReduce"
    | Signum                                         -> "Signum"
    | Sigmoid                                        -> "Sigmoid"
    | Relu                                           -> "Relu"
    | Min'                                           -> "Min'"
    | Max'                                           -> "Max'"
    | Sum'                                           -> "Sum'"
    | L1norm'                                        -> "L1norm'"
    | L2norm'                                        -> "L2norm'"
    | L2NormSqr'                                     -> "L2NormSqr'"
    | ClipByValue                                    -> "ClipByValue"
    | ClipByL2norm                                   -> "ClipByL2norm"
    | Pow                                            -> "Pow"
    | ScalarPow                                      -> "ScalarPow"
    | PowScalar                                      -> "PowScalar"
    | Atan2                                          -> "Atan2"
    | ScalarAtan2                                    -> "ScalarAtan2"
    | Atan2Scalar                                    -> "Atan2Scalar"
    | Hypot                                          -> "Hypot"
    | Min2                                           -> "Min2"
    | Max2                                           -> "Max2"
    | Add                                            -> "Add"
    | Sub                                            -> "Sub"
    | Mul                                            -> "Mul"
    | Div                                            -> "Div"
    | AddScalar                                      -> "AddScalar"
    | SubScalar                                      -> "SubScalar"
    | MulScalar                                      -> "MulScalar"
    | DivScalar                                      -> "DivScalar"
    | ScalarAdd                                      -> "ScalarAdd"
    | ScalarSub                                      -> "ScalarSub"
    | ScalarMul                                      -> "ScalarMul"
    | ScalarDiv                                      -> "ScalarDiv"
    | FMA                                            -> "FMA"
    | EltEqual                                       -> "EltEqual"
    | EltNotEqual                                    -> "EltNotEqual"
    | EltLess                                        -> "EltLess"
    | EltGreater                                     -> "EltGreater"
    | EltLessEqual                                   -> "EltLessEqual"
    | EltGreaterEqual                                -> "EltGreaterEqual"
    | EltEqualScalar                                 -> "EltEqualScalar"
    | EltNotEqualScalar                              -> "EltNotEqualScalar"
    | EltLessScalar                                  -> "EltLessScalar"
    | EltGreaterScalar                               -> "EltGreaterScalar"
    | EltLessEqualScalar                             -> "EltLessEqualScalar"
    | EltGreaterEqualScalar                          -> "EltGreaterEqualScalar"
    | Conv1d (_padding, _stride)                     -> "Conv1d"
    | Conv2d (__padding, __stride)                   -> "Conv2d"
    | Conv3d (_padding, _stride)                     -> "Conv3d"
    | TransposeConv1d (_padding, _stride)            -> "TransposeConv1d"
    | TransposeConv2d (_padding, _stride)            -> "TransposeConv2d"
    | TransposeConv3d (_padding, _stride)            -> "TransposeConv3d"
    | DilatedConv1d (_padding, _stride, _rate)       -> "DilatedConv1d"
    | DilatedConv2d (_padding, _stride, _rate)       -> "DilatedConv2d"
    | DilatedConv3d (_padding, _stride, _rate)       -> "DilatedConv3d"
    | MaxPool1d (_padding, _kernel, _stride)         -> "MaxPool1d"
    | MaxPool2d (_padding, _kernel, _stride)         -> "MaxPool2d"
    | MaxPool3d (_padding, _kernel, _stride)         -> "MaxPool3d"
    | AvgPool1d (_padding, _kernel, _stride)         -> "AvgPool1d"
    | AvgPool2d (_padding, _kernel, _stride)         -> "AvgPool2d"
    | AvgPool3d (_padding, _kernel, _stride)         -> "AvgPool3d"
    | UpSampling2d _size                             -> "UpSampling2d"
    | Conv1dBackwardInput _stride                    -> "Conv1dBackwardInput"
    | Conv1dBackwardKernel _stride                   -> "Conv1dBackwardKernel"
    | Conv2dBackwardInput _stride                    -> "Conv2dBackwardInput"
    | Conv2dBackwardKernel _stride                   -> "Conv2dBackwardKernel"
    | Conv3dBackwardInput _stride                    -> "Conv3dBackwardInput"
    | Conv3dBackwardKernel _stride                   -> "Conv3dBackwardKernel"
    | TransposeConv1dBackwardInput _stride           -> "TransposeConv1dBackwardInput"
    | TransposeConv1dBackwardKernel _stride          -> "TransposeConv1dBackwardKernel"
    | TransposeConv2dBackwardInput _stride           -> "TransposeConv2dBackwardInput"
    | TransposeConv2dBackwardKernel _stride          -> "TransposeConv2dBackwardKernel"
    | TransposeConv3dBackwardInput _stride           -> "TransposeConv3dBackwardInput"
    | TransposeConv3dBackwardKernel _stride          -> "TransposeConv3dBackwardKernel"
    | DilatedConv1dBackwardInput (_stride, _rate)    -> "DilatedConv1dBackwardInput"
    | DilatedConv1dBackwardKernel (_stride, _rate)   -> "DilatedConv1dBackwardKernel"
    | DilatedConv2dBackwardInput (_stride, _rate)    -> "DilatedConv2dBackwardInput"
    | DilatedConv2dBackwardKernel (_stride, _rate)   -> "DilatedConv2dBackwardKernel"
    | DilatedConv3dBackwardInput (_stride, _rate)    -> "DilatedConv3dBackwardInput"
    | DilatedConv3dBackwardKernel (_stride, _rate)   -> "DilatedConv3dBackwardKernel"
    | MaxPool1dBackward (_padding, _kernel, _stride) -> "MaxPool1dBackward"
    | MaxPool2dBackward (_padding, _kernel, _stride) -> "MaxPool2dBackward"
    | MaxPool3dBackward (_padding, _kernel, _stride) -> "MaxPool3dBackward"
    | AvgPool1dBackward (_padding, _kernel, _stride) -> "AvgPool1dBackward"
    | AvgPool2dBackward (_padding, _kernel, _stride) -> "AvgPool2dBackward"
    | AvgPool3dBackward (_padding, _kernel, _stride) -> "AvgPool3dBackward"
    | UpSampling2dBackward _size                     -> "UpSampling2dBackward"
    | Pad (_v, _padding)                             -> "Pad"
    | RowNum                                         -> "RowNum"
    | ColNum                                         -> "ColNum"
    | Row                                            -> "Row"
    | Rows _i                                        -> "Rows"
    | CopyRowTo                                      -> "CopyRowTo"
    | CopyColTo                                      -> "CopyColTo"
    | Dot (_transa, _transb, _alpha, _beta)          -> "Dot"
    | Inv                                            -> "Inv"
    | Trace                                          -> "Trace"
    | Transpose _i                                   -> "Transpose"
    | ToRows                                         -> "ToRows"
    | OfRows                                         -> "OfRows"
    | Scalar_Add                                     -> "Scalar Add"
    | Scalar_Sub                                     -> "Scalar Sub"
    | Scalar_Mul                                     -> "Scalar Mul"
    | Scalar_Div                                     -> "Scalar Div"
    | Scalar_Pow                                     -> "Scalar Pow"
    | Scalar_Atan2                                   -> "Scalar Atan2"
    | Scalar_Abs                                     -> "Scalar Abs"
    | Scalar_Neg                                     -> "Scalar Neg"
    | Scalar_Sqr                                     -> "Scalar Sqr"
    | Scalar_Sqrt                                    -> "Scalar Sqrt"
    | Scalar_Exp                                     -> "Scalar Exp"
    | Scalar_Log                                     -> "Scalar Log"
    | Scalar_Log2                                    -> "Scalar Log2"
    | Scalar_Log10                                   -> "Scalar Log10"
    | Scalar_Signum                                  -> "Scalar Signum"
    | Scalar_Floor                                   -> "Scalar Floor"
    | Scalar_Ceil                                    -> "Scalar Ceil"
    | Scalar_Round                                   -> "Scalar Round"
    | Scalar_Sin                                     -> "Scalar Sin"
    | Scalar_Cos                                     -> "Scalar Cos"
    | Scalar_Tan                                     -> "Scalar Tan"
    | Scalar_Sinh                                    -> "Scalar Sinh"
    | Scalar_Cosh                                    -> "Scalar Cosh"
    | Scalar_Tanh                                    -> "Scalar Tanh"
    | Scalar_Asin                                    -> "Scalar Asin"
    | Scalar_Acos                                    -> "Scalar Acos"
    | Scalar_Atan                                    -> "Scalar Atan"
    | Scalar_Asinh                                   -> "Scalar Asinh"
    | Scalar_Acosh                                   -> "Scalar Acosh"
    | Scalar_Atanh                                   -> "Scalar Atanh"
    | Scalar_Relu                                    -> "Scalar Relu"
    | Scalar_Sigmoid                                 -> "Scalar Sigmoid"
    | Fused_Adagrad (_rate, _eps)                    -> "Fused_Adagrad"



  (* utility functions *)

  let is_random_variable = function
    | Uniform _shape   -> true
    | Gaussian _shape  -> true
    | Bernoulli _shape -> true
    | _                -> false


  let refnum x = Owl_graph.outdegree x


  let node_shape x =
    let x_shape = (attr x).shape in
    assert (Array.length x_shape > 0);
    match x_shape.(0) with
    | Some s -> s
    | None   -> failwith "Owl_computation_symbol:node_shape"


  let node_numel x = Array.fold_left ( * ) 1 (node_shape x)


  let is_shape_unknown x =
    let x_shape = (attr x).shape in
    match x_shape.(0) with
    | Some _ -> true
    | None   -> false


  let infer_shape_graph xs =
    iter_descendants (fun x ->
      if is_shape_unknown x = false then (
        let x_attr = attr x in
        let x_parents = parents x in
        x_attr.shape <- infer_shape x_attr.op x_parents
      )
    ) xs


  let shape_to_str shp =
    assert (Array.length shp > 0);
    let s = match shp.(0) with
      | Some s -> Owl_utils_array.to_string string_of_int s
      | None   -> "unknown"
    in
    Printf.sprintf "[%s]" s


  let node_to_str n =
    let attr = attr n in
    let shape_s = shape_to_str attr.shape in
    let state_s = if attr.state = Valid then "valid" else "invalid" in
    Printf.sprintf "[ #%i | name:%s | op:%s | state:%s | r:%i | s:%s ]"
      (id n) (name n) (op_to_str attr.op) state_s (refnum n) shape_s


  (* core manipulation functions *)

  let node_to_arr x = Arr x


  let arr_to_node = function Arr x -> x


  let node_to_elt x = Elt x


  let elt_to_node = function Elt x -> x


  let new_block_id =
    let _global_block_id = ref 0 in
    (fun () ->
      _global_block_id := !_global_block_id + 1;
      !_global_block_id)


  (* Meant for reusable nodes. *)
  let make_empty_block ?block_id size =
    let block_id = match block_id with
      | Some block_id -> block_id
      | None          -> new_block_id () in
    (* allocate a one-dimensional array *)
    let memory = arr_to_value (A.empty [|size|]) in
    { size; block_id; active = None; memory; nodes = []; }


  (* This is meant for nodes that are not reusable: memory is not reshaped. *)
  let make_value_block memory x =
    let block_id = new_block_id () in
    let size = if is_elt memory then 1
               else A.numel (value_to_arr memory) in
    let block = { size; block_id; active = Some x; memory; nodes = [ x ]; } in
    (attr x).value <- [| memory |];
    (attr x).block <- Some [| block |]


  let make_node ?name ?value ?shape ?freeze ?reuse ?state op =
    let shape = match shape with Some s -> s | None -> [| None |] in
    let state = match state with Some s -> s | None -> Invalid in
    let reuse = match reuse with Some s -> s | None -> true in
    let freeze = match freeze with Some s -> s | None -> false in
    let value = match value with Some v -> v | None -> [| |] in
    let attr = { op; freeze; reuse; state; shape; value; block = None; } in
    let node = Owl_graph.node ?name attr in
    if value <> [| |] then (
      make_value_block value.(0) node
    );
    node


  let make_then_connect ?shape op parents =
    let shape = match shape with
      | Some s -> s
      | None   -> infer_shape op parents
    in
    let child = make_node ~shape op in
    (* define the dependency of operation, can have duplicates *)
    connect_ancestors parents [|child|];
    (* define the flow of computation graph, no duplicates *)
    let uniq_parents = Owl_utils_array.unique parents in
    Array.iter (fun parent ->
      if (attr parent).freeze = false then
        connect_descendants [|parent|] [|child|]
    ) uniq_parents;
    child


  let var_arr ?shape name =
    make_node ~name ~shape:[| shape |] ~reuse:false Var
    |> node_to_arr


  let var_elt name =
    make_node ~name ~shape:[| Some [||] |] ~reuse:false Var
    |> node_to_elt


  let const_arr name v =
    let value = [| arr_to_value v |] in
    let shape = [| Some A.(shape v) |] in
    make_node ~name ~value ~shape ~freeze:true ~reuse:false ~state:Valid Const
    |> node_to_arr


  let const_elt name v =
    let value = [| elt_to_value v |] in
    let shape = [| Some [||] |] in
    make_node ~name ~value ~shape ~freeze:true ~reuse:false ~state:Valid Const
    |> node_to_elt


  let get_nodes_using_block b = b.nodes


  let _get_value_block b = b.memory


  let get_block_opt x = (attr x).block


  let get_block x = match get_block_opt x with
    | Some b -> b
    | None   -> failwith "Symbol:get_block_exn: block not assigned"


  let _set_block x b = (attr x).block <- Some b


  let add_node_to_block x block =
    let dst_shp = node_shape x in
    let dst_numel = node_numel x in
    let src_val = value_to_arr (_get_value_block block) in
    (* allocate the first [dst_numel] elements for the memory of the node *)
    let dst_val = arr_to_value (A.reshape (A.sub_left src_val 0 dst_numel) dst_shp) in
    block.nodes <- x :: block.nodes;
    _set_block x [| block |];
    (attr x).value <- [| dst_val |]


  let get_active_node b = b.active


  let set_active_node b x = b.active <- Some x


  let get_block_id x = match get_block_opt x with
    | Some bs -> bs.(0).block_id
    | None    -> -1


  let set_value x v =
    if is_arr v.(0) then (
      match get_block_opt x with
      | Some _ ->
         let xv = value_to_arr (attr x).value.(0) in
         let vv = value_to_arr v.(0) in
         A.copy_ ~out:xv vv
      | None   -> make_value_block v.(0) x
    )
    else (
      match get_block_opt x with
      | Some bs -> (attr x).value <- v; bs.(0).memory <- v.(0)
      | None    -> make_value_block v.(0) x
    )


  let get_value x = (attr x).value


  let set_operator x op = (attr x).op <- op


  let get_operator x = (attr x).op


  let set_reuse x reuse =
    let op = (attr x).op in
    if op = Var && op = Const then
      Owl_log.warn "set_reuse: ignored, %s" (node_to_str x)
    else
      (attr x).reuse <- reuse


  let is_reusable x = (attr x).reuse


  let is_shared x = match get_block_opt x with
    | Some bs -> (match get_nodes_using_block bs.(0) with
                  | _ :: _ :: _ -> true (* at least 2 elements *)
                  | _           -> false
                 )
    | None    -> false


  (* contains itself *)
  let get_shared_nodes x = match get_block_opt x with
    | Some bs -> Array.of_list (get_nodes_using_block bs.(0))
    | None    -> [| x |]


  let is_var x = (attr x).op = Var


  let is_const x = (attr x).op = Const


  let is_node_arr x =
    match (attr x).shape.(0) with
    | Some [||] -> false
    | Some _    -> true
    | _         -> failwith "Owl_computation_symbol:is_arr"


  let is_node_elt x =
    match (attr x).shape.(0) with
    | Some [||] -> true
    | Some _    -> false
    | _         -> failwith "Owl_computation_symbol:is_elt"


  let is_assigned x =
    match get_block_opt x with
    | Some _ -> true
    | None   -> false


  let check_assigned x =
    if not (is_assigned x) then (
      Owl_log.error "value not assigned: %s" (node_to_str x);
      failwith "owl_computation_symbol:check_assigned"
    )


  let is_valid x = (attr x).state = Valid


  let validate x = (attr x).state <- Valid


  let invalidate x = (attr x).state <- Invalid


  let invalidate_graph x = iter_descendants invalidate [|x|]


  let is_freeze x = (attr x).freeze


  let freeze x = (attr x).freeze <- true


  let freeze_descendants x = iter_descendants freeze x


  let freeze_ancestors x = iter_ancestors freeze x


  let pack_arr arr = const_arr "" arr


  let unpack_arr x =
    let value = arr_to_node x |> get_value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "not evaluated: %s" (arr_to_node x |> node_to_str);
      assert (valen > 0)
    );
    value_to_arr value.(0)


  let pack_elt elt = const_elt "" elt


  let unpack_elt x =
    let value = elt_to_node x |> get_value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "not evaluated: %s" (elt_to_node x |> node_to_str);
      assert (valen > 0)
    );
    value_to_elt value.(0)


  let unsafe_assign_arr x arr =
    let node = arr_to_node x in
    if is_var node then (
      if is_assigned node = false then (
        (attr node).shape <- [| Some A.(shape arr) |];
        infer_shape_graph [| node |]
      );
      set_value node [| arr_to_value arr |];
      invalidate_graph node
    )
    else
      let info = node_to_str node in
      Printf.sprintf "unsafe_assign_arr: const cannot be assigned, %s" info
      |> failwith


  let assign_arr x arr =
    let node = arr_to_node x in
    if is_var node then (
      if is_assigned node then (
        let out = unpack_arr x in
        A.copy_ ~out arr
      )
      else (
        let dst = A.copy arr in
        set_value node [| arr_to_value dst |];
        (* propagate the shape information *)
        (attr node).shape <- [| Some A.(shape dst) |];
        infer_shape_graph [| node |]
      );
      invalidate_graph node
    )
    else
      let info = node_to_str node in
      Printf.sprintf "assign_arr: const cannot be assigned, %s" info
      |> failwith


  let assign_elt x elt =
    let node = elt_to_node x in
    if is_var node then (
      set_value node [| elt_to_value elt |];
      invalidate_graph node
    )
    else
      let info = node_to_str node in
      Printf.sprintf "assign_elt: const cannot be assigned, %s" info
      |> failwith


  let float_to_elt x = const_elt "" (A.float_to_elt x)


  let elt_to_float x = unpack_elt x |> A.elt_to_float


end

(* Make functor ends *)
