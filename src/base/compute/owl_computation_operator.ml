(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

(* Functor of making Lazy module of different number types *)

module Make
  (Symbol : Owl_computation_symbol_sig.Sig)
  = struct

  module Symbol = Symbol

  open Symbol

  open Symbol.Shape.Type

  open Symbol.Shape.Type.Device


  (* mathematical functions *)

  let noop x =
    make_then_connect Noop [|arr_to_node x|] |> node_to_arr

  let empty shape =
    make_node ~shape:[|Some shape|] (Empty shape) |> node_to_arr

  let zeros shape =
    make_node ~shape:[|Some shape|] (Zeros shape) |> node_to_arr

  let ones shape =
    make_node ~shape:[|Some shape|] (Ones shape) |> node_to_arr

  let create shape v =
    make_then_connect ~shape:[|Some shape|] (Create shape) [|elt_to_node v|] |> node_to_arr

  let sequential ?a ?step shape =
    let a = match a with
      | Some a -> a
      | None   -> const_elt "sequential_a" (A.float_to_elt 0.)
    in
    let b = match step with
      | Some b -> b
      | None   -> const_elt "sequential_step" (A.float_to_elt 1.)
    in
    make_then_connect ~shape:[|Some shape|] (Sequential shape) [|elt_to_node a; elt_to_node b|]
    |> node_to_arr

  let uniform ?a ?b shape =
    let a = match a with
      | Some a -> a
      | None   -> const_elt "uniform_a" (A.float_to_elt 0.)
    in
    let b = match b with
      | Some b -> b
      | None   -> const_elt "uniform_b" (A.float_to_elt 1.)
    in
    make_then_connect ~shape:[|Some shape|] (Uniform shape) [|elt_to_node a; elt_to_node b|]
    |> node_to_arr

  let gaussian ?mu ?sigma shape =
    let a = match mu with
      | Some a -> a
      | None   -> const_elt "sequential_a" (A.float_to_elt 0.)
    in
    let b = match sigma with
      | Some b -> b
      | None   -> const_elt "sequential_step" (A.float_to_elt 1.)
    in
    make_then_connect ~shape:[|Some shape|] (Gaussian shape) [|elt_to_node a; elt_to_node b|]
    |> node_to_arr

  let bernoulli ?p shape =
    let p = match p with
      | Some p -> p
      | None   -> const_elt "bernoulli_p" (A.float_to_elt 0.5)
    in
    make_then_connect ~shape:[|Some shape|] (Bernoulli shape) [|elt_to_node p|]
    |> node_to_arr

  let init shape f =
    make_node ~shape:[|Some shape|] (Init (shape, f)) |> node_to_arr

  let shape x = arr_to_node x |> node_shape

  let numel x = Array.fold_left ( * ) 1 (shape x)

  let get x i =
    make_then_connect (Get i) [|arr_to_node x|] |> node_to_elt

  let set x i v =
    make_then_connect (Set i) [|arr_to_node x; elt_to_node v|] |> ignore

  let get_slice slice x =
    make_then_connect (GetSlice slice) [|arr_to_node x|] |> node_to_arr

  let set_slice slice x y =
    make_then_connect (SetSlice slice) [|arr_to_node x; arr_to_node y|] |> ignore

  let copy x =
    make_then_connect Copy [|arr_to_node x|] |> node_to_arr

  let copy_ ~out _x = failwith "Owl_computation_operator:copy_: not implemented" [@@warning "-27"]

  let reset x =
    make_then_connect Reset [|arr_to_node x|] |> node_to_arr |> ignore

  let reshape x shape =
    let n_old = numel x in
    let n_new = Array.fold_left ( * ) 1 shape in
    assert (n_old = n_new);
    make_then_connect (Reshape shape) [|arr_to_node x|] |> node_to_arr

  let reverse x =
    make_then_connect Reverse [|arr_to_node x|] |> node_to_arr

  let tile x axises =
    make_then_connect (Tile axises) [|arr_to_node x|] |> node_to_arr

  let repeat x repeats =
    make_then_connect (Repeat repeats) [|arr_to_node x|] |> node_to_arr

  let pad ?v padding x =
    let v = match v with
      | Some v -> v
      | None   -> const_elt "pad_v" (A.float_to_elt 0.)
    in
    make_then_connect (Pad (v, padding)) [|arr_to_node x|] |> node_to_arr

  let concatenate ?(axis=0) xs =
    make_then_connect (Concatenate axis) (Array.map arr_to_node xs) |> node_to_arr

  let split ?(axis=0) _parts _x = failwith "split: not implemented"  [@@warning "-27"]

  let draw ?(axis=0) x n =
    let y = make_then_connect (Draw (axis, n)) [|arr_to_node x|] |> node_to_arr in
    y, [||]

  let map f x =
    make_then_connect (Map f) [|arr_to_node x|] |> node_to_arr

  let fold ?(axis=(-1)) f a x =
    make_then_connect (Fold (axis, f)) [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let scan ?(axis=(-1)) f x =
    make_then_connect (Scan (axis, f)) [|arr_to_node x|] |> node_to_arr

  let one_hot depth x =
    make_then_connect (OneHot depth) [|arr_to_node x|] |> node_to_arr

  let delay f x =
    make_then_connect (Delay f) [|arr_to_node x|] |> node_to_arr

  let delay_array shape f x =
    make_then_connect ~shape:[|Some shape|] (DelayArray (shape, f))
      (Array.map arr_to_node x) |> node_to_arr

  let lazy_print ?max_row ?max_col ?header ?fmt x =
    make_then_connect (LazyPrint (max_row, max_col, header, fmt)) [|arr_to_node x|] |> node_to_arr

  let print ?max_row ?max_col ?header ?fmt x = ()  [@@warning "-27"]


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
    let a = match amin with
      | Some a -> a
      | None   -> const_elt "clip_by_value_amin" (A.float_to_elt neg_infinity)
    in
    let b = match amax with
      | Some b -> b
      | None   -> const_elt "clip_by_value_amax" (A.float_to_elt infinity)
    in
    make_then_connect ClipByValue [|arr_to_node x; elt_to_node a; elt_to_node b|] |> node_to_arr

  let clip_by_l2norm a x =
    make_then_connect ClipByL2norm [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let pow x y = make_then_connect Pow [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let scalar_pow a x = make_then_connect ScalarPow [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let pow_scalar x a = make_then_connect PowScalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let atan2 x y = make_then_connect Atan2 [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let scalar_atan2 a x = make_then_connect ScalarAtan2 [|elt_to_node a; arr_to_node x|] |> node_to_arr

  let atan2_scalar x a = make_then_connect Atan2Scalar [|arr_to_node x; elt_to_node a|] |> node_to_arr

  let hypot x y = make_then_connect Hypot [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let min2 x y = make_then_connect Min2 [|arr_to_node x; arr_to_node y|] |> node_to_arr

  let max2 x y = make_then_connect Max2 [|arr_to_node x; arr_to_node y|] |> node_to_arr

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

  let fma x y z = make_then_connect FMA [|arr_to_node x; arr_to_node y; arr_to_node z|] |> node_to_arr

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

  let conv1d ?(padding=SAME) input kernel stride =
    make_then_connect (Conv1d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let conv2d ?(padding=SAME) input kernel stride =
    make_then_connect (Conv2d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let conv3d ?(padding=SAME) input kernel stride =
    make_then_connect (Conv3d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let transpose_conv1d ?(padding=SAME) input kernel stride =
    make_then_connect (TransposeConv1d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let transpose_conv2d ?(padding=SAME) input kernel stride =
    make_then_connect (TransposeConv2d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let transpose_conv3d ?(padding=SAME) input kernel stride =
    make_then_connect (TransposeConv3d (padding, stride)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let dilated_conv1d ?(padding=SAME) input kernel stride rate =
    make_then_connect (DilatedConv1d (padding, stride, rate)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let dilated_conv2d ?(padding=SAME) input kernel stride rate =
    make_then_connect (DilatedConv2d (padding, stride, rate)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let dilated_conv3d ?(padding=SAME) input kernel stride rate =
    make_then_connect (DilatedConv3d (padding, stride, rate)) [|arr_to_node input; arr_to_node kernel|] |> node_to_arr

  let max_pool1d ?(padding=SAME) input kernel stride =
    make_then_connect (MaxPool1d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let max_pool2d ?(padding=SAME) input kernel stride =
    make_then_connect (MaxPool2d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let max_pool3d ?(padding=SAME) input kernel stride =
    make_then_connect (MaxPool3d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let avg_pool1d ?(padding=SAME) input kernel stride =
    make_then_connect (AvgPool1d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let avg_pool2d ?(padding=SAME) input kernel stride =
    make_then_connect (AvgPool2d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let avg_pool3d ?(padding=SAME) input kernel stride =
    make_then_connect (AvgPool3d (padding, kernel, stride)) [|arr_to_node input|] |> node_to_arr

  let upsampling2d input size =
    make_then_connect (UpSampling2d size) [|arr_to_node input|] |> node_to_arr

  let conv1d_backward_input input kernel stride output' =
    make_then_connect (Conv1dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv1d_backward_kernel input kernel stride output' =
    make_then_connect (Conv1dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv2d_backward_input input kernel stride output' =
    make_then_connect (Conv2dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv2d_backward_kernel input kernel stride output' =
    make_then_connect (Conv2dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv3d_backward_input input kernel stride output' =
    make_then_connect (Conv3dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let conv3d_backward_kernel input kernel stride output' =
    make_then_connect (Conv3dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv1d_backward_input input kernel stride output' =
    make_then_connect (TransposeConv1dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv1d_backward_kernel input kernel stride output' =
    make_then_connect (TransposeConv1dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv2d_backward_input input kernel stride output' =
    make_then_connect (TransposeConv2dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv2d_backward_kernel input kernel stride output' =
    make_then_connect (TransposeConv2dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv3d_backward_input input kernel stride output' =
    make_then_connect (TransposeConv3dBackwardInput stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let transpose_conv3d_backward_kernel input kernel stride output' =
    make_then_connect (TransposeConv3dBackwardKernel stride) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let dilated_conv1d_backward_input input kernel stride rate output' =
    make_then_connect (DilatedConv1dBackwardInput (stride, rate)) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let dilated_conv1d_backward_kernel input kernel stride rate output' =
    make_then_connect (DilatedConv1dBackwardKernel (stride, rate)) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let dilated_conv2d_backward_input input kernel stride rate output' =
    make_then_connect (DilatedConv2dBackwardInput (stride, rate)) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let dilated_conv2d_backward_kernel input kernel stride rate output' =
    make_then_connect (DilatedConv2dBackwardKernel (stride, rate)) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let dilated_conv3d_backward_input input kernel stride rate output' =
    make_then_connect (DilatedConv3dBackwardInput (stride, rate)) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let dilated_conv3d_backward_kernel input kernel stride rate output' =
    make_then_connect (DilatedConv3dBackwardKernel (stride, rate)) [|arr_to_node input; arr_to_node kernel; arr_to_node output'|] |> node_to_arr

  let max_pool1d_backward padding input kernel stride output' =
    make_then_connect (MaxPool1dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let max_pool2d_backward padding input kernel stride output' =
    make_then_connect (MaxPool2dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let max_pool3d_backward padding input kernel stride output' =
    make_then_connect (MaxPool3dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let avg_pool1d_backward padding input kernel stride output' =
    make_then_connect (AvgPool1dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let avg_pool2d_backward padding input kernel stride output' =
    make_then_connect (AvgPool2dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let avg_pool3d_backward padding input kernel stride output' =
    make_then_connect (AvgPool3dBackward (padding, kernel, stride)) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let upsampling2d_backward input size output' =
    make_then_connect (UpSampling2dBackward size) [|arr_to_node input; arr_to_node output'|] |> node_to_arr

  let row_num x =
    let s = shape x in
    assert (Array.length s = 2);
    s.(0)

  let col_num x =
    let s = shape x in
    assert (Array.length s = 2);
    s.(1)

  let row x _i = make_then_connect Row [|arr_to_node x|] |> node_to_arr

  let rows x i = make_then_connect (Rows i) [|arr_to_node x|] |> node_to_arr

  let copy_row_to x _y _i = make_then_connect CopyRowTo [|arr_to_node x|] |> ignore

  let copy_col_to x _y _j = make_then_connect CopyColTo [|arr_to_node x|] |> ignore

  let inv x = make_then_connect Inv [|arr_to_node x|] |> node_to_arr

  let chol ?(upper=true) _x = upper |> ignore; raise Owl_exception.NOT_IMPLEMENTED

  let qr _x = raise Owl_exception.NOT_IMPLEMENTED 
  
  let lyapunov _a _q = raise Owl_exception.NOT_IMPLEMENTED 
  
  let diag ?k _x = k |> ignore; raise Owl_exception.NOT_IMPLEMENTED 

  let tril?k _x = k |> ignore; raise Owl_exception.NOT_IMPLEMENTED 

  let triu?k _x = k |> ignore; raise Owl_exception.NOT_IMPLEMENTED 

  let trace x = make_then_connect Trace [|arr_to_node x|] |> node_to_elt

  let dot x y =
    let transa = false in
    let transb = false in
    let alpha = A.float_to_elt 1. |> pack_elt in
    let beta = A.float_to_elt 0. |> pack_elt in
    let op = Dot (transa, transb, alpha, beta) in
    make_then_connect op [|arr_to_node x; arr_to_node y|] |> node_to_arr

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

  let of_array _x _shape = raise Owl_exception.NOT_IMPLEMENTED

  let of_arrays _x = raise Owl_exception.NOT_IMPLEMENTED


  (** Scalar maths *)

  module Scalar = struct

    let add x y = make_then_connect Scalar_Add [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let sub x y = make_then_connect Scalar_Sub [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let mul x y = make_then_connect Scalar_Mul [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let div x y = make_then_connect Scalar_Div [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let pow x y = make_then_connect Scalar_Pow [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let atan2 x y = make_then_connect Scalar_Atan2 [|elt_to_node x; elt_to_node y|] |> node_to_elt

    let abs x = make_then_connect Scalar_Abs [|elt_to_node x|] |> node_to_elt

    let neg x = make_then_connect Scalar_Neg [|elt_to_node x|] |> node_to_elt

    let sqr x = make_then_connect Scalar_Sqr [|elt_to_node x|] |> node_to_elt

    let sqrt x = make_then_connect Scalar_Sqrt [|elt_to_node x|] |> node_to_elt

    let exp x = make_then_connect Scalar_Exp [|elt_to_node x|] |> node_to_elt

    let log x = make_then_connect Scalar_Log [|elt_to_node x|] |> node_to_elt

    let log2 x = make_then_connect Scalar_Log2 [|elt_to_node x|] |> node_to_elt

    let log10 x = make_then_connect Scalar_Log10 [|elt_to_node x|] |> node_to_elt

    let signum x = make_then_connect Scalar_Signum [|elt_to_node x|] |> node_to_elt

    let floor x = make_then_connect Scalar_Floor [|elt_to_node x|] |> node_to_elt

    let ceil x = make_then_connect Scalar_Ceil [|elt_to_node x|] |> node_to_elt

    let round x = make_then_connect Scalar_Round [|elt_to_node x|] |> node_to_elt

    let sin x = make_then_connect Scalar_Sin [|elt_to_node x|] |> node_to_elt

    let cos x = make_then_connect Scalar_Cos [|elt_to_node x|] |> node_to_elt

    let tan x = make_then_connect Scalar_Tan [|elt_to_node x|] |> node_to_elt

    let sinh x = make_then_connect Scalar_Sinh [|elt_to_node x|] |> node_to_elt

    let cosh x = make_then_connect Scalar_Cosh [|elt_to_node x|] |> node_to_elt

    let tanh x = make_then_connect Scalar_Tanh [|elt_to_node x|] |> node_to_elt

    let asin x = make_then_connect Scalar_Asin [|elt_to_node x|] |> node_to_elt

    let acos x = make_then_connect Scalar_Acos [|elt_to_node x|] |> node_to_elt

    let atan x = make_then_connect Scalar_Atan [|elt_to_node x|] |> node_to_elt

    let asinh x = make_then_connect Scalar_Asinh [|elt_to_node x|] |> node_to_elt

    let acosh x = make_then_connect Scalar_Acosh [|elt_to_node x|] |> node_to_elt

    let atanh x = make_then_connect Scalar_Atanh [|elt_to_node x|] |> node_to_elt

    let relu x = make_then_connect Scalar_Relu [|elt_to_node x|] |> node_to_elt

    let sigmoid x = make_then_connect Scalar_Sigmoid [|elt_to_node x|] |> node_to_elt

  end


end

(* Make functor ends *)
