(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making the shape inference of a computation graph. *)

module Make
  (A : Ndarray_Algodiff)
  (D : Computation_Device)
  = struct

  include Owl_computation_type.Make (A) (D)


  (* infer the shape of outcome from inputs *)

  let _infer_shape_00 input_shapes = [| Some [||] |]


  let _infer_shape_01 input_shapes =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Array.(copy s) |]
    | None   -> [| None |]


  let _infer_shape_02 input_shapes =
    match input_shapes.(1).(0) with
    | Some s -> [| Some Array.(copy s) |]
    | None   -> [| None |]


  let _infer_shape_03 input_shapes =
    let s0 = input_shapes.(0).(0) in
    let s1 = input_shapes.(1).(0) in
    match s0, s1 with
    | Some s0, Some s1 -> [| Some Owl_utils_infer_shape.(broadcast1 s0 s1) |]
    | _, _             -> [| None |]


  let _infer_shape_04 input_shapes axis =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(fold s axis) |]
    | None   -> [| None |]


  let _infer_shape_05 input_shapes repeats =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(tile s repeats) |]
    | None   -> [| None |]


  let _infer_shape_06 input_shapes axis repeats =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(repeat s axis repeats) |]
    | None   -> [| None |]


  let _infer_shape_07 input_shapes axis =
    let s0 = Array.map (fun s -> s.(0)) input_shapes in
    if Array.exists (function Some _ -> false | None -> true) s0 then [| None |]
    else (
      let s1 = Array.map (function Some a -> a | None -> failwith "_infer_shape_07") s0 in
      [| Some Owl_utils_infer_shape.(concatenate s1 axis) |]
    )


  let _infer_shape_08 input_shapes axis parts =
    match input_shapes.(0).(0) with
    | Some s -> (
        let s0 = Owl_utils_infer_shape.(split s axis parts) in
        Array.map (fun s -> Some s) s0
      )
    | None   -> Array.(make (length parts) None)


  let _infer_shape_09 input_shapes axis n =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(draw s axis n) |]
    | None   -> [| None |]


  let _infer_shape_10 input_shapes axis =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(reduce s axis) |]
    | None   -> [| None |]


  let _infer_shape_11 input_shapes padding stride =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(conv1d input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_12 input_shapes padding stride =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(conv2d input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_13 input_shapes padding stride =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(conv3d input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_14 input_shapes padding stride =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(transpose_conv2d input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_15 input_shapes padding kernel stride =
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils_infer_shape.(conv1d input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_16 input_shapes padding kernel stride =
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils_infer_shape.(conv2d input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_17 input_shapes padding kernel stride =
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils_infer_shape.(conv3d input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_18 input_shapes axis =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(transpose s axis) |]
    | None   -> [| None |]


  let _infer_shape_19 input_shapes =
    let x_shape = input_shapes.(0).(0) in
    let y_shape = input_shapes.(1).(0) in
    match x_shape, y_shape with
    | Some s0, Some s1 -> [| Some Owl_utils_infer_shape.(dot s0 s1) |]
    | _, _                    -> [| None |]


  let _infer_shape_20 input_shapes axis =
    match input_shapes.(0).(0) with
    | Some s -> (
        let axis = List.map (fun i -> R_ (Array.of_list i)) axis |> Array.of_list in
        let axis = Owl_base_slicing.check_slice_definition axis s in
        [| Some Owl_base_slicing.(calc_slice_shape axis) |]
      )
    | None   -> [| None |]


  let _infer_shape_21 input_shapes padding kernel stride =
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils_infer_shape.(pool2d input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_22 input_shapes depth =
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils_infer_shape.(onehot s depth) |]
    | None   -> [| None |]


  let _infer_shape_23 input_shapes =
    let s0 = input_shapes.(0).(0) in
    let s1 = input_shapes.(1).(0) in
    let s2 = input_shapes.(2).(0) in
    match s0, s1, s2 with
    | Some s0, Some s1, Some s2 -> [| Some Owl_utils_infer_shape.(broadcast2 s0 s1 s2) |]
    | _, _, _                   -> [| None |]


  let _infer_shape_24 input_shapes padding stride =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(transpose_conv1d input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_25 input_shapes padding stride =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(transpose_conv3d input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_26 input_shapes padding stride rate =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(dilated_conv1d input padding kernel stride rate) |]
    | _, _                    -> [| None |]


  let _infer_shape_27 input_shapes padding stride rate =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(dilated_conv2d input padding kernel stride rate) |]
    | _, _                    -> [| None |]


  let _infer_shape_28 input_shapes padding stride rate =
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils_infer_shape.(dilated_conv3d input padding kernel stride rate) |]
    | _, _                    -> [| None |]


  let _infer_shape_xx input_shapes = failwith "_infer_shape_xx: not implemented"


  let infer_shape operator args =
    let input_shapes = Array.map (fun a -> (Owl_graph.attr a).shape) args in
    match operator with
    | Noop                                        -> _infer_shape_01 input_shapes
    | Create shape                                -> [| Some shape |]
    | Get _                                       -> _infer_shape_00 input_shapes
    | GetSlice slice                              -> _infer_shape_20 input_shapes slice
    | Copy                                        -> _infer_shape_01 input_shapes
    | Reshape shape                               -> [| Some shape |]
    | Reverse                                     -> _infer_shape_01 input_shapes
    | Tile repeats                                -> _infer_shape_05 input_shapes repeats
    | Repeat (axis, repeats)                      -> _infer_shape_06 input_shapes axis repeats
    | Concatenate axis                            -> _infer_shape_07 input_shapes axis
    | Split (axis, parts)                         -> _infer_shape_08 input_shapes axis parts
    | Draw (axis, n)                              -> _infer_shape_09 input_shapes axis n
    | Map _                                       -> _infer_shape_01 input_shapes
    | Fold (axis, f)                              -> _infer_shape_04 input_shapes axis
    | Scan (axis, f)                              -> _infer_shape_01 input_shapes
    | OneHot depth                                -> _infer_shape_22 input_shapes depth
    | Abs                                         -> _infer_shape_01 input_shapes
    | Neg                                         -> _infer_shape_01 input_shapes
    | Floor                                       -> _infer_shape_01 input_shapes
    | Ceil                                        -> _infer_shape_01 input_shapes
    | Round                                       -> _infer_shape_01 input_shapes
    | Sqr                                         -> _infer_shape_01 input_shapes
    | Sqrt                                        -> _infer_shape_01 input_shapes
    | Log                                         -> _infer_shape_01 input_shapes
    | Log2                                        -> _infer_shape_01 input_shapes
    | Log10                                       -> _infer_shape_01 input_shapes
    | Exp                                         -> _infer_shape_01 input_shapes
    | Sin                                         -> _infer_shape_01 input_shapes
    | Cos                                         -> _infer_shape_01 input_shapes
    | Tan                                         -> _infer_shape_01 input_shapes
    | Sinh                                        -> _infer_shape_01 input_shapes
    | Cosh                                        -> _infer_shape_01 input_shapes
    | Tanh                                        -> _infer_shape_01 input_shapes
    | Asin                                        -> _infer_shape_01 input_shapes
    | Acos                                        -> _infer_shape_01 input_shapes
    | Atan                                        -> _infer_shape_01 input_shapes
    | Asinh                                       -> _infer_shape_01 input_shapes
    | Acosh                                       -> _infer_shape_01 input_shapes
    | Atanh                                       -> _infer_shape_01 input_shapes
    | Min axis                                    -> _infer_shape_04 input_shapes axis
    | Max axis                                    -> _infer_shape_04 input_shapes axis
    | Sum axis                                    -> _infer_shape_04 input_shapes axis
    | SumReduce axis                              -> _infer_shape_10 input_shapes axis
    | Signum                                      -> _infer_shape_01 input_shapes
    | Sigmoid                                     -> _infer_shape_01 input_shapes
    | Relu                                        -> _infer_shape_01 input_shapes
    | Min'                                        -> _infer_shape_00 input_shapes
    | Max'                                        -> _infer_shape_00 input_shapes
    | Sum'                                        -> _infer_shape_00 input_shapes
    | L1norm'                                     -> _infer_shape_00 input_shapes
    | L2norm'                                     -> _infer_shape_00 input_shapes
    | L2NormSqr'                                  -> _infer_shape_00 input_shapes
    | ClipByValue                                 -> _infer_shape_01 input_shapes
    | ClipByL2norm                                -> _infer_shape_01 input_shapes
    | Pow                                         -> _infer_shape_01 input_shapes
    | ScalarPow                                   -> _infer_shape_02 input_shapes
    | PowScalar                                   -> _infer_shape_01 input_shapes
    | Atan2                                       -> _infer_shape_03 input_shapes
    | ScalarAtan2                                 -> _infer_shape_02 input_shapes
    | Atan2Scalar                                 -> _infer_shape_01 input_shapes
    | Hypot                                       -> _infer_shape_01 input_shapes
    | Min2                                        -> _infer_shape_01 input_shapes
    | Max2                                        -> _infer_shape_01 input_shapes
    | Add                                         -> _infer_shape_03 input_shapes
    | Sub                                         -> _infer_shape_03 input_shapes
    | Mul                                         -> _infer_shape_03 input_shapes
    | Div                                         -> _infer_shape_03 input_shapes
    | AddScalar                                   -> _infer_shape_01 input_shapes
    | SubScalar                                   -> _infer_shape_01 input_shapes
    | MulScalar                                   -> _infer_shape_01 input_shapes
    | DivScalar                                   -> _infer_shape_01 input_shapes
    | ScalarAdd                                   -> _infer_shape_02 input_shapes
    | ScalarSub                                   -> _infer_shape_02 input_shapes
    | ScalarMul                                   -> _infer_shape_02 input_shapes
    | ScalarDiv                                   -> _infer_shape_02 input_shapes
    | FMA                                         -> _infer_shape_23 input_shapes
    | EltEqual                                    -> _infer_shape_01 input_shapes
    | EltNotEqual                                 -> _infer_shape_01 input_shapes
    | EltLess                                     -> _infer_shape_01 input_shapes
    | EltGreater                                  -> _infer_shape_01 input_shapes
    | EltLessEqual                                -> _infer_shape_01 input_shapes
    | EltGreaterEqual                             -> _infer_shape_01 input_shapes
    | EltEqualScalar                              -> _infer_shape_01 input_shapes
    | EltNotEqualScalar                           -> _infer_shape_01 input_shapes
    | EltLessScalar                               -> _infer_shape_01 input_shapes
    | EltGreaterScalar                            -> _infer_shape_01 input_shapes
    | EltLessEqualScalar                          -> _infer_shape_01 input_shapes
    | EltGreaterEqualScalar                       -> _infer_shape_01 input_shapes
    | Conv1d (padding, stride)                    -> _infer_shape_11 input_shapes padding stride
    | Conv2d (padding, stride)                    -> _infer_shape_12 input_shapes padding stride
    | Conv3d (padding, stride)                    -> _infer_shape_13 input_shapes padding stride
    | TransposeConv1d (padding, stride)           -> _infer_shape_24 input_shapes padding stride
    | TransposeConv2d (padding, stride)           -> _infer_shape_14 input_shapes padding stride
    | TransposeConv3d (padding, stride)           -> _infer_shape_25 input_shapes padding stride
    | DilatedConv1d (padding, stride, rate)       -> _infer_shape_26 input_shapes padding stride rate
    | DilatedConv2d (padding, stride, rate)       -> _infer_shape_27 input_shapes padding stride rate
    | DilatedConv3d (padding, stride, rate)       -> _infer_shape_28 input_shapes padding stride rate
    | MaxPool1d (padding, kernel, stride)         -> _infer_shape_15 input_shapes padding kernel stride
    | MaxPool2d (padding, kernel, stride)         -> _infer_shape_21 input_shapes padding kernel stride
    | MaxPool3d (padding, kernel, stride)         -> _infer_shape_17 input_shapes padding kernel stride
    | AvgPool1d (padding, kernel, stride)         -> _infer_shape_15 input_shapes padding kernel stride
    | AvgPool2d (padding, kernel, stride)         -> _infer_shape_21 input_shapes padding kernel stride
    | AvgPool3d (padding, kernel, stride)         -> _infer_shape_17 input_shapes padding kernel stride
    | Conv1dBackwardInput stride                  -> _infer_shape_01 input_shapes
    | Conv1dBackwardKernel stride                 -> _infer_shape_02 input_shapes
    | Conv2dBackwardInput stride                  -> _infer_shape_01 input_shapes
    | Conv2dBackwardKernel stride                 -> _infer_shape_02 input_shapes
    | Conv3dBackwardInput stride                  -> _infer_shape_01 input_shapes
    | Conv3dBackwardKernel stride                 -> _infer_shape_02 input_shapes
    | TransposeConv1dBackwardInput stride         -> _infer_shape_01 input_shapes
    | TransposeConv1dBackwardKernel stride        -> _infer_shape_02 input_shapes
    | TransposeConv2dBackwardInput stride         -> _infer_shape_01 input_shapes
    | TransposeConv2dBackwardKernel stride        -> _infer_shape_02 input_shapes
    | TransposeConv3dBackwardInput stride         -> _infer_shape_01 input_shapes
    | TransposeConv3dBackwardKernel stride        -> _infer_shape_02 input_shapes
    | DilatedConv1dBackwardInput (stride, rate)   -> _infer_shape_01 input_shapes
    | DilatedConv1dBackwardKernel (stride, rate)  -> _infer_shape_02 input_shapes
    | DilatedConv2dBackwardInput (stride, rate)   -> _infer_shape_01 input_shapes
    | DilatedConv2dBackwardKernel (stride, rate)  -> _infer_shape_02 input_shapes
    | DilatedConv3dBackwardInput (stride, rate)   -> _infer_shape_01 input_shapes
    | DilatedConv3dBackwardKernel (stride, rate)  -> _infer_shape_02 input_shapes
    | MaxPool1dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | MaxPool2dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | MaxPool3dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | AvgPool1dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | AvgPool2dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | AvgPool3dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | Row                                         -> _infer_shape_09 input_shapes 0 1
    | Rows i                                      -> _infer_shape_09 input_shapes 0 Array.(length i)
    | Dot (transa, transb, alpha, beta)           -> _infer_shape_19 input_shapes
    | Inv                                         -> _infer_shape_01 input_shapes
    | Trace                                       -> _infer_shape_00 input_shapes
    | Transpose axis                              -> _infer_shape_18 input_shapes axis
    | ToRows                                      -> _infer_shape_xx input_shapes
    | OfRows                                      -> _infer_shape_xx input_shapes
    | Scalar_Add                                  -> _infer_shape_00 input_shapes
    | Scalar_Sub                                  -> _infer_shape_00 input_shapes
    | Scalar_Mul                                  -> _infer_shape_00 input_shapes
    | Scalar_Div                                  -> _infer_shape_00 input_shapes
    | Scalar_Pow                                  -> _infer_shape_00 input_shapes
    | Scalar_Atan2                                -> _infer_shape_00 input_shapes
    | Scalar_Abs                                  -> _infer_shape_00 input_shapes
    | Scalar_Neg                                  -> _infer_shape_00 input_shapes
    | Scalar_Sqr                                  -> _infer_shape_00 input_shapes
    | Scalar_Sqrt                                 -> _infer_shape_00 input_shapes
    | Scalar_Exp                                  -> _infer_shape_00 input_shapes
    | Scalar_Log                                  -> _infer_shape_00 input_shapes
    | Scalar_Log2                                 -> _infer_shape_00 input_shapes
    | Scalar_Log10                                -> _infer_shape_00 input_shapes
    | Scalar_Signum                               -> _infer_shape_00 input_shapes
    | Scalar_Floor                                -> _infer_shape_00 input_shapes
    | Scalar_Ceil                                 -> _infer_shape_00 input_shapes
    | Scalar_Round                                -> _infer_shape_00 input_shapes
    | Scalar_Sin                                  -> _infer_shape_00 input_shapes
    | Scalar_Cos                                  -> _infer_shape_00 input_shapes
    | Scalar_Tan                                  -> _infer_shape_00 input_shapes
    | Scalar_Sinh                                 -> _infer_shape_00 input_shapes
    | Scalar_Cosh                                 -> _infer_shape_00 input_shapes
    | Scalar_Tanh                                 -> _infer_shape_00 input_shapes
    | Scalar_Asin                                 -> _infer_shape_00 input_shapes
    | Scalar_Acos                                 -> _infer_shape_00 input_shapes
    | Scalar_Atan                                 -> _infer_shape_00 input_shapes
    | Scalar_Asinh                                -> _infer_shape_00 input_shapes
    | Scalar_Acosh                                -> _infer_shape_00 input_shapes
    | Scalar_Atanh                                -> _infer_shape_00 input_shapes
    | Scalar_Relu                                 -> _infer_shape_00 input_shapes
    | Scalar_Sigmoid                              -> _infer_shape_00 input_shapes
    | Fused_Adagrad (rate, eps)                   -> _infer_shape_01 input_shapes
    | _                                           -> [| None |]


end
