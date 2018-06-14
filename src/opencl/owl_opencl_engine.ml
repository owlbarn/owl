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


  let aggregate_events xs =
    let stack = Owl_utils_stack.make () in
    Array.iter (fun x ->
      let events = (get_value x).(0).events in
      Array.iter (fun e ->
        Owl_utils_stack.push stack e
      ) events
    ) xs;
    Owl_utils_stack.to_array stack


  let make_typed_kernel_name fun_name =
    match A.number with
    | F32 -> "owl_opencl_float32_" ^ fun_name
    | F64 -> "owl_opencl_float64_" ^ fun_name
    | _   -> failwith "make_typed_kernel_name"


  let make_kernel x program fun_name =
    let x_val = (get_value x).(0) in
    if Array.length x_val.kernel = 0 then (
      let typed_fun = make_typed_kernel_name fun_name in
      let kernel = Kernel.create program typed_fun in
      x_val.kernel <- [| kernel |];
    );
    x_val.kernel.(0)


  let is_cpu_gpu_malloc x =
    let x_val = get_value x in
    if Array.length x_val = 0 then false
    else if Array.length x_val.(0).gpu_mem = 0 then false
    else true


  let allocate_cpu_mem x =
    if is_assigned x = false then (
      let x_shp = shape (node_to_arr x) in
      let cpu_mem = A.empty x_shp in
      let new_val = CL_Dev.make_value [|ArrVal cpu_mem|] [||] [||] [||] in
      set_value x [| new_val |]
    )


  let allocate_gpu_mem ctx x =
    let x_val = (get_value x).(0) in
    if Array.length x_val.gpu_mem = 0 then (
      let cpu_mem = value_to_arr x_val in
      let flags = [ cl_MEM_USE_HOST_PTR ] in
      let gpu_mem = Buffer.create ~flags ctx (Obj.magic cpu_mem) in
      let new_val = CL_Dev.make_value [|ArrVal cpu_mem|] [|gpu_mem|] [||] [||] in
      set_value x [| new_val |]
    )


  let cpu_gpu_malloc ctx x =
    allocate_cpu_mem x;
    allocate_gpu_mem ctx x


  let get_cpu_ptr x_val =
    let cpu_mem = CL_Dev.value_to_arr x_val in
    Ctypes.(bigarray_start genarray (Obj.magic cpu_mem))


  let get_gpu_ptr x_val =
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    Ctypes.allocate cl_mem gpu_mem


  let get_elt_ptr x_val =
    let elt_mem = value_to_float x_val in
    Ctypes.allocate Ctypes.float elt_mem


  let cpu_to_gpu_copy param x_val =
    let ctx, cmdq, _ = param in
    let cpu_ptr = get_cpu_ptr x_val in
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let event = Buffer.enqueue_write cmdq gpu_mem 0 sizeof_cl_mem (Ctypes.to_voidp cpu_ptr) in
    CL_Dev.append_events x_val [| event |]


  let gpu_to_cpu_copy param x_val =
    let ctx, cmdq, _ = param in
    let cpu_ptr = get_cpu_ptr x_val in
    let gpu_mem = CL_Dev.(x_val.gpu_mem.(0)) in
    let event = Buffer.enqueue_read cmdq gpu_mem 0 sizeof_cl_mem (Ctypes.to_voidp cpu_ptr) in
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
        set_value x [| CL_Dev.copy_cpu_gpu_mem parent_val |]
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
      let shp_x = Owl_utils_infer_shape.broadcast1 shp_0 shp_1 in

      if shp_0 = shp_x then (
        if refnum parent_0 = 1 && get_reuse parent_0 then (
          invalidate parent_0;
          set_value x [| CL_Dev.copy_cpu_gpu_mem parent_0_val |]
        )
        else if refnum parent_0 = 2 && parent_0 == parent_1 && get_reuse parent_0 then (
          invalidate parent_0;
          set_value x [| CL_Dev.copy_cpu_gpu_mem parent_0_val |]
        )
        else cpu_gpu_malloc ctx x
      )
      else if shp_1 = shp_x then (
        if refnum parent_1 = 1 && get_reuse parent_1 then (
          invalidate parent_1;
          set_value x [| CL_Dev.copy_cpu_gpu_mem parent_1_val |]
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
        | Abs                                         -> _eval_map_01 x param "abs"
        | Neg                                         -> _eval_map_01 x param "neg"
        | Floor                                       -> _eval_map_01 x param "floor"
        | Ceil                                        -> _eval_map_01 x param "ceil"
        | Round                                       -> _eval_map_01 x param "round"
        | Sqr                                         -> _eval_map_01 x param "sqr"
        | Sqrt                                        -> _eval_map_01 x param "sqrt"
        | Log                                         -> _eval_map_01 x param "log"
        | Log2                                        -> _eval_map_01 x param "log2"
        | Log10                                       -> _eval_map_01 x param "log10"
        | Exp                                         -> _eval_map_01 x param "exp"
        | Sin                                         -> _eval_map_01 x param "sin"
        | Cos                                         -> _eval_map_01 x param "cos"
        | Tan                                         -> _eval_map_01 x param "tan"
        | Sinh                                        -> _eval_map_01 x param "sinh"
        | Cosh                                        -> _eval_map_01 x param "cosh"
        | Tanh                                        -> _eval_map_01 x param "tanh"
        | Asin                                        -> _eval_map_01 x param "asin"
        | Acos                                        -> _eval_map_01 x param "acos"
        | Atan                                        -> _eval_map_01 x param "atan"
        | Asinh                                       -> _eval_map_01 x param "asinh"
        | Acosh                                       -> _eval_map_01 x param "acosh"
        | Atanh                                       -> _eval_map_01 x param "atanh"
        | Min axis                                    -> _eval_map_xx x
        | Max axis                                    -> _eval_map_xx x
        | Sum axis                                    -> _eval_map_xx x
        | SumReduce axis                              -> _eval_map_xx x
        | Signum                                      -> _eval_map_01 x param "signum"
        | Sigmoid                                     -> _eval_map_01 x param "sigmoid"
        | Relu                                        -> _eval_map_01 x param "relu"
        | Min'                                        -> _eval_map_xx x
        | Max'                                        -> _eval_map_xx x
        | Sum'                                        -> _eval_map_xx x
        | L1norm'                                     -> _eval_map_xx x
        | L2norm'                                     -> _eval_map_xx x
        | L2NormSqr'                                  -> _eval_map_xx x
        | ClipByValue                                 -> failwith "ClipByValue"
        | ClipByL2norm                                -> failwith "ClipByL2norm"
        | Pow                                         -> _eval_map_02 x param "pow"
        | ScalarPow                                   -> _eval_map_04 x param "scalar_pow"
        | PowScalar                                   -> _eval_map_03 x param "pow_scalar"
        | Atan2                                       -> _eval_map_02 x param "atan2"
        | ScalarAtan2                                 -> _eval_map_04 x param "scalar_atan2"
        | Atan2Scalar                                 -> _eval_map_03 x param "atan2_scalar"
        | Hypot                                       -> _eval_map_02 x param "hypot"
        | Min2                                        -> _eval_map_02 x param "min2"
        | Max2                                        -> _eval_map_02 x param "max2"
        | Add                                         -> _eval_map_02 x param "add"
        | Sub                                         -> _eval_map_02 x param "sub"
        | Mul                                         -> _eval_map_02 x param "mul"
        | Div                                         -> _eval_map_02 x param "div"
        | AddScalar                                   -> _eval_map_03 x param "add_scalar"
        | SubScalar                                   -> _eval_map_03 x param "sub_scalar"
        | MulScalar                                   -> _eval_map_03 x param "mul_scalar"
        | DivScalar                                   -> _eval_map_03 x param "div_scalar"
        | ScalarAdd                                   -> _eval_map_04 x param "scalar_add"
        | ScalarSub                                   -> _eval_map_04 x param "scalar_sub"
        | ScalarMul                                   -> _eval_map_04 x param "scalar_mul"
        | ScalarDiv                                   -> _eval_map_04 x param "scalar_div"
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
        | EltEqual                                    -> _eval_map_02 x param "elt_equal"
        | EltNotEqual                                 -> _eval_map_02 x param "elt_not_equal"
        | EltLess                                     -> _eval_map_02 x param "elt_less"
        | EltGreater                                  -> _eval_map_02 x param "elt_greater"
        | EltLessEqual                                -> _eval_map_02 x param "elt_less_equal"
        | EltGreaterEqual                             -> _eval_map_02 x param "elt_greater_equal"
        | EltEqualScalar                              -> _eval_map_03 x param "elt_equal_scalar"
        | EltNotEqualScalar                           -> _eval_map_03 x param "elt_not_equal_scalar"
        | EltLessScalar                               -> _eval_map_03 x param "elt_less_scalar"
        | EltGreaterScalar                            -> _eval_map_03 x param "elt_greater_scalar"
        | EltLessEqualScalar                          -> _eval_map_03 x param "elt_less_equal_scalar"
        | EltGreaterEqualScalar                       -> _eval_map_03 x param "elt_greater_equal_scalar"
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
    allocate_from_parent_1 ctx x x_parent;
    let x_parent_val = (get_value x_parent).(0) in
    let i_ptr = get_gpu_ptr x_parent_val in
    let o_ptr = get_gpu_ptr (get_value x).(0) in

    let kernel = make_kernel x program fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem i_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem o_ptr;
    let _size = node_to_arr x |> numel in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
    CL_Dev.append_events (get_value x).(0) [| event |]


  (* [f] is inpure, for [arr -> arr -> arr] *)
  and _eval_map_02 x param fun_name =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0 param;
    _eval_term x_parent_1 param;

    let ctx, cmdq, program = param in
    allocate_from_parent_2 ctx x x_parent_0 x_parent_1;
    let a_ptr = (get_value x_parent_0).(0) |> get_gpu_ptr in
    let b_ptr = (get_value x_parent_1).(0) |> get_gpu_ptr in
    let c_ptr = (get_value x).(0) |> get_gpu_ptr in

    let kernel = make_kernel x program fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 2 sizeof_cl_mem c_ptr;
    let _size = node_to_arr x |> numel in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
    CL_Dev.append_events (get_value x).(0) [| event |]


  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map_03 x param fun_name =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0 param;
    _eval_term x_parent_1 param;

    let ctx, cmdq, program = param in
    allocate_from_parent_1 ctx x x_parent_0;
    let a_ptr = (get_value x_parent_0).(0) |> get_gpu_ptr in
    let b_ptr = (get_value x_parent_1).(0) |> get_elt_ptr in
    let c_ptr = (get_value x).(0) |> get_gpu_ptr in

    let kernel = make_kernel x program fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_float_ptr b_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 2 sizeof_cl_mem c_ptr;
    let _size = node_to_arr x |> numel in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
    CL_Dev.append_events (get_value x).(0) [| event |]


  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map_04 x param fun_name =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0 param;
    _eval_term x_parent_1 param;

    let ctx, cmdq, program = param in
    allocate_from_parent_1 ctx x x_parent_1;
    let a_ptr = (get_value x_parent_1).(0) |> get_elt_ptr in
    let b_ptr = (get_value x_parent_0).(0) |> get_gpu_ptr in
    let c_ptr = (get_value x).(0) |> get_gpu_ptr in

    let kernel = make_kernel x program fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_float_ptr a_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 2 sizeof_cl_mem c_ptr;
    let _size = node_to_arr x |> numel in
    let wait_for = aggregate_events (parents x) |> Array.to_list in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
    CL_Dev.append_events (get_value x).(0) [| event |]


  (* copy from cpu to gpu *)
  and _eval_map_98 x param =
    if is_valid x = false then (
      let ctx, cmdq, program = param in
      allocate_from_parent_0 ctx x;
      let x_val = (get_value x).(0) in
      cpu_to_gpu_copy param x_val
    )


  let eval_arr ?(dev_id=0) xs =
    let ctx = Owl_opencl_context.(get_opencl_ctx default) in
    let dev = Owl_opencl_context.(get_dev default dev_id) in
    let cmdq = Owl_opencl_context.(get_cmdq default dev) in
    let prog = Owl_opencl_context.(get_program default) in
    let param = (ctx, cmdq, prog) in
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
