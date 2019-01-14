(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph

open Owl_opencl_base


(* Functor of making an OpenCL engine to execute a computation graph. *)

module Make
  (Device : Owl_types_computation_opencl_device.Sig)
  = struct

  module Graph = Owl_computation_engine.Make_Graph (Device)

  open Graph.Optimiser.Operator.Symbol

  open Graph.Optimiser.Operator.Symbol.Shape.Type.Device


  (* utility functions *)

  let reset_all_events x =
    Array.iter (fun v -> Device.reset_events v) (get_value x)


  let aggregate_events xs =
    let stack = Owl_utils_stack.make () in
    Array.iter (fun x ->
      let events = (get_value x).(0).events in
      Array.iter (fun e ->
        Owl_utils_stack.push stack e
      ) events
    ) xs;
    Owl_utils_stack.to_array stack


  let size_in_bytes x_val =
    let cpu_mem = Device.value_to_arr x_val in
    let n = A.numel cpu_mem in
    let elt_size = match A.number with
      | F32 -> 4
      | F64 -> 8
      | _   -> failwith "size_in_bytes: unsupported type"
    in
    n * elt_size


  let cpu_to_gpu_copy param x_val =
    let _, cmdq, _ = param in
    let cpu_ptr = Device.get_cpu_ptr x_val in
    let gpu_mem = Device.get_gpu_mem x_val in
    let size = size_in_bytes x_val in
    Buffer.enqueue_write ~blocking:false cmdq gpu_mem 0 size cpu_ptr


  let gpu_to_cpu_copy param x_val =
    let _, cmdq, _ = param in
    let cpu_ptr = Device.get_cpu_ptr x_val in
    let gpu_mem = Device.get_gpu_mem x_val in
    let size = size_in_bytes x_val in
    Buffer.enqueue_read ~blocking:false cmdq gpu_mem 0 size cpu_ptr


  (* update parents' validity *)

  let update_validity x =
    validate x;
    Array.iter invalidate (get_vnode x)


  let rec _eval_term x param =
    Owl_log.debug "eval %s ..." (node_to_str x);
    reset_all_events x;

    if is_valid x = false then
      let _ = try
        match (get_operator x) with
        | Noop                                        -> _eval_map_xx x
        | Var                                         -> _eval_map_00 x param
        | Const                                       -> _eval_map_00 x param
        | Empty _shape                                 -> _eval_map_00 x param
        | Zeros _shape                                 -> _eval_map_01 x param
        | Ones _shape                                  -> _eval_map_01 x param
        | Create _shape                                -> _eval_map_01 x param
        | Sequential _shape                            -> _eval_map_01 x param
        | Uniform _shape                               -> _eval_map_02 x param
        | Gaussian _shape                              -> _eval_map_02 x param
        | Bernoulli _shape                             -> _eval_map_02 x param
        | Init (_shape, _f)                             -> failwith "Init"
        | Get _i                                       -> _eval_map_xx x
        | Set _i                                       -> failwith "Set"
        | GetSlice _slice                              -> _eval_map_xx x
        | SetSlice _slice                              -> failwith "SetSlice"
        | Copy                                        -> _eval_map_xx x
        | Reset                                       -> failwith "Reset"
        | Reshape _shape                               -> _eval_map_xx x
        | Reverse                                     -> _eval_map_xx x
        | Tile _repeats                                -> _eval_map_xx x
        | Repeat _repeats                              -> _eval_map_xx x
        | Concatenate _axis                            -> _eval_map_xx x
        | Split (_axis, _parts)                         -> failwith "Split"
        | Draw (_axis, _n)                              -> failwith "Draw"
        | Map _f                                       -> failwith "Map"
        | Fold (_axis, _f)                              -> failwith "Fold"
        | Scan (_axis, _f)                              -> failwith "Scan"
        | OneHot _depth                                -> _eval_map_xx x
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
        | Min _axis                                    -> _eval_map_01 x param
        | Max _axis                                    -> _eval_map_01 x param
        | Sum _axis                                    -> _eval_map_01 x param
        | SumReduce _axis                              -> _eval_map_xx x
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
        | Pow                                         -> _eval_map_01 x param
        | ScalarPow                                   -> _eval_map_01 x param
        | PowScalar                                   -> _eval_map_01 x param
        | Atan2                                       -> _eval_map_01 x param
        | ScalarAtan2                                 -> _eval_map_01 x param
        | Atan2Scalar                                 -> _eval_map_01 x param
        | Hypot                                       -> _eval_map_01 x param
        | Min2                                        -> _eval_map_01 x param
        | Max2                                        -> _eval_map_01 x param
        | Add                                         -> _eval_map_01 x param
        | Sub                                         -> _eval_map_01 x param
        | Mul                                         -> _eval_map_01 x param
        | Div                                         -> _eval_map_01 x param
        | AddScalar                                   -> _eval_map_01 x param
        | SubScalar                                   -> _eval_map_01 x param
        | MulScalar                                   -> _eval_map_01 x param
        | DivScalar                                   -> _eval_map_01 x param
        | ScalarAdd                                   -> _eval_map_01 x param
        | ScalarSub                                   -> _eval_map_01 x param
        | ScalarMul                                   -> _eval_map_01 x param
        | ScalarDiv                                   -> _eval_map_01 x param
        | FMA                                         -> _eval_map_xx x
        | EltEqual                                    -> _eval_map_01 x param
        | EltNotEqual                                 -> _eval_map_01 x param
        | EltLess                                     -> _eval_map_01 x param
        | EltGreater                                  -> _eval_map_01 x param
        | EltLessEqual                                -> _eval_map_01 x param
        | EltGreaterEqual                             -> _eval_map_01 x param
        | EltEqualScalar                              -> _eval_map_01 x param
        | EltNotEqualScalar                           -> _eval_map_01 x param
        | EltLessScalar                               -> _eval_map_01 x param
        | EltGreaterScalar                            -> _eval_map_01 x param
        | EltLessEqualScalar                          -> _eval_map_01 x param
        | EltGreaterEqualScalar                       -> _eval_map_01 x param
        | Conv1d (_padding, _stride)                    -> _eval_map_xx x
        | Conv2d (_padding, _stride)                    -> _eval_map_xx x
        | Conv3d (_padding, _stride)                    -> _eval_map_xx x
        | TransposeConv2d (_padding, _stride)           -> _eval_map_xx x
        | MaxPool1d (_padding, _kernel, _stride)         -> _eval_map_xx x
        | MaxPool2d (_padding, _kernel, _stride)         -> _eval_map_xx x
        | MaxPool3d (_padding, _kernel, _stride)         -> _eval_map_xx x
        | AvgPool1d (_padding, _kernel, _stride)         -> _eval_map_xx x
        | AvgPool2d (_padding, _kernel, _stride)         -> _eval_map_xx x
        | AvgPool3d (_padding, _kernel, _stride)         -> _eval_map_xx x
        | Conv1dBackwardInput _stride                  -> _eval_map_xx x
        | Conv1dBackwardKernel _stride                 -> _eval_map_xx x
        | Conv2dBackwardInput _stride                  -> _eval_map_xx x
        | Conv2dBackwardKernel _stride                 -> _eval_map_xx x
        | Conv3dBackwardInput _stride                  -> _eval_map_xx x
        | Conv3dBackwardKernel _stride                 -> _eval_map_xx x
        | TransposeConv2dBackwardInput _stride         -> _eval_map_xx x
        | TransposeConv2dBackwardKernel _stride        -> _eval_map_xx x
        | MaxPool1dBackward (_padding, _kernel, _stride) -> _eval_map_xx x
        | MaxPool2dBackward (_padding, _kernel, _stride) -> _eval_map_xx x
        | MaxPool3dBackward (_padding, _kernel, _stride) -> _eval_map_xx x
        | AvgPool1dBackward (_padding, _kernel, _stride) -> _eval_map_xx x
        | AvgPool2dBackward (_padding, _kernel, _stride) -> _eval_map_xx x
        | AvgPool3dBackward (_padding, _kernel, _stride) -> _eval_map_xx x
        | Row                                         -> failwith "Row"
        | Rows _i                                      -> failwith "Rows"
        | CopyRowTo                                   -> failwith "CopyRowTo"
        | CopyColTo                                   -> failwith "CopyColTo"
        | Dot (_transa, _transb, _alpha, _beta)           -> _eval_map_xx x
        | Inv                                         -> _eval_map_xx x
        | Trace                                       -> _eval_map_xx x
        | Transpose _axis                              -> _eval_map_xx x
        | ToRows                                      -> failwith "ToRows"
        | OfRows                                      -> failwith "OfRows"
        | Scalar_Add                                  -> _eval_map_01 x param
        | Scalar_Sub                                  -> _eval_map_01 x param
        | Scalar_Mul                                  -> _eval_map_01 x param
        | Scalar_Div                                  -> _eval_map_01 x param
        | Scalar_Pow                                  -> _eval_map_01 x param
        | Scalar_Atan2                                -> _eval_map_01 x param
        | Scalar_Abs                                  -> _eval_map_01 x param
        | Scalar_Neg                                  -> _eval_map_01 x param
        | Scalar_Sqr                                  -> _eval_map_01 x param
        | Scalar_Sqrt                                 -> _eval_map_01 x param
        | Scalar_Exp                                  -> _eval_map_01 x param
        | Scalar_Log                                  -> _eval_map_01 x param
        | Scalar_Log2                                 -> _eval_map_01 x param
        | Scalar_Log10                                -> _eval_map_01 x param
        | Scalar_Signum                               -> _eval_map_01 x param
        | Scalar_Floor                                -> _eval_map_01 x param
        | Scalar_Ceil                                 -> _eval_map_01 x param
        | Scalar_Round                                -> _eval_map_01 x param
        | Scalar_Sin                                  -> _eval_map_01 x param
        | Scalar_Cos                                  -> _eval_map_01 x param
        | Scalar_Tan                                  -> _eval_map_01 x param
        | Scalar_Sinh                                 -> _eval_map_01 x param
        | Scalar_Cosh                                 -> _eval_map_01 x param
        | Scalar_Tanh                                 -> _eval_map_01 x param
        | Scalar_Asin                                 -> _eval_map_01 x param
        | Scalar_Acos                                 -> _eval_map_01 x param
        | Scalar_Atan                                 -> _eval_map_01 x param
        | Scalar_Asinh                                -> _eval_map_01 x param
        | Scalar_Acosh                                -> _eval_map_01 x param
        | Scalar_Atanh                                -> _eval_map_01 x param
        | Scalar_Relu                                 -> _eval_map_01 x param
        | Scalar_Sigmoid                              -> _eval_map_01 x param
        | Fused_Adagrad (_rate, _eps)                   -> _eval_map_xx x
        | _                                           -> failwith "owl_opencl_engine:_eval_term"

        with exn -> (
          Owl_log.error "Error in evaluating %s" (node_to_str x);
          raise exn
        )
      in
      update_validity x


  (* dummy map *)
  and _eval_map_xx _ = ()


  (* varibles and consts, copy cpu -> gpu *)
  and _eval_map_00 x param =
    if is_valid x = false then (
      let event = cpu_to_gpu_copy param (get_value x).(0) in
      Device.append_events (get_value x).(0) [| event |]
    )


  (* [f] is inpure, for [arr array -> arr] *)
  and _eval_map_01 x param =
    Array.iter (fun parent -> _eval_term parent param) (parents x);

    let _, cmdq, _ = param in
    let kernel = (get_value x).(0).kernel.(0) in
    let items = [ node_numel x ] in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 items in
    Device.append_events (get_value x).(0) [| event |]


  (* [f] is inpure, for [arr array -> arr], for PRNG *)
  and _eval_map_02 x param =
    Array.iter (fun parent -> _eval_term parent param) (parents x);

    let _, cmdq, _ = param in
    let kernel = (get_value x).(0).kernel.(0) in

    let numpu = Owl_opencl_hardware.processing_units () in
    let limit = node_numel x in
    let items = [ Owl_opencl_utils.calc_opt_chunk numpu limit |> fst ] in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 items in
    Device.append_events (get_value x).(0) [| event |]


end
