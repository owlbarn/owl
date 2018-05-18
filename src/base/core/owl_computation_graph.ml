(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


type value


type t = attr node

and attr = {
  op    : op;
  shape : (int array option) array;
  value : value array;
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
  | Conv1d                        of padding option * int array
  | Conv2d                        of padding option * int array
  | Conv3d                        of padding option * int array
  | TransposeConv2d               of padding option * int array
  | MaxPool1d                     of padding option * int array * int array
  | MaxPool2d                     of padding option * int array * int array
  | MaxPool3d                     of padding option * int array * int array
  | AvgPool1d                     of padding option * int array * int array
  | AvgPool2d                     of padding option * int array * int array
  | AvgPool3d                     of padding option * int array * int array
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
  | Rows
  | CopyRowTo
  | CopyColTo
  | Dot
  | Inv
  | Trace
  | Transpose                     of int array option
  | ToRows
  | OfRows
  | OfArray
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
  | Rows                                        -> "Rows"
  | CopyRowTo                                   -> "CopyRowTo"
  | CopyColTo                                   -> "CopyColTo"
  | Dot                                         -> "Dot"
  | Inv                                         -> "Inv"
  | Trace                                       -> "Trace"
  | Transpose i                                 -> "Transpose"
  | ToRows                                      -> "ToRows"
  | OfRows                                      -> "OfRows"
  | OfArray                                     -> "OfArray"
  | OfArrays                                    -> "OfArrays"


(* packing and unpacking functions *)

let pack_arr x = Arr x

let unpack_arr = function Arr x -> x

let pack_elt x = Elt x

let unpack_elt = function Elt x -> x


(* infer the shape of outcome from inputs *)

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
  | Some s0, Some s1 -> [| Some Owl_utils.(calc_broadcast_shape s0 s1) |]
  | _, _             -> [| None |]


let _infer_shape_04 input_shapes axis =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Owl_utils.(calc_fold_shape s axis) |]
  | None   -> [| None |]


let _infer_shape_05 input_shapes repeats =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Owl_utils.(calc_tile_shape s repeats) |]
  | None   -> [| None |]


let _infer_shape_06 input_shapes axis repeats =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Owl_utils.(calc_repeat_shape s axis repeats) |]
  | None   -> [| None |]


let _infer_shape_07 input_shapes axis =
  let s0 = Array.map (fun s -> s.(0)) input_shapes in
  if Array.exists (function Some _ -> false | None -> true) s0 then [| None |]
  else (
    let s1 = Array.map (function Some a -> a | None -> failwith "_infer_shape_07") s0 in
    [| Some Owl_utils.(calc_concatenate_shape s1 axis) |]
  )


let _infer_shape_08 input_shapes axis parts =
  match input_shapes.(0).(0) with
  | Some s -> (
      let s0 = Owl_utils.(calc_split_shape s axis parts) in
      Array.map (fun s -> Some s) s0
    )
  | None   -> Array.(make (length parts) None)


let _infer_shape_09 input_shapes axis n =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Owl_utils.(calc_draw_shape s axis n) |]
  | None   -> [| None |]


let _infer_shape_10 input_shapes axis =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Owl_utils.(calc_reduce_shape s axis) |]
  | None   -> [| None |]


let _infer_shape_x input_shapes = [| None |]


let infer_shape operator args =
  let input_shapes = Array.map (fun a -> (attr a).shape) args in
  match operator with
  | Get _                                       -> [| Some [||] |]
  | GetSlice slice                              -> _infer_shape_x input_shapes
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
  | Min'                                        -> [| Some [||] |]
  | Max'                                        -> [| Some [||] |]
  | Sum'                                        -> [| Some [||] |]
  | L1norm'                                     -> [| Some [||] |]
  | L2norm'                                     -> [| Some [||] |]
  | L2NormSqr'                                  -> [| Some [||] |]
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
  | IsZero                                      -> [| Some [||] |]
  | IsPositive                                  -> [| Some [||] |]
  | IsNegative                                  -> [| Some [||] |]
  | IsNonpositive                               -> [| Some [||] |]
  | IsNonnegative                               -> [| Some [||] |]
  | Equal                                       -> [| Some [||] |]
  | NotEqual                                    -> [| Some [||] |]
  | Less                                        -> [| Some [||] |]
  | Greater                                     -> [| Some [||] |]
  | LessEqual                                   -> [| Some [||] |]
  | GreaterEqual                                -> [| Some [||] |]
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
  | ApproxEqual _                               -> [| Some [||] |]
  | ApproxEqualScalar _                         -> [| Some [||] |]
  | ApproxEltEqual _                            -> _infer_shape_01 input_shapes
  | ApproxEltEqualScalar _                      -> _infer_shape_01 input_shapes
  | Conv1d (padding, stride)                    -> _infer_shape_x input_shapes
  | Conv2d (padding, stride)                    -> _infer_shape_x input_shapes
  | Conv3d (padding, stride)                    -> _infer_shape_x input_shapes
  | TransposeConv2d (padding, stride)           -> _infer_shape_x input_shapes
  | MaxPool1d (padding, kernel, stride)         -> _infer_shape_x input_shapes
  | MaxPool2d (padding, kernel, stride)         -> _infer_shape_x input_shapes
  | MaxPool3d (padding, kernel, stride)         -> _infer_shape_x input_shapes
  | AvgPool1d (padding, kernel, stride)         -> _infer_shape_x input_shapes
  | AvgPool2d (padding, kernel, stride)         -> _infer_shape_x input_shapes
  | AvgPool3d (padding, kernel, stride)         -> _infer_shape_x input_shapes
  | Conv1dBackwardInput stride                  -> _infer_shape_x input_shapes
  | Conv1dBackwardKernel stride                 -> _infer_shape_x input_shapes
  | Conv2dBackwardInput stride                  -> _infer_shape_x input_shapes
  | Conv2dBackwardKernel stride                 -> _infer_shape_x input_shapes
  | Conv3dBackwardInput stride                  -> _infer_shape_x input_shapes
  | Conv3dBackwardKernel stride                 -> _infer_shape_x input_shapes
  | TransposeConv2dBackwardInput stride         -> _infer_shape_x input_shapes
  | TransposeConv2dBackwardKernel stride        -> _infer_shape_x input_shapes
  | MaxPool1dBackward (padding, kernel, stride) -> _infer_shape_x input_shapes
  | MaxPool2dBackward (padding, kernel, stride) -> _infer_shape_x input_shapes
  | MaxPool3dBackward (padding, kernel, stride) -> _infer_shape_x input_shapes
  | AvgPool1dBackward (padding, kernel, stride) -> _infer_shape_x input_shapes
  | AvgPool2dBackward (padding, kernel, stride) -> _infer_shape_x input_shapes
  | AvgPool3dBackward (padding, kernel, stride) -> _infer_shape_x input_shapes
  | Row                                         -> _infer_shape_x input_shapes
  | Rows                                        -> _infer_shape_x input_shapes
  | Dot                                         -> _infer_shape_x input_shapes
  | Inv                                         -> _infer_shape_x input_shapes
  | Trace                                       -> [| Some [||] |]
  | Transpose axies                             -> _infer_shape_x input_shapes
  | ToRows                                      -> _infer_shape_x input_shapes
  | OfRows                                      -> _infer_shape_x input_shapes
  | OfArray                                     -> _infer_shape_x input_shapes
  | OfArrays                                    -> _infer_shape_x input_shapes
  | _                                           -> [| None |]


(* core manipulation functions *)

let make_node ?name ?value ?shape op =
  let value = match value with Some v -> v | None -> [||] in
  let shape = match shape with Some s -> s | None -> [| None |] in
  Owl_graph.node ?name { op; shape; value }


let refnum x = Owl_graph.outdegree x


let make_then_connect ?shape op parents =
  let shape = match shape with
    | Some s -> s
    | None   -> infer_shape op parents
  in
  let child = make_node ~shape op in
  connect parents [|child|];
  child


(* mathematical functions *)

let noop x = make_then_connect Noop [|unpack_arr x|] |> pack_arr

let var_arr ~name shape = make_node ~name ~shape:[|shape|] Var |> pack_arr

let var_elt ~name = make_node ~name ~shape:[|Some [||]|] Var |> pack_elt

let const_arr ~name shape = make_node ~name ~shape:[|shape|] Const |> pack_arr

let const_elt ~name = make_node ~name ~shape:[|Some [||]|] Const |> pack_elt

let empty shape = make_node ~shape:[|Some shape|] Empty |> pack_arr

let zeros shape = make_node ~shape:[|Some shape|] Zeros |> pack_arr

let ones shape = make_node ~shape:[|Some shape|] Ones |> pack_arr

let create shape v = make_then_connect ~shape:[|Some shape|] Create [|unpack_elt v|] |> pack_arr

let sequential ?a ?step shape = make_node ~shape:[|Some shape|] Sequential |> pack_arr

let uniform ?a ?b shape = make_node ~shape:[|Some shape|] Uniform |> pack_arr

let gaussian ?mu ?sigma shape = make_node ~shape:[|Some shape|] Gaussian |> pack_arr

let bernoulli ?p shape = make_node ~shape:[|Some shape|] (Bernoulli p) |> pack_arr

let init shape f = make_node ~shape:[|Some shape|] (Init f) |> pack_arr

let shape x =
  let x_shape = (unpack_arr x |> attr).shape in
  assert (Array.length x_shape > 0);
  match x_shape.(0) with
  | Some s -> s
  | None   -> [||]

let numel x = Array.fold_left ( * ) 1 (shape x)

let get x i = make_then_connect (Get i) [|unpack_arr x|] |> pack_elt

let set x i v = make_then_connect (Set i) [|unpack_arr x; unpack_elt v|] |> ignore

let get_slice slice x = make_then_connect (GetSlice slice) [|unpack_arr x|] |> pack_arr

let set_slice slice x y = make_then_connect (SetSlice slice) [|unpack_arr x; unpack_arr y|] |> ignore

let copy x = make_then_connect Copy [|unpack_arr x|] |> pack_arr

let reset x = make_then_connect Reset [|unpack_arr x|] |> pack_arr |> ignore

let reshape x shape =
  let n_old = numel x in
  let n_new = Array.fold_left ( * ) 1 shape in
  assert (n_old = n_new);
  make_then_connect (Reshape shape) [|unpack_arr x|] |> pack_arr

let reverse x = make_then_connect Reverse [|unpack_arr x|] |> pack_arr

let tile x axises = make_then_connect (Tile axises) [|unpack_arr x|] |> pack_arr

let repeat ?(axis=(-1)) x repeats =
  make_then_connect (Repeat (axis, repeats)) [|unpack_arr x|] |> pack_arr

let concatenate ?(axis=0) xs =
  make_then_connect (Concatenate axis) (Array.map unpack_arr xs) |> pack_arr

let split ?(axis=0) parts x =
  let y = make_then_connect (Split (axis, parts)) [|unpack_arr x|] in
  (* FIXME: wrong shape *)
  Array.map (fun s ->
    let z = make_node ~shape:[|Some parts|] Noop in
    connect [|y|] [|z|];
    pack_arr y
  ) parts

let draw ?(axis=0) x n =
  let y = make_then_connect (Draw (axis, n)) [|unpack_arr x|] |> pack_arr in
  y, [||]

let map f x = make_then_connect (Map f) [|unpack_arr x|] |> pack_arr

let fold ?(axis=(-1)) f a x = make_then_connect (Fold (axis, f)) [|unpack_arr x; unpack_elt a|] |> pack_arr

let scan ?(axis=(-1)) f x = make_then_connect (Scan (axis, f)) [|unpack_arr x|] |> pack_arr

let print ?max_row ?max_col ?header ?fmt x = ()


let abs x = make_then_connect Abs [|unpack_arr x|] |> pack_arr

let neg x = make_then_connect Neg [|unpack_arr x|] |> pack_arr

let floor x = make_then_connect Floor [|unpack_arr x|] |> pack_arr

let ceil x = make_then_connect Ceil [|unpack_arr x|] |> pack_arr

let round x = make_then_connect Round [|unpack_arr x|] |> pack_arr

let sqr x = make_then_connect Sqr [|unpack_arr x|] |> pack_arr

let sqrt x = make_then_connect Sqrt [|unpack_arr x|] |> pack_arr

let log x = make_then_connect Log [|unpack_arr x|] |> pack_arr

let log2 x = make_then_connect Log2 [|unpack_arr x|] |> pack_arr

let log10 x = make_then_connect Log10 [|unpack_arr x|] |> pack_arr

let exp x = make_then_connect Exp [|unpack_arr x|] |> pack_arr

let sin x = make_then_connect Sin [|unpack_arr x|] |> pack_arr

let cos x = make_then_connect Cos [|unpack_arr x|] |> pack_arr

let tan x = make_then_connect Tan [|unpack_arr x|] |> pack_arr

let sinh x = make_then_connect Sinh [|unpack_arr x|] |> pack_arr

let cosh x = make_then_connect Cosh [|unpack_arr x|] |> pack_arr

let tanh x = make_then_connect Tanh [|unpack_arr x|] |> pack_arr

let asin x = make_then_connect Asin [|unpack_arr x|] |> pack_arr

let acos x = make_then_connect Acos [|unpack_arr x|] |> pack_arr

let atan x = make_then_connect Atan [|unpack_arr x|] |> pack_arr

let asinh x = make_then_connect Asinh [|unpack_arr x|] |> pack_arr

let acosh x = make_then_connect Acosh [|unpack_arr x|] |> pack_arr

let atanh x = make_then_connect Atanh [|unpack_arr x|] |> pack_arr

let min ?(axis=(-1)) x = make_then_connect (Min axis) [|unpack_arr x|] |> pack_arr

let max ?(axis=(-1)) x = make_then_connect (Max axis) [|unpack_arr x|] |> pack_arr

let sum ?(axis=(-1)) x = make_then_connect (Sum axis) [|unpack_arr x|] |> pack_arr

let sum_reduce ?(axis=[|-1|]) x = make_then_connect (SumReduce axis) [|unpack_arr x|] |> pack_arr

let signum x = make_then_connect Signum [|unpack_arr x|] |> pack_arr

let sigmoid x = make_then_connect Sigmoid [|unpack_arr x|] |> pack_arr

let relu x = make_then_connect Relu [|unpack_arr x|] |> pack_arr

let min' x = make_then_connect Min' [|unpack_arr x|] |> pack_elt

let max' x = make_then_connect Max' [|unpack_arr x|] |> pack_elt

let sum' x = make_then_connect Sum' [|unpack_arr x|] |> pack_elt

let l1norm' x = make_then_connect L1norm' [|unpack_arr x|] |> pack_elt

let l2norm' x = make_then_connect L2norm' [|unpack_arr x|] |> pack_elt

let l2norm_sqr' x = make_then_connect L2NormSqr' [|unpack_arr x|] |> pack_elt

let clip_by_value ?amin ?amax x =
  let amin = match amin with Some a -> a | None -> var_elt "" in
  let amax = match amax with Some a -> a | None -> var_elt "" in
  make_then_connect ClipByValue [|unpack_arr x; unpack_elt amin; unpack_elt amax|] |> pack_arr

let clip_by_l2norm a x = make_then_connect ClipByL2norm [|unpack_arr x|] |> pack_arr

let pow x y = make_then_connect Pow [|unpack_arr x; unpack_arr y|] |> pack_arr

let scalar_pow a x = make_then_connect ScalarPow [|unpack_elt a; unpack_arr x|] |> pack_arr

let pow_scalar x a = make_then_connect PowScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let atan2 x y = make_then_connect Atan2 [|unpack_arr x; unpack_arr y|] |> pack_arr

let scalar_atan2 a x = make_then_connect ScalarAtan2 [|unpack_elt a; unpack_arr x|] |> pack_arr

let atan2_scalar x a = make_then_connect Atan2Scalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let add x y = make_then_connect Add [|unpack_arr x; unpack_arr y|] |> pack_arr

let sub x y = make_then_connect Sub [|unpack_arr x; unpack_arr y|] |> pack_arr

let mul x y = make_then_connect Mul [|unpack_arr x; unpack_arr y|] |> pack_arr

let div x y = make_then_connect Div [|unpack_arr x; unpack_arr y|] |> pack_arr

let add_scalar x a = make_then_connect AddScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let sub_scalar x a = make_then_connect SubScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let mul_scalar x a = make_then_connect MulScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let div_scalar x a = make_then_connect DivScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let scalar_add a x = make_then_connect ScalarAdd [|unpack_elt a; unpack_arr x|] |> pack_arr

let scalar_sub a x = make_then_connect ScalarSub [|unpack_elt a; unpack_arr x|] |> pack_arr

let scalar_mul a x = make_then_connect ScalarMul [|unpack_elt a; unpack_arr x|] |> pack_arr

let scalar_div a x = make_then_connect ScalarDiv [|unpack_elt a; unpack_arr x|] |> pack_arr

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

let elt_equal x y = make_then_connect EltEqual [|unpack_arr x; unpack_arr y|] |> pack_arr

let elt_not_equal x y = make_then_connect EltNotEqual [|unpack_arr x; unpack_arr y|] |> pack_arr

let elt_less x y = make_then_connect EltLess [|unpack_arr x; unpack_arr y|] |> pack_arr

let elt_greater x y = make_then_connect EltGreater [|unpack_arr x; unpack_arr y|] |> pack_arr

let elt_less_equal x y = make_then_connect EltLessEqual [|unpack_arr x; unpack_arr y|] |> pack_arr

let elt_greater_equal x y = make_then_connect EltGreaterEqual [|unpack_arr x; unpack_arr y|] |> pack_arr

let elt_equal_scalar x a = make_then_connect EltEqualScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let elt_not_equal_scalar x a = make_then_connect EltNotEqualScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let elt_less_scalar x a = make_then_connect EltLessScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let elt_greater_scalar x a = make_then_connect EltGreaterScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let elt_less_equal_scalar x a = make_then_connect EltLessEqualScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let elt_greater_equal_scalar x a = make_then_connect EltGreaterEqualScalar [|unpack_arr x; unpack_elt a|] |> pack_arr

let approx_equal ?eps x y =
  make_then_connect (ApproxEqual eps) [|unpack_arr x; unpack_arr y|] |> ignore;
  true

let approx_equal_scalar ?eps x a =
  make_then_connect (ApproxEqualScalar eps) [|unpack_arr x; unpack_elt a|] |> ignore;
  true

let approx_elt_equal ?eps x y =
  make_then_connect (ApproxEltEqual eps) [|unpack_arr x; unpack_arr y|] |> pack_arr

let approx_elt_equal_scalar ?eps x a =
  make_then_connect (ApproxEltEqualScalar eps) [|unpack_arr x; unpack_elt a|] |> pack_arr


let conv1d ?padding input kernel stride =
  make_then_connect (Conv1d (padding, stride)) [|unpack_arr input; unpack_arr kernel|] |> pack_arr

let conv2d ?padding input kernel stride =
  make_then_connect (Conv2d (padding, stride)) [|unpack_arr input; unpack_arr kernel|] |> pack_arr

let conv3d ?padding input kernel stride =
  make_then_connect (Conv3d (padding, stride)) [|unpack_arr input; unpack_arr kernel|] |> pack_arr

let transpose_conv2d ?padding input kernel stride =
  make_then_connect (TransposeConv2d (padding, stride)) [|unpack_arr input; unpack_arr kernel|] |> pack_arr

let max_pool1d ?padding input kernel stride =
  make_then_connect (MaxPool1d (padding, kernel, stride)) [|unpack_arr input|] |> pack_arr

let max_pool2d ?padding input kernel stride =
  make_then_connect (MaxPool2d (padding, kernel, stride)) [|unpack_arr input|] |> pack_arr

let max_pool3d ?padding input kernel stride =
  make_then_connect (MaxPool3d (padding, kernel, stride)) [|unpack_arr input|] |> pack_arr

let avg_pool1d ?padding input kernel stride =
  make_then_connect (AvgPool1d (padding, kernel, stride)) [|unpack_arr input|] |> pack_arr

let avg_pool2d ?padding input kernel stride =
  make_then_connect (AvgPool2d (padding, kernel, stride)) [|unpack_arr input|] |> pack_arr

let avg_pool3d ?padding input kernel stride =
  make_then_connect (AvgPool3d (padding, kernel, stride)) [|unpack_arr input|] |> pack_arr

let conv1d_backward_input input kernel stride output' =
  make_then_connect (Conv1dBackwardInput stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let conv1d_backward_kernel input kernel stride output' =
  make_then_connect (Conv1dBackwardKernel stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let conv2d_backward_input input kernel stride output' =
  make_then_connect (Conv2dBackwardInput stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let conv2d_backward_kernel input kernel stride output' =
  make_then_connect (Conv2dBackwardKernel stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let conv3d_backward_input input kernel stride output' =
  make_then_connect (Conv3dBackwardInput stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let conv3d_backward_kernel input kernel stride output' =
  make_then_connect (Conv3dBackwardKernel stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let transpose_conv2d_backward_input input kernel stride output' =
  make_then_connect (TransposeConv2dBackwardInput stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let transpose_conv2d_backward_kernel input kernel stride output' =
  make_then_connect (TransposeConv2dBackwardKernel stride) [|unpack_arr input; unpack_arr kernel; unpack_arr output'|] |> pack_arr

let max_pool1d_backward padding input kernel stride output' =
  make_then_connect (MaxPool1dBackward (padding, kernel, stride)) [|unpack_arr input; unpack_arr output'|] |> pack_arr

let max_pool2d_backward padding input kernel stride output' =
  make_then_connect (MaxPool2dBackward (padding, kernel, stride)) [|unpack_arr input; unpack_arr output'|] |> pack_arr

let max_pool3d_backward padding input kernel stride output' =
  make_then_connect (MaxPool3dBackward (padding, kernel, stride)) [|unpack_arr input; unpack_arr output'|] |> pack_arr

let avg_pool1d_backward padding input kernel stride output' =
  make_then_connect (AvgPool1dBackward (padding, kernel, stride)) [|unpack_arr input; unpack_arr output'|] |> pack_arr

let avg_pool2d_backward padding input kernel stride output' =
  make_then_connect (AvgPool2dBackward (padding, kernel, stride)) [|unpack_arr input; unpack_arr output'|] |> pack_arr

let avg_pool3d_backward padding input kernel stride output' =
  make_then_connect (AvgPool3dBackward (padding, kernel, stride)) [|unpack_arr input; unpack_arr output'|] |> pack_arr

let row_num x =
  let s = shape x in
  assert (Array.length s = 2);
  s.(0)

let col_num x =
  let s = shape x in
  assert (Array.length s = 2);
  s.(1)

let row x i = make_then_connect Row [|unpack_arr x|] |> pack_arr

let rows x i = make_then_connect Rows [|unpack_arr x|] |> pack_arr

let copy_row_to x y i = make_then_connect CopyRowTo [|unpack_arr x|] |> ignore

let copy_col_to x y j = make_then_connect CopyColTo [|unpack_arr x|] |> ignore

let dot x y = make_then_connect Dot [|unpack_arr x; unpack_arr y|] |> pack_arr

let inv x = make_then_connect Inv [|unpack_arr x|] |> pack_arr

let trace x = make_then_connect Trace [|unpack_arr x|] |> pack_elt

let transpose ?axis x = make_then_connect (Transpose axis) [|unpack_arr x|] |> pack_arr

let to_rows x =
  let _ = make_then_connect ToRows [|unpack_arr x|] in
  (* FIXME: wrong shape *)
  [||]

let of_rows xs = make_then_connect OfRows (Array.map unpack_arr xs) |> pack_arr

let of_array x shape = raise Owl_exception.NOT_IMPLEMENTED

let of_arrays x = raise Owl_exception.NOT_IMPLEMENTED


let float_to_elt x = const_elt ""

let elt_to_float x =  infinity


module Scalar = struct

  let add x y = make_then_connect Add [|unpack_elt x; unpack_elt y|] |> pack_elt

  let sub x y = make_then_connect Sub [|unpack_elt x; unpack_elt y|] |> pack_elt

  let mul x y = make_then_connect Mul [|unpack_elt x; unpack_elt y|] |> pack_elt

  let div x y = make_then_connect Div [|unpack_elt x; unpack_elt y|] |> pack_elt

  let pow x y = make_then_connect Pow [|unpack_elt x; unpack_elt y|] |> pack_elt

  let atan2 x y = make_then_connect Atan2 [|unpack_elt x; unpack_elt y|] |> pack_elt

  let abs x = make_then_connect Abs [|unpack_elt x|] |> pack_elt

  let neg x = make_then_connect Neg [|unpack_elt x|] |> pack_elt

  let sqr x = make_then_connect Sqr [|unpack_elt x|] |> pack_elt

  let sqrt x = make_then_connect Sqrt [|unpack_elt x|] |> pack_elt

  let exp x = make_then_connect Exp [|unpack_elt x|] |> pack_elt

  let log x = make_then_connect Log [|unpack_elt x|] |> pack_elt

  let log2 x = make_then_connect Log2 [|unpack_elt x|] |> pack_elt

  let log10 x = make_then_connect Log10 [|unpack_elt x|] |> pack_elt

  let signum x = make_then_connect Signum [|unpack_elt x|] |> pack_elt

  let floor x = make_then_connect Floor [|unpack_elt x|] |> pack_elt

  let ceil x = make_then_connect Ceil [|unpack_elt x|] |> pack_elt

  let round x = make_then_connect Round [|unpack_elt x|] |> pack_elt

  let sin x = make_then_connect Sin [|unpack_elt x|] |> pack_elt

  let cos x = make_then_connect Cos [|unpack_elt x|] |> pack_elt

  let tan x = make_then_connect Tan [|unpack_elt x|] |> pack_elt

  let sinh x = make_then_connect Sinh [|unpack_elt x|] |> pack_elt

  let cosh x = make_then_connect Cosh [|unpack_elt x|] |> pack_elt

  let tanh x = make_then_connect Tanh [|unpack_elt x|] |> pack_elt

  let asin x = make_then_connect Asin [|unpack_elt x|] |> pack_elt

  let acos x = make_then_connect Acos [|unpack_elt x|] |> pack_elt

  let atan x = make_then_connect Atan [|unpack_elt x|] |> pack_elt

  let asinh x = make_then_connect Asinh [|unpack_elt x|] |> pack_elt

  let acosh x = make_then_connect Acosh [|unpack_elt x|] |> pack_elt

  let atanh x = make_then_connect Atanh [|unpack_elt x|] |> pack_elt

  let relu x = make_then_connect Relu [|unpack_elt x|] |> pack_elt

  let sigmoid x = make_then_connect Sigmoid [|unpack_elt x|] |> pack_elt

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
