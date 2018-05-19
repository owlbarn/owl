(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making Lazy module of different number types *)

module Make (A : Ndarray_Algodiff) = struct


  (* type definitions *)

  type state = Valid | Invalid

  type value = ArrVal of A.arr | EltVal of A.elt

  type t = attr node
  and attr = {
    mutable op    : op;
    mutable state : state;
    mutable shape : (int array option) array;
    mutable value : value array;
  }
  and arr = Arr of t
  and elt = Elt of t
  and op =
    | Noop
    | Var
    | Const
    | Empty
    | Zeros
    | Ones
    | Create
    | Sequential
    | Uniform
    | Gaussian
    | Bernoulli                     of float option
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
    | TransposeConv2d               of padding * int array
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
    | TransposeConv2dBackwardInput  of int array
    | TransposeConv2dBackwardKernel of int array
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
    | Dot
    | Inv
    | Trace
    | Transpose                     of int array
    | ToRows
    | OfRows
    | OfArray                       of int array
    | OfArrays


  let op_to_str = function
    | Noop                                        -> "Noop"
    | Var                                         -> "Var"
    | Const                                       -> "Const"
    | Empty                                       -> "Empty"
    | Zeros                                       -> "Zeros"
    | Ones                                        -> "Ones"
    | Create                                      -> "Create"
    | Sequential                                  -> "Sequential"
    | Uniform                                     -> "Uniform"
    | Gaussian                                    -> "Gaussian"
    | Bernoulli _                                 -> "Bernoulli"
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
    | Min axis                                    -> "Min"
    | Max axis                                    -> "Max"
    | Sum axis                                    -> "Sum"
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
    | TransposeConv2d (padding, stride)           -> "TransposeConv2d"
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
    | TransposeConv2dBackwardInput stride         -> "TransposeConv2dBackwardInput"
    | TransposeConv2dBackwardKernel stride        -> "TransposeConv2dBackwardKernel"
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
    | Dot                                         -> "Dot"
    | Inv                                         -> "Inv"
    | Trace                                       -> "Trace"
    | Transpose i                                 -> "Transpose"
    | ToRows                                      -> "ToRows"
    | OfRows                                      -> "OfRows"
    | OfArray shape                               -> "OfArray"
    | OfArrays                                    -> "OfArrays"


  (* packing and unpacking functions *)

  let node_to_arr x = Arr x

  let arr_to_node = function Arr x -> x

  let node_to_elt x = Elt x

  let elt_to_node = function Elt x -> x

  let pack_arr x = ArrVal x

  let unpack_arr = function ArrVal x -> x | _ -> failwith "Owl_computation_graph: unpack_arr"

  let pack_elt x = EltVal x

  let unpack_elt = function EltVal x -> x | _ -> failwith "Owl_computation_graph: unpack_elt"


  (* infer the shape of outcome from inputs *)

  let _infer_shape_00 input_shapes = [| Some [||] |]


  let _infer_shape_01 input_shapes =
    Owl_log.warn "_infer_shape_01";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Array.(copy s) |]
    | None   -> [| None |]


  let _infer_shape_02 input_shapes =
    Owl_log.warn "_infer_shape_02";
    match input_shapes.(1).(0) with
    | Some s -> [| Some Array.(copy s) |]
    | None   -> [| None |]


  let _infer_shape_03 input_shapes =
    Owl_log.warn "_infer_shape_03";
    let s0 = input_shapes.(0).(0) in
    let s1 = input_shapes.(1).(0) in
    match s0, s1 with
    | Some s0, Some s1 -> [| Some Owl_utils.(calc_broadcast_shape s0 s1) |]
    | _, _             -> [| None |]


  let _infer_shape_04 input_shapes axis =
    Owl_log.warn "_infer_shape_04";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils.(calc_fold_shape s axis) |]
    | None   -> [| None |]


  let _infer_shape_05 input_shapes repeats =
    Owl_log.warn "_infer_shape_05";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils.(calc_tile_shape s repeats) |]
    | None   -> [| None |]


  let _infer_shape_06 input_shapes axis repeats =
  Owl_log.warn "_infer_shape_06";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils.(calc_repeat_shape s axis repeats) |]
    | None   -> [| None |]


  let _infer_shape_07 input_shapes axis =
  Owl_log.warn "_infer_shape_07";
    let s0 = Array.map (fun s -> s.(0)) input_shapes in
    if Array.exists (function Some _ -> false | None -> true) s0 then [| None |]
    else (
      let s1 = Array.map (function Some a -> a | None -> failwith "_infer_shape_07") s0 in
      [| Some Owl_utils.(calc_concatenate_shape s1 axis) |]
    )


  let _infer_shape_08 input_shapes axis parts =
    Owl_log.warn "_infer_shape_08";
    match input_shapes.(0).(0) with
    | Some s -> (
        let s0 = Owl_utils.(calc_split_shape s axis parts) in
        Array.map (fun s -> Some s) s0
      )
    | None   -> Array.(make (length parts) None)


  let _infer_shape_09 input_shapes axis n =
    Owl_log.warn "_infer_shape_09";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils.(calc_draw_shape s axis n) |]
    | None   -> [| None |]


  let _infer_shape_10 input_shapes axis =
    Owl_log.warn "_infer_shape_10";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils.(calc_reduce_shape s axis) |]
    | None   -> [| None |]


  let _infer_shape_11 input_shapes padding stride =
    Owl_log.warn "_infer_shape_11";
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils.(calc_conv1d_shape input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_12 input_shapes padding stride =
    Owl_log.warn "_infer_shape_12";
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils.(calc_conv2d_shape input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_13 input_shapes padding stride =
    Owl_log.warn "_infer_shape_13";
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils.(calc_conv3d_shape input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_14 input_shapes padding stride =
    Owl_log.warn "_infer_shape_14";
    let input_shape = input_shapes.(0).(0) in
    let kernel_shape = input_shapes.(1).(0) in
    match input_shape, kernel_shape with
    | Some input, Some kernel -> [| Some Owl_utils.(calc_transpose_conv2d_shape input padding kernel stride) |]
    | _, _                    -> [| None |]


  let _infer_shape_15 input_shapes padding kernel stride =
    Owl_log.warn "_infer_shape_15";
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils.(calc_conv1d_shape input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_16 input_shapes padding kernel stride =
    Owl_log.warn "_infer_shape_16";
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils.(calc_conv2d_shape input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_17 input_shapes padding kernel stride =
    Owl_log.warn "_infer_shape_17";
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils.(calc_conv3d_shape input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_18 input_shapes axis =
    Owl_log.warn "_infer_shape_18";
    match input_shapes.(0).(0) with
    | Some s -> [| Some Owl_utils.(calc_transpose_shape s axis) |]
    | None   -> [| None |]


  let _infer_shape_19 input_shapes =
    Owl_log.warn "_infer_shape_19";
    let x_shape = input_shapes.(0).(0) in
    let y_shape = input_shapes.(1).(0) in
    match x_shape, y_shape with
    | Some s0, Some s1 -> [| Some Owl_utils.(calc_dot_shape s0 s1) |]
    | _, _                    -> [| None |]


  let _infer_shape_20 input_shapes axis =
    Owl_log.warn "_infer_shape_20";
    match input_shapes.(0).(0) with
    | Some s -> (
        let axis = List.map (fun i -> R_ (Array.of_list i)) axis |> Array.of_list in
        let axis = Owl_base_slicing.check_slice_definition axis s in
        [| Some Owl_base_slicing.(calc_slice_shape axis) |]
      )
    | None   -> [| None |]


  let _infer_shape_21 input_shapes padding kernel stride =
    Owl_log.warn "_infer_shape_21";
    let input_shape = input_shapes.(0).(0) in
    match input_shape with
    | Some input -> [| Some Owl_utils.(calc_pool2d_shape input padding kernel stride) |]
    | _          -> [| None |]


  let _infer_shape_xx input_shapes = [| None |]


  let infer_shape operator args =
    let input_shapes = Array.map (fun a -> (attr a).shape) args in
    match operator with
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
    | TransposeConv2d (padding, stride)           -> _infer_shape_14 input_shapes padding stride
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
    | TransposeConv2dBackwardInput stride         -> _infer_shape_01 input_shapes
    | TransposeConv2dBackwardKernel stride        -> _infer_shape_02 input_shapes
    | MaxPool1dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | MaxPool2dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | MaxPool3dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | AvgPool1dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | AvgPool2dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | AvgPool3dBackward (padding, kernel, stride) -> _infer_shape_01 input_shapes
    | Row                                         -> _infer_shape_09 input_shapes 0 1
    | Rows i                                      -> _infer_shape_09 input_shapes 0 Array.(length i)
    | Dot                                         -> _infer_shape_19 input_shapes
    | Inv                                         -> _infer_shape_01 input_shapes
    | Trace                                       -> _infer_shape_00 input_shapes
    | Transpose axis                              -> _infer_shape_18 input_shapes axis
    | ToRows                                      -> _infer_shape_xx input_shapes
    | OfRows                                      -> _infer_shape_xx input_shapes
    | OfArray shape                               -> [| Some shape |]
    | OfArrays                                    -> _infer_shape_xx input_shapes
    | _                                           -> [| None |]


  (* core manipulation functions *)

  let make_node ?name ?value ?shape op =
    let value = match value with Some v -> v | None -> [||] in
    let shape = match shape with Some s -> s | None -> [| None |] in
    let state = Invalid in
    Owl_graph.node ?name { op; state; shape; value }


  let make_then_connect ?shape op parents =
    let shape = match shape with
      | Some s -> s
      | None   -> infer_shape op parents
    in
    let child = make_node ~shape op in
    connect parents [|child|];
    child


  let refnum x = Owl_graph.outdegree x


  let set_value x v = (attr x).value <- v


  let get_value x = (attr x).value


  let get_operator x = (attr x).op


  let is_var x = (attr x).op = Var


  let is_const x = (attr x).op = Const


  let is_assigned x = assert (Array.length (attr x).value > 0)


  let is_valid x = (attr x).state = Valid


  let validate x = (attr x).state <- Valid


  let invalidate x =
    let a = attr x in
    a.state <- Invalid;
    a.value <- [||]


  let invalidate_graph x = iter_descendants invalidate [|x|]


  (* mathematical functions *)

  let noop x = make_then_connect Noop [|arr_to_node x|] |> node_to_arr

  let var_arr ~name shape = make_node ~name ~shape:[|shape|] Var |> node_to_arr

  let var_elt ~name = make_node ~name ~shape:[|Some [||]|] Var |> node_to_elt

  let const_arr ~name shape = make_node ~name ~shape:[|shape|] Const |> node_to_arr

  let const_elt ~name = make_node ~name ~shape:[|Some [||]|] Const |> node_to_elt

  let empty shape =
    Owl_log.warn "empty";
    make_node ~shape:[|Some shape|] Empty |> node_to_arr

  let zeros shape =
    Owl_log.warn "zeros";
    make_node ~shape:[|Some shape|] Zeros |> node_to_arr

  let ones shape =
    Owl_log.warn "ones";
    make_node ~shape:[|Some shape|] Ones |> node_to_arr

  let create shape v =
    Owl_log.warn "create";
    make_then_connect ~shape:[|Some shape|] Create [|elt_to_node v|] |> node_to_arr

  let sequential ?a ?step shape =
    Owl_log.warn "sequential";
    make_node ~shape:[|Some shape|] Sequential |> node_to_arr

  let uniform ?a ?b shape =
    Owl_log.warn "uniform";
    make_node ~shape:[|Some shape|] Uniform |> node_to_arr

  let gaussian ?mu ?sigma shape =
    Owl_log.warn "gaussian";
    make_node ~shape:[|Some shape|] Gaussian |> node_to_arr

  let bernoulli ?p shape =
    Owl_log.warn "bernoulli";
    make_node ~shape:[|Some shape|] (Bernoulli p) |> node_to_arr

  let init shape f =
    Owl_log.warn "init";
    make_node ~shape:[|Some shape|] (Init f) |> node_to_arr

  let shape x =
    Owl_log.warn "shape";
    let x_shape = (arr_to_node x |> attr).shape in
    assert (Array.length x_shape > 0);
    match x_shape.(0) with
    | Some s -> s
    | None   -> [||]

  let numel x =
    Owl_log.warn "numel";
    Array.fold_left ( * ) 1 (shape x)

  let get x i =
    Owl_log.warn "get";
    make_then_connect (Get i) [|arr_to_node x|] |> node_to_elt

  let set x i v =
    Owl_log.warn "set";
    make_then_connect (Set i) [|arr_to_node x; elt_to_node v|] |> ignore

  let get_slice slice x =
    Owl_log.warn "get_slice";
    make_then_connect (GetSlice slice) [|arr_to_node x|] |> node_to_arr

  let set_slice slice x y =
    Owl_log.warn "set_slice";
    make_then_connect (SetSlice slice) [|arr_to_node x; arr_to_node y|] |> ignore

  let copy x =
    Owl_log.warn "copy";
    make_then_connect Copy [|arr_to_node x|] |> node_to_arr

  let reset x =
    Owl_log.warn "reset";
    make_then_connect Reset [|arr_to_node x|] |> node_to_arr |> ignore

  let reshape x shape =
    Owl_log.warn "reshape";
    let n_old = numel x in
    let n_new = Array.fold_left ( * ) 1 shape in
    assert (n_old = n_new);
    make_then_connect (Reshape shape) [|arr_to_node x|] |> node_to_arr

  let reverse x =
    Owl_log.warn "reverse";
    make_then_connect Reverse [|arr_to_node x|] |> node_to_arr

  let tile x axises =
    Owl_log.warn "tile";
    make_then_connect (Tile axises) [|arr_to_node x|] |> node_to_arr

  let repeat ?(axis=(-1)) x repeats =
    Owl_log.warn "repeat";
    make_then_connect (Repeat (axis, repeats)) [|arr_to_node x|] |> node_to_arr

  let concatenate ?(axis=0) xs =
    Owl_log.warn "concatenate";
    make_then_connect (Concatenate axis) (Array.map arr_to_node xs) |> node_to_arr

  let split ?(axis=0) parts x =
    Owl_log.warn "split";
    let y = make_then_connect (Split (axis, parts)) [|arr_to_node x|] in
    (* FIXME: wrong shape *)
    Array.map (fun s ->
      let z = make_node ~shape:[|Some parts|] Noop in
      connect [|y|] [|z|];
      node_to_arr y
    ) parts

  let draw ?(axis=0) x n =
    Owl_log.warn "draw";
    let y = make_then_connect (Draw (axis, n)) [|arr_to_node x|] |> node_to_arr in
    y, [||]

  let map f x =
    Owl_log.warn "map";
    make_then_connect (Map f) [|arr_to_node x|] |> node_to_arr

  let fold ?(axis=(-1)) f a x =
    Owl_log.warn "fold";
    make_then_connect (Fold (axis, f)) [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let scan ?(axis=(-1)) f x =
    Owl_log.warn "scan";
    make_then_connect (Scan (axis, f)) [|arr_to_node x|] |> node_to_arr

  let print ?max_row ?max_col ?header ?fmt x = ()


  let abs x = make_then_connect Abs [|arr_to_node x|] |> node_to_arr

  let neg x = make_then_connect Neg [|arr_to_node x|] |> node_to_arr

  let floor x = make_then_connect Floor [|arr_to_node x|] |> node_to_arr

  let ceil x = make_then_connect Ceil [|arr_to_node x|] |> node_to_arr

  let round x = make_then_connect Round [|arr_to_node x|] |> node_to_arr

  let sqr x = make_then_connect Sqr [|arr_to_node x|] |> node_to_arr

  let sqrt x = make_then_connect Sqrt [|arr_to_node x|] |> node_to_arr

  let log x = make_then_connect Log [|arr_to_node x|] |> node_to_arr

  let log2 x = make_then_connect Log2 [|arr_to_node x|] |> node_to_arr

  let log10 x = make_then_connect Log10 [|arr_to_node x|] |> node_to_arr

  let exp x = make_then_connect Exp [|arr_to_node x|] |> node_to_arr

  let sin x = make_then_connect Sin [|arr_to_node x|] |> node_to_arr

  let cos x = make_then_connect Cos [|arr_to_node x|] |> node_to_arr

  let tan x = make_then_connect Tan [|arr_to_node x|] |> node_to_arr

  let sinh x = make_then_connect Sinh [|arr_to_node x|] |> node_to_arr

  let cosh x = make_then_connect Cosh [|arr_to_node x|] |> node_to_arr

  let tanh x = make_then_connect Tanh [|arr_to_node x|] |> node_to_arr

  let asin x = make_then_connect Asin [|arr_to_node x|] |> node_to_arr

  let acos x = make_then_connect Acos [|arr_to_node x|] |> node_to_arr

  let atan x = make_then_connect Atan [|arr_to_node x|] |> node_to_arr

  let asinh x = make_then_connect Asinh [|arr_to_node x|] |> node_to_arr

  let acosh x = make_then_connect Acosh [|arr_to_node x|] |> node_to_arr

  let atanh x = make_then_connect Atanh [|arr_to_node x|] |> node_to_arr

  let min ?(axis=(-1)) x = make_then_connect (Min axis) [|arr_to_node x|] |> node_to_arr

  let max ?(axis=(-1)) x = make_then_connect (Max axis) [|arr_to_node x|] |> node_to_arr

  let sum ?(axis=(-1)) x = make_then_connect (Sum axis) [|arr_to_node x|] |> node_to_arr

  let sum_reduce ?(axis=[|-1|]) x = make_then_connect (SumReduce axis) [|arr_to_node x|] |> node_to_arr

  let signum x = make_then_connect Signum [|arr_to_node x|] |> node_to_arr

  let sigmoid x = make_then_connect Sigmoid [|arr_to_node x|] |> node_to_arr

  let relu x = make_then_connect Relu [|arr_to_node x|] |> node_to_arr

  let min' x = make_then_connect Min' [|arr_to_node x|] |> node_to_elt

  let max' x = make_then_connect Max' [|arr_to_node x|] |> node_to_elt

  let sum' x = make_then_connect Sum' [|arr_to_node x|] |> node_to_elt

  let l1norm' x = make_then_connect L1norm' [|arr_to_node x|] |> node_to_elt

  let l2norm' x = make_then_connect L2norm' [|arr_to_node x|] |> node_to_elt

  let l2norm_sqr' x = make_then_connect L2NormSqr' [|arr_to_node x|] |> node_to_elt

  let clip_by_value ?amin ?amax x =
    let amin = match amin with Some a -> a | None -> var_elt "" in
    let amax = match amax with Some a -> a | None -> var_elt "" in
    make_then_connect ClipByValue [|arr_to_node x; elt_to_node amin; elt_to_node amax|] |> node_to_arr

  let clip_by_l2norm a x = make_then_connect ClipByL2norm [|arr_to_node x|] |> node_to_arr

  let pow x y = make_then_connect Pow [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let scalar_pow a x = make_then_connect ScalarPow [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let pow_scalar x a = make_then_connect PowScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let atan2 x y = make_then_connect Atan2 [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let scalar_atan2 a x = make_then_connect ScalarAtan2 [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let atan2_scalar x a = make_then_connect Atan2Scalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let add x y = make_then_connect Add [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let sub x y = make_then_connect Sub [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let mul x y = make_then_connect Mul [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let div x y = make_then_connect Div [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let add_scalar x a = make_then_connect AddScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let sub_scalar x a = make_then_connect SubScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let mul_scalar x a = make_then_connect MulScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let div_scalar x a = make_then_connect DivScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let scalar_add a x = make_then_connect ScalarAdd [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let scalar_sub a x = make_then_connect ScalarSub [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let scalar_mul a x = make_then_connect ScalarMul [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let scalar_div a x = make_then_connect ScalarDiv [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let is_zero x = raise Owl_exception.NOT_IMPLEMENTED

  let is_positive x = raise Owl_exception.NOT_IMPLEMENTED

  let is_negative x = raise Owl_exception.NOT_IMPLEMENTED

  let is_nonpositive x = raise Owl_exception.NOT_IMPLEMENTED

  let is_nonnegative x = raise Owl_exception.NOT_IMPLEMENTED

  let equal x y = raise Owl_exception.NOT_IMPLEMENTED

  let not_equal x y = raise Owl_exception.NOT_IMPLEMENTED

  let less x y = raise Owl_exception.NOT_IMPLEMENTED

  let greater x y = raise Owl_exception.NOT_IMPLEMENTED

  let less_equal x y = raise Owl_exception.NOT_IMPLEMENTED

  let greater_equal x y = raise Owl_exception.NOT_IMPLEMENTED

  let elt_equal x y = make_then_connect EltEqual [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let elt_not_equal x y = make_then_connect EltNotEqual [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let elt_less x y = make_then_connect EltLess [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let elt_greater x y = make_then_connect EltGreater [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let elt_less_equal x y = make_then_connect EltLessEqual [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let elt_greater_equal x y = make_then_connect EltGreaterEqual [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let elt_equal_scalar x a = make_then_connect EltEqualScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let elt_not_equal_scalar x a = make_then_connect EltNotEqualScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let elt_less_scalar x a = make_then_connect EltLessScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let elt_greater_scalar x a = make_then_connect EltGreaterScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let elt_less_equal_scalar x a = make_then_connect EltLessEqualScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let elt_greater_equal_scalar x a = make_then_connect EltGreaterEqualScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let approx_equal ?eps x y =
    make_then_connect (ApproxEqual eps) [|arr_to_node x; arr_to_node y|] |> ignore;
    true

  let approx_equal_scalar ?eps x a =
    make_then_connect (ApproxEqualScalar eps) [|arr_to_node x; elt_to_node a|] |> ignore;
    true

  let approx_elt_equal ?eps x y =
    make_then_connect (ApproxEltEqual eps) [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let approx_elt_equal_scalar ?eps x a =
    make_then_connect (ApproxEltEqualScalar eps) [|arr_to_node x; elt_to_node a|] |> node_to_arr


  let conv1d ?(padding=SAME) input kernel stride =
    Owl_log.warn "conv1d";
    make_then_connect (Conv1d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let conv2d ?(padding=SAME) input kernel stride =
    Owl_log.warn "conv2d";
    make_then_connect (Conv2d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let conv3d ?(padding=SAME) input kernel stride =
    Owl_log.warn "conv3d";
    make_then_connect (Conv3d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let transpose_conv2d ?(padding=SAME) input kernel stride =
    make_then_connect (TransposeConv2d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let max_pool1d ?(padding=SAME) input kernel stride =
    Owl_log.warn "max_pool1d";
    make_then_connect (MaxPool1d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let max_pool2d ?(padding=SAME) input kernel stride =
    Owl_log.warn "max_pool2d";
    make_then_connect (MaxPool2d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let max_pool3d ?(padding=SAME) input kernel stride =
    Owl_log.warn "max_pool3d";
    make_then_connect (MaxPool3d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let avg_pool1d ?(padding=SAME) input kernel stride =
    Owl_log.warn "avg_pool1d";
    make_then_connect (AvgPool1d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let avg_pool2d ?(padding=SAME) input kernel stride =
    Owl_log.warn "avg_pool2d";
    make_then_connect (AvgPool2d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let avg_pool3d ?(padding=SAME) input kernel stride =
    Owl_log.warn "avg_pool3d";
    make_then_connect (AvgPool3d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let conv1d_backward_input input kernel stride output' =
    Owl_log.warn "conv1d_backward_input";
    make_then_connect (Conv1dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv1d_backward_kernel input kernel stride output' =
    Owl_log.warn "conv1d_backward_kernel";
    make_then_connect (Conv1dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv2d_backward_input input kernel stride output' =
    Owl_log.warn "conv2d_backward_input";
    make_then_connect (Conv2dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv2d_backward_kernel input kernel stride output' =
    Owl_log.warn "conv2d_backward_kernel";
    make_then_connect (Conv2dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv3d_backward_input input kernel stride output' =
    Owl_log.warn "conv3d_backward_input";
    make_then_connect (Conv3dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv3d_backward_kernel input kernel stride output' =
    Owl_log.warn "conv3d_backward_kernel";
    make_then_connect (Conv3dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv2d_backward_input input kernel stride output' =
    Owl_log.warn "transpose_conv2d_backward_input";
    make_then_connect (TransposeConv2dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv2d_backward_kernel input kernel stride output' =
    Owl_log.warn "transpose_conv2d_backward_kernel";
    make_then_connect (TransposeConv2dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let max_pool1d_backward padding input kernel stride output' =
    Owl_log.warn "conmax_pool1d_backwardv2d";
    make_then_connect (MaxPool1dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let max_pool2d_backward padding input kernel stride output' =
    Owl_log.warn "max_pool2d_backward";
    make_then_connect (MaxPool2dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let max_pool3d_backward padding input kernel stride output' =
    Owl_log.warn "max_pool3d_backward";
    make_then_connect (MaxPool3dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let avg_pool1d_backward padding input kernel stride output' =
    Owl_log.warn "avg_pool1d_backward";
    make_then_connect (AvgPool1dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let avg_pool2d_backward padding input kernel stride output' =
    Owl_log.warn "avg_pool2d_backward";
    make_then_connect (AvgPool2dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let avg_pool3d_backward padding input kernel stride output' =
    Owl_log.warn "avg_pool3d_backward";
    make_then_connect (AvgPool3dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let row_num x =
    let s = shape x in
    assert (Array.length s = 2);
    s.(0)

  let col_num x =
    let s = shape x in
    assert (Array.length s = 2);
    s.(1)

  let row x i = make_then_connect Row [|arr_to_node x|] |> node_to_arr

  let rows x i = make_then_connect (Rows i) [|arr_to_node x|] |> node_to_arr

  let copy_row_to x y i = make_then_connect CopyRowTo [|arr_to_node x|] |> ignore

  let copy_col_to x y j = make_then_connect CopyColTo [|arr_to_node x|] |> ignore

  let dot x y = make_then_connect Dot [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let inv x = make_then_connect Inv [|arr_to_node x|] |> node_to_arr

  let trace x = make_then_connect Trace [|arr_to_node x|] |> node_to_elt

  let transpose ?axis x =
    let d = Array.length (shape x) in
    let axis = match axis with
      | Some a -> a
      | None   -> Array.init d (fun i -> d - i - 1)
    in
    make_then_connect (Transpose axis) [|arr_to_node x|] |> node_to_arr

  let to_rows x =
    let _ = make_then_connect ToRows [|arr_to_node x|] in
    (* FIXME: wrong shape *)
    [||]

  let of_rows xs = make_then_connect OfRows (Array.map arr_to_node xs) |> node_to_arr

  let of_array x shape = raise Owl_exception.NOT_IMPLEMENTED

  let of_arrays x = raise Owl_exception.NOT_IMPLEMENTED


  let float_to_elt x = const_elt ""

  let elt_to_float x =  infinity


  module Scalar = struct

    let add x y = make_then_connect Add [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let sub x y = make_then_connect Sub [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let mul x y = make_then_connect Mul [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let div x y = make_then_connect Div [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let pow x y = make_then_connect Pow [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let atan2 x y = make_then_connect Atan2 [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let abs x = make_then_connect Abs [|elt_to_node x|] |> node_to_elt

    let neg x = make_then_connect Neg [|elt_to_node x|] |> node_to_elt

    let sqr x = make_then_connect Sqr [|elt_to_node x|] |> node_to_elt

    let sqrt x = make_then_connect Sqrt [|elt_to_node x|] |> node_to_elt

    let exp x = make_then_connect Exp [|elt_to_node x|] |> node_to_elt

    let log x = make_then_connect Log [|elt_to_node x|] |> node_to_elt

    let log2 x = make_then_connect Log2 [|elt_to_node x|] |> node_to_elt

    let log10 x = make_then_connect Log10 [|elt_to_node x|] |> node_to_elt

    let signum x = make_then_connect Signum [|elt_to_node x|] |> node_to_elt

    let floor x = make_then_connect Floor [|elt_to_node x|] |> node_to_elt

    let ceil x = make_then_connect Ceil [|elt_to_node x|] |> node_to_elt

    let round x = make_then_connect Round [|elt_to_node x|] |> node_to_elt

    let sin x = make_then_connect Sin [|elt_to_node x|] |> node_to_elt

    let cos x = make_then_connect Cos [|elt_to_node x|] |> node_to_elt

    let tan x = make_then_connect Tan [|elt_to_node x|] |> node_to_elt

    let sinh x = make_then_connect Sinh [|elt_to_node x|] |> node_to_elt

    let cosh x = make_then_connect Cosh [|elt_to_node x|] |> node_to_elt

    let tanh x = make_then_connect Tanh [|elt_to_node x|] |> node_to_elt

    let asin x = make_then_connect Asin [|elt_to_node x|] |> node_to_elt

    let acos x = make_then_connect Acos [|elt_to_node x|] |> node_to_elt

    let atan x = make_then_connect Atan [|elt_to_node x|] |> node_to_elt

    let asinh x = make_then_connect Asinh [|elt_to_node x|] |> node_to_elt

    let acosh x = make_then_connect Acosh [|elt_to_node x|] |> node_to_elt

    let atanh x = make_then_connect Atanh [|elt_to_node x|] |> node_to_elt

    let relu x = make_then_connect Relu [|elt_to_node x|] |> node_to_elt

    let sigmoid x = make_then_connect Sigmoid [|elt_to_node x|] |> node_to_elt

  end


  let shape_to_str shp =
    assert (Array.length shp > 0);
    let s = match shp.(0) with
      | Some s -> Owl_utils_array.to_string string_of_int s
      | None   -> "? ..."
    in
    Printf.sprintf "[ %s ]" s


  let to_dot x =
    let x = Array.of_list x in
    let edge_s = fold_in_edges (fun a u v -> Printf.sprintf "%s%i -> %i;\n" a (id u) (id v)) "" x in
    let node_s = fold_ancestors (fun a n ->
      let shape_s = shape_to_str (attr n).shape in
      Printf.sprintf "%s%i [ label=\"{{#%i | { %s | %s }} | r:%i; s:%s }\" ];\n"
        a (id n) (id n) (name n) (op_to_str (attr n).op) (refnum n) shape_s
    ) "" x
    in
    Printf.sprintf "digraph CG {\nnode [shape=record];\n%s%s}" edge_s node_s


end
