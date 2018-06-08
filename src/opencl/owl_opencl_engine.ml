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


  let rec _eval_term x =
    Owl_log.debug "eval %s ..." (node_to_str x);
    if is_valid x = false then
      let _ = try
        match (get_operator x) with
        | Noop                                        -> _eval_map_00 x
        | Var                                         -> check_assigned x
        | Const                                       -> check_assigned x
        | Empty shape                                 -> _eval_map_00 x
        | Zeros shape                                 -> _eval_map_00 x
        | Ones shape                                  -> _eval_map_00 x
        | Create shape                                -> _eval_map_00 x
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> _eval_map_00 x
        | Gaussian                                    -> failwith "Gaussian"
        | Bernoulli (p, shape)                        -> _eval_map_00 x
        | Init _                                      -> failwith "Init"
        | Get i                                       -> _eval_map_00 x
        | Set i                                       -> failwith "Set"
        | GetSlice slice                              -> _eval_map_00 x
        | SetSlice slice                              -> failwith "SetSlice"
        | Copy                                        -> _eval_map_00 x
        | Reset                                       -> failwith "Reset"
        | Reshape shape                               -> _eval_map_00 x
        | Reverse                                     -> _eval_map_00 x
        | Tile repeats                                -> _eval_map_00 x
        | Repeat (axis, repeats)                      -> _eval_map_00 x
        | Concatenate axis                            -> _eval_map_00 x
        | Split (axis, parts)                         -> failwith "Split"
        | Draw (axis, n)                              -> failwith "Draw"
        | Map f                                       -> failwith "Map"
        | Fold (axis, f)                              -> failwith "Fold"
        | Scan (axis, f)                              -> failwith "Scan"
        | OneHot depth                                -> _eval_map_00 x
        | Abs                                         -> _eval_map_00 x
        | Neg                                         -> _eval_map_00 x
        | Floor                                       -> _eval_map_00 x
        | Ceil                                        -> _eval_map_00 x
        | Round                                       -> _eval_map_00 x
        | Sqr                                         -> _eval_map_00 x
        | Sqrt                                        -> _eval_map_00 x
        | Log                                         -> _eval_map_00 x
        | Log2                                        -> _eval_map_00 x
        | Log10                                       -> _eval_map_00 x
        | Exp                                         -> _eval_map_00 x
        | Sin                                         -> _eval_map_00 x
        | Cos                                         -> _eval_map_00 x
        | Tan                                         -> _eval_map_00 x
        | Sinh                                        -> _eval_map_00 x
        | Cosh                                        -> _eval_map_00 x
        | Tanh                                        -> _eval_map_00 x
        | Asin                                        -> _eval_map_00 x
        | Acos                                        -> _eval_map_00 x
        | Atan                                        -> _eval_map_00 x
        | Asinh                                       -> _eval_map_00 x
        | Acosh                                       -> _eval_map_00 x
        | Atanh                                       -> _eval_map_00 x
        | Min axis                                    -> _eval_map_00 x
        | Max axis                                    -> _eval_map_00 x
        | Sum axis                                    -> _eval_map_00 x
        | SumReduce axis                              -> _eval_map_00 x
        | Signum                                      -> _eval_map_00 x
        | Sigmoid                                     -> _eval_map_00 x
        | Relu                                        -> _eval_map_00 x
        | Min'                                        -> _eval_map_00 x
        | Max'                                        -> _eval_map_00 x
        | Sum'                                        -> _eval_map_00 x
        | L1norm'                                     -> _eval_map_00 x
        | L2norm'                                     -> _eval_map_00 x
        | L2NormSqr'                                  -> _eval_map_00 x
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> _eval_map_00 x
        | ScalarPow                                   -> _eval_map_00 x
        | PowScalar                                   -> _eval_map_00 x
        | Atan2                                       -> _eval_map_00 x
        | ScalarAtan2                                 -> _eval_map_00 x
        | Atan2Scalar                                 -> _eval_map_00 x
        | Hypot                                       -> _eval_map_00 x
        | Min2                                        -> _eval_map_00 x
        | Max2                                        -> _eval_map_00 x
        | Add                                         -> _eval_map_00 x
        | Sub                                         -> _eval_map_00 x
        | Mul                                         -> _eval_map_00 x
        | Div                                         -> _eval_map_00 x
        | AddScalar                                   -> _eval_map_00 x
        | SubScalar                                   -> _eval_map_00 x
        | MulScalar                                   -> _eval_map_00 x
        | DivScalar                                   -> _eval_map_00 x
        | ScalarAdd                                   -> _eval_map_00 x
        | ScalarSub                                   -> _eval_map_00 x
        | ScalarMul                                   -> _eval_map_00 x
        | ScalarDiv                                   -> _eval_map_00 x
        | FMA                                         -> _eval_map_00 x
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
        | EltEqual                                    -> _eval_map_00 x
        | EltNotEqual                                 -> _eval_map_00 x
        | EltLess                                     -> _eval_map_00 x
        | EltGreater                                  -> _eval_map_00 x
        | EltLessEqual                                -> _eval_map_00 x
        | EltGreaterEqual                             -> _eval_map_00 x
        | EltEqualScalar                              -> _eval_map_00 x
        | EltNotEqualScalar                           -> _eval_map_00 x
        | EltLessScalar                               -> _eval_map_00 x
        | EltGreaterScalar                            -> _eval_map_00 x
        | EltLessEqualScalar                          -> _eval_map_00 x
        | EltGreaterEqualScalar                       -> _eval_map_00 x
        | ApproxEqual eps                             -> failwith "ApproxEqual"
        | ApproxEqualScalar eps                       -> failwith "ApproxEqualScalar"
        | ApproxEltEqual eps                          -> failwith "ApproxEltEqual"
        | ApproxEltEqualScalar eps                    -> failwith "ApproxEltEqualScalar"
        | Conv1d (padding, stride)                    -> _eval_map_00 x
        | Conv2d (padding, stride)                    -> _eval_map_00 x
        | Conv3d (padding, stride)                    -> _eval_map_00 x
        | TransposeConv2d (padding, stride)           -> _eval_map_00 x
        | MaxPool1d (padding, kernel, stride)         -> _eval_map_00 x
        | MaxPool2d (padding, kernel, stride)         -> _eval_map_00 x
        | MaxPool3d (padding, kernel, stride)         -> _eval_map_00 x
        | AvgPool1d (padding, kernel, stride)         -> _eval_map_00 x
        | AvgPool2d (padding, kernel, stride)         -> _eval_map_00 x
        | AvgPool3d (padding, kernel, stride)         -> _eval_map_00 x
        | Conv1dBackwardInput stride                  -> _eval_map_00 x
        | Conv1dBackwardKernel stride                 -> _eval_map_00 x
        | Conv2dBackwardInput stride                  -> _eval_map_00 x
        | Conv2dBackwardKernel stride                 -> _eval_map_00 x
        | Conv3dBackwardInput stride                  -> _eval_map_00 x
        | Conv3dBackwardKernel stride                 -> _eval_map_00 x
        | TransposeConv2dBackwardInput stride         -> _eval_map_00 x
        | TransposeConv2dBackwardKernel stride        -> _eval_map_00 x
        | MaxPool1dBackward (padding, kernel, stride) -> _eval_map_00 x
        | MaxPool2dBackward (padding, kernel, stride) -> _eval_map_00 x
        | MaxPool3dBackward (padding, kernel, stride) -> _eval_map_00 x
        | AvgPool1dBackward (padding, kernel, stride) -> _eval_map_00 x
        | AvgPool2dBackward (padding, kernel, stride) -> _eval_map_00 x
        | AvgPool3dBackward (padding, kernel, stride) -> _eval_map_00 x
        | Row                                         -> failwith "Row"
        | Rows i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (transa, transb, alpha, beta)           -> _eval_map_00 x
        | Inv                                         -> _eval_map_00 x
        | Trace                                       -> _eval_map_00 x
        | Transpose axis                              -> _eval_map_00 x
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | OfArray shape                               -> failwith "OfArray"
        | OfArrays                                    -> failwith "OfArrays"
        | Scalar_Add                                  -> _eval_map_00 x
        | Scalar_Sub                                  -> _eval_map_00 x
        | Scalar_Mul                                  -> _eval_map_00 x
        | Scalar_Div                                  -> _eval_map_00 x
        | Scalar_Pow                                  -> _eval_map_00 x
        | Scalar_Atan2                                -> _eval_map_00 x
        | Scalar_Abs                                  -> _eval_map_00 x
        | Scalar_Neg                                  -> _eval_map_00 x
        | Scalar_Sqr                                  -> _eval_map_00 x
        | Scalar_Sqrt                                 -> _eval_map_00 x
        | Scalar_Exp                                  -> _eval_map_00 x
        | Scalar_Log                                  -> _eval_map_00 x
        | Scalar_Log2                                 -> _eval_map_00 x
        | Scalar_Log10                                -> _eval_map_00 x
        | Scalar_Signum                               -> _eval_map_00 x
        | Scalar_Floor                                -> _eval_map_00 x
        | Scalar_Ceil                                 -> _eval_map_00 x
        | Scalar_Round                                -> _eval_map_00 x
        | Scalar_Sin                                  -> _eval_map_00 x
        | Scalar_Cos                                  -> _eval_map_00 x
        | Scalar_Tan                                  -> _eval_map_00 x
        | Scalar_Sinh                                 -> _eval_map_00 x
        | Scalar_Cosh                                 -> _eval_map_00 x
        | Scalar_Tanh                                 -> _eval_map_00 x
        | Scalar_Asin                                 -> _eval_map_00 x
        | Scalar_Acos                                 -> _eval_map_00 x
        | Scalar_Atan                                 -> _eval_map_00 x
        | Scalar_Asinh                                -> _eval_map_00 x
        | Scalar_Acosh                                -> _eval_map_00 x
        | Scalar_Atanh                                -> _eval_map_00 x
        | Scalar_Relu                                 -> _eval_map_00 x
        | Scalar_Sigmoid                              -> _eval_map_00 x
        | Fused_Adagrad (rate, eps)                   -> _eval_map_00 x
        | _                                           -> failwith "owl_lazy:_eval_term"

        with exn -> (
          Owl_log.error "Error in evaluating %s" (node_to_str x);
          raise exn
        )
      in
      validate x

  and _eval_map_00 x = ()


end
