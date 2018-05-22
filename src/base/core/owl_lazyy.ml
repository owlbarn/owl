(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making a Lazy engine to execute a computation graph. *)

module Make (A : Ndarray_Mutable) = struct

  include Owl_computation_graph.Make (A)


  (* allocate memory and evaluate experssions *)

  let allocate_1 x =
    let x_val = value_to_arr (attr x).value.(0) in
    if refnum x = 1 && is_mutable x then (
      invalidate x;
      x_val
    )
    else A.copy x_val


  let allocate_2 x y =
    let x_val = value_to_arr (attr x).value.(0) in
    let y_val = value_to_arr (attr y).value.(0) in
    let x_shp = A.shape x_val in
    let y_shp = A.shape y_val in
    let x_shp, y_shp = Owl_utils_array.align `Left 1 x_shp y_shp in

    if x_shp = y_shp then (
      if refnum x = 1 && is_mutable x then (
        invalidate x;
        Some (x_val, y_val)
      )
      else if refnum y = 1 && is_mutable y then (
        invalidate y;
        Some (y_val, x_val)
      )
      else if refnum x = 2 && x == y && is_mutable x then (
        invalidate x;
        Some (x_val, y_val)
      )
      else Some (A.copy x_val, y_val)
    )
    else if Owl_utils.Array.greater_eqaul x_shp y_shp && refnum x = 1 && is_mutable x then (
      invalidate x;
      Some (x_val, y_val)
    )
    else if Owl_utils.Array.greater_eqaul y_shp x_shp && refnum y = 1 && is_mutable y then (
      invalidate y;
      Some (y_val, x_val)
    )
    else None


  let rec _eval_term x =
    Owl_log.debug "eval %s ..." (node_to_str x);
    if is_valid x = false then (
     (
        match (get_operator x) with
        | Noop                                        -> ()
        | Var                                         -> is_assigned x
        | Const                                       -> is_assigned x
        | Empty shape                                 -> _eval_map_08 x (fun x -> A.empty shape)
        | Zeros shape                                 -> _eval_map_08 x (fun x -> A.zeros shape)
        | Ones shape                                  -> _eval_map_08 x (fun x -> A.ones shape)
        | Create                                      -> failwith "Create"
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> _eval_map_08 x (fun x -> A.uniform ~a:x.(0) ~b:x.(1) shape)
        | Gaussian                                    -> failwith "Gaussian"
        | Bernoulli (p, shape)                        -> _eval_map_08 x (fun x -> A.bernoulli ~p shape)
        | Init _                                      -> failwith "Init"
        | Get i                                       -> failwith "Get"
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
        | Min axis                                    -> _eval_map_00 x A.(min ~axis)
        | Max axis                                    -> _eval_map_00 x A.(max ~axis)
        | Sum axis                                    -> _eval_map_00 x A.(sum ~axis)
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
        | Pow                                         -> _eval_map_02 x A.pow_ A.pow
        | ScalarPow                                   -> _eval_map_04 x A.scalar_pow_
        | PowScalar                                   -> _eval_map_03 x A.pow_scalar_
        | Atan2                                       -> _eval_map_02 x A.atan2_ A.atan2
        | ScalarAtan2                                 -> _eval_map_04 x A.scalar_atan2_
        | Atan2Scalar                                 -> _eval_map_03 x A.atan2_scalar_
        | Add                                         -> _eval_map_02 x A.add_ A.add
        | Sub                                         -> _eval_map_02 x A.sub_ A.sub
        | Mul                                         -> _eval_map_02 x A.mul_ A.mul
        | Div                                         -> _eval_map_02 x A.div_ A.div
        | AddScalar                                   -> _eval_map_03 x A.add_scalar_
        | SubScalar                                   -> _eval_map_03 x A.sub_scalar_
        | MulScalar                                   -> _eval_map_03 x A.mul_scalar_
        | DivScalar                                   -> _eval_map_03 x A.div_scalar_
        | ScalarAdd                                   -> _eval_map_04 x A.scalar_add_
        | ScalarSub                                   -> _eval_map_04 x A.scalar_sub_
        | ScalarMul                                   -> _eval_map_04 x A.scalar_mul_
        | ScalarDiv                                   -> _eval_map_04 x A.scalar_div_
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
        | EltEqual                                    -> _eval_map_02 x A.elt_equal_ A.elt_equal
        | EltNotEqual                                 -> _eval_map_02 x A.elt_not_equal_ A.elt_not_equal
        | EltLess                                     -> _eval_map_02 x A.elt_less_ A.elt_less
        | EltGreater                                  -> _eval_map_02 x A.elt_greater_ A.elt_greater
        | EltLessEqual                                -> _eval_map_02 x A.elt_less_equal_ A.elt_less_equal
        | EltGreaterEqual                             -> _eval_map_02 x A.elt_greater_equal_ A.elt_greater_equal
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
        | Conv1d (padding, stride)                    -> _eval_map_05 x (fun x -> A.conv1d ~padding x.(0) x.(1) stride)
        | Conv2d (padding, stride)                    -> _eval_map_05 x (fun x -> A.conv2d ~padding x.(0) x.(1) stride)
        | Conv3d (padding, stride)                    -> _eval_map_05 x (fun x -> A.conv3d ~padding x.(0) x.(1) stride)
        | TransposeConv2d (padding, stride)           -> _eval_map_05 x (fun x -> A.transpose_conv2d ~padding x.(0) x.(1) stride)
        | MaxPool1d (padding, kernel, stride)         -> _eval_map_00 x (fun x -> A.max_pool1d ~padding x kernel stride)
        | MaxPool2d (padding, kernel, stride)         -> _eval_map_00 x (fun x -> A.max_pool2d ~padding x kernel stride)
        | MaxPool3d (padding, kernel, stride)         -> _eval_map_00 x (fun x -> A.max_pool3d ~padding x kernel stride)
        | AvgPool1d (padding, kernel, stride)         -> _eval_map_00 x (fun x -> A.avg_pool1d ~padding x kernel stride)
        | AvgPool2d (padding, kernel, stride)         -> _eval_map_00 x (fun x -> A.avg_pool2d ~padding x kernel stride)
        | AvgPool3d (padding, kernel, stride)         -> _eval_map_00 x (fun x -> A.avg_pool3d ~padding x kernel stride)
        | Conv1dBackwardInput stride                  -> _eval_map_05 x (fun x -> A.conv1d_backward_input x.(0) x.(1) stride x.(2))
        | Conv1dBackwardKernel stride                 -> _eval_map_05 x (fun x -> A.conv1d_backward_kernel x.(0) x.(1) stride x.(2))
        | Conv2dBackwardInput stride                  -> _eval_map_05 x (fun x -> A.conv2d_backward_input x.(0) x.(1) stride x.(2))
        | Conv2dBackwardKernel stride                 -> _eval_map_05 x (fun x -> A.conv2d_backward_kernel x.(0) x.(1) stride x.(2))
        | Conv3dBackwardInput stride                  -> _eval_map_05 x (fun x -> A.conv3d_backward_input x.(0) x.(1) stride x.(2))
        | Conv3dBackwardKernel stride                 -> _eval_map_05 x (fun x -> A.conv3d_backward_kernel x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardInput stride         -> _eval_map_05 x (fun x -> A.transpose_conv2d_backward_input x.(0) x.(1) stride x.(2))
        | TransposeConv2dBackwardKernel stride        -> _eval_map_05 x (fun x -> A.transpose_conv2d_backward_kernel x.(0) x.(1) stride x.(2))
        | MaxPool1dBackward (padding, kernel, stride) -> _eval_map_05 x (fun x -> A.max_pool1d_backward padding x.(0) kernel stride x.(1))
        | MaxPool2dBackward (padding, kernel, stride) -> _eval_map_05 x (fun x -> A.max_pool2d_backward padding x.(0) kernel stride x.(1))
        | MaxPool3dBackward (padding, kernel, stride) -> _eval_map_05 x (fun x -> A.max_pool3d_backward padding x.(0) kernel stride x.(1))
        | AvgPool1dBackward (padding, kernel, stride) -> _eval_map_05 x (fun x -> A.avg_pool1d_backward padding x.(0) kernel stride x.(1))
        | AvgPool2dBackward (padding, kernel, stride) -> _eval_map_05 x (fun x -> A.avg_pool2d_backward padding x.(0) kernel stride x.(1))
        | AvgPool3dBackward (padding, kernel, stride) -> _eval_map_05 x (fun x -> A.avg_pool3d_backward padding x.(0) kernel stride x.(1))
        | Row                                         -> failwith "Row"
        | Rows i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot                                         -> _eval_map_05 x (fun x -> A.dot x.(0) x.(1))
        | Inv                                         -> _eval_map_00 x A.inv
        | Trace                                       -> _eval_map_07 x A.trace
        | Transpose axis                              -> _eval_map_00 x A.(transpose ~axis)
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
        | _                                           -> failwith "owl_lazy:_eval_term"
      );
      validate x
    )

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
    let a = allocate_1 x_parent in
    f a;
    set_value x [|arr_to_value a|]


  (* [f] is inpure and [g] is pure, for [arr -> arr -> arr] *)
  and _eval_map_02 x f g =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_arr (get_value x_parent_0).(0) in
    let b = value_to_arr (get_value x_parent_1).(0) in
    let c = match allocate_2 x_parent_0 x_parent_1 with
      | Some (p, q) -> f p q; p    (* in-place function, p will be written *)
      | None        -> g a b       (* pure function without touching a and b *)
    in
    set_value x [|arr_to_value c|]


  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map_03 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = allocate_1 x_parent_0 in
    let b = value_to_elt (get_value x_parent_1).(0) in
    f a b;
    set_value x [|arr_to_value a|]


  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map_04 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = value_to_elt (get_value x_parent_0).(0) in
    let b = allocate_1 x_parent_1 in
    f a b;
    set_value x [|arr_to_value b|]


  (* [f] is pure, shape changes so always allocate mem, for [arr array -> arr] *)
  and _eval_map_05 x f =
    let a = Array.map (fun x ->
      _eval_term x;
      value_to_arr (get_value x).(0)
    ) (parents x) |> f
    in
    set_value x [|arr_to_value a|]


  (* [f] is pure, for [arr -> elt] *)
  and _eval_map_07 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|elt_to_value a|]


  (* [f] is pure, for [elt array -> arr] *)
  and _eval_map_08 x f =
    let a = Array.map (fun x ->
      _eval_term x;
      value_to_elt (get_value x).(0)
    ) (parents x) |> f
    in
    set_value x [|arr_to_value a|]


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


  (* NOTE: this function is debugging purpose *)
  let dump_dot fname xs =
    let s0 = to_dot xs in
    Owl_io.write_file fname s0


  let eval_elt xs =
    let ys = Array.map elt_to_node xs |> Array.to_list in
    dump_dot "yyy.dot" ys;
    Array.iter (fun x -> elt_to_node x |> _eval_term) xs


  let eval_arr xs =
    let ys = Array.map arr_to_node xs |> Array.to_list in
    dump_dot "zzz.dot" ys;
    Array.iter (fun x -> arr_to_node x |> _eval_term) xs


  let elt_to_float x =
    eval_elt [|x|];
    unpack_elt x |> A.elt_to_float


  let arr_to_arr x =
    eval_arr [|x|];
    set_operator (arr_to_node x) Var;
    arr_to_arr x


end
