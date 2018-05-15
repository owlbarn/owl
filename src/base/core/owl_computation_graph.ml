(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_graph


type value =
  | F   of float
  | F32 of (float, float32_elt, c_layout) Genarray.t
  | F64 of (float, float64_elt, c_layout) Genarray.t


type t = attr node

and attr = {
  op    : op;
  shape : (int array option) array;
  value : value array;
}

and arr = Arr of t

and elt = Elt of t

and op =
  | Var
  | Const
  | Empty
  | Zeros
  | Ones
  | Create
  | Sequential
  | Uniform
  | Gaussian
  | Bernoulli
  | Init
  | Shape
  | Numel
  | Get
  | Set
  | GetSlice
  | SetSlice
  | Copy
  | Reset
  | Reshape
  | Reverse
  | Tile
  | Repeat
  | Concatenate
  | Split
  | Draw
  | Map
  | Fold
  | Scan
  | Print
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
  | Min
  | Max
  | Sum
  | SumReduce
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
  | ApproxEqual
  | ApproxEqualScalar
  | ApproxEltEqual
  | ApproxEltEqualScalar
  | Conv1d
  | Conv2d
  | Conv3d
  | TransposeConv2d
  | MaxPool1d
  | MaxPool2d
  | MaxPool3d
  | AvgPool1d
  | AvgPool2d
  | AvgPool3d
  | Conv1dBackwardInput
  | Conv1dBackwardKernel
  | Conv2dBackwardInput
  | Conv2dBackwardKernel
  | Conv3dBackwardInput
  | Conv3dBackwardKernel
  | TransposeConv2dBackwardInput
  | TransposeConv2dBackwardKernel
  | MaxPool1dBackward
  | MaxPool2dBackward
  | MaxPool3dBackward
  | AvgPool1dBackward
  | AvgPool2dBackward
  | AvgPool3dBackward
  | RowNum
  | ColNum
  | Row
  | Rows
  | CopyRowTo
  | CopyColTo
  | Dot
  | Inv
  | Trace
  | Transpose
  | ToRows
  | OfRows
  | OfArray
  | OfArrays


let pack_arr x = Arr x

let unpack_arr = function Arr x -> x

let pack_elt x = Elt x

let unpack_elt = function Elt x -> x


let _shape = function
  | F _   -> [||]
  | F32 x -> Genarray.dims x
  | F64 x -> Genarray.dims x


let _infer_shape_1 input_shapes =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Array.(copy s) |]
  | None   -> [| None |]


(* FIXME *)
let _infer_shape_2 input_shapes =
  let s0 = input_shapes.(0).(0) in
  let s1 = input_shapes.(1).(0) in
  match s0, s1 with
  | Some s0, Some s1 -> [| Some s0 |]
  | _, _             -> [| None |]


let infer_shape operator args =
  let input_shapes = Array.map (fun a -> (attr a).shape) args in
  match operator with
  | Var   -> _infer_shape_1 input_shapes
  | Const -> _infer_shape_1 input_shapes
  | Sin   -> _infer_shape_1 input_shapes
  | Cos   -> _infer_shape_1 input_shapes
  | Add   -> _infer_shape_2 input_shapes
  | Sub   -> _infer_shape_2 input_shapes
  | Mul   -> _infer_shape_2 input_shapes
  | Div   -> _infer_shape_2 input_shapes
  | _     -> _infer_shape_2 input_shapes


let make_node ?value ?shape op =
  let value = match value with Some v -> v | None -> [||] in
  let shape =
    if Array.length value > 0 then
      Array.map (fun v -> Some (_shape v)) value
    else
      match shape with Some s -> s | None -> [||]
  in
  Owl_graph.node { op; shape; value }


let refnum x = Owl_graph.outdegree x


let make_then_connect op x =
  let shape = infer_shape op x in
  let y = make_node ~shape op in
  connect x [|y|];
  y


let variable shape = make_node ~shape:[|shape|] Var

let empty shape = make_node ~shape:[|Some shape|] Empty |> pack_arr

let zeros shape = make_node ~shape:[|Some shape|] Zeros |> pack_arr

let ones shape = make_node ~shape:[|Some shape|] Ones |> pack_arr

let create shape v = make_node ~shape:[|Some shape|] Create |> pack_arr

let sequential ?a ?step shape = make_node ~shape:[|Some shape|] Sequential |> pack_arr

let uniform ?a ?b shape = make_node ~shape:[|Some shape|] Uniform |> pack_arr

let gaussian ?mu ?sigma shape = make_node ~shape:[|Some shape|] Gaussian |> pack_arr

let bernoulli ?p shape = make_node ~shape:[|Some shape|] Bernoulli |> pack_arr

let init shape f = make_node ~shape:[|Some shape|] Init |> pack_arr

let shape x = raise Owl_exception.NOT_IMPLEMENTED

let numel x = raise Owl_exception.NOT_IMPLEMENTED

let get x i = make_then_connect Get [|unpack_arr x|] |> pack_elt

let set x i v = make_then_connect Set [|unpack_arr x|] |> ignore

let get_slice slice x = make_then_connect GetSlice [|unpack_arr x|] |> pack_arr

let set_slice slice x y = make_then_connect SetSlice [|unpack_arr x; unpack_arr y|]

let copy x = make_then_connect Copy [|unpack_arr x|] |> pack_arr

let reset slice x = raise Owl_exception.NOT_IMPLEMENTED

let reshape x shape = make_then_connect Reshape [|unpack_arr x|] |> pack_arr

let reverse x = make_then_connect Reverse [|unpack_arr x|] |> pack_arr

let tile x axises = make_then_connect Tile [|unpack_arr x|] |> pack_arr

let repeat ?axis x repeats = make_then_connect Repeat [|unpack_arr x|] |> pack_arr

let concatenate ?axis xs = make_then_connect Concatenate xs |> pack_arr

let split ?axis parts x = make_then_connect Split [|unpack_arr x|]

let draw ?axis x n = make_then_connect Draw [|unpack_arr x|]

let map f x = make_then_connect Map [|unpack_arr x|] |> pack_arr

let fold ?axis f x = make_then_connect Fold [|unpack_arr x|] |> pack_arr

let scan ?axis f x = make_then_connect Scan [|unpack_arr x|] |> pack_arr

let print ?max_row ?max_col ?header ?fmt x = make_then_connect Print [|unpack_arr x|]


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

let min ?axis x = make_then_connect Min [|unpack_arr x|] |> pack_arr

let max ?axis x = make_then_connect Max [|unpack_arr x|] |> pack_arr

let sum ?axis x = make_then_connect Sum [|unpack_arr x|] |> pack_arr

let sum_reduce ?axis x = make_then_connect SumReduce [|unpack_arr x|] |> pack_arr

let signum x = make_then_connect Signum [|unpack_arr x|] |> pack_arr

let sigmoid x = make_then_connect Sigmoid [|unpack_arr x|] |> pack_arr

let relu x = make_then_connect Relu [|unpack_arr x|] |> pack_arr

let min' x = make_then_connect Min' [|unpack_arr x|] |> pack_elt

let max' x = make_then_connect Max' [|unpack_arr x|] |> pack_elt

let sum' x = make_then_connect Sum' [|unpack_arr x|] |> pack_elt

let l1norm' x = make_then_connect L1norm' [|unpack_arr x|] |> pack_elt

let l2norm' x = make_then_connect L2norm' [|unpack_arr x|] |> pack_elt

let l2norm_sqr' x = make_then_connect L2NormSqr' [|unpack_arr x|] |> pack_elt

let clip_by_value ?amin ?amax x = make_then_connect ClipByValue [|unpack_arr x|] |> pack_arr

let clip_by_l2norm x = make_then_connect ClipByL2norm [|unpack_arr x|] |> pack_arr

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

let scalar_add x a = make_then_connect ScalarAdd [|unpack_elt a; unpack_arr x|] |> pack_arr

let scalar_sub x a = make_then_connect ScalarSub [|unpack_elt a; unpack_arr x|] |> pack_arr

let scalar_mul x a = make_then_connect ScalarMul [|unpack_elt a; unpack_arr x|] |> pack_arr

let scalar_div x a = make_then_connect ScalarDiv [|unpack_elt a; unpack_arr x|] |> pack_arr

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

let approx_equal ?eps x y = raise Owl_exception.NOT_IMPLEMENTED

let approx_equal_scalar ?eps x a = raise Owl_exception.NOT_IMPLEMENTED

let approx_elt_equal ?eps x y = make_then_connect ApproxEltEqual [|unpack_arr x; unpack_arr y|] |> pack_arr

let approx_elt_equal_scalar ?eps x a = make_then_connect ApproxEltEqualScalar [|unpack_arr x; unpack_elt a|] |> pack_arr


let conv1d ?padding input kernel stride = make_then_connect Conv1d [|input; kernel|] |> pack_arr

let conv2d ?padding input kernel stride = make_then_connect Conv2d [|input; kernel|] |> pack_arr

let conv3d ?padding input kernel stride = make_then_connect Conv3d [|input; kernel|] |> pack_arr

let transpose_conv2d ?padding input kernel stride = make_then_connect TransposeConv2d [|input; kernel|] |> pack_arr

let max_pool1d ?padding input kernel stride = make_then_connect MaxPool1d [|input|] |> pack_arr

let max_pool2d ?padding input kernel stride = make_then_connect MaxPool2d [|input|] |> pack_arr

let max_pool3d ?padding input kernel stride = make_then_connect MaxPool3d [|input|] |> pack_arr

let avg_pool1d ?padding input kernel stride = make_then_connect AvgPool1d [|input|] |> pack_arr

let avg_pool2d ?padding input kernel stride = make_then_connect AvgPool2d [|input|] |> pack_arr

let avg_pool3d ?padding input kernel stride = make_then_connect AvgPool3d [|input|] |> pack_arr

let conv1d_backward_input input kernel stride output' = make_then_connect Conv1dBackwardInput [|input; kernel; output'|] |> pack_arr

let conv1d_backward_kernel input kernel stride output' = make_then_connect Conv1dBackwardKernel [|input; kernel; output'|] |> pack_arr

let conv2d_backward_input input kernel stride output' = make_then_connect Conv2dBackwardInput [|input; kernel; output'|] |> pack_arr

let conv2d_backward_kernel input kernel stride output' = make_then_connect Conv2dBackwardKernel [|input; kernel; output'|] |> pack_arr

let conv3d_backward_input input kernel stride output' = make_then_connect Conv3dBackwardInput [|input; kernel; output'|] |> pack_arr

let conv3d_backward_kernel input kernel stride output' = make_then_connect Conv3dBackwardKernel [|input; kernel; output'|] |> pack_arr

let transpose_conv2d_backward_input input kernel stride output' = make_then_connect TransposeConv2dBackwardInput [|input; kernel; output'|] |> pack_arr

let transpose_conv2d_backward_kernel input kernel stride output' = make_then_connect TransposeConv2dBackwardKernel [|input; kernel; output'|] |> pack_arr

let max_pool1d_backward padding input kernel stride output' = make_then_connect MaxPool1dBackward [|input; output'|] |> pack_arr

let max_pool2d_backward padding input kernel stride output' = make_then_connect MaxPool2dBackward [|input; output'|] |> pack_arr

let max_pool3d_backward padding input kernel stride output' = make_then_connect MaxPool3dBackward [|input; output'|] |> pack_arr

let avg_pool1d_backward padding input kernel stride output' = make_then_connect AvgPool1dBackward [|input; output'|] |> pack_arr

let avg_pool2d_backward padding input kernel stride output' = make_then_connect AvgPool2dBackward [|input; output'|] |> pack_arr

let avg_pool3d_backward padding input kernel stride output' = make_then_connect AvgPool3dBackward [|input; output'|] |> pack_arr

let row_num x = raise Owl_exception.NOT_IMPLEMENTED

let col_num x = raise Owl_exception.NOT_IMPLEMENTED

let row x i = make_then_connect Row [|unpack_arr x|]

let rows x i = make_then_connect Rows [|unpack_arr x|]

let copy_row_to x y i = make_then_connect CopyRowTo [|unpack_arr x|]

let copy_col_to x y j = make_then_connect CopyColTo [|unpack_arr x|]

let dot x y = make_then_connect Dot [|unpack_arr x; unpack_arr y|] |> pack_arr

let inv x = make_then_connect Inv [|unpack_arr x|] |> pack_arr

let trace x = make_then_connect Trace [|unpack_arr x|] |> pack_arr

let transpose ?axis x = make_then_connect Transpose [|unpack_arr x|] |> pack_arr

let to_rows x = make_then_connect ToRows [|unpack_arr x|]

let of_rows xs = make_then_connect OfRows xs

let of_array x shape = raise Owl_exception.NOT_IMPLEMENTED

let of_arrays x shape = raise Owl_exception.NOT_IMPLEMENTED



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
