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

  let reset_all_events x =
    Array.iter (fun v -> CL_Dev.(reset_events v)) (get_value x)


  let allocate_cpu_mem x =
    if is_assigned x = false then (
      let x_shp = shape (node_to_arr x) in
      let cpu_mem = A.empty x_shp in
      let new_val = CL_Dev.make_value [|ArrVal cpu_mem|] [||] [||] in
      set_value x [| new_val |]
    )


  let allocate_gpu_mem ctx x =
    let x_val = (get_value x).(0) in
    if Array.length x_val.gpu_mem = 0 then (
      let cpu_mem = value_to_arr x_val in
      let flags = [ cl_MEM_USE_HOST_PTR ] in
      let gpu_mem = Buffer.create ~flags ctx (Obj.magic cpu_mem) in
      let new_val = CL_Dev.make_value [|ArrVal cpu_mem|] [|gpu_mem|] [||] in
      set_value x [| new_val |]
    )


  let cpu_gpu_malloc ctx x =
    allocate_cpu_mem x;
    allocate_gpu_mem ctx x


  let get_gpu_ptr x_val =
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    Ctypes.allocate cl_mem gpu_mem


  let cpu_to_gpu_copy param x_val =
    let ctx, cmdq, _ = param in
    let cpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let gpu_ptr = Ctypes.allocate cl_mem gpu_mem in
    let event = Buffer.enqueue_read cmdq cpu_mem 0 sizeof_cl_mem (Ctypes.to_voidp gpu_ptr) in
    CL_Dev.append_events x_val [| event |]


  let gpu_to_cpu_copy param x_val =
    let ctx, cmdq, _ = param in
    let cpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let gpu_ptr = Ctypes.allocate cl_mem gpu_mem in
    let event = Buffer.enqueue_write cmdq cpu_mem 0 sizeof_cl_mem (Ctypes.to_voidp gpu_ptr) in
    CL_Dev.append_events x_val [| event |]


  (* allocate memory and evaluate experssions *)

  let allocate_from_parent_0 ctx x = cpu_gpu_malloc ctx x


  let allocate_from_parent_1 ctx x parent =
    let parent_val = (get_value parent).(0) in
    let parent_cpu_mem = parent_val.cpu_mem.(0) in
    if is_assigned x = true then (
      let x_val = (get_value x).(0) in
      let x_cpu_mem = x_val.cpu_mem.(0) in
      if x_cpu_mem == parent_cpu_mem then invalidate parent
    )
    else (
      if refnum parent = 1 && get_reuse parent then (
        invalidate parent;
        let x_val = CL_Dev.copy_value parent_val in
        CL_Dev.reset_events x_val;
        set_value x [| x_val |]
      )
      else cpu_gpu_malloc ctx x
    )


  let allocate_from_parent_2 ctx x parent_0 parent_1 =
    let parent_0_val = (get_value parent_0).(0) in
    let parent_1_val = (get_value parent_1).(0) in
    if is_assigned x = true then (
      let parent_0_cpu_mem = parent_0_val.cpu_mem.(0) in
      let parent_1_cpu_mem = parent_1_val.cpu_mem.(0) in
      let x_cpu_mem = (get_value x).(0).cpu_mem.(0) in
      if x_cpu_mem == parent_0_cpu_mem then invalidate parent_0
      else if x_cpu_mem == parent_1_cpu_mem then invalidate parent_1
    )
    else (
      let shp_0 = A.shape (value_to_arr parent_0_val) in
      let shp_1 = A.shape (value_to_arr parent_1_val) in
      let shp_0, shp_1 = Owl_utils_array.align `Left 1 shp_0 shp_1 in
      let shp_x = Owl_utils.calc_broadcast_shape1 shp_0 shp_1 in

      if shp_0 = shp_x then (
        if refnum parent_0 = 1 && get_reuse parent_0 then (
          invalidate parent_0;
          let x_val = CL_Dev.copy_value parent_0_val in
          CL_Dev.reset_events x_val;
          set_value x [| x_val |]
        )
        else if refnum parent_0 = 2 && parent_0 == parent_1 && get_reuse parent_0 then (
          invalidate parent_0;
          let x_val = CL_Dev.copy_value parent_0_val in
          CL_Dev.reset_events x_val;
          set_value x [| x_val |]
        )
        else cpu_gpu_malloc ctx x
      )
      else if shp_1 = shp_x then (
        if refnum parent_1 = 1 && get_reuse parent_1 then (
          invalidate parent_1;
          let x_val = CL_Dev.copy_value parent_1_val in
          CL_Dev.reset_events x_val;
          set_value x [| x_val |]
        )
        else cpu_gpu_malloc ctx x
      )
      else cpu_gpu_malloc ctx x
    )


  let rec _eval_term x param =
    Owl_log.debug "eval %s ..." (node_to_str x);
    reset_all_events x;

    if is_valid x = false then
      let _ = try
        match (get_operator x) with
        | Noop                                        -> _eval_map_xx x
        | Var                                         -> _eval_map_98 x param
        | Const                                       -> check_assigned x
        | Empty shape                                 -> _eval_map_xx x
        | Zeros shape                                 -> _eval_map_xx x
        | Ones shape                                  -> _eval_map_xx x
        | Create shape                                -> _eval_map_xx x
        | Sequential                                  -> failwith "Sequential"
        | Uniform shape                               -> _eval_map_xx x
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
        | Abs                                         -> _eval_map_xx x
        | Neg                                         -> _eval_map_xx x
        | Floor                                       -> _eval_map_xx x
        | Ceil                                        -> _eval_map_xx x
        | Round                                       -> _eval_map_xx x
        | Sqr                                         -> _eval_map_xx x
        | Sqrt                                        -> _eval_map_xx x
        | Log                                         -> _eval_map_xx x
        | Log2                                        -> _eval_map_xx x
        | Log10                                       -> _eval_map_xx x
        | Exp                                         -> _eval_map_xx x
        | Sin                                         -> _eval_map_01 x param "owl_opencl_float32_sin"
        | Cos                                         -> _eval_map_01 x param "owl_opencl_float32_cos"
        | Tan                                         -> _eval_map_xx x
        | Sinh                                        -> _eval_map_xx x
        | Cosh                                        -> _eval_map_xx x
        | Tanh                                        -> _eval_map_xx x
        | Asin                                        -> _eval_map_xx x
        | Acos                                        -> _eval_map_xx x
        | Atan                                        -> _eval_map_xx x
        | Asinh                                       -> _eval_map_xx x
        | Acosh                                       -> _eval_map_xx x
        | Atanh                                       -> _eval_map_xx x
        | Min axis                                    -> _eval_map_xx x
        | Max axis                                    -> _eval_map_xx x
        | Sum axis                                    -> _eval_map_xx x
        | SumReduce axis                              -> _eval_map_xx x
        | Signum                                      -> _eval_map_xx x
        | Sigmoid                                     -> _eval_map_xx x
        | Relu                                        -> _eval_map_xx x
        | Min'                                        -> _eval_map_xx x
        | Max'                                        -> _eval_map_xx x
        | Sum'                                        -> _eval_map_xx x
        | L1norm'                                     -> _eval_map_xx x
        | L2norm'                                     -> _eval_map_xx x
        | L2NormSqr'                                  -> _eval_map_xx x
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> _eval_map_xx x
        | ScalarPow                                   -> _eval_map_xx x
        | PowScalar                                   -> _eval_map_xx x
        | Atan2                                       -> _eval_map_xx x
        | ScalarAtan2                                 -> _eval_map_xx x
        | Atan2Scalar                                 -> _eval_map_xx x
        | Hypot                                       -> _eval_map_xx x
        | Min2                                        -> _eval_map_xx x
        | Max2                                        -> _eval_map_xx x
        | Add                                         -> _eval_map_xx x
        | Sub                                         -> _eval_map_xx x
        | Mul                                         -> _eval_map_xx x
        | Div                                         -> _eval_map_xx x
        | AddScalar                                   -> _eval_map_xx x
        | SubScalar                                   -> _eval_map_xx x
        | MulScalar                                   -> _eval_map_xx x
        | DivScalar                                   -> _eval_map_xx x
        | ScalarAdd                                   -> _eval_map_xx x
        | ScalarSub                                   -> _eval_map_xx x
        | ScalarMul                                   -> _eval_map_xx x
        | ScalarDiv                                   -> _eval_map_xx x
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
        | EltEqual                                    -> _eval_map_xx x
        | EltNotEqual                                 -> _eval_map_xx x
        | EltLess                                     -> _eval_map_xx x
        | EltGreater                                  -> _eval_map_xx x
        | EltLessEqual                                -> _eval_map_xx x
        | EltGreaterEqual                             -> _eval_map_xx x
        | EltEqualScalar                              -> _eval_map_xx x
        | EltNotEqualScalar                           -> _eval_map_xx x
        | EltLessScalar                               -> _eval_map_xx x
        | EltGreaterScalar                            -> _eval_map_xx x
        | EltLessEqualScalar                          -> _eval_map_xx x
        | EltGreaterEqualScalar                       -> _eval_map_xx x
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
        | _                                           -> failwith "owl_lazy:_eval_term"

        with exn -> (
          Owl_log.error "Error in evaluating %s" (node_to_str x);
          raise exn
        )
      in
      validate x


  (* dummy map *)
  and _eval_map_xx x = ()


  (* [f] is pure, shape changes so always allocate mem, for [arr -> arr] *)
  and _eval_map_00 x param f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent param;
    let a = (get_value x_parent).(0) |> value_to_arr |> f in
    set_value x [|arr_to_value a|]


  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map_01 x param fun_name =
    let x_parent = (parents x).(0) in
    _eval_term x_parent param;

    let ctx, cmdq, program = param in
    allocate_from_parent_1 ctx.context x x_parent;
    let x_parent_val = (get_value x_parent).(0) in
    let i_ptr = get_gpu_ptr x_parent_val in
    let x_val = (get_value x).(0) in
    let o_ptr = get_gpu_ptr x_val in

    let kernel = Owl_opencl_context.make_kernel ctx fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem i_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem o_ptr;
    let _size = node_to_arr x |> numel in
    let wait_for = Array.to_list x_parent_val.events in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
    CL_Dev.set_events x_val [| event |]
  (*
  and _eval_map_01 x param fun_name =
    let x_parent = (parents x).(0) in
    _eval_term x_parent param;
    let a = value_to_arr (get_value x_parent).(0) in
    let out = allocate_from_parent_1 x x_parent in
    let o_val, o_mem, o_ptr = out in

    let ctx, cmdq, program = param in
    let kernel = Owl_opencl_context.make_kernel ctx fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem o_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem o_ptr;


    (* f ~out a; *)
    set_value x [|arr_to_value out|]
*)

  (* copy from cpu to gpu *)
  and _eval_map_98 x param =
    if is_valid x = false then (
      let ctx, cmdq, program = param in
      allocate_from_parent_0 ctx.context x;
      let x_val = (get_value x).(0) in
      cpu_to_gpu_copy param x_val
    )


  let eval_arr ?(dev_id=0) xs =
    let ctx = Owl_opencl_context.(get_opencl_ctx default) in
    let dev = Owl_opencl_context.(get_dev default dev_id) in
    let cmdq = Owl_opencl_context.(get_cmdq default dev) in
    let prog = Owl_opencl_context.(get_program default) in
    let param = (Owl_opencl_context.default, cmdq, prog) in
    Array.iter (fun x -> let y = arr_to_node x in _eval_term y param) xs;
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
