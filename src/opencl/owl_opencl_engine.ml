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

  module CGInit = Owl_opencl_engine_init.Make (A)

  module CL_Dev = Owl_opencl_device.Make (A)

  include CGraph


  (* utility functions *)

  let reset_all_events x =
    Array.iter (fun v -> CL_Dev.(reset_events v)) (get_value x)


  let aggregate_events xs =
    let stack = Owl_utils_stack.make () in
    Array.iter (fun x ->
      let events = (get_value x).(0).events in
      Array.iter (fun e ->
        Owl_utils_stack.push stack e
      ) events
    ) xs;
    Owl_utils_stack.to_array stack


  let get_cpu_ptr x_val =
    let cpu_mem = CL_Dev.value_to_arr x_val in
    Ctypes.(bigarray_start genarray (Obj.magic cpu_mem))


  let get_gpu_ptr x_val =
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    Ctypes.allocate cl_mem gpu_mem


  let size_in_bytes x_val =
    let cpu_mem = CL_Dev.value_to_arr x_val in
    let n = A.numel cpu_mem in
    let elt_size = match A.number with
      | F32 -> 4
      | F64 -> 8
      | _   -> failwith "size_in_bytes: unsupported type"
    in
    n * elt_size


  let cpu_to_gpu_copy param x_val =
    let ctx, cmdq, _ = param in
    let cpu_ptr = get_cpu_ptr x_val in
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let size = size_in_bytes x_val in
    Buffer.enqueue_write ~blocking:false cmdq gpu_mem 0 size (Ctypes.to_voidp cpu_ptr)


  let gpu_to_cpu_copy param x_val =
    let ctx, cmdq, _ = param in
    let cpu_ptr = get_cpu_ptr x_val in
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let size = size_in_bytes x_val in
    Buffer.enqueue_read ~blocking:false cmdq gpu_mem 0 size (Ctypes.to_voidp cpu_ptr)


  (* update parents' validity *)

  let update_validity_1 ctx x parent =
    let parent_val = (get_value parent).(0) in
    let parent_cpu_mem = parent_val.cpu_mem.(0) in
    let x_val = (get_value x).(0) in
    let x_cpu_mem = x_val.cpu_mem.(0) in
    if x_cpu_mem == parent_cpu_mem then invalidate parent


  let update_validity_2 ctx x parent_0 parent_1 =
    let parent_0_val = (get_value parent_0).(0) in
    let parent_1_val = (get_value parent_1).(0) in
    let parent_0_cpu_mem = parent_0_val.cpu_mem.(0) in
    let parent_1_cpu_mem = parent_1_val.cpu_mem.(0) in
    let x_cpu_mem = (get_value x).(0).cpu_mem.(0) in
    if x_cpu_mem == parent_0_cpu_mem then invalidate parent_0
    else if x_cpu_mem == parent_1_cpu_mem then invalidate parent_1


  let rec _eval_term x param =
    Owl_log.debug "eval %s ..." (node_to_str x);
    reset_all_events x;

    if is_valid x = false then
      let _ = try
        match (get_operator x) with
        | Noop                                        -> _eval_map_xx x
        | Var                                         -> _eval_map_00 x param
        | Const                                       -> _eval_map_00 x param
        | Empty shape                                 -> _eval_map_xx x
        | Zeros shape                                 -> _eval_map_xx x
        | Ones shape                                  -> _eval_map_xx x
        | Create shape                                -> _eval_map_xx x
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> _eval_map_20 x param
        | Gaussian                                    -> failwith "Gaussian"
        | Bernoulli (p, shape)                        -> _eval_map_xx x
        | Init _                                      -> failwith "Init"
        | Get i                                       -> _eval_map_xx x
        | Set i                                       -> failwith "Set"
        | GetSlice slice                              -> _eval_map_xx x
        | SetSlice slice                              -> failwith "SetSlice"
        | Copy                                        -> _eval_map_xx x
        | Reset                                       -> failwith "Reset"
        | Reshape shape                               -> _eval_map_xx x
        | Reverse                                     -> _eval_map_xx x
        | Tile repeats                                -> _eval_map_xx x
        | Repeat (axis, repeats)                      -> _eval_map_xx x
        | Concatenate axis                            -> _eval_map_xx x
        | Split (axis, parts)                         -> failwith "Split"
        | Draw (axis, n)                              -> failwith "Draw"
        | Map f                                       -> failwith "Map"
        | Fold (axis, f)                              -> failwith "Fold"
        | Scan (axis, f)                              -> failwith "Scan"
        | OneHot depth                                -> _eval_map_xx x
        | Abs                                         -> _eval_map_01 x param
        | Neg                                         -> _eval_map_01 x param
        | Floor                                       -> _eval_map_01 x param
        | Ceil                                        -> _eval_map_01 x param
        | Round                                       -> _eval_map_01 x param
        | Sqr                                         -> _eval_map_01 x param
        | Sqrt                                        -> _eval_map_01 x param
        | Log                                         -> _eval_map_01 x param
        | Log2                                        -> _eval_map_01 x param
        | Log10                                       -> _eval_map_01 x param
        | Exp                                         -> _eval_map_01 x param
        | Sin                                         -> _eval_map_01 x param
        | Cos                                         -> _eval_map_01 x param
        | Tan                                         -> _eval_map_01 x param
        | Sinh                                        -> _eval_map_01 x param
        | Cosh                                        -> _eval_map_01 x param
        | Tanh                                        -> _eval_map_01 x param
        | Asin                                        -> _eval_map_01 x param
        | Acos                                        -> _eval_map_01 x param
        | Atan                                        -> _eval_map_01 x param
        | Asinh                                       -> _eval_map_01 x param
        | Acosh                                       -> _eval_map_01 x param
        | Atanh                                       -> _eval_map_01 x param
        | Min axis                                    -> _eval_map_01 x param
        | Max axis                                    -> _eval_map_01 x param
        | Sum axis                                    -> _eval_map_01 x param
        | SumReduce axis                              -> _eval_map_xx x
        | Signum                                      -> _eval_map_01 x param
        | Sigmoid                                     -> _eval_map_01 x param
        | Relu                                        -> _eval_map_01 x param
        | Min'                                        -> _eval_map_xx x
        | Max'                                        -> _eval_map_xx x
        | Sum'                                        -> _eval_map_xx x
        | L1norm'                                     -> _eval_map_xx x
        | L2norm'                                     -> _eval_map_xx x
        | L2NormSqr'                                  -> _eval_map_xx x
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> _eval_map_02 x param
        | ScalarPow                                   -> _eval_map_02 x param
        | PowScalar                                   -> _eval_map_02 x param
        | Atan2                                       -> _eval_map_02 x param
        | ScalarAtan2                                 -> _eval_map_02 x param
        | Atan2Scalar                                 -> _eval_map_02 x param
        | Hypot                                       -> _eval_map_02 x param
        | Min2                                        -> _eval_map_02 x param
        | Max2                                        -> _eval_map_02 x param
        | Add                                         -> _eval_map_02 x param
        | Sub                                         -> _eval_map_02 x param
        | Mul                                         -> _eval_map_02 x param
        | Div                                         -> _eval_map_02 x param
        | AddScalar                                   -> _eval_map_02 x param
        | SubScalar                                   -> _eval_map_02 x param
        | MulScalar                                   -> _eval_map_02 x param
        | DivScalar                                   -> _eval_map_02 x param
        | ScalarAdd                                   -> _eval_map_02 x param
        | ScalarSub                                   -> _eval_map_02 x param
        | ScalarMul                                   -> _eval_map_02 x param
        | ScalarDiv                                   -> _eval_map_02 x param
        | FMA                                         -> _eval_map_xx x
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
        | EltEqual                                    -> _eval_map_02 x param
        | EltNotEqual                                 -> _eval_map_02 x param
        | EltLess                                     -> _eval_map_02 x param
        | EltGreater                                  -> _eval_map_02 x param
        | EltLessEqual                                -> _eval_map_02 x param
        | EltGreaterEqual                             -> _eval_map_02 x param
        | EltEqualScalar                              -> _eval_map_02 x param
        | EltNotEqualScalar                           -> _eval_map_02 x param
        | EltLessScalar                               -> _eval_map_02 x param
        | EltGreaterScalar                            -> _eval_map_02 x param
        | EltLessEqualScalar                          -> _eval_map_02 x param
        | EltGreaterEqualScalar                       -> _eval_map_02 x param
        | ApproxEqual eps                             -> failwith "ApproxEqual"
        | ApproxEqualScalar eps                       -> failwith "ApproxEqualScalar"
        | ApproxEltEqual eps                          -> failwith "ApproxEltEqual"
        | ApproxEltEqualScalar eps                    -> failwith "ApproxEltEqualScalar"
        | Conv1d (padding, stride)                    -> _eval_map_xx x
        | Conv2d (padding, stride)                    -> _eval_map_xx x
        | Conv3d (padding, stride)                    -> _eval_map_xx x
        | TransposeConv2d (padding, stride)           -> _eval_map_xx x
        | MaxPool1d (padding, kernel, stride)         -> _eval_map_xx x
        | MaxPool2d (padding, kernel, stride)         -> _eval_map_xx x
        | MaxPool3d (padding, kernel, stride)         -> _eval_map_xx x
        | AvgPool1d (padding, kernel, stride)         -> _eval_map_xx x
        | AvgPool2d (padding, kernel, stride)         -> _eval_map_xx x
        | AvgPool3d (padding, kernel, stride)         -> _eval_map_xx x
        | Conv1dBackwardInput stride                  -> _eval_map_xx x
        | Conv1dBackwardKernel stride                 -> _eval_map_xx x
        | Conv2dBackwardInput stride                  -> _eval_map_xx x
        | Conv2dBackwardKernel stride                 -> _eval_map_xx x
        | Conv3dBackwardInput stride                  -> _eval_map_xx x
        | Conv3dBackwardKernel stride                 -> _eval_map_xx x
        | TransposeConv2dBackwardInput stride         -> _eval_map_xx x
        | TransposeConv2dBackwardKernel stride        -> _eval_map_xx x
        | MaxPool1dBackward (padding, kernel, stride) -> _eval_map_xx x
        | MaxPool2dBackward (padding, kernel, stride) -> _eval_map_xx x
        | MaxPool3dBackward (padding, kernel, stride) -> _eval_map_xx x
        | AvgPool1dBackward (padding, kernel, stride) -> _eval_map_xx x
        | AvgPool2dBackward (padding, kernel, stride) -> _eval_map_xx x
        | AvgPool3dBackward (padding, kernel, stride) -> _eval_map_xx x
        | Row                                         -> failwith "Row"
        | Rows i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (transa, transb, alpha, beta)           -> _eval_map_xx x
        | Inv                                         -> _eval_map_xx x
        | Trace                                       -> _eval_map_xx x
        | Transpose axis                              -> _eval_map_xx x
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | OfArray shape                               -> failwith "OfArray"
        | OfArrays                                    -> failwith "OfArrays"
        | Scalar_Add                                  -> _eval_map_xx x
        | Scalar_Sub                                  -> _eval_map_xx x
        | Scalar_Mul                                  -> _eval_map_xx x
        | Scalar_Div                                  -> _eval_map_xx x
        | Scalar_Pow                                  -> _eval_map_xx x
        | Scalar_Atan2                                -> _eval_map_xx x
        | Scalar_Abs                                  -> _eval_map_xx x
        | Scalar_Neg                                  -> _eval_map_xx x
        | Scalar_Sqr                                  -> _eval_map_xx x
        | Scalar_Sqrt                                 -> _eval_map_xx x
        | Scalar_Exp                                  -> _eval_map_xx x
        | Scalar_Log                                  -> _eval_map_xx x
        | Scalar_Log2                                 -> _eval_map_xx x
        | Scalar_Log10                                -> _eval_map_xx x
        | Scalar_Signum                               -> _eval_map_xx x
        | Scalar_Floor                                -> _eval_map_xx x
        | Scalar_Ceil                                 -> _eval_map_xx x
        | Scalar_Round                                -> _eval_map_xx x
        | Scalar_Sin                                  -> _eval_map_xx x
        | Scalar_Cos                                  -> _eval_map_xx x
        | Scalar_Tan                                  -> _eval_map_xx x
        | Scalar_Sinh                                 -> _eval_map_xx x
        | Scalar_Cosh                                 -> _eval_map_xx x
        | Scalar_Tanh                                 -> _eval_map_xx x
        | Scalar_Asin                                 -> _eval_map_xx x
        | Scalar_Acos                                 -> _eval_map_xx x
        | Scalar_Atan                                 -> _eval_map_xx x
        | Scalar_Asinh                                -> _eval_map_xx x
        | Scalar_Acosh                                -> _eval_map_xx x
        | Scalar_Atanh                                -> _eval_map_xx x
        | Scalar_Relu                                 -> _eval_map_xx x
        | Scalar_Sigmoid                              -> _eval_map_xx x
        | Fused_Adagrad (rate, eps)                   -> _eval_map_xx x
        | _                                           -> failwith "owl_opencl_engine:_eval_term"

        with exn -> (
          Owl_log.error "Error in evaluating %s" (node_to_str x);
          raise exn
        )
      in
      validate x


  (* dummy map *)
  and _eval_map_xx x = ()


  (* varibles and consts, copy cpu -> gpu *)
  and _eval_map_00 x param =
    if is_valid x = false then (
      let ctx, cmdq, program = param in
      let event = cpu_to_gpu_copy param (get_value x).(0) in
      CL_Dev.append_events (get_value x).(0) [| event |]
    )


  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map_01 x param =
    let parent = (parents x).(0) in
    _eval_term parent param;

    let ctx, cmdq, program = param in
    update_validity_1 ctx x parent;
    let kernel = (get_value x).(0).kernel.(0) in
    let items = [ node_to_arr x |> numel ] in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 items in
    CL_Dev.append_events (get_value x).(0) [| event |]


  (* [f] is inpure, for [arr -> arr -> arr] *)
  and _eval_map_02 x param =
    let parent_0 = (parents x).(0) in
    let parent_1 = (parents x).(1) in
    _eval_term parent_0 param;
    _eval_term parent_1 param;

    let ctx, cmdq, program = param in
    update_validity_2 ctx x parent_0 parent_1;
    let kernel = (get_value x).(0).kernel.(0) in
    let items = [ node_to_arr x |> numel ] in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 items in
    CL_Dev.append_events (get_value x).(0) [| event |]


  (* for random generators *)
  and _eval_map_20 x param =
    Array.iter (fun parent -> _eval_term parent param) (parents x);

    let ctx, cmdq, program = param in
    let kernel = (get_value x).(0).kernel.(0) in
    let items = [ node_to_arr x |> numel ] in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 items in
    CL_Dev.append_events (get_value x).(0) [| event |]


  let eval_arr ?(dev_id=0) xs =
    let ctx = Owl_opencl_context.(get_opencl_ctx default) in
    let dev = Owl_opencl_context.(get_dev default dev_id) in
    let cmdq = Owl_opencl_context.(get_cmdq default dev) in
    let prog = Owl_opencl_context.(get_program default) in
    let param = (ctx, cmdq, prog) in

    (* initialise the computation graph *)
    let nodes = Array.map arr_to_node xs in
    CGInit.init_nodes nodes param;

    Array.iter (fun y ->
      _eval_term y param;
      (* read the results from buffer *)
      let y_val = (get_value y).(0) in
      gpu_to_cpu_copy param y_val |> ignore
    ) nodes;

    Owl_opencl_base.CommandQueue.finish cmdq


(*
  let eval_elt xs = Array.iter (fun x -> elt_to_node x |> _eval_term) xs


  let eval_arr ?(dev_id=0) xs =
    let ctx = Owl_opencl_context.(get_opencl_ctx default) in
    let dev = Owl_opencl_context.(get_dev default dev_id) in
    let cmdq = Owl_opencl_context.(get_cmdq default dev) in
    let prog = Owl_opencl_context.(get_program default) in
    Array.iter (fun x -> arr_to_node x |> _eval_term) xs;
    Owl_opencl_base.CommandQueue.finish cmdq


  let eval_graph graph = CGraph.get_outputs graph |> Array.iter _eval_term
*)

end
