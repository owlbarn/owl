(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making Lazy module of different number types *)

module Make
  (A : Ndarray_Algodiff)
  (D : Computation_Device)
  = struct

  (* module constant *)

  let number = A.number

  (* create device-dependent module *)

  module Device = D.Make (A)

  include Device


  (* type definitions *)

  type state = Valid | Invalid

  type t = attr node
  and attr = {
    mutable op     : op;                        (* operation stored in this node *)
    mutable freeze : bool;                      (* whether or not a node can link to other nodes *)
    mutable reuse  : bool;                      (* whether others can resuse the allocated memory *)
    mutable state  : state;                     (* state to show whether re-evaluation is needed *)
    mutable shape  : (int array option) array;  (* shape of the output values stored in the node *)
    mutable value  : value array;               (* output values of the node *)
  }
  and arr = Arr of t
  and elt = Elt of t
  and op =
    | Noop
    | Var
    | Const
    | Empty                         of int array
    | Zeros                         of int array
    | Ones                          of int array
    | Create                        of int array
    | Sequential
    | Uniform                       of int array
    | Gaussian
    | Bernoulli                     of float * (int array)
    | Init                          of (int -> elt)
    | Get                           of int array
    | Set                           of int array
    | GetSlice                      of int list list
    | SetSlice                      of int list list
    | Copy
    | Reset
    | Reshape                       of int array
    | Reverse
    | Tile                          of int array
    | Repeat                        of int * int
    | Concatenate                   of int
    | Split                         of int * int array
    | Draw                          of int * int
    | Map                           of (elt -> elt)
    | Fold                          of int * (elt -> elt -> elt)
    | Scan                          of int * (elt -> elt -> elt)
    | OneHot                        of int
    | Abs
    | Neg
    | Floor
    | Ceil
    | Round
    | Sqr
    | Sqrt
    | Log
    | Log2
    | Log10
    | Exp
    | Sin
    | Cos
    | Tan
    | Sinh
    | Cosh
    | Tanh
    | Asin
    | Acos
    | Atan
    | Asinh
    | Acosh
    | Atanh
    | Min                           of int
    | Max                           of int
    | Sum                           of int
    | SumReduce                     of int array
    | Signum
    | Sigmoid
    | Relu
    | Min'
    | Max'
    | Sum'
    | L1norm'
    | L2norm'
    | L2NormSqr'
    | ClipByValue
    | ClipByL2norm
    | Pow
    | ScalarPow
    | PowScalar
    | Atan2
    | ScalarAtan2
    | Atan2Scalar
    | Hypot
    | Min2
    | Max2
    | Add
    | Sub
    | Mul
    | Div
    | AddScalar
    | SubScalar
    | MulScalar
    | DivScalar
    | ScalarAdd
    | ScalarSub
    | ScalarMul
    | ScalarDiv
    | FMA
    | IsZero
    | IsPositive
    | IsNegative
    | IsNonpositive
    | IsNonnegative
    | Equal
    | NotEqual
    | Less
    | Greater
    | LessEqual
    | GreaterEqual
    | EltEqual
    | EltNotEqual
    | EltLess
    | EltGreater
    | EltLessEqual
    | EltGreaterEqual
    | EltEqualScalar
    | EltNotEqualScalar
    | EltLessScalar
    | EltGreaterScalar
    | EltLessEqualScalar
    | EltGreaterEqualScalar
    | ApproxEqual                   of float option
    | ApproxEqualScalar             of float option
    | ApproxEltEqual                of float option
    | ApproxEltEqualScalar          of float option
    | Conv1d                        of padding * int array
    | Conv2d                        of padding * int array
    | Conv3d                        of padding * int array
    | TransposeConv1d               of padding * int array
    | TransposeConv2d               of padding * int array
    | TransposeConv3d               of padding * int array
    | MaxPool1d                     of padding * int array * int array
    | MaxPool2d                     of padding * int array * int array
    | MaxPool3d                     of padding * int array * int array
    | AvgPool1d                     of padding * int array * int array
    | AvgPool2d                     of padding * int array * int array
    | AvgPool3d                     of padding * int array * int array
    | Conv1dBackwardInput           of int array
    | Conv1dBackwardKernel          of int array
    | Conv2dBackwardInput           of int array
    | Conv2dBackwardKernel          of int array
    | Conv3dBackwardInput           of int array
    | Conv3dBackwardKernel          of int array
    | TransposeConv1dBackwardInput  of int array
    | TransposeConv1dBackwardKernel of int array
    | TransposeConv2dBackwardInput  of int array
    | TransposeConv2dBackwardKernel of int array
    | TransposeConv3dBackwardInput  of int array
    | TransposeConv3dBackwardKernel of int array
    | MaxPool1dBackward             of padding * int array * int array
    | MaxPool2dBackward             of padding * int array * int array
    | MaxPool3dBackward             of padding * int array * int array
    | AvgPool1dBackward             of padding * int array * int array
    | AvgPool2dBackward             of padding * int array * int array
    | AvgPool3dBackward             of padding * int array * int array
    | RowNum
    | ColNum
    | Row
    | Rows                          of int array
    | CopyRowTo
    | CopyColTo
    | Dot                           of bool * bool * elt * elt
    | Inv
    | Trace
    | Transpose                     of int array
    | ToRows
    | OfRows
    | OfArray                       of int array
    | OfArrays
    | Scalar_Add
    | Scalar_Sub
    | Scalar_Mul
    | Scalar_Div
    | Scalar_Pow
    | Scalar_Atan2
    | Scalar_Abs
    | Scalar_Neg
    | Scalar_Sqr
    | Scalar_Sqrt
    | Scalar_Exp
    | Scalar_Log
    | Scalar_Log2
    | Scalar_Log10
    | Scalar_Signum
    | Scalar_Floor
    | Scalar_Ceil
    | Scalar_Round
    | Scalar_Sin
    | Scalar_Cos
    | Scalar_Tan
    | Scalar_Sinh
    | Scalar_Cosh
    | Scalar_Tanh
    | Scalar_Asin
    | Scalar_Acos
    | Scalar_Atan
    | Scalar_Asinh
    | Scalar_Acosh
    | Scalar_Atanh
    | Scalar_Relu
    | Scalar_Sigmoid
    | Fused_Adagrad                 of float * float


  let op_to_str = function
    | Noop                                        -> "Noop"
    | Var                                         -> "Var"
    | Const                                       -> "Const"
    | Empty shape                                 -> "Empty"
    | Zeros shape                                 -> "Zeros"
    | Ones shape                                  -> "Ones"
    | Create shape                                -> "Create"
    | Sequential                                  -> "Sequential"
    | Uniform shape                               -> "Uniform"
    | Gaussian                                    -> "Gaussian"
    | Bernoulli (p, shape)                        -> Printf.sprintf "Bernoulli p:%g" p
    | Init _                                      -> "Init"
    | Get i                                       -> "Get"
    | Set i                                       -> "Set"
    | GetSlice slice                              -> "GetSlice"
    | SetSlice slice                              -> "SetSlice"
    | Copy                                        -> "Copy"
    | Reset                                       -> "Reset"
    | Reshape shape                               -> "Reshape"
    | Reverse                                     -> "Reverse"
    | Tile repeats                                -> "Tile"
    | Repeat (axis, repeats)                      -> "Repeat"
    | Concatenate axis                            -> "Concatenate"
    | Split (axis, parts)                         -> "Split"
    | Draw (axis, n)                              -> "Draw"
    | Map f                                       -> "Map"
    | Fold (axis, f)                              -> "Fold"
    | Scan (axis, f)                              -> "Scan"
    | OneHot depth                                -> Printf.sprintf "OneHot d:%i" depth
    | Abs                                         -> "Abs"
    | Neg                                         -> "Neg"
    | Floor                                       -> "Floor"
    | Ceil                                        -> "Ceil"
    | Round                                       -> "Round"
    | Sqr                                         -> "Sqr"
    | Sqrt                                        -> "Sqrt"
    | Log                                         -> "Log"
    | Log2                                        -> "Log2"
    | Log10                                       -> "Log10"
    | Exp                                         -> "Exp"
    | Sin                                         -> "Sin"
    | Cos                                         -> "Cos"
    | Tan                                         -> "Tan"
    | Sinh                                        -> "Sinh"
    | Cosh                                        -> "Cosh"
    | Tanh                                        -> "Tanh"
    | Asin                                        -> "Asin"
    | Acos                                        -> "Acos"
    | Atan                                        -> "Atan"
    | Asinh                                       -> "Asinh"
    | Acosh                                       -> "Acosh"
    | Atanh                                       -> "Atanh"
    | Min axis                                    -> Printf.sprintf "Min axis:%i" axis
    | Max axis                                    -> Printf.sprintf "Max axis:%i" axis
    | Sum axis                                    -> Printf.sprintf "Sum axis:%i" axis
    | SumReduce axis                              -> "SumReduce"
    | Signum                                      -> "Signum"
    | Sigmoid                                     -> "Sigmoid"
    | Relu                                        -> "Relu"
    | Min'                                        -> "Min'"
    | Max'                                        -> "Max'"
    | Sum'                                        -> "Sum'"
    | L1norm'                                     -> "L1norm'"
    | L2norm'                                     -> "L2norm'"
    | L2NormSqr'                                  -> "L2NormSqr'"
    | ClipByValue                                 -> "ClipByValue"
    | ClipByL2norm                                -> "ClipByL2norm"
    | Pow                                         -> "Pow"
    | ScalarPow                                   -> "ScalarPow"
    | PowScalar                                   -> "PowScalar"
    | Atan2                                       -> "Atan2"
    | ScalarAtan2                                 -> "ScalarAtan2"
    | Atan2Scalar                                 -> "Atan2Scalar"
    | Hypot                                       -> "Hypot"
    | Min2                                        -> "Min2"
    | Max2                                        -> "Max2"
    | Add                                         -> "Add"
    | Sub                                         -> "Sub"
    | Mul                                         -> "Mul"
    | Div                                         -> "Div"
    | AddScalar                                   -> "AddScalar"
    | SubScalar                                   -> "SubScalar"
    | MulScalar                                   -> "MulScalar"
    | DivScalar                                   -> "DivScalar"
    | ScalarAdd                                   -> "ScalarAdd"
    | ScalarSub                                   -> "ScalarSub"
    | ScalarMul                                   -> "ScalarMul"
    | ScalarDiv                                   -> "ScalarDiv"
    | FMA                                         -> "FMA"
    | IsZero                                      -> "IsZero"
    | IsPositive                                  -> "IsPositive"
    | IsNegative                                  -> "IsNegative"
    | IsNonpositive                               -> "IsNonpositive"
    | IsNonnegative                               -> "IsNonnegative"
    | Equal                                       -> "Equal"
    | NotEqual                                    -> "NotEqual"
    | Less                                        -> "Less"
    | Greater                                     -> "Greater"
    | LessEqual                                   -> "LessEqual"
    | GreaterEqual                                -> "GreaterEqual"
    | EltEqual                                    -> "EltEqual"
    | EltNotEqual                                 -> "EltNotEqual"
    | EltLess                                     -> "EltLess"
    | EltGreater                                  -> "EltGreater"
    | EltLessEqual                                -> "EltLessEqual"
    | EltGreaterEqual                             -> "EltGreaterEqual"
    | EltEqualScalar                              -> "EltEqualScalar"
    | EltNotEqualScalar                           -> "EltNotEqualScalar"
    | EltLessScalar                               -> "EltLessScalar"
    | EltGreaterScalar                            -> "EltGreaterScalar"
    | EltLessEqualScalar                          -> "EltLessEqualScalar"
    | EltGreaterEqualScalar                       -> "EltGreaterEqualScalar"
    | ApproxEqual eps                             -> "ApproxEqual"
    | ApproxEqualScalar eps                       -> "ApproxEqualScalar"
    | ApproxEltEqual eps                          -> "ApproxEltEqual"
    | ApproxEltEqualScalar eps                    -> "ApproxEltEqualScalar"
    | Conv1d (padding, stride)                    -> "Conv1d"
    | Conv2d (padding, stride)                    -> "Conv2d"
    | Conv3d (padding, stride)                    -> "Conv3d"
    | TransposeConv1d (padding, stride)           -> "TransposeConv1d"
    | TransposeConv2d (padding, stride)           -> "TransposeConv2d"
    | TransposeConv3d (padding, stride)           -> "TransposeConv3d"
    | MaxPool1d (padding, kernel, stride)         -> "MaxPool1d"
    | MaxPool2d (padding, kernel, stride)         -> "MaxPool2d"
    | MaxPool3d (padding, kernel, stride)         -> "MaxPool3d"
    | AvgPool1d (padding, kernel, stride)         -> "AvgPool1d"
    | AvgPool2d (padding, kernel, stride)         -> "AvgPool2d"
    | AvgPool3d (padding, kernel, stride)         -> "AvgPool3d"
    | Conv1dBackwardInput stride                  -> "Conv1dBackwardInput"
    | Conv1dBackwardKernel stride                 -> "Conv1dBackwardKernel"
    | Conv2dBackwardInput stride                  -> "Conv2dBackwardInput"
    | Conv2dBackwardKernel stride                 -> "Conv2dBackwardKernel"
    | Conv3dBackwardInput stride                  -> "Conv3dBackwardInput"
    | Conv3dBackwardKernel stride                 -> "Conv3dBackwardKernel"
    | TransposeConv1dBackwardInput stride         -> "TransposeConv1dBackwardInput"
    | TransposeConv1dBackwardKernel stride        -> "TransposeConv1dBackwardKernel"
    | TransposeConv2dBackwardInput stride         -> "TransposeConv2dBackwardInput"
    | TransposeConv2dBackwardKernel stride        -> "TransposeConv2dBackwardKernel"
    | TransposeConv3dBackwardInput stride         -> "TransposeConv3dBackwardInput"
    | TransposeConv3dBackwardKernel stride        -> "TransposeConv3dBackwardKernel"
    | MaxPool1dBackward (padding, kernel, stride) -> "MaxPool1dBackward"
    | MaxPool2dBackward (padding, kernel, stride) -> "MaxPool2dBackward"
    | MaxPool3dBackward (padding, kernel, stride) -> "MaxPool3dBackward"
    | AvgPool1dBackward (padding, kernel, stride) -> "AvgPool1dBackward"
    | AvgPool2dBackward (padding, kernel, stride) -> "AvgPool2dBackward"
    | AvgPool3dBackward (padding, kernel, stride) -> "AvgPool3dBackward"
    | RowNum                                      -> "RowNum"
    | ColNum                                      -> "ColNum"
    | Row                                         -> "Row"
    | Rows i                                      -> "Rows"
    | CopyRowTo                                   -> "CopyRowTo"
    | CopyColTo                                   -> "CopyColTo"
    | Dot (transa, transb, alpha, beta)           -> "Dot"
    | Inv                                         -> "Inv"
    | Trace                                       -> "Trace"
    | Transpose i                                 -> "Transpose"
    | ToRows                                      -> "ToRows"
    | OfRows                                      -> "OfRows"
    | OfArray shape                               -> "OfArray"
    | OfArrays                                    -> "OfArrays"
    | Scalar_Add                                  -> "Scalar Add"
    | Scalar_Sub                                  -> "Scalar Sub"
    | Scalar_Mul                                  -> "Scalar Mul"
    | Scalar_Div                                  -> "Scalar Div"
    | Scalar_Pow                                  -> "Scalar Pow"
    | Scalar_Atan2                                -> "Scalar Atan2"
    | Scalar_Abs                                  -> "Scalar Abs"
    | Scalar_Neg                                  -> "Scalar Neg"
    | Scalar_Sqr                                  -> "Scalar Sqr"
    | Scalar_Sqrt                                 -> "Scalar Sqrt"
    | Scalar_Exp                                  -> "Scalar Exp"
    | Scalar_Log                                  -> "Scalar Log"
    | Scalar_Log2                                 -> "Scalar Log2"
    | Scalar_Log10                                -> "Scalar Log10"
    | Scalar_Signum                               -> "Scalar Signum"
    | Scalar_Floor                                -> "Scalar Floor"
    | Scalar_Ceil                                 -> "Scalar Ceil"
    | Scalar_Round                                -> "Scalar Round"
    | Scalar_Sin                                  -> "Scalar Sin"
    | Scalar_Cos                                  -> "Scalar Cos"
    | Scalar_Tan                                  -> "Scalar Tan"
    | Scalar_Sinh                                 -> "Scalar Sinh"
    | Scalar_Cosh                                 -> "Scalar Cosh"
    | Scalar_Tanh                                 -> "Scalar Tanh"
    | Scalar_Asin                                 -> "Scalar Asin"
    | Scalar_Acos                                 -> "Scalar Acos"
    | Scalar_Atan                                 -> "Scalar Atan"
    | Scalar_Asinh                                -> "Scalar Asinh"
    | Scalar_Acosh                                -> "Scalar Acosh"
    | Scalar_Atanh                                -> "Scalar Atanh"
    | Scalar_Relu                                 -> "Scalar Relu"
    | Scalar_Sigmoid                              -> "Scalar Sigmoid"
    | Fused_Adagrad (rate, eps)                   -> "Fused_Adagrad"


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


  let _infer_shape_xx input_shapes = failwith "_infer_shape_xx: not implemented"


  let infer_shape operator args =
    let input_shapes = Array.map (fun a -> (attr a).shape) args in
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
    | IsZero                                      -> _infer_shape_00 input_shapes
    | IsPositive                                  -> _infer_shape_00 input_shapes
    | IsNegative                                  -> _infer_shape_00 input_shapes
    | IsNonpositive                               -> _infer_shape_00 input_shapes
    | IsNonnegative                               -> _infer_shape_00 input_shapes
    | Equal                                       -> _infer_shape_00 input_shapes
    | NotEqual                                    -> _infer_shape_00 input_shapes
    | Less                                        -> _infer_shape_00 input_shapes
    | Greater                                     -> _infer_shape_00 input_shapes
    | LessEqual                                   -> _infer_shape_00 input_shapes
    | GreaterEqual                                -> _infer_shape_00 input_shapes
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
    | ApproxEqual _                               -> _infer_shape_00 input_shapes
    | ApproxEqualScalar _                         -> _infer_shape_00 input_shapes
    | ApproxEltEqual _                            -> _infer_shape_01 input_shapes
    | ApproxEltEqualScalar _                      -> _infer_shape_01 input_shapes
    | Conv1d (padding, stride)                    -> _infer_shape_11 input_shapes padding stride
    | Conv2d (padding, stride)                    -> _infer_shape_12 input_shapes padding stride
    | Conv3d (padding, stride)                    -> _infer_shape_13 input_shapes padding stride
    | TransposeConv1d (padding, stride)           -> _infer_shape_24 input_shapes padding stride
    | TransposeConv2d (padding, stride)           -> _infer_shape_14 input_shapes padding stride
    | TransposeConv3d (padding, stride)           -> _infer_shape_25 input_shapes padding stride
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
    | OfArray shape                               -> [| Some shape |]
    | OfArrays                                    -> _infer_shape_xx input_shapes
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


  (* Helper functions *)

  let refnum x = Owl_graph.outdegree x


  let is_shape_unkown x =
    let x_shape = (attr x).shape in
    match x_shape.(0) with
    | Some _ -> true
    | None   -> false


  let infer_shape_graph xs =
    iter_descendants (fun x ->
      if is_shape_unkown x = false then (
        let x_attr = attr x in
        let x_parents = parents x in
        x_attr.shape <- infer_shape x_attr.op x_parents
      )
    ) xs


  let shape_to_str shp =
    assert (Array.length shp > 0);
    let s = match shp.(0) with
      | Some s -> Owl_utils_array.to_string string_of_int s
      | None   -> "unkown"
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


  let make_node ?name ?value ?shape ?freeze ?reuse ?state op =
    let value = match value with Some v -> v | None -> [| |] in
    let shape = match shape with Some s -> s | None -> [| None |] in
    let state = match state with Some s -> s | None -> Invalid in
    let reuse = match reuse with Some s -> s | None -> true in
    let freeze = match freeze with Some s -> s | None -> false in
    Owl_graph.node ?name { op; freeze; reuse; state; shape; value }


  let make_then_connect ?shape op parents =
    let shape = match shape with
      | Some s -> s
      | None   -> infer_shape op parents
    in
    let child = make_node ~shape op in
    Array.iter (fun parent ->
      if (attr parent).freeze = true then
        connect_ancestors [|parent|] [|child|]
      else
        connect [|parent|] [|child|]
    ) parents;
    (* connect parents [|child|]; *)
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


  let set_value x v = (attr x).value <- v


  let get_value x = (attr x).value


  let set_operator x op = (attr x).op <- op


  let get_operator x = (attr x).op


  let set_reuse x reuse =
    let op = (attr x).op in
    if op = Var && op = Const then
      Owl_log.warn "set_reuse: ignored, %s" (node_to_str x)
    else
      (attr x).reuse <- reuse


  let get_reuse x = (attr x).reuse


  let is_var x = (attr x).op = Var


  let is_const x = (attr x).op = Const


  let is_arr x =
    match (attr x).shape.(0) with
    | Some _ -> true
    | None   -> false


  let is_elt x =
    match (attr x).shape.(0) with
    | Some _ -> false
    | None   -> true


  let is_assigned x =
    let value = (attr x).value in
    let valen = Array.length value in
    valen > 0


  let check_assigned x =
    let value = (attr x).value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "value not assigned: %s" (node_to_str x);
      assert (valen > 0)
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
    let value = (arr_to_node x |> attr).value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "value not assigned: %s" (arr_to_node x |> node_to_str);
      assert (valen > 0)
    );
    value_to_arr value.(0)


  let pack_elt elt = const_elt "" elt


  let unpack_elt x =
    let value = (elt_to_node x |> attr).value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "value not assigned: %s" (elt_to_node x |> node_to_str);
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
        let dst = unpack_arr x in
        A.copy_to arr dst
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


  (* TODO: should move to symbolic ... *)
  let arr_to_var x =
    let attr = arr_to_node x |> attr in
    let op = attr.op in
    let freeze = attr.freeze in
    let reuse = false in
    let state = attr.state in
    let shape = attr.shape in
    let value = attr.value in
    Owl_graph.node ~name:"" { op; state; reuse; freeze; shape; value }
    |> node_to_arr


  let float_to_elt x = const_elt "" (A.float_to_elt x)


  let elt_to_float x = unpack_elt x |> A.elt_to_float


  (* print shape for ndarrays, whilst value for scalars *)
  let shape_or_value x =
    let shape = (attr x).shape in
    if is_assigned x = true then (
      match shape.(0) with
      | Some s -> (
          if Array.length s = 0 then
            Printf.sprintf "v:%g" (node_to_elt x |> elt_to_float)
          else
            Printf.sprintf "s:%s" (shape_to_str shape)
        )
      | None   -> Printf.sprintf "s:%s" (shape_to_str shape)
    )
    else
      Printf.sprintf "s:%s" (shape_to_str shape)


  let nodes_to_dot x =
    let edge_s = fold_in_edges (fun a u v -> Printf.sprintf "%s%i -> %i;\n" a (id u) (id v)) "" x in
    let node_s = fold_ancestors (fun a n ->
      let svs = shape_or_value n in
      Printf.sprintf "%s%i [ label=\"{{#%i | { %s | %s }} | r:%i; %s }\" ];\n"
        a (id n) (id n) (name n) (op_to_str (attr n).op) (refnum n) svs
    ) "" x
    in
    Printf.sprintf "digraph CG {\nnode [shape=record];\n%s%s}" edge_s node_s


  let to_trace x = "to_trace: not implemented yet"


end
