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


  (* utility functions *)


  let make_typed_kernel_name fun_name =
    match A.number with
    | F32 -> "owl_opencl_float32_" ^ fun_name
    | F64 -> "owl_opencl_float64_" ^ fun_name
    | _   -> failwith "make_typed_kernel_name"


  let make_kernel x program fun_name =
    let x_val = (get_value x).(0) in
    let typed_fun = make_typed_kernel_name fun_name in
    let kernel = Kernel.create program typed_fun in
    x_val.kernel <- [| kernel |];
    kernel


  let allocate_cpu_buffer x =
    if is_assigned x = false then (
      let x_shp = shape (node_to_arr x) in
      let cpu_mem = A.empty x_shp in
      let new_val = CL_Dev.make_value [|ArrVal cpu_mem|] [||] [||] [||] in
      set_value x [| new_val |]
    )


  let allocate_gpu_buffer ctx x =
    let x_val = (get_value x).(0) in
    if Array.length x_val.gpu_mem = 0 then (
      let cpu_mem = value_to_arr x_val in
      let flags = [ cl_MEM_USE_HOST_PTR ] in
      let gpu_mem = Buffer.create_bigarray ~flags ctx (Obj.magic cpu_mem) in
      let new_val = CL_Dev.make_value [|ArrVal cpu_mem|] [|gpu_mem|] [||] [||] in
      set_value x [| new_val |]
    )


  let allocate_cpu_gpu_buffer ctx x =
    allocate_cpu_buffer x;
    allocate_gpu_buffer ctx x


  let get_cpu_ptr x_val =
    let cpu_mem = CL_Dev.value_to_arr x_val in
    Ctypes.(bigarray_start genarray (Obj.magic cpu_mem))


  let get_gpu_ptr x_val =
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    Ctypes.allocate cl_mem gpu_mem


  let get_elt_ptr x_val =
    let elt_mem = value_to_float x_val in
    Ctypes.allocate Ctypes.float elt_mem


  let allocate_from_parent_0 ctx x = allocate_cpu_gpu_buffer ctx x


  let allocate_from_parent_1 ctx x parent =
    let parent_val = (get_value parent).(0) in
    if refnum parent = 1 && get_reuse parent then
      set_value x [| CL_Dev.copy_cpu_gpu_mem parent_val |]
    else allocate_cpu_gpu_buffer ctx x


  (* a node is initialised iff the kernel is allocated *)
  let is_initialised x =
    let x_val = get_value x in
    if Array.length x_val = 0 then false
    else Array.length x_val.(0).kernel > 0


  let rec _init_term x param =
    Owl_log.debug "init %s ..." (node_to_str x);

    if is_initialised x = false then
      try
        match (get_operator x) with
        | Noop                                        -> _init_xx x param
        | Var                                         -> _init_00 x param
        | Const                                       -> check_assigned x
        | Empty shape                                 -> _init_xx x param
        | Zeros shape                                 -> _init_xx x param
        | Ones shape                                  -> _init_xx x param
        | Create shape                                -> _init_xx x param
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> _init_xx x param
        | Gaussian                                    -> failwith "Gaussian"
        | Bernoulli (p, shape)                        -> _init_xx x param
        | Init _                                      -> failwith "Init"
        | Get i                                       -> _init_xx x param
        | Set i                                       -> failwith "Set"
        | GetSlice slice                              -> _init_xx x param
        | SetSlice slice                              -> failwith "SetSlice"
        | Copy                                        -> _init_xx x param
        | Reset                                       -> failwith "Reset"
        | Reshape shape                               -> _init_xx x param
        | Reverse                                     -> _init_xx x param
        | Tile repeats                                -> _init_xx x param
        | Repeat (axis, repeats)                      -> _init_xx x param
        | Concatenate axis                            -> _init_xx x param
        | Split (axis, parts)                         -> failwith "Split"
        | Draw (axis, n)                              -> failwith "Draw"
        | Map f                                       -> failwith "Map"
        | Fold (axis, f)                              -> failwith "Fold"
        | Scan (axis, f)                              -> failwith "Scan"
        | OneHot depth                                -> _init_xx x param
        | Abs                                         -> _init_01 x param "abs"
        | Neg                                         -> _init_01 x param "neg"
        | Floor                                       -> _init_01 x param "floor"
        | Ceil                                        -> _init_01 x param "ceil"
        | Round                                       -> _init_01 x param "round"
        | Sqr                                         -> _init_01 x param "sqr"
        | Sqrt                                        -> _init_01 x param "sqrt"
        | Log                                         -> _init_01 x param "log"
        | Log2                                        -> _init_01 x param "log2"
        | Log10                                       -> _init_01 x param "log10"
        | Exp                                         -> _init_01 x param "exp"
        | Sin                                         -> _init_01 x param "sin"
        | Cos                                         -> _init_01 x param "cos"
        | Tan                                         -> _init_01 x param "tan"
        | Sinh                                        -> _init_01 x param "sinh"
        | Cosh                                        -> _init_01 x param "cosh"
        | Tanh                                        -> _init_01 x param "tanh"
        | Asin                                        -> _init_01 x param "asin"
        | Acos                                        -> _init_01 x param "acos"
        | Atan                                        -> _init_01 x param "atan"
        | Asinh                                       -> _init_01 x param "asinh"
        | Acosh                                       -> _init_01 x param "acosh"
        | Atanh                                       -> _init_01 x param "atanh"
        | Min axis                                    -> _init_xx x param
        | Max axis                                    -> _init_xx x param
        | Sum axis                                    -> _init_xx x param
        | SumReduce axis                              -> _init_xx x param
        | Signum                                      -> _init_xx x param
        | Sigmoid                                     -> _init_xx x param
        | Relu                                        -> _init_xx x param
        | Min'                                        -> _init_xx x param
        | Max'                                        -> _init_xx x param
        | Sum'                                        -> _init_xx x param
        | L1norm'                                     -> _init_xx x param
        | L2norm'                                     -> _init_xx x param
        | L2NormSqr'                                  -> _init_xx x param
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> _init_xx x param
        | ScalarPow                                   -> _init_xx x param
        | PowScalar                                   -> _init_xx x param
        | Atan2                                       -> _init_xx x param
        | ScalarAtan2                                 -> _init_xx x param
        | Atan2Scalar                                 -> _init_xx x param
        | Hypot                                       -> _init_xx x param
        | Min2                                        -> _init_xx x param
        | Max2                                        -> _init_xx x param
        | Add                                         -> _init_xx x param
        | Sub                                         -> _init_xx x param
        | Mul                                         -> _init_xx x param
        | Div                                         -> _init_xx x param
        | AddScalar                                   -> _init_xx x param
        | SubScalar                                   -> _init_xx x param
        | MulScalar                                   -> _init_xx x param
        | DivScalar                                   -> _init_xx x param
        | ScalarAdd                                   -> _init_xx x param
        | ScalarSub                                   -> _init_xx x param
        | ScalarMul                                   -> _init_xx x param
        | ScalarDiv                                   -> _init_xx x param
        | FMA                                         -> _init_xx x param
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
        | EltEqual                                    -> _init_xx x param
        | EltNotEqual                                 -> _init_xx x param
        | EltLess                                     -> _init_xx x param
        | EltGreater                                  -> _init_xx x param
        | EltLessEqual                                -> _init_xx x param
        | EltGreaterEqual                             -> _init_xx x param
        | EltEqualScalar                              -> _init_xx x param
        | EltNotEqualScalar                           -> _init_xx x param
        | EltLessScalar                               -> _init_xx x param
        | EltGreaterScalar                            -> _init_xx x param
        | EltLessEqualScalar                          -> _init_xx x param
        | EltGreaterEqualScalar                       -> _init_xx x param
        | ApproxEqual eps                             -> failwith "ApproxEqual"
        | ApproxEqualScalar eps                       -> failwith "ApproxEqualScalar"
        | ApproxEltEqual eps                          -> failwith "ApproxEltEqual"
        | ApproxEltEqualScalar eps                    -> failwith "ApproxEltEqualScalar"
        | Conv1d (padding, stride)                    -> _init_xx x param
        | Conv2d (padding, stride)                    -> _init_xx x param
        | Conv3d (padding, stride)                    -> _init_xx x param
        | TransposeConv2d (padding, stride)           -> _init_xx x param
        | MaxPool1d (padding, kernel, stride)         -> _init_xx x param
        | MaxPool2d (padding, kernel, stride)         -> _init_xx x param
        | MaxPool3d (padding, kernel, stride)         -> _init_xx x param
        | AvgPool1d (padding, kernel, stride)         -> _init_xx x param
        | AvgPool2d (padding, kernel, stride)         -> _init_xx x param
        | AvgPool3d (padding, kernel, stride)         -> _init_xx x param
        | Conv1dBackwardInput stride                  -> _init_xx x param
        | Conv1dBackwardKernel stride                 -> _init_xx x param
        | Conv2dBackwardInput stride                  -> _init_xx x param
        | Conv2dBackwardKernel stride                 -> _init_xx x param
        | Conv3dBackwardInput stride                  -> _init_xx x param
        | Conv3dBackwardKernel stride                 -> _init_xx x param
        | TransposeConv2dBackwardInput stride         -> _init_xx x param
        | TransposeConv2dBackwardKernel stride        -> _init_xx x param
        | MaxPool1dBackward (padding, kernel, stride) -> _init_xx x param
        | MaxPool2dBackward (padding, kernel, stride) -> _init_xx x param
        | MaxPool3dBackward (padding, kernel, stride) -> _init_xx x param
        | AvgPool1dBackward (padding, kernel, stride) -> _init_xx x param
        | AvgPool2dBackward (padding, kernel, stride) -> _init_xx x param
        | AvgPool3dBackward (padding, kernel, stride) -> _init_xx x param
        | Row                                         -> failwith "Row"
        | Rows i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (transa, transb, alpha, beta)           -> _init_xx x param
        | Inv                                         -> _init_xx x param
        | Trace                                       -> _init_xx x param
        | Transpose axis                              -> _init_xx x param
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | OfArray shape                               -> failwith "OfArray"
        | OfArrays                                    -> failwith "OfArrays"
        | Scalar_Add                                  -> _init_xx x param
        | Scalar_Sub                                  -> _init_xx x param
        | Scalar_Mul                                  -> _init_xx x param
        | Scalar_Div                                  -> _init_xx x param
        | Scalar_Pow                                  -> _init_xx x param
        | Scalar_Atan2                                -> _init_xx x param
        | Scalar_Abs                                  -> _init_xx x param
        | Scalar_Neg                                  -> _init_xx x param
        | Scalar_Sqr                                  -> _init_xx x param
        | Scalar_Sqrt                                 -> _init_xx x param
        | Scalar_Exp                                  -> _init_xx x param
        | Scalar_Log                                  -> _init_xx x param
        | Scalar_Log2                                 -> _init_xx x param
        | Scalar_Log10                                -> _init_xx x param
        | Scalar_Signum                               -> _init_xx x param
        | Scalar_Floor                                -> _init_xx x param
        | Scalar_Ceil                                 -> _init_xx x param
        | Scalar_Round                                -> _init_xx x param
        | Scalar_Sin                                  -> _init_xx x param
        | Scalar_Cos                                  -> _init_xx x param
        | Scalar_Tan                                  -> _init_xx x param
        | Scalar_Sinh                                 -> _init_xx x param
        | Scalar_Cosh                                 -> _init_xx x param
        | Scalar_Tanh                                 -> _init_xx x param
        | Scalar_Asin                                 -> _init_xx x param
        | Scalar_Acos                                 -> _init_xx x param
        | Scalar_Atan                                 -> _init_xx x param
        | Scalar_Asinh                                -> _init_xx x param
        | Scalar_Acosh                                -> _init_xx x param
        | Scalar_Atanh                                -> _init_xx x param
        | Scalar_Relu                                 -> _init_xx x param
        | Scalar_Sigmoid                              -> _init_xx x param
        | Fused_Adagrad (rate, eps)                   -> _init_xx x param
        | _                                           -> failwith "owl_opencl_engine:_eval_term"

        with exn -> (
          Owl_log.error "Error in initialising %s" (node_to_str x);
          raise exn
        )


  and _init_xx x param = ()


  and _init_00 x param =
    let ctx, cmdq, program = param in
    allocate_from_parent_0 ctx x


  and _init_01 x param fun_name =
    let x_parent = (parents x).(0) in
    _init_term x_parent param;

    let ctx, cmdq, program = param in
    allocate_cpu_gpu_buffer ctx x;
    let i_ptr = get_gpu_ptr (get_value x_parent).(0) in
    let o_ptr = get_gpu_ptr (get_value x).(0) in

    let kernel = make_kernel x program fun_name in
    Kernel.set_arg kernel 0 sizeof_cl_mem i_ptr;
    Kernel.set_arg kernel 1 sizeof_cl_mem o_ptr


  let init_nodes xs param = Array.iter (fun x -> _init_term x param) xs



end
