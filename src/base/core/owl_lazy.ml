(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making a Lazy engine to execute a computation graph. *)

module Make (A : Ndarray_Mutable) = struct

  module CGraph = Owl_computation_graph.Make (A)

  include CGraph


  (* allocate memory and evaluate experssions *)

  let allocate_1 x =
    let x_val = value_to_arr (attr x).value.(0) in
    if refnum x = 1 && get_reuse x then (
      invalidate x;
      x_val
    )
    else A.copy x_val


  let allocate_from_parent_0 x =
    if is_assigned x = true then (
      let x_val = value_to_arr (get_value x).(0) in
      x_val
    )
    else (
      let x_shp = shape (node_to_arr x) in
      A.empty x_shp
    )


  let allocate_from_parent_1 x parent =
    let parent_val = value_to_arr (get_value parent).(0) in
    if is_assigned x = true then (
      let x_val = value_to_arr (get_value x).(0) in
      if x_val == parent_val then invalidate parent;
      x_val
    )
    else (
      if refnum parent = 1 && get_reuse parent then (
        invalidate parent;
        parent_val
      )
      else A.empty (A.shape parent_val)
    )


  let allocate_from_parent_2 x parent_0 parent_1 =
    let parent_0_val = value_to_arr (get_value parent_0).(0) in
    let parent_1_val = value_to_arr (get_value parent_1).(0) in
    if is_assigned x = true then (
      let x_val = value_to_arr (get_value x).(0) in
      if x_val == parent_0_val then invalidate parent_0
      else if x_val == parent_1_val then invalidate parent_1;
      x_val
    )
    else (
      let shp_0 = A.shape parent_0_val in
      let shp_1 = A.shape parent_1_val in
      let shp_0, shp_1 = Owl_utils_array.align `Left 1 shp_0 shp_1 in
      let shp_x = Owl_utils.calc_broadcast_shape1 shp_0 shp_1 in

      if shp_0 = shp_x then (
        if refnum parent_0 = 1 && get_reuse parent_0 then (
          invalidate parent_0;
          parent_0_val
        )
        else if refnum parent_0 = 2 && parent_0 == parent_1 && get_reuse parent_0 then (
          invalidate parent_0;
          parent_0_val
        )
        else A.empty shp_x
      )
      else if shp_1 = shp_x then (
        if refnum parent_1 = 1 && get_reuse parent_1 then (
          invalidate parent_1;
          parent_1_val
        )
        else A.empty shp_x
      )
      else A.empty shp_x
    )


  let allocate_from_parent_3 x parent_0 parent_1 parent_2 =
    let parent_0_val = value_to_arr (get_value parent_0).(0) in
    let parent_1_val = value_to_arr (get_value parent_1).(0) in
    let parent_2_val = value_to_arr (get_value parent_2).(0) in
    if is_assigned x = true then (
      let x_val = value_to_arr (get_value x).(0) in
      if x_val == parent_0_val then invalidate parent_0
      else if x_val == parent_1_val then invalidate parent_1
      else if x_val == parent_2_val then invalidate parent_2;
      x_val
    )
    else (
      let shp_0 = A.shape parent_0_val in
      let shp_1 = A.shape parent_1_val in
      let shp_2 = A.shape parent_2_val in
      let shp_0, shp_1, shp_2 = Owl_utils_array.align3 `Left 1 shp_0 shp_1 shp_2 in
      let shp_x = Owl_utils.calc_broadcast_shape2 shp_0 shp_1 shp_2 in

      if shp_0 = shp_x && refnum parent_0 = 1 && get_reuse parent_0 then (
        invalidate parent_0;
        parent_0_val
      )
      else if shp_1 = shp_x && refnum parent_1 = 1 && get_reuse parent_1 then (
        invalidate parent_1;
        parent_1_val
      )
      else if shp_2 = shp_x && refnum parent_2 = 1 && get_reuse parent_2 then (
        invalidate parent_2;
        parent_2_val
      )
      else A.empty shp_x
    )


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
        | TransposeConv2d (padding, stride)           -> _eval_map_06 x (fun ~out x -> A.transpose_conv2d_ ~out ~padding x.(0) x.(1) stride)
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
        | TransposeConv2dBackwardInput stride         -> _eval_map_06 x (fun ~out x -> A.transpose_conv2d_backward_input_ ~out x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardKernel stride        -> _eval_map_06 x (fun ~out x -> A.transpose_conv2d_backward_kernel_ ~out x.(0) x.(1) stride x.(2))
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
          Owl_log.error "Error in evaluating %s" (node_to_str x);
          raise exn
        )
      in
      validate x


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
    let out = allocate_from_parent_1 x x_parent in
    f ~out a;
    set_value x [|arr_to_value out|]


  (* [f] is inpure, for [arr -> arr -> arr] *)
  and _eval_map_02 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_arr (get_value x_parent_0).(0) in
    let b = value_to_arr (get_value x_parent_1).(0) in
    let out = allocate_from_parent_2 x x_parent_0 x_parent_1 in
    f ~out a b;
    set_value x [|arr_to_value out|]


  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map_03 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_arr (get_value x_parent_0).(0) in
    let b = value_to_elt (get_value x_parent_1).(0) in
    let out = allocate_from_parent_1 x x_parent_0 in
    f ~out a b;
    set_value x [|arr_to_value out|]


  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map_04 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_elt (get_value x_parent_0).(0) in
    let b = value_to_arr (get_value x_parent_1).(0) in
    let out = allocate_from_parent_1 x x_parent_1 in
    f ~out a b;
    set_value x [|arr_to_value out|]


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
    let out = allocate_from_parent_0 x in
    f ~out a;
    set_value x [|arr_to_value out|]


  (* [f] is pure, for [arr -> elt] *)
  and _eval_map_07 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|elt_to_value a|]


  (* [f] is inpure, for [elt array -> arr] *)
  and _eval_map_08 x f =
    let a = Array.map (fun x ->
      _eval_term x;
      value_to_elt (get_value x).(0)
    ) (parents x)
    in
    let out = allocate_from_parent_0 x in
    f ~out a;
    set_value x [|arr_to_value out|]


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
    let out = allocate_from_parent_3 x x_parent_0 x_parent_1 x_parent_2 in
    f ~out a b c;
    set_value x [|arr_to_value out|]


  (* dummy map for functions like noop, not invalidate parent *)
  and _eval_map_99 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|arr_to_value a|]


  let eval_elt xs = Array.iter (fun x -> elt_to_node x |> _eval_term) xs


  let eval_arr xs = Array.iter (fun x -> arr_to_node x |> _eval_term) xs


  let eval_graph graph = CGraph.get_outputs graph |> Array.iter _eval_term


  let elt_to_float x =
    eval_elt [|x|];
    unpack_elt x |> A.elt_to_float


  let arr_to_var x =
    eval_arr [|x|];
    set_operator (arr_to_node x) Var;
    arr_to_var x


end

(* Make functor ends *)
