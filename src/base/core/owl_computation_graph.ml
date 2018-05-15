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

let empty shape = make_node ~shape:[|shape|] Empty

let zeros shape = make_node ~shape:[|shape|] Zeros

let ones shape = make_node ~shape:[|shape|] Ones

let create shape v = make_node ~shape:[|shape|] Create

let sequential ?a ?step shape = make_node ~shape:[|shape|] Sequential

let uniform ?a ?b shape = make_node ~shape:[|shape|] Uniform

let gaussian ?mu ?sigma shape = make_node ~shape:[|shape|] Gaussian

let bernoulli ?p shape = make_node ~shape:[|shape|] Bernoulli

let init shape f = make_node ~shape:[|shape|] Init

let shape x = raise Owl_exception.NOT_IMPLEMENTED

let numel x = raise Owl_exception.NOT_IMPLEMENTED

let get x i = make_then_connect Get [|x|]

let set x i v = make_then_connect Set [|x|]

let get_slice slice x = make_then_connect GetSlice [|x|]

let set_slice slice x y = make_then_connect SetSlice [|x; y|]

let copy x = make_then_connect Copy [|x|]

let reset slice x = raise Owl_exception.NOT_IMPLEMENTED

let reshape x shape = make_then_connect Reshape [|x|]

let reverse x = make_then_connect Reverse [|x|]

let tile x axises = make_then_connect Tile [|x|]

let repeat ?axis x repeats = make_then_connect Repeat [|x|]

let concatenate ?axis xs = make_then_connect Concatenate xs

let split ?axis parts x = make_then_connect Split [|x|]

let draw ?axis x n = make_then_connect Draw [|x|]

let map f x = make_then_connect Map [|x|]

let fold ?axis f x = make_then_connect Fold [|x|]

let scan ?axis f x = make_then_connect Scan [|x|]

let print ?max_row ?max_col ?header ?fmt x = make_then_connect Print [|x|]


let abs x = make_then_connect Abs [|x|]

let neg x = make_then_connect Neg [|x|]

let floor x = make_then_connect Floor [|x|]

let ceil x = make_then_connect Ceil [|x|]

let round x = make_then_connect Round [|x|]

let sqr x = make_then_connect Sqr [|x|]

let sqrt x = make_then_connect Sqrt [|x|]

let log x = make_then_connect Log [|x|]

let log2 x = make_then_connect Log2 [|x|]

let log10 x = make_then_connect Log10 [|x|]

let exp x = make_then_connect Exp [|x|]

let sin x = make_then_connect Sin [|x|]

let cos x = make_then_connect Cos [|x|]

let tan x = make_then_connect Tan [|x|]

let sinh x = make_then_connect Sinh [|x|]

let cosh x = make_then_connect Cosh [|x|]

let tanh x = make_then_connect Tanh [|x|]

let asin x = make_then_connect Asin [|x|]

let acos x = make_then_connect Acos [|x|]

let atan x = make_then_connect Atan [|x|]

let asinh x = make_then_connect Asinh [|x|]

let acosh x = make_then_connect Acosh [|x|]

let atanh x = make_then_connect Atanh [|x|]

let min ?axis x = make_then_connect Min [|x|]

let max ?axis x = make_then_connect Max [|x|]

let sum ?axis x = make_then_connect Sum [|x|]

let sum_reduce ?axis x = make_then_connect SumReduce [|x|]

let signum x = make_then_connect Signum [|x|]

let sigmoid x = make_then_connect Sigmoid [|x|]

let relu x = make_then_connect Relu [|x|]

let min' x = make_then_connect Min' [|x|]

let max' x = make_then_connect Max' [|x|]

let sum x = make_then_connect Sum' [|x|]

let l1norm' x = make_then_connect L1norm' [|x|]

let l2norm' x = make_then_connect L2norm' [|x|]

let l2norm_sqr' x = make_then_connect L2NormSqr' [|x|]

let clip_by_value ?amin ?amax x = make_then_connect ClipByValue [|x|]

let clip_by_l2norm x = make_then_connect ClipByL2norm [|x|]

let pow x y = make_then_connect Pow [|x; y|]

let scalar_pow a x = make_then_connect ScalarPow [|a; x|]

let pow_scalar x a = make_then_connect PowScalar [|x; a|]

let atan2 x y = make_then_connect Atan2 [|x; y|]

let scalar_atan2 a x = make_then_connect ScalarAtan2 [|a; x|]

let atan2_scalar x a = make_then_connect Atan2Scalar [|x; a|]

let add x y = make_then_connect Add [|x; y|]

let sub x y = make_then_connect Sub [|x; y|]

let mul x y = make_then_connect Mul [|x; y|]

let div x y = make_then_connect Div [|x; y|]

let add_scalar x a = make_then_connect AddScalar [|x; a|]

let sub_scalar x a = make_then_connect SubScalar [|x; a|]

let mul_scalar x a = make_then_connect MulScalar [|x; a|]

let div_scalar x a = make_then_connect DivScalar [|x; a|]

let scalar_add x a = make_then_connect ScalarAdd [|a; x|]

let scalar_sub x a = make_then_connect ScalarSub [|a; x|]

let scalar_mul x a = make_then_connect ScalarMul [|a; x|]

let scalar_div x a = make_then_connect ScalarDiv [|a; x|]

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

let elt_equal x y = make_then_connect EltEqual [|x; y|]

let elt_not_equal x y = make_then_connect EltNotEqual [|x; y|]

let elt_less x y = make_then_connect EltLess [|x; y|]

let elt_greater x y = make_then_connect EltGreater [|x; y|]

let elt_less_equal x y = make_then_connect EltLessEqual [|x; y|]

let elt_greater_equal x y = make_then_connect EltGreaterEqual [|x; y|]

let elt_equal_scalar x a = make_then_connect EltEqualScalar [|x; a|]

let elt_not_equal_scalar x a = make_then_connect EltNotEqualScalar [|x; a|]

let elt_less_scalar x a = make_then_connect EltLessScalar [|x; a|]

let elt_greater_scalar x a = make_then_connect EltGreaterScalar [|x; a|]

let elt_less_equal_scalar x a = make_then_connect EltLessEqualScalar [|x; a|]

let elt_greater_equal_scalar x a = make_then_connect EltGreaterEqualScalar [|x; a|]

let approx_equal ?eps x y = raise Owl_exception.NOT_IMPLEMENTED

let approx_equal_scalar ?eps x a = raise Owl_exception.NOT_IMPLEMENTED

let approx_elt_equal ?eps x y = make_then_connect ApproxEltEqual [|x; y|]

let approx_elt_equal_scalar ?eps x a = make_then_connect ApproxEltEqualScalar [|x; a|]


let conv1d ?padding input kernel stride = make_then_connect Conv1d [|input; kernel|]

let conv2d ?padding input kernel stride = make_then_connect Conv2d [|input; kernel|]

let conv3d ?padding input kernel stride = make_then_connect Conv3d [|input; kernel|]

let transpose_conv2d ?padding input kernel stride = make_then_connect TransposeConv2d [|input; kernel|]

let max_pool1d ?padding input kernel stride = make_then_connect MaxPool1d [|input|]

let max_pool2d ?padding input kernel stride = make_then_connect MaxPool2d [|input|]

let max_pool3d ?padding input kernel stride = make_then_connect MaxPool3d [|input|]

let avg_pool1d ?padding input kernel stride = make_then_connect AvgPool1d [|input|]

let avg_pool2d ?padding input kernel stride = make_then_connect AvgPool2d [|input|]

let avg_pool3d ?padding input kernel stride = make_then_connect AvgPool3d [|input|]

let conv1d_backward_input input kernel stride output' = make_then_connect Conv1dBackwardInput [|input; kernel; output'|]

let conv1d_backward_kernel input kernel stride output' = make_then_connect Conv1dBackwardKernel [|input; kernel; output'|]

let conv2d_backward_input input kernel stride output' = make_then_connect Conv2dBackwardInput [|input; kernel; output'|]

let conv2d_backward_kernel input kernel stride output' = make_then_connect Conv2dBackwardKernel [|input; kernel; output'|]

let conv3d_backward_input input kernel stride output' = make_then_connect Conv3dBackwardInput [|input; kernel; output'|]

let conv3d_backward_kernel input kernel stride output' = make_then_connect Conv3dBackwardKernel [|input; kernel; output'|]

let transpose_conv2d_backward_input input kernel stride output' = make_then_connect TransposeConv2dBackwardInput [|input; kernel; output'|]

let transpose_conv2d_backward_kernel input kernel stride output' = make_then_connect TransposeConv2dBackwardKernel [|input; kernel; output'|]

let max_pool1d_backward padding input kernel stride output' = make_then_connect MaxPool1dBackward [|input; output'|]

let max_pool2d_backward padding input kernel stride output' = make_then_connect MaxPool2dBackward [|input; output'|]

let max_pool3d_backward padding input kernel stride output' = make_then_connect MaxPool3dBackward [|input; output'|]

let avg_pool1d_backward padding input kernel stride output' = make_then_connect AvgPool1dBackward [|input; output'|]

let avg_pool2d_backward padding input kernel stride output' = make_then_connect AvgPool2dBackward [|input; output'|]

let avg_pool3d_backward padding input kernel stride output' = make_then_connect AvgPool3dBackward [|input; output'|]

let row_num x = raise Owl_exception.NOT_IMPLEMENTED

let col_num x = raise Owl_exception.NOT_IMPLEMENTED

let row x i = make_then_connect Row [|x|]

let rows x i = make_then_connect Rows [|x|]

let copy_row_to x y i = make_then_connect CopyRowTo [|x|]

let copy_col_to x y j = make_then_connect CopyColTo [|x|]

let dot x y = make_then_connect Dot [|x; y|]

let inv x = make_then_connect Inv [|x|]

let trace x = make_then_connect Trace [|x|]

let transpose ?axis x = make_then_connect Transpose [|x|]

let to_rows x = make_then_connect ToRows [|x|]

let of_rows xs = make_then_connect OfRows xs

let of_array x shape = raise Owl_exception.NOT_IMPLEMENTED

let of_arrays x shape = raise Owl_exception.NOT_IMPLEMENTED
