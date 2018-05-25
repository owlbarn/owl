(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making a Lazy engine to execute a computation graph. *)

module Make (A : Ndarray_Algodiff) = struct

  include Owl_computation_graph.Make (A)


  let rec _optimise_term x =
    Owl_log.debug "optimise %s ..." (node_to_str x);
    if is_valid x = false then (
      (
        match (get_operator x) with
        | Noop                                        -> pattern_dummy x
        | Var                                         -> ()
        | Const                                       -> pattern_dummy x
        | Empty shape                                 -> pattern_dummy x
        | Zeros shape                                 -> pattern_dummy x
        | Ones shape                                  -> pattern_dummy x
        | Create                                      -> pattern_dummy x
        | Sequential                                  -> pattern_dummy x
        | Uniform shape                               -> pattern_dummy x
        | Gaussian                                    -> pattern_dummy x
        | Bernoulli (p, shape)                        -> pattern_dummy x
        | Init _                                      -> pattern_dummy x
        | Get i                                       -> pattern_dummy x
        | Set i                                       -> pattern_dummy x
        | GetSlice slice                              -> pattern_dummy x
        | SetSlice slice                              -> pattern_dummy x
        | Copy                                        -> pattern_dummy x
        | Reset                                       -> pattern_dummy x
        | Reshape shape                               -> pattern_dummy x
        | Reverse                                     -> pattern_dummy x
        | Tile repeats                                -> pattern_dummy x
        | Repeat (axis, repeats)                      -> pattern_dummy x
        | Concatenate axis                            -> pattern_dummy x
        | Split (axis, parts)                         -> pattern_dummy x
        | Draw (axis, n)                              -> pattern_dummy x
        | Map f                                       -> pattern_dummy x
        | Fold (axis, f)                              -> pattern_dummy x
        | Scan (axis, f)                              -> pattern_dummy x
        | OneHot depth                                -> pattern_dummy x
        | Abs                                         -> pattern_dummy x
        | Neg                                         -> pattern_dummy x
        | Floor                                       -> pattern_dummy x
        | Ceil                                        -> pattern_dummy x
        | Round                                       -> pattern_dummy x
        | Sqr                                         -> pattern_dummy x
        | Sqrt                                        -> pattern_dummy x
        | Log                                         -> pattern_dummy x
        | Log2                                        -> pattern_dummy x
        | Log10                                       -> pattern_dummy x
        | Exp                                         -> pattern_dummy x
        | Sin                                         -> pattern_dummy x
        | Cos                                         -> pattern_dummy x
        | Tan                                         -> pattern_dummy x
        | Sinh                                        -> pattern_dummy x
        | Cosh                                        -> pattern_dummy x
        | Tanh                                        -> pattern_dummy x
        | Asin                                        -> pattern_dummy x
        | Acos                                        -> pattern_dummy x
        | Atan                                        -> pattern_dummy x
        | Asinh                                       -> pattern_dummy x
        | Acosh                                       -> pattern_dummy x
        | Atanh                                       -> pattern_dummy x
        | Min axis                                    -> pattern_dummy x
        | Max axis                                    -> pattern_dummy x
        | Sum axis                                    -> pattern_dummy x
        | SumReduce axis                              -> pattern_dummy x
        | Signum                                      -> pattern_dummy x
        | Sigmoid                                     -> pattern_dummy x
        | Relu                                        -> pattern_dummy x
        | Min'                                        -> pattern_dummy x
        | Max'                                        -> pattern_dummy x
        | Sum'                                        -> pattern_dummy x
        | L1norm'                                     -> pattern_dummy x
        | L2norm'                                     -> pattern_dummy x
        | L2NormSqr'                                  -> pattern_dummy x
        | ClipByValue                                 -> pattern_dummy x
        | ClipByL2norm                                -> pattern_dummy x
        | Pow                                         -> pattern_dummy x
        | ScalarPow                                   -> pattern_dummy x
        | PowScalar                                   -> pattern_dummy x
        | Atan2                                       -> pattern_dummy x
        | ScalarAtan2                                 -> pattern_dummy x
        | Atan2Scalar                                 -> pattern_dummy x
        | Add                                         -> pattern_add x
        | Sub                                         -> pattern_dummy x
        | Mul                                         -> pattern_dummy x
        | Div                                         -> pattern_dummy x
        | AddScalar                                   -> pattern_dummy x
        | SubScalar                                   -> pattern_dummy x
        | MulScalar                                   -> pattern_dummy x
        | DivScalar                                   -> pattern_dummy x
        | ScalarAdd                                   -> pattern_dummy x
        | ScalarSub                                   -> pattern_dummy x
        | ScalarMul                                   -> pattern_dummy x
        | ScalarDiv                                   -> pattern_dummy x
        | IsZero                                      -> pattern_dummy x
        | IsPositive                                  -> pattern_dummy x
        | IsNegative                                  -> pattern_dummy x
        | IsNonpositive                               -> pattern_dummy x
        | IsNonnegative                               -> pattern_dummy x
        | Equal                                       -> pattern_dummy x
        | NotEqual                                    -> pattern_dummy x
        | Less                                        -> pattern_dummy x
        | Greater                                     -> pattern_dummy x
        | LessEqual                                   -> pattern_dummy x
        | GreaterEqual                                -> pattern_dummy x
        | EltEqual                                    -> pattern_dummy x
        | EltNotEqual                                 -> pattern_dummy x
        | EltLess                                     -> pattern_dummy x
        | EltGreater                                  -> pattern_dummy x
        | EltLessEqual                                -> pattern_dummy x
        | EltGreaterEqual                             -> pattern_dummy x
        | EltEqualScalar                              -> pattern_dummy x
        | EltNotEqualScalar                           -> pattern_dummy x
        | EltLessScalar                               -> pattern_dummy x
        | EltGreaterScalar                            -> pattern_dummy x
        | EltLessEqualScalar                          -> pattern_dummy x
        | EltGreaterEqualScalar                       -> pattern_dummy x
        | ApproxEqual eps                             -> pattern_dummy x
        | ApproxEqualScalar eps                       -> pattern_dummy x
        | ApproxEltEqual eps                          -> pattern_dummy x
        | ApproxEltEqualScalar eps                    -> pattern_dummy x
        | Conv1d (padding, stride)                    -> pattern_dummy x
        | Conv2d (padding, stride)                    -> pattern_dummy x
        | Conv3d (padding, stride)                    -> pattern_dummy x
        | TransposeConv2d (padding, stride)           -> pattern_dummy x
        | MaxPool1d (padding, kernel, stride)         -> pattern_dummy x
        | MaxPool2d (padding, kernel, stride)         -> pattern_dummy x
        | MaxPool3d (padding, kernel, stride)         -> pattern_dummy x
        | AvgPool1d (padding, kernel, stride)         -> pattern_dummy x
        | AvgPool2d (padding, kernel, stride)         -> pattern_dummy x
        | AvgPool3d (padding, kernel, stride)         -> pattern_dummy x
        | Conv1dBackwardInput stride                  -> pattern_dummy x
        | Conv1dBackwardKernel stride                 -> pattern_dummy x
        | Conv2dBackwardInput stride                  -> pattern_dummy x
        | Conv2dBackwardKernel stride                 -> pattern_dummy x
        | Conv3dBackwardInput stride                  -> pattern_dummy x
        | Conv3dBackwardKernel stride                 -> pattern_dummy x
        | TransposeConv2dBackwardInput stride         -> pattern_dummy x
        | TransposeConv2dBackwardKernel stride        -> pattern_dummy x
        | MaxPool1dBackward (padding, kernel, stride) -> pattern_dummy x
        | MaxPool2dBackward (padding, kernel, stride) -> pattern_dummy x
        | MaxPool3dBackward (padding, kernel, stride) -> pattern_dummy x
        | AvgPool1dBackward (padding, kernel, stride) -> pattern_dummy x
        | AvgPool2dBackward (padding, kernel, stride) -> pattern_dummy x
        | AvgPool3dBackward (padding, kernel, stride) -> pattern_dummy x
        | Row                                         -> pattern_dummy x
        | Rows i                                      -> pattern_dummy x
        | CopyRowTo                                   -> pattern_dummy x
        | CopyColTo                                   -> pattern_dummy x
        | Dot                                         -> pattern_dummy x
        | Inv                                         -> pattern_dummy x
        | Trace                                       -> pattern_dummy x
        | Transpose axis                              -> pattern_dummy x
        | ToRows                                      -> pattern_dummy x
        | OfRows                                      -> pattern_dummy x
        | OfArray shape                               -> pattern_dummy x
        | OfArrays                                    -> pattern_dummy x
        | Scalar_Add                                  -> pattern_dummy x
        | Scalar_Sub                                  -> pattern_dummy x
        | Scalar_Mul                                  -> pattern_dummy x
        | Scalar_Div                                  -> pattern_dummy x
        | Scalar_Pow                                  -> pattern_dummy x
        | Scalar_Atan2                                -> pattern_dummy x
        | Scalar_Abs                                  -> pattern_dummy x
        | Scalar_Neg                                  -> pattern_dummy x
        | Scalar_Sqr                                  -> pattern_dummy x
        | Scalar_Sqrt                                 -> pattern_dummy x
        | Scalar_Exp                                  -> pattern_dummy x
        | Scalar_Log                                  -> pattern_dummy x
        | Scalar_Log2                                 -> pattern_dummy x
        | Scalar_Log10                                -> pattern_dummy x
        | Scalar_Signum                               -> pattern_dummy x
        | Scalar_Floor                                -> pattern_dummy x
        | Scalar_Ceil                                 -> pattern_dummy x
        | Scalar_Round                                -> pattern_dummy x
        | Scalar_Sin                                  -> pattern_dummy x
        | Scalar_Cos                                  -> pattern_dummy x
        | Scalar_Tan                                  -> pattern_dummy x
        | Scalar_Sinh                                 -> pattern_dummy x
        | Scalar_Cosh                                 -> pattern_dummy x
        | Scalar_Tanh                                 -> pattern_dummy x
        | Scalar_Asin                                 -> pattern_dummy x
        | Scalar_Acos                                 -> pattern_dummy x
        | Scalar_Atan                                 -> pattern_dummy x
        | Scalar_Asinh                                -> pattern_dummy x
        | Scalar_Acosh                                -> pattern_dummy x
        | Scalar_Atanh                                -> pattern_dummy x
        | Scalar_Relu                                 -> pattern_dummy x
        | Scalar_Sigmoid                              -> pattern_dummy x
        | _                                           -> failwith "Owl_computation_optimiser:_optimise_term"
      );
      validate x
    )


  and pattern_dummy x =
    let parents = parents x in
    Array.iter _optimise_term parents


  and pattern_add x =
    let parents = parents x in
    let a = parents.(0) in
    let b = parents.(1) in
    _optimise_term a;
    _optimise_term b;
    let _ = match get_operator a with
      | Zeros shape -> (
          set_operator x Noop;
          remove_edge a x;
          remove_edge x a;
          let value = get_value x in
          if Array.length value > 0 then
            set_value x [|value.(1)|]
        )
      | _           -> ()
    in
    let _ = match get_operator b with
      | Zeros shape -> (
          set_operator x Noop;
          remove_edge b x;
          remove_edge x b;
          let value = get_value x in
          if Array.length value > 0 then
            set_value x [|value.(0)|]
        )
      | _           -> ()
    in
    ()


  let run x =
    Array.iter _optimise_term (Obj.magic x);
    (* NOTE: invalidate ancestors *)
    iter_ancestors (fun v -> invalidate v) (Obj.magic x)


end

(* Make functor ends *)
