(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph


(* Functor of making evaluator of a CPU-based engine *)

module Make
  (Graph : Owl_computation_graph_sig.Sig)
  = struct

  open Graph.Optimiser.Operator.Symbol

  open Graph.Optimiser.Operator.Symbol.Shape.Type.Device


  (* utility functions *)

  let update_validity x =
    validate x;
    Array.iter invalidate (get_vnode x)


  (* core evaluation function *)

  let rec _eval_term x =
    Owl_log.debug "eval %s ..." (node_to_str x);

    if is_valid x = false then
      let _ = try
        match (get_operator x) with
        | Noop                                        -> _eval_map_00 x (fun x -> x.(0))
        | Var                                         -> check_assigned x
        | Const                                       -> check_assigned x
        | Empty _shape                                 -> _eval_map_01 x (fun ~out _x -> ()) [@warning "-27"]
        | Zeros _shape                                 -> _eval_map_01 x (fun ~out _x -> A.zeros_ ~out)
        | Ones _shape                                  -> _eval_map_01 x (fun ~out _x -> A.ones_ ~out)
        | Create _shape                                -> _eval_map_02 x (fun ~out x -> A.create_ ~out x.(0))
        | Sequential _shape                            -> _eval_map_02 x (fun ~out x -> A.sequential_ ~a:x.(0) ~step:x.(1) ~out)
        | Uniform _shape                               -> _eval_map_02 x (fun ~out x -> A.uniform_ ~a:x.(0) ~b:x.(1) ~out)
        | Gaussian _shape                              -> _eval_map_02 x (fun ~out x -> A.gaussian_ ~mu:x.(0) ~sigma:x.(1) ~out)
        | Bernoulli _shape                             -> _eval_map_02 x (fun ~out x -> A.bernoulli_ ~p:x.(0) ~out)
        | Init (_shape, _f)                             -> failwith "Init"
        | Get i                                       -> _eval_map_06 x (fun x -> A.get x i)
        | Set _i                                       -> failwith "Set"
        | GetSlice slice                              -> _eval_map_01 x (fun ~out x -> A.get_slice_ ~out slice x.(0))
        | SetSlice slice                              -> _eval_map_01 x (fun ~out x -> A.set_slice_ ~out slice x.(0) x.(1))
        | Copy                                        -> _eval_map_01 x (fun ~out x -> A.copy_ ~out x.(0)) [@warning "-27"]
        | Reset                                       -> _eval_map_01 x (fun ~out _x -> A.reset out)
        | Reshape _shape                               -> _eval_map_01 x (fun ~out x -> A.reshape_ ~out x.(0))
        | Reverse                                     -> _eval_map_01 x (fun ~out x -> A.reverse_ ~out x.(0))
        | Tile repeats                                -> _eval_map_01 x (fun ~out x -> A.tile_ ~out x.(0) repeats)
        | Repeat repeats                              -> _eval_map_01 x (fun ~out x -> A.repeat_ ~out x.(0) repeats)
        | Concatenate axis                            -> _eval_map_00 x A.(concatenate ~axis)
        | Split (_axis, _parts)                         -> failwith "Split"
        | Draw (_axis, _n)                              -> failwith "Draw"
        | Map _f                                       -> failwith "Map"
        | Fold (_axis, _f)                              -> failwith "Fold"
        | Scan (_axis, _f)                              -> failwith "Scan"
        | OneHot depth                                -> _eval_map_01 x (fun ~out x -> A.one_hot_ ~out depth x.(0))
        | Abs                                         -> _eval_map_01 x (fun ~out x -> A.abs_ ~out x.(0))
        | Neg                                         -> _eval_map_01 x (fun ~out x -> A.neg_ ~out x.(0))
        | Floor                                       -> _eval_map_01 x (fun ~out x -> A.floor_ ~out x.(0))
        | Ceil                                        -> _eval_map_01 x (fun ~out x -> A.ceil_ ~out x.(0))
        | Round                                       -> _eval_map_01 x (fun ~out x -> A.round_ ~out x.(0))
        | Sqr                                         -> _eval_map_01 x (fun ~out x -> A.sqr_ ~out x.(0))
        | Sqrt                                        -> _eval_map_01 x (fun ~out x -> A.sqrt_ ~out x.(0))
        | Log                                         -> _eval_map_01 x (fun ~out x -> A.log_ ~out x.(0))
        | Log2                                        -> _eval_map_01 x (fun ~out x -> A.log2_ ~out x.(0))
        | Log10                                       -> _eval_map_01 x (fun ~out x -> A.log10_ ~out x.(0))
        | Exp                                         -> _eval_map_01 x (fun ~out x -> A.exp_ ~out x.(0))
        | Sin                                         -> _eval_map_01 x (fun ~out x -> A.sin_ ~out x.(0))
        | Cos                                         -> _eval_map_01 x (fun ~out x -> A.cos_ ~out x.(0))
        | Tan                                         -> _eval_map_01 x (fun ~out x -> A.tan_ ~out x.(0))
        | Sinh                                        -> _eval_map_01 x (fun ~out x -> A.sinh_ ~out x.(0))
        | Cosh                                        -> _eval_map_01 x (fun ~out x -> A.cosh_ ~out x.(0))
        | Tanh                                        -> _eval_map_01 x (fun ~out x -> A.tanh_ ~out x.(0))
        | Asin                                        -> _eval_map_01 x (fun ~out x -> A.asin_ ~out x.(0))
        | Acos                                        -> _eval_map_01 x (fun ~out x -> A.acos_ ~out x.(0))
        | Atan                                        -> _eval_map_01 x (fun ~out x -> A.atan_ ~out x.(0))
        | Asinh                                       -> _eval_map_01 x (fun ~out x -> A.asinh_ ~out x.(0))
        | Acosh                                       -> _eval_map_01 x (fun ~out x -> A.acosh_ ~out x.(0))
        | Atanh                                       -> _eval_map_01 x (fun ~out x -> A.atanh_ ~out x.(0))
        | Min axis                                    -> _eval_map_01 x (fun ~out x -> A.min_ ~out ~axis x.(0))
        | Max axis                                    -> _eval_map_01 x (fun ~out x -> A.max_ ~out ~axis x.(0))
        | Sum axis                                    -> _eval_map_01 x (fun ~out x -> A.sum_ ~out ~axis x.(0))
        | SumReduce axis                              -> _eval_map_00 x (fun x -> A.sum_reduce ~axis x.(0))
        | Signum                                      -> _eval_map_01 x (fun ~out x -> A.signum_ ~out x.(0))
        | Sigmoid                                     -> _eval_map_01 x (fun ~out x -> A.sigmoid_ ~out x.(0))
        | Relu                                        -> _eval_map_01 x (fun ~out x -> A.relu_ ~out x.(0))
        | Min'                                        -> _eval_map_06 x A.min'
        | Max'                                        -> _eval_map_06 x A.max'
        | Sum'                                        -> _eval_map_06 x A.sum'
        | L1norm'                                     -> _eval_map_06 x A.l1norm'
        | L2norm'                                     -> _eval_map_06 x A.l2norm'
        | L2NormSqr'                                  -> _eval_map_06 x A.l2norm_sqr'
        | ClipByValue                                 -> _eval_map_07 x (fun ~out a e -> A.clip_by_value_ ~out ~amin:e.(0) ~amax:e.(1) a.(0))
        | ClipByL2norm                                -> _eval_map_07 x (fun ~out a e -> A.clip_by_l2norm_ ~out e.(0) a.(0))
        | Pow                                         -> _eval_map_01 x (fun ~out x -> A.pow_ ~out x.(0) x.(1))
        | ScalarPow                                   -> _eval_map_05 x A.scalar_pow_
        | PowScalar                                   -> _eval_map_04 x A.pow_scalar_
        | Atan2                                       -> _eval_map_01 x (fun ~out x -> A.atan2_ ~out x.(0) x.(1))
        | ScalarAtan2                                 -> _eval_map_05 x A.scalar_atan2_
        | Atan2Scalar                                 -> _eval_map_04 x A.atan2_scalar_
        | Hypot                                       -> _eval_map_01 x (fun ~out x -> A.hypot_ ~out x.(0) x.(1))
        | Min2                                        -> _eval_map_01 x (fun ~out x -> A.min2_ ~out x.(0) x.(1))
        | Max2                                        -> _eval_map_01 x (fun ~out x -> A.max2_ ~out x.(0) x.(1))
        | Add                                         -> _eval_map_01 x (fun ~out x -> A.add_ ~out x.(0) x.(1))
        | Sub                                         -> _eval_map_01 x (fun ~out x -> A.sub_ ~out x.(0) x.(1))
        | Mul                                         -> _eval_map_01 x (fun ~out x -> A.mul_ ~out x.(0) x.(1))
        | Div                                         -> _eval_map_01 x (fun ~out x -> A.div_ ~out x.(0) x.(1))
        | AddScalar                                   -> _eval_map_04 x A.add_scalar_
        | SubScalar                                   -> _eval_map_04 x A.sub_scalar_
        | MulScalar                                   -> _eval_map_04 x A.mul_scalar_
        | DivScalar                                   -> _eval_map_04 x A.div_scalar_
        | ScalarAdd                                   -> _eval_map_05 x A.scalar_add_
        | ScalarSub                                   -> _eval_map_05 x A.scalar_sub_
        | ScalarMul                                   -> _eval_map_05 x A.scalar_mul_
        | ScalarDiv                                   -> _eval_map_05 x A.scalar_div_
        | FMA                                         -> _eval_map_01 x (fun ~out x -> A.fma_ ~out x.(0) x.(1) x.(2))
        | EltEqual                                    -> _eval_map_01 x (fun ~out x -> A.elt_equal_ ~out x.(0) x.(1))
        | EltNotEqual                                 -> _eval_map_01 x (fun ~out x -> A.elt_not_equal_ ~out x.(0) x.(1))
        | EltLess                                     -> _eval_map_01 x (fun ~out x -> A.elt_less_ ~out x.(0) x.(1))
        | EltGreater                                  -> _eval_map_01 x (fun ~out x -> A.elt_greater_ ~out x.(0) x.(1))
        | EltLessEqual                                -> _eval_map_01 x (fun ~out x -> A.elt_less_equal_ ~out x.(0) x.(1))
        | EltGreaterEqual                             -> _eval_map_01 x (fun ~out x -> A.elt_greater_equal_ ~out x.(0) x.(1))
        | EltEqualScalar                              -> _eval_map_04 x A.elt_equal_scalar_
        | EltNotEqualScalar                           -> _eval_map_04 x A.elt_not_equal_scalar_
        | EltLessScalar                               -> _eval_map_04 x A.elt_less_scalar_
        | EltGreaterScalar                            -> _eval_map_04 x A.elt_greater_scalar_
        | EltLessEqualScalar                          -> _eval_map_04 x A.elt_less_equal_scalar_
        | EltGreaterEqualScalar                       -> _eval_map_04 x A.elt_greater_equal_scalar_
        | Conv1d (padding, stride)                    -> _eval_map_01 x (fun ~out x -> A.conv1d_ ~out ~padding x.(0) x.(1) stride)
        | Conv2d (padding, stride)                    -> _eval_map_01 x (fun ~out x -> A.conv2d_ ~out ~padding x.(0) x.(1) stride)
        | Conv3d (padding, stride)                    -> _eval_map_01 x (fun ~out x -> A.conv3d_ ~out ~padding x.(0) x.(1) stride)
        | TransposeConv1d (padding, stride)           -> _eval_map_01 x (fun ~out x -> A.transpose_conv1d_ ~out ~padding x.(0) x.(1) stride)
        | TransposeConv2d (padding, stride)           -> _eval_map_01 x (fun ~out x -> A.transpose_conv2d_ ~out ~padding x.(0) x.(1) stride)
        | TransposeConv3d (padding, stride)           -> _eval_map_01 x (fun ~out x -> A.transpose_conv3d_ ~out ~padding x.(0) x.(1) stride)
        | DilatedConv1d (padding, stride, rate)       -> _eval_map_01 x (fun ~out x -> A.dilated_conv1d_ ~out ~padding x.(0) x.(1) stride rate)
        | DilatedConv2d (padding, stride, rate)       -> _eval_map_01 x (fun ~out x -> A.dilated_conv2d_ ~out ~padding x.(0) x.(1) stride rate)
        | DilatedConv3d (padding, stride, rate)       -> _eval_map_01 x (fun ~out x -> A.dilated_conv3d_ ~out ~padding x.(0) x.(1) stride rate)
        | MaxPool1d (padding, kernel, stride)         -> _eval_map_01 x (fun ~out x -> A.max_pool1d_ ~out ~padding x.(0) kernel stride)
        | MaxPool2d (padding, kernel, stride)         -> _eval_map_01 x (fun ~out x -> A.max_pool2d_ ~out ~padding x.(0) kernel stride)
        | MaxPool3d (padding, kernel, stride)         -> _eval_map_01 x (fun ~out x -> A.max_pool3d_ ~out ~padding x.(0) kernel stride)
        | AvgPool1d (padding, kernel, stride)         -> _eval_map_01 x (fun ~out x -> A.avg_pool1d_ ~out ~padding x.(0) kernel stride)
        | AvgPool2d (padding, kernel, stride)         -> _eval_map_01 x (fun ~out x -> A.avg_pool2d_ ~out ~padding x.(0) kernel stride)
        | AvgPool3d (padding, kernel, stride)         -> _eval_map_01 x (fun ~out x -> A.avg_pool3d_ ~out ~padding x.(0) kernel stride)
        | Conv1dBackwardInput stride                  -> _eval_map_01 x (fun ~out x -> A.conv1d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | Conv1dBackwardKernel stride                 -> _eval_map_01 x (fun ~out x -> A.conv1d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | Conv2dBackwardInput stride                  -> _eval_map_01 x (fun ~out x -> A.conv2d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | Conv2dBackwardKernel stride                 -> _eval_map_01 x (fun ~out x -> A.conv2d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | Conv3dBackwardInput stride                  -> _eval_map_01 x (fun ~out x -> A.conv3d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | Conv3dBackwardKernel stride                 -> _eval_map_01 x (fun ~out x -> A.conv3d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv1dBackwardInput stride         -> _eval_map_01 x (fun ~out x -> A.transpose_conv1d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv1dBackwardKernel stride        -> _eval_map_01 x (fun ~out x -> A.transpose_conv1d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardInput stride         -> _eval_map_01 x (fun ~out x -> A.transpose_conv2d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardKernel stride        -> _eval_map_01 x (fun ~out x -> A.transpose_conv2d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv3dBackwardInput stride         -> _eval_map_01 x (fun ~out x -> A.transpose_conv3d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv3dBackwardKernel stride        -> _eval_map_01 x (fun ~out x -> A.transpose_conv3d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | DilatedConv1dBackwardInput (stride, rate)   -> _eval_map_01 x (fun ~out x -> A.dilated_conv1d_backward_input_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv1dBackwardKernel (stride, rate)  -> _eval_map_01 x (fun ~out x -> A.dilated_conv1d_backward_kernel_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv2dBackwardInput (stride, rate)   -> _eval_map_01 x (fun ~out x -> A.dilated_conv2d_backward_input_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv2dBackwardKernel (stride, rate)  -> _eval_map_01 x (fun ~out x -> A.dilated_conv2d_backward_kernel_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv3dBackwardInput (stride, rate)   -> _eval_map_01 x (fun ~out x -> A.dilated_conv3d_backward_input_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv3dBackwardKernel (stride, rate)  -> _eval_map_01 x (fun ~out x -> A.dilated_conv3d_backward_kernel_ ~out x.(0) x.(1) stride rate x.(2))
        | MaxPool1dBackward (padding, kernel, stride) -> _eval_map_01 x (fun ~out x -> A.max_pool1d_backward_ ~out padding x.(0) kernel stride x.(1))
        | MaxPool2dBackward (padding, kernel, stride) -> _eval_map_01 x (fun ~out x -> A.max_pool2d_backward_ ~out padding x.(0) kernel stride x.(1))
        | MaxPool3dBackward (padding, kernel, stride) -> _eval_map_01 x (fun ~out x -> A.max_pool3d_backward_ ~out padding x.(0) kernel stride x.(1))
        | AvgPool1dBackward (padding, kernel, stride) -> _eval_map_01 x (fun ~out x -> A.avg_pool1d_backward_ ~out padding x.(0) kernel stride x.(1))
        | AvgPool2dBackward (padding, kernel, stride) -> _eval_map_01 x (fun ~out x -> A.avg_pool2d_backward_ ~out padding x.(0) kernel stride x.(1))
        | AvgPool3dBackward (padding, kernel, stride) -> _eval_map_01 x (fun ~out x -> A.avg_pool3d_backward_ ~out padding x.(0) kernel stride x.(1))
        | Row                                         -> failwith "Row"
        | Rows _i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (transa, transb, alpha, beta)           -> _eval_map_01 x (fun ~out x -> A.dot_ ~transa ~transb ~alpha:(unpack_elt alpha) ~beta:(unpack_elt beta) ~c:out x.(0) x.(1))
        | Inv                                         -> _eval_map_00 x (fun x -> A.inv x.(0))
        | Trace                                       -> _eval_map_06 x A.trace
        | Transpose axis                              -> _eval_map_01 x (fun ~out x -> A.transpose_ ~out ~axis x.(0))
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | Scalar_Add                                  -> _eval_map_03 x (fun x -> A.Scalar.add x.(0) x.(1))
        | Scalar_Sub                                  -> _eval_map_03 x (fun x -> A.Scalar.sub x.(0) x.(1))
        | Scalar_Mul                                  -> _eval_map_03 x (fun x -> A.Scalar.mul x.(0) x.(1))
        | Scalar_Div                                  -> _eval_map_03 x (fun x -> A.Scalar.div x.(0) x.(1))
        | Scalar_Pow                                  -> _eval_map_03 x (fun x -> A.Scalar.pow x.(0) x.(1))
        | Scalar_Atan2                                -> _eval_map_03 x (fun x -> A.Scalar.atan2 x.(0) x.(1))
        | Scalar_Abs                                  -> _eval_map_03 x (fun x -> A.Scalar.abs x.(0))
        | Scalar_Neg                                  -> _eval_map_03 x (fun x -> A.Scalar.neg x.(0))
        | Scalar_Sqr                                  -> _eval_map_03 x (fun x -> A.Scalar.sqr x.(0))
        | Scalar_Sqrt                                 -> _eval_map_03 x (fun x -> A.Scalar.sqrt x.(0))
        | Scalar_Exp                                  -> _eval_map_03 x (fun x -> A.Scalar.exp x.(0))
        | Scalar_Log                                  -> _eval_map_03 x (fun x -> A.Scalar.log x.(0))
        | Scalar_Log2                                 -> _eval_map_03 x (fun x -> A.Scalar.log2 x.(0))
        | Scalar_Log10                                -> _eval_map_03 x (fun x -> A.Scalar.log10 x.(0))
        | Scalar_Signum                               -> _eval_map_03 x (fun x -> A.Scalar.signum x.(0))
        | Scalar_Floor                                -> _eval_map_03 x (fun x -> A.Scalar.floor x.(0))
        | Scalar_Ceil                                 -> _eval_map_03 x (fun x -> A.Scalar.ceil x.(0))
        | Scalar_Round                                -> _eval_map_03 x (fun x -> A.Scalar.round x.(0))
        | Scalar_Sin                                  -> _eval_map_03 x (fun x -> A.Scalar.sin x.(0))
        | Scalar_Cos                                  -> _eval_map_03 x (fun x -> A.Scalar.cos x.(0))
        | Scalar_Tan                                  -> _eval_map_03 x (fun x -> A.Scalar.tan x.(0))
        | Scalar_Sinh                                 -> _eval_map_03 x (fun x -> A.Scalar.sinh x.(0))
        | Scalar_Cosh                                 -> _eval_map_03 x (fun x -> A.Scalar.cosh x.(0))
        | Scalar_Tanh                                 -> _eval_map_03 x (fun x -> A.Scalar.tanh x.(0))
        | Scalar_Asin                                 -> _eval_map_03 x (fun x -> A.Scalar.asin x.(0))
        | Scalar_Acos                                 -> _eval_map_03 x (fun x -> A.Scalar.acos x.(0))
        | Scalar_Atan                                 -> _eval_map_03 x (fun x -> A.Scalar.atan x.(0))
        | Scalar_Asinh                                -> _eval_map_03 x (fun x -> A.Scalar.asinh x.(0))
        | Scalar_Acosh                                -> _eval_map_03 x (fun x -> A.Scalar.acosh x.(0))
        | Scalar_Atanh                                -> _eval_map_03 x (fun x -> A.Scalar.atanh x.(0))
        | Scalar_Relu                                 -> _eval_map_03 x (fun x -> A.Scalar.relu x.(0))
        | Scalar_Sigmoid                              -> _eval_map_03 x (fun x -> A.Scalar.sigmoid x.(0))
        | Fused_Adagrad (rate, eps)                   -> _eval_map_01 x (fun ~out x -> A.fused_adagrad_ ~out ~rate ~eps x.(0))
        | _                                           -> failwith "owl_computation_eval:_eval_term"

        with exn -> (
          Owl_log.error "evaluating %s" (node_to_str x);
          raise exn
        )
      in
      update_validity x


  (* [f] is pure, for [arr array -> arr] *)
  and _eval_map_00 x f =
    let inputs = Array.map (fun x ->
      _eval_term x;
      value_to_arr (get_value x).(0)
    ) (parents x)
    in
    let out = f inputs in
    set_value x [|arr_to_value out|]


  (* [f] is inpure, for [arr array -> arr] *)
  and _eval_map_01 x f =
    let inputs = Array.map (fun parent ->
      _eval_term parent;
      value_to_arr (get_value parent).(0)
    ) (parents x)
    in
    let out = value_to_arr (get_value x).(0) in
    f ~out inputs


  (* [f] is inpure, for [elt array -> arr] *)
  and _eval_map_02 x f =
    let inputs = Array.map (fun parent ->
      _eval_term parent;
      value_to_elt (get_value parent).(0)
    ) (parents x)
    in
    let out = value_to_arr (get_value x).(0) in
    f ~out inputs


  (* [f] is pure, for [elt array -> elt] *)
  and _eval_map_03 x f =
    let inputs = Array.map (fun parent ->
      _eval_term parent;
      value_to_elt (get_value parent).(0)
    ) (parents x)
    in
    let out = f inputs in
    set_value x [|elt_to_value out|]


  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map_04 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_arr (get_value x_parent_0).(0) in
    let b = value_to_elt (get_value x_parent_1).(0) in
    let out = value_to_arr (get_value x).(0) in
    f ~out a b


  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map_05 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_elt (get_value x_parent_0).(0) in
    let b = value_to_arr (get_value x_parent_1).(0) in
    let out = value_to_arr (get_value x).(0) in
    f ~out a b


  (* [f] is pure, for [arr -> elt] *)
  and _eval_map_06 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|elt_to_value a|]


  (* [f] is inpure, for [arr array -> elt array -> arr] *)
  and _eval_map_07 x f =
    let x_parents = parents x in
    Array.iter _eval_term x_parents;
    let arr_args = Owl_utils_array.filter is_arr x_parents |> Array.map (fun v -> (get_value v).(0) |> value_to_arr) in
    let elt_args = Owl_utils_array.filter is_elt x_parents |> Array.map (fun v -> (get_value v).(0) |> value_to_elt) in
    let out = value_to_arr (get_value x).(0) in
    f ~out arr_args elt_args


end


(* Make functor ends *)
