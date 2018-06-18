(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_graph

open Owl_opencl_base

open Owl_opencl_utils

open Owl_opencl_context

open Owl_opencl_generated


(* Functor of making a Lazy engine to execute a computation graph. *)

module Make (A : Ndarray_Mutable) = struct

  module CGraph = Owl_computation_graph.Make (A) (Owl_opencl_device)

  module CL_Dev = Owl_opencl_device.Make (A)

  include CGraph


  let is_initialised x =
    let x_val = get_value x in
    if Array.length x_val = 0 then false
    else Array.length x_val.(0).kernel > 0


  let rec _init_term x param =
    Owl_log.debug "init %s ..." (node_to_str x);

    if is_initialised x = false then
      try
        match (get_operator x) with
        | Noop                                        -> init_xx x param
        | Var                                         -> init_xx x param
        | Const                                       -> check_assigned x
        | Empty shape                                 -> init_xx x param
        | Zeros shape                                 -> init_xx x param
        | Ones shape                                  -> init_xx x param
        | Create shape                                -> init_xx x param
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> init_xx x param
        | Gaussian                                    -> failwith "Gaussian"
        | Bernoulli (p, shape)                        -> init_xx x param
        | Init _                                      -> failwith "Init"
        | Get i                                       -> init_xx x param
        | Set i                                       -> failwith "Set"
        | GetSlice slice                              -> init_xx x param
        | SetSlice slice                              -> failwith "SetSlice"
        | Copy                                        -> init_xx x param
        | Reset                                       -> failwith "Reset"
        | Reshape shape                               -> init_xx x param
        | Reverse                                     -> init_xx x param
        | Tile repeats                                -> init_xx x param
        | Repeat (axis, repeats)                      -> init_xx x param
        | Concatenate axis                            -> init_xx x param
        | Split (axis, parts)                         -> failwith "Split"
        | Draw (axis, n)                              -> failwith "Draw"
        | Map f                                       -> failwith "Map"
        | Fold (axis, f)                              -> failwith "Fold"
        | Scan (axis, f)                              -> failwith "Scan"
        | OneHot depth                                -> init_xx x param
        | Abs                                         -> init_xx x param
        | Neg                                         -> init_xx x param
        | Floor                                       -> init_xx x param
        | Ceil                                        -> init_xx x param
        | Round                                       -> init_xx x param
        | Sqr                                         -> init_xx x param
        | Sqrt                                        -> init_xx x param
        | Log                                         -> init_xx x param
        | Log2                                        -> init_xx x param
        | Log10                                       -> init_xx x param
        | Exp                                         -> init_xx x param
        | Sin                                         -> init_00 x param
        | Cos                                         -> init_xx x param
        | Tan                                         -> init_xx x param
        | Sinh                                        -> init_xx x param
        | Cosh                                        -> init_xx x param
        | Tanh                                        -> init_xx x param
        | Asin                                        -> init_xx x param
        | Acos                                        -> init_xx x param
        | Atan                                        -> init_xx x param
        | Asinh                                       -> init_xx x param
        | Acosh                                       -> init_xx x param
        | Atanh                                       -> init_xx x param
        | Min axis                                    -> init_xx x param
        | Max axis                                    -> init_xx x param
        | Sum axis                                    -> init_xx x param
        | SumReduce axis                              -> init_xx x param
        | Signum                                      -> init_xx x param
        | Sigmoid                                     -> init_xx x param
        | Relu                                        -> init_xx x param
        | Min'                                        -> init_xx x param
        | Max'                                        -> init_xx x param
        | Sum'                                        -> init_xx x param
        | L1norm'                                     -> init_xx x param
        | L2norm'                                     -> init_xx x param
        | L2NormSqr'                                  -> init_xx x param
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> init_xx x param
        | ScalarPow                                   -> init_xx x param
        | PowScalar                                   -> init_xx x param
        | Atan2                                       -> init_xx x param
        | ScalarAtan2                                 -> init_xx x param
        | Atan2Scalar                                 -> init_xx x param
        | Hypot                                       -> init_xx x param
        | Min2                                        -> init_xx x param
        | Max2                                        -> init_xx x param
        | Add                                         -> init_xx x param
        | Sub                                         -> init_xx x param
        | Mul                                         -> init_xx x param
        | Div                                         -> init_xx x param
        | AddScalar                                   -> init_xx x param
        | SubScalar                                   -> init_xx x param
        | MulScalar                                   -> init_xx x param
        | DivScalar                                   -> init_xx x param
        | ScalarAdd                                   -> init_xx x param
        | ScalarSub                                   -> init_xx x param
        | ScalarMul                                   -> init_xx x param
        | ScalarDiv                                   -> init_xx x param
        | FMA                                         -> init_xx x param
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
        | EltEqual                                    -> init_xx x param
        | EltNotEqual                                 -> init_xx x param
        | EltLess                                     -> init_xx x param
        | EltGreater                                  -> init_xx x param
        | EltLessEqual                                -> init_xx x param
        | EltGreaterEqual                             -> init_xx x param
        | EltEqualScalar                              -> init_xx x param
        | EltNotEqualScalar                           -> init_xx x param
        | EltLessScalar                               -> init_xx x param
        | EltGreaterScalar                            -> init_xx x param
        | EltLessEqualScalar                          -> init_xx x param
        | EltGreaterEqualScalar                       -> init_xx x param
        | ApproxEqual eps                             -> failwith "ApproxEqual"
        | ApproxEqualScalar eps                       -> failwith "ApproxEqualScalar"
        | ApproxEltEqual eps                          -> failwith "ApproxEltEqual"
        | ApproxEltEqualScalar eps                    -> failwith "ApproxEltEqualScalar"
        | Conv1d (padding, stride)                    -> init_xx x param
        | Conv2d (padding, stride)                    -> init_xx x param
        | Conv3d (padding, stride)                    -> init_xx x param
        | TransposeConv2d (padding, stride)           -> init_xx x param
        | MaxPool1d (padding, kernel, stride)         -> init_xx x param
        | MaxPool2d (padding, kernel, stride)         -> init_xx x param
        | MaxPool3d (padding, kernel, stride)         -> init_xx x param
        | AvgPool1d (padding, kernel, stride)         -> init_xx x param
        | AvgPool2d (padding, kernel, stride)         -> init_xx x param
        | AvgPool3d (padding, kernel, stride)         -> init_xx x param
        | Conv1dBackwardInput stride                  -> init_xx x param
        | Conv1dBackwardKernel stride                 -> init_xx x param
        | Conv2dBackwardInput stride                  -> init_xx x param
        | Conv2dBackwardKernel stride                 -> init_xx x param
        | Conv3dBackwardInput stride                  -> init_xx x param
        | Conv3dBackwardKernel stride                 -> init_xx x param
        | TransposeConv2dBackwardInput stride         -> init_xx x param
        | TransposeConv2dBackwardKernel stride        -> init_xx x param
        | MaxPool1dBackward (padding, kernel, stride) -> init_xx x param
        | MaxPool2dBackward (padding, kernel, stride) -> init_xx x param
        | MaxPool3dBackward (padding, kernel, stride) -> init_xx x param
        | AvgPool1dBackward (padding, kernel, stride) -> init_xx x param
        | AvgPool2dBackward (padding, kernel, stride) -> init_xx x param
        | AvgPool3dBackward (padding, kernel, stride) -> init_xx x param
        | Row                                         -> failwith "Row"
        | Rows i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (transa, transb, alpha, beta)           -> init_xx x param
        | Inv                                         -> init_xx x param
        | Trace                                       -> init_xx x param
        | Transpose axis                              -> init_xx x param
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | OfArray shape                               -> failwith "OfArray"
        | OfArrays                                    -> failwith "OfArrays"
        | Scalar_Add                                  -> init_xx x param
        | Scalar_Sub                                  -> init_xx x param
        | Scalar_Mul                                  -> init_xx x param
        | Scalar_Div                                  -> init_xx x param
        | Scalar_Pow                                  -> init_xx x param
        | Scalar_Atan2                                -> init_xx x param
        | Scalar_Abs                                  -> init_xx x param
        | Scalar_Neg                                  -> init_xx x param
        | Scalar_Sqr                                  -> init_xx x param
        | Scalar_Sqrt                                 -> init_xx x param
        | Scalar_Exp                                  -> init_xx x param
        | Scalar_Log                                  -> init_xx x param
        | Scalar_Log2                                 -> init_xx x param
        | Scalar_Log10                                -> init_xx x param
        | Scalar_Signum                               -> init_xx x param
        | Scalar_Floor                                -> init_xx x param
        | Scalar_Ceil                                 -> init_xx x param
        | Scalar_Round                                -> init_xx x param
        | Scalar_Sin                                  -> init_xx x param
        | Scalar_Cos                                  -> init_xx x param
        | Scalar_Tan                                  -> init_xx x param
        | Scalar_Sinh                                 -> init_xx x param
        | Scalar_Cosh                                 -> init_xx x param
        | Scalar_Tanh                                 -> init_xx x param
        | Scalar_Asin                                 -> init_xx x param
        | Scalar_Acos                                 -> init_xx x param
        | Scalar_Atan                                 -> init_xx x param
        | Scalar_Asinh                                -> init_xx x param
        | Scalar_Acosh                                -> init_xx x param
        | Scalar_Atanh                                -> init_xx x param
        | Scalar_Relu                                 -> init_xx x param
        | Scalar_Sigmoid                              -> init_xx x param
        | Fused_Adagrad (rate, eps)                   -> init_xx x param
        | _                                           -> failwith "owl_opencl_engine:_eval_term"

        with exn -> (
          Owl_log.error "Error in initialising %s" (node_to_str x);
          raise exn
        )


  and init_xx x param = ()


  and init_00 x param =
    let x_parent = (parents x).(0) in
    _init_term x_parent param;
    ()


  let init_nodes xs param = Array.iter (fun x -> _init_term x param) xs



end
