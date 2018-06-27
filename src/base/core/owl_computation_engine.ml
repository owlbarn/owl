(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making a CPU-based engine to execute computation graphs. *)

module Make (A : Ndarray_Mutable) = struct

  module CGraph = Owl_computation_graph.Make (A) (Owl_computation_device)

  module CGInit = Owl_computation_engine_init.Make (A)

  include CGraph


  (* utility functions *)

  let update_validity x =
    validate x;
    Array.iter invalidate (get_vnode x)


  let allocate_1 x =
    let x_val = value_to_arr (attr x).value.(0) in
    if refnum x = 1 && get_reuse x then (
      invalidate x;
      x_val
    )
    else A.copy x_val


  (* core evaluation function *)

  let rec _eval_term x =
    Owl_log.debug "eval %s ..." (node_to_str x);

    if is_valid x = false then
      let _ = try
        match (get_operator x) with
        | Noop                                        -> _eval_map_99 x (fun x -> x)
        | Var                                         -> check_assigned x
        | Const                                       -> check_assigned x
        | Empty shape                                 -> _eval_map_08 x (fun ~out x -> ())
        | Zeros shape                                 -> _eval_map_06 x (fun ~out x -> A.zeros_ ~out)
        | Ones shape                                  -> _eval_map_06 x (fun ~out x -> A.ones_ ~out)
        | Create shape                                -> _eval_map_08 x (fun ~out x -> A.create_ ~out x.(0))
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> _eval_map_08 x (fun ~out x -> A.uniform_ ~a:x.(0) ~b:x.(1) ~out)
        | Gaussian                                    -> failwith "Gaussian"
        | Bernoulli (p, shape)                        -> _eval_map_06 x (fun ~out x -> A.bernoulli_ ~p ~out)
        | Init _                                      -> failwith "Init"
        | Get i                                       -> _eval_map_07 x (fun x -> A.get x i)
        | Set i                                       -> failwith "Set"
        | GetSlice slice                              -> _eval_map_05 x (fun x -> A.get_slice slice x.(0))
        | SetSlice slice                              -> failwith "SetSlice"
        | Copy                                        -> _eval_map_00 x (fun x -> x)
        | Reset                                       -> failwith "Reset"
        | Reshape shape                               -> _eval_map_11 x (fun x -> A.reshape x shape)
        | Reverse                                     -> _eval_map_00 x A.reverse
        | Tile repeats                                -> _eval_map_05 x (fun x -> A.tile x.(0) repeats)
        | Repeat (axis, repeats)                      -> _eval_map_05 x (fun x -> A.repeat ~axis x.(0) repeats)
        | Concatenate axis                            -> _eval_map_05 x A.(concatenate ~axis)
        | Split (axis, parts)                         -> failwith "Split"
        | Draw (axis, n)                              -> failwith "Draw"
        | Map f                                       -> failwith "Map"
        | Fold (axis, f)                              -> failwith "Fold"
        | Scan (axis, f)                              -> failwith "Scan"
        | OneHot depth                                -> _eval_map_06 x (fun ~out x -> A.one_hot_ ~out depth x.(0))
        | Abs                                         -> _eval_map_01 x A.abs_
        | Neg                                         -> _eval_map_01 x A.neg_
        | Floor                                       -> _eval_map_01 x A.floor_
        | Ceil                                        -> _eval_map_01 x A.ceil_
        | Round                                       -> _eval_map_01 x A.round_
        | Sqr                                         -> _eval_map_01 x A.sqr_
        | Sqrt                                        -> _eval_map_01 x A.sqrt_
        | Log                                         -> _eval_map_01 x A.log_
        | Log2                                        -> _eval_map_01 x A.log2_
        | Log10                                       -> _eval_map_01 x A.log10_
        | Exp                                         -> _eval_map_01 x A.exp_
        | Sin                                         -> _eval_map_01 x A.sin_
        | Cos                                         -> _eval_map_01 x A.cos_
        | Tan                                         -> _eval_map_01 x A.tan_
        | Sinh                                        -> _eval_map_01 x A.sinh_
        | Cosh                                        -> _eval_map_01 x A.cosh_
        | Tanh                                        -> _eval_map_01 x A.tanh_
        | Asin                                        -> _eval_map_01 x A.asin_
        | Acos                                        -> _eval_map_01 x A.acos_
        | Atan                                        -> _eval_map_01 x A.atan_
        | Asinh                                       -> _eval_map_01 x A.asinh_
        | Acosh                                       -> _eval_map_01 x A.acosh_
        | Atanh                                       -> _eval_map_01 x A.atanh_
        | Min axis                                    -> _eval_map_06 x (fun ~out x -> A.min_ ~out ~axis x.(0))
        | Max axis                                    -> _eval_map_06 x (fun ~out x -> A.max_ ~out ~axis x.(0))
        | Sum axis                                    -> _eval_map_06 x (fun ~out x -> A.sum_ ~out ~axis x.(0))
        | SumReduce axis                              -> _eval_map_00 x A.(sum_reduce ~axis)
        | Signum                                      -> _eval_map_01 x A.signum_
        | Sigmoid                                     -> _eval_map_01 x A.sigmoid_
        | Relu                                        -> _eval_map_01 x A.relu_
        | Min'                                        -> _eval_map_07 x A.min'
        | Max'                                        -> _eval_map_07 x A.max'
        | Sum'                                        -> _eval_map_07 x A.sum'
        | L1norm'                                     -> _eval_map_07 x A.l1norm'
        | L2norm'                                     -> _eval_map_07 x A.l2norm'
        | L2NormSqr'                                  -> _eval_map_07 x A.l2norm_sqr'
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> _eval_map_02 x A.pow_
        | ScalarPow                                   -> _eval_map_04 x A.scalar_pow_
        | PowScalar                                   -> _eval_map_03 x A.pow_scalar_
        | Atan2                                       -> _eval_map_02 x A.atan2_
        | ScalarAtan2                                 -> _eval_map_04 x A.scalar_atan2_
        | Atan2Scalar                                 -> _eval_map_03 x A.atan2_scalar_
        | Hypot                                       -> _eval_map_02 x A.hypot_
        | Min2                                        -> _eval_map_02 x A.min2_
        | Max2                                        -> _eval_map_02 x A.max2_
        | Add                                         -> _eval_map_02 x A.add_
        | Sub                                         -> _eval_map_02 x A.sub_
        | Mul                                         -> _eval_map_02 x A.mul_
        | Div                                         -> _eval_map_02 x A.div_
        | AddScalar                                   -> _eval_map_03 x A.add_scalar_
        | SubScalar                                   -> _eval_map_03 x A.sub_scalar_
        | MulScalar                                   -> _eval_map_03 x A.mul_scalar_
        | DivScalar                                   -> _eval_map_03 x A.div_scalar_
        | ScalarAdd                                   -> _eval_map_04 x A.scalar_add_
        | ScalarSub                                   -> _eval_map_04 x A.scalar_sub_
        | ScalarMul                                   -> _eval_map_04 x A.scalar_mul_
        | ScalarDiv                                   -> _eval_map_04 x A.scalar_div_
        | FMA                                         -> _eval_map_12 x A.fma_
        | IsZero                                      -> failwith "IsZero"
        | IsPositive                                  -> failwith "IsPositive"
        | IsNegative                                  -> failwith "IsNegative"
        | IsNonpositive                               -> failwith "IsNonpositive"
        | IsNonnegative                               -> failwith "IsNonnegative"
        | Equal                                       -> failwith "Equal"
        | NotEqual                                    -> failwith "NotEqual"
        | Less                                        -> failwith "Less"
        | Greater                                     -> failwith "Greater"
        | LessEqual                                   -> failwith "LessEqual"
        | GreaterEqual                                -> failwith "GreaterEqual"
        | EltEqual                                    -> _eval_map_02 x A.elt_equal_
        | EltNotEqual                                 -> _eval_map_02 x A.elt_not_equal_
        | EltLess                                     -> _eval_map_02 x A.elt_less_
        | EltGreater                                  -> _eval_map_02 x A.elt_greater_
        | EltLessEqual                                -> _eval_map_02 x A.elt_less_equal_
        | EltGreaterEqual                             -> _eval_map_02 x A.elt_greater_equal_
        | EltEqualScalar                              -> _eval_map_03 x A.elt_equal_scalar_
        | EltNotEqualScalar                           -> _eval_map_03 x A.elt_not_equal_scalar_
        | EltLessScalar                               -> _eval_map_03 x A.elt_less_scalar_
        | EltGreaterScalar                            -> _eval_map_03 x A.elt_greater_scalar_
        | EltLessEqualScalar                          -> _eval_map_03 x A.elt_less_equal_scalar_
        | EltGreaterEqualScalar                       -> _eval_map_03 x A.elt_greater_equal_scalar_
        | ApproxEqual eps                             -> failwith "ApproxEqual"
        | ApproxEqualScalar eps                       -> failwith "ApproxEqualScalar"
        | ApproxEltEqual eps                          -> failwith "ApproxEltEqual"
        | ApproxEltEqualScalar eps                    -> failwith "ApproxEltEqualScalar"
        | Conv1d (padding, stride)                    -> _eval_map_06 x (fun ~out x -> A.conv1d_ ~out ~padding x.(0) x.(1) stride)
        | Conv2d (padding, stride)                    -> _eval_map_06 x (fun ~out x -> A.conv2d_ ~out ~padding x.(0) x.(1) stride)
        | Conv3d (padding, stride)                    -> _eval_map_06 x (fun ~out x -> A.conv3d_ ~out ~padding x.(0) x.(1) stride)
        | TransposeConv1d (padding, stride)           -> _eval_map_06 x (fun ~out x -> A.transpose_conv1d_ ~out ~padding x.(0) x.(1) stride)
        | TransposeConv2d (padding, stride)           -> _eval_map_06 x (fun ~out x -> A.transpose_conv2d_ ~out ~padding x.(0) x.(1) stride)
        | TransposeConv3d (padding, stride)           -> _eval_map_06 x (fun ~out x -> A.transpose_conv3d_ ~out ~padding x.(0) x.(1) stride)
        | DilatedConv1d (padding, stride, rate)       -> _eval_map_06 x (fun ~out x -> A.dilated_conv1d_ ~out ~padding x.(0) x.(1) stride rate)
        | DilatedConv2d (padding, stride, rate)       -> _eval_map_06 x (fun ~out x -> A.dilated_conv2d_ ~out ~padding x.(0) x.(1) stride rate)
        | DilatedConv3d (padding, stride, rate)       -> _eval_map_06 x (fun ~out x -> A.dilated_conv3d_ ~out ~padding x.(0) x.(1) stride rate)
        | MaxPool1d (padding, kernel, stride)         -> _eval_map_06 x (fun ~out x -> A.max_pool1d_ ~out ~padding x.(0) kernel stride)
        | MaxPool2d (padding, kernel, stride)         -> _eval_map_06 x (fun ~out x -> A.max_pool2d_ ~out ~padding x.(0) kernel stride)
        | MaxPool3d (padding, kernel, stride)         -> _eval_map_06 x (fun ~out x -> A.max_pool3d_ ~out ~padding x.(0) kernel stride)
        | AvgPool1d (padding, kernel, stride)         -> _eval_map_06 x (fun ~out x -> A.avg_pool1d_ ~out ~padding x.(0) kernel stride)
        | AvgPool2d (padding, kernel, stride)         -> _eval_map_06 x (fun ~out x -> A.avg_pool2d_ ~out ~padding x.(0) kernel stride)
        | AvgPool3d (padding, kernel, stride)         -> _eval_map_06 x (fun ~out x -> A.avg_pool3d_ ~out ~padding x.(0) kernel stride)
        | Conv1dBackwardInput stride                  -> _eval_map_06 x (fun ~out x -> A.conv1d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | Conv1dBackwardKernel stride                 -> _eval_map_06 x (fun ~out x -> A.conv1d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | Conv2dBackwardInput stride                  -> _eval_map_06 x (fun ~out x -> A.conv2d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | Conv2dBackwardKernel stride                 -> _eval_map_06 x (fun ~out x -> A.conv2d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | Conv3dBackwardInput stride                  -> _eval_map_06 x (fun ~out x -> A.conv3d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | Conv3dBackwardKernel stride                 -> _eval_map_06 x (fun ~out x -> A.conv3d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv1dBackwardInput stride         -> _eval_map_06 x (fun ~out x -> A.transpose_conv1d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv1dBackwardKernel stride        -> _eval_map_06 x (fun ~out x -> A.transpose_conv1d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardInput stride         -> _eval_map_06 x (fun ~out x -> A.transpose_conv2d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardKernel stride        -> _eval_map_06 x (fun ~out x -> A.transpose_conv2d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv3dBackwardInput stride         -> _eval_map_06 x (fun ~out x -> A.transpose_conv3d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv3dBackwardKernel stride        -> _eval_map_06 x (fun ~out x -> A.transpose_conv3d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
        | DilatedConv1dBackwardInput (stride, rate)   -> _eval_map_06 x (fun ~out x -> A.dilated_conv1d_backward_input_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv1dBackwardKernel (stride, rate)  -> _eval_map_06 x (fun ~out x -> A.dilated_conv1d_backward_kernel_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv2dBackwardInput (stride, rate)   -> _eval_map_06 x (fun ~out x -> A.dilated_conv2d_backward_input_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv2dBackwardKernel (stride, rate)  -> _eval_map_06 x (fun ~out x -> A.dilated_conv2d_backward_kernel_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv3dBackwardInput (stride, rate)   -> _eval_map_06 x (fun ~out x -> A.dilated_conv3d_backward_input_ ~out x.(0) x.(1) stride rate x.(2))
        | DilatedConv3dBackwardKernel (stride, rate)  -> _eval_map_06 x (fun ~out x -> A.dilated_conv3d_backward_kernel_ ~out x.(0) x.(1) stride rate x.(2))
        | MaxPool1dBackward (padding, kernel, stride) -> _eval_map_06 x (fun ~out x -> A.max_pool1d_backward_ ~out padding x.(0) kernel stride x.(1))
        | MaxPool2dBackward (padding, kernel, stride) -> _eval_map_06 x (fun ~out x -> A.max_pool2d_backward_ ~out padding x.(0) kernel stride x.(1))
        | MaxPool3dBackward (padding, kernel, stride) -> _eval_map_06 x (fun ~out x -> A.max_pool3d_backward_ ~out padding x.(0) kernel stride x.(1))
        | AvgPool1dBackward (padding, kernel, stride) -> _eval_map_06 x (fun ~out x -> A.avg_pool1d_backward_ ~out padding x.(0) kernel stride x.(1))
        | AvgPool2dBackward (padding, kernel, stride) -> _eval_map_06 x (fun ~out x -> A.avg_pool2d_backward_ ~out padding x.(0) kernel stride x.(1))
        | AvgPool3dBackward (padding, kernel, stride) -> _eval_map_06 x (fun ~out x -> A.avg_pool3d_backward_ ~out padding x.(0) kernel stride x.(1))
        | Row                                         -> failwith "Row"
        | Rows i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (transa, transb, alpha, beta)           -> _eval_map_06 x (fun ~out x -> A.dot_ ~transa ~transb ~alpha:(unpack_elt alpha) ~beta:(unpack_elt beta) ~c:out x.(0) x.(1))
        | Inv                                         -> _eval_map_00 x A.inv
        | Trace                                       -> _eval_map_07 x A.trace
        | Transpose axis                              -> _eval_map_06 x (fun ~out x -> A.transpose_ ~out ~axis x.(0))
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | OfArray shape                               -> failwith "OfArray"
        | OfArrays                                    -> failwith "OfArrays"
        | Scalar_Add                                  -> _eval_map_10 x A.Scalar.add
        | Scalar_Sub                                  -> _eval_map_10 x A.Scalar.sub
        | Scalar_Mul                                  -> _eval_map_10 x A.Scalar.mul
        | Scalar_Div                                  -> _eval_map_10 x A.Scalar.div
        | Scalar_Pow                                  -> _eval_map_10 x A.Scalar.pow
        | Scalar_Atan2                                -> _eval_map_10 x A.Scalar.atan2
        | Scalar_Abs                                  -> _eval_map_09 x A.Scalar.abs
        | Scalar_Neg                                  -> _eval_map_09 x A.Scalar.neg
        | Scalar_Sqr                                  -> _eval_map_09 x A.Scalar.sqr
        | Scalar_Sqrt                                 -> _eval_map_09 x A.Scalar.sqrt
        | Scalar_Exp                                  -> _eval_map_09 x A.Scalar.exp
        | Scalar_Log                                  -> _eval_map_09 x A.Scalar.log
        | Scalar_Log2                                 -> _eval_map_09 x A.Scalar.log2
        | Scalar_Log10                                -> _eval_map_09 x A.Scalar.log10
        | Scalar_Signum                               -> _eval_map_09 x A.Scalar.signum
        | Scalar_Floor                                -> _eval_map_09 x A.Scalar.floor
        | Scalar_Ceil                                 -> _eval_map_09 x A.Scalar.ceil
        | Scalar_Round                                -> _eval_map_09 x A.Scalar.round
        | Scalar_Sin                                  -> _eval_map_09 x A.Scalar.sin
        | Scalar_Cos                                  -> _eval_map_09 x A.Scalar.cos
        | Scalar_Tan                                  -> _eval_map_09 x A.Scalar.tan
        | Scalar_Sinh                                 -> _eval_map_09 x A.Scalar.sinh
        | Scalar_Cosh                                 -> _eval_map_09 x A.Scalar.cosh
        | Scalar_Tanh                                 -> _eval_map_09 x A.Scalar.tanh
        | Scalar_Asin                                 -> _eval_map_09 x A.Scalar.asin
        | Scalar_Acos                                 -> _eval_map_09 x A.Scalar.acos
        | Scalar_Atan                                 -> _eval_map_09 x A.Scalar.atan
        | Scalar_Asinh                                -> _eval_map_09 x A.Scalar.asinh
        | Scalar_Acosh                                -> _eval_map_09 x A.Scalar.acosh
        | Scalar_Atanh                                -> _eval_map_09 x A.Scalar.atanh
        | Scalar_Relu                                 -> _eval_map_09 x A.Scalar.relu
        | Scalar_Sigmoid                              -> _eval_map_09 x A.Scalar.sigmoid
        | Fused_Adagrad (rate, eps)                   -> _eval_map_06 x (fun ~out x -> A.fused_adagrad_ ~out ~rate ~eps x.(0))
        | _                                           -> failwith "owl_lazy:_eval_term"

        with exn -> (
          Owl_log.error "evaluating %s" (node_to_str x);
          raise exn
        )
      in
      update_validity x


  (* [f] is pure, shape changes so always allocate mem, for [arr -> arr] *)
  and _eval_map_00 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|arr_to_value a|]


  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map_01 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = value_to_arr (get_value x_parent).(0) in
    let out = value_to_arr (get_value x).(0) in
    f ~out a


  (* [f] is inpure, for [arr -> arr -> arr] *)
  and _eval_map_02 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_arr (get_value x_parent_0).(0) in
    let b = value_to_arr (get_value x_parent_1).(0) in
    let out = value_to_arr (get_value x).(0) in
    f ~out a b;
    set_value x [|arr_to_value out|];
    update_validity x


  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map_03 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_arr (get_value x_parent_0).(0) in
    let b = value_to_elt (get_value x_parent_1).(0) in
    let out = value_to_arr (get_value x).(0) in
    f ~out a b


  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map_04 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_elt (get_value x_parent_0).(0) in
    let b = value_to_arr (get_value x_parent_1).(0) in
    let out = value_to_arr (get_value x).(0) in
    f ~out a b


  (* [f] is pure, shape changes so always allocate mem, for [arr array -> arr] *)
  and _eval_map_05 x f =
    let a = Array.map (fun x ->
      _eval_term x;
      value_to_arr (get_value x).(0)
    ) (parents x) |> f
    in
    set_value x [|arr_to_value a|]


  (* [f] is inpure, allocate mem for first run, for [arr array -> arr] *)
  and _eval_map_06 x f =
    let a = Array.map (fun x ->
      _eval_term x;
      value_to_arr (get_value x).(0)
    ) (parents x)
    in
    let out = value_to_arr (get_value x).(0) in
    f ~out a


  (* [f] is pure, for [arr -> elt] *)
  and _eval_map_07 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|elt_to_value a|]


  (* [f] is inpure, for [elt array -> arr] *)
  and _eval_map_08 x f =
    let a = Array.map (fun x_parent ->
      _eval_term x_parent;
      value_to_elt (get_value x_parent).(0)
    ) (parents x)
    in
    let out = value_to_arr (get_value x).(0) in
    f ~out a


  (* [f] is pure, for [elt -> elt] *)
  and _eval_map_09 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = value_to_elt (get_value x_parent).(0) in
    let b = f a in
    set_value x [|elt_to_value b|]


  (* [f] is pure, for [elt -> elt -> elt] *)
  and _eval_map_10 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_elt (get_value x_parent_0).(0) in
    let b = value_to_elt (get_value x_parent_1).(0) in
    let c = f a b in
    set_value x [|elt_to_value c|]


  (* [f] is inpure but returns modified memory, for [arr -> arr] *)
  and _eval_map_11 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = allocate_1 x_parent in
    let b = f a in
    set_value x [|arr_to_value b|]


  (* [f] is inpure, for [arr -> arr -> arr -> arr] *)
  and _eval_map_12 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    let x_parent_2 = (parents x).(2) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    _eval_term x_parent_2;
    let a = (get_value x_parent_0).(0) |> value_to_arr in
    let b = (get_value x_parent_1).(0) |> value_to_arr in
    let c = (get_value x_parent_2).(0) |> value_to_arr in
    let out = value_to_arr (get_value x).(0) in
    f ~out a b c


  (* dummy map for functions like noop, not invalidate parent *)
  and _eval_map_99 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|arr_to_value a|]


  (* core interface *)

  let eval_elt xs =
    let nodes = Array.map elt_to_node xs in
    CGInit.init_nodes nodes;
    Array.iter _eval_term nodes


  let eval_arr xs =
    let nodes = Array.map arr_to_node xs in
    CGInit.init_nodes nodes;
    Array.iter _eval_term nodes


  let eval_graph graph =
    let nodes = CGraph.get_outputs graph in
    CGInit.init_nodes nodes;
    Array.iter _eval_term nodes


end

(* Make functor ends *)
