(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph
open Owl_opencl_base
open Owl_opencl_utils
open Owl_opencl_generated

(* Functor of initialising an OpenCL engine to execute a computation graph. *)

module Make (Device : Owl_types_computation_opencl_device.Sig) = struct
  module Graph = Owl_computation_engine.Make_Graph (Device)
  open Graph.Optimiser.Operator.Symbol
  open Graph.Optimiser.Operator.Symbol.Shape.Type.Device

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
    if is_assigned x = false
    then (
      let x_shp = node_shape x in
      let cpu_mem = A.empty x_shp in
      let new_val = Device.make_value [| cpu_mem |] [||] [||] [||] in
      set_value x [| new_val |])


  let allocate_gpu_buffer ctx x =
    let x_val = (get_value x).(0) in
    if Array.length x_val.gpu_mem = 0
    then (
      let cpu_mem = value_to_arr x_val in
      let flags = [ cl_MEM_USE_HOST_PTR ] in
      let gpu_mem = Buffer.create_bigarray ~flags ctx (Obj.magic cpu_mem) in
      let new_val = Device.make_value [| cpu_mem |] [| gpu_mem |] [||] [||] in
      set_value x [| new_val |])


  let allocate_cpu_gpu_buffer ctx x =
    allocate_cpu_buffer x;
    allocate_gpu_buffer ctx x


  let allocate_from_parent_0 ctx x = allocate_cpu_gpu_buffer ctx x

  let allocate_from_parent_1 ctx x parent =
    let parent_val = (get_value parent).(0) in
    if refnum parent = 1 && get_reuse parent
    then (
      set_value x [| Device.refer_value parent_val |];
      set_vnode x [| parent |])
    else allocate_cpu_gpu_buffer ctx x


  let allocate_from_parent_2 ctx x parent_0 parent_1 =
    let parent_0_val = (get_value parent_0).(0) in
    let parent_1_val = (get_value parent_1).(0) in
    let shp_0 = A.shape (value_to_arr parent_0_val) in
    let shp_1 = A.shape (value_to_arr parent_1_val) in
    let shp_0, shp_1 = Owl_utils_array.align `Left 1 shp_0 shp_1 in
    let shp_x = Owl_utils_infer_shape.broadcast1 shp_0 shp_1 in
    if shp_0 = shp_x && refnum parent_0 = 1 && get_reuse parent_0
    then (
      set_value x [| Device.refer_value parent_0_val |];
      set_vnode x [| parent_0 |])
    else if shp_1 = shp_x && refnum parent_1 = 1 && get_reuse parent_1
    then (
      set_value x [| Device.refer_value parent_1_val |];
      set_vnode x [| parent_1 |])
    else allocate_cpu_gpu_buffer ctx x


  (* a node is initialised iff the kernel is allocated *)
  let is_initialised x =
    let x_val = get_value x in
    if Array.length x_val = 0 then false else Array.length x_val.(0).kernel > 0


  let rec _init_term x param =
    Owl_log.debug "init %s ..." (node_to_str x);
    if is_initialised x = false
    then (
      try
        match get_operator x with
        | Noop -> _init_xx x param
        | Var -> _init_00 x param
        | Const -> _init_00 x param
        | Empty _shape -> _init_00 x param
        | Zeros _shape -> _init_10 x param "zeros"
        | Ones _shape -> _init_10 x param "ones"
        | Create _shape -> _init_10 x param "create"
        | Sequential _shape -> _init_10 x param "sequential"
        | Uniform _shape -> _init_20 x param "uniform"
        | Gaussian _shape -> _init_20 x param "gaussian"
        | Bernoulli _shape -> _init_20 x param "bernoulli"
        | Init (_shape, _f) -> failwith "Init"
        | Get _i -> _init_xx x param
        | Set _i -> failwith "Set"
        | GetSlice _slice -> _init_xx x param
        | SetSlice _slice -> failwith "SetSlice"
        | Copy -> _init_xx x param
        | Reset -> failwith "Reset"
        | Reshape _shape -> _init_xx x param
        | Reverse -> _init_xx x param
        | Tile _repeats -> _init_xx x param
        | Repeat _repeats -> _init_xx x param
        | Concatenate _axis -> _init_xx x param
        | Split (_axis, _parts) -> failwith "Split"
        | Draw (_axis, _n) -> failwith "Draw"
        | Map _f -> failwith "Map"
        | Fold (_axis, _f) -> failwith "Fold"
        | Scan (_axis, _f) -> failwith "Scan"
        | OneHot _depth -> _init_xx x param
        | Abs -> _init_01 x param "abs"
        | Neg -> _init_01 x param "neg"
        | Floor -> _init_01 x param "floor"
        | Ceil -> _init_01 x param "ceil"
        | Round -> _init_01 x param "round"
        | Sqr -> _init_01 x param "sqr"
        | Sqrt -> _init_01 x param "sqrt"
        | Log -> _init_01 x param "log"
        | Log2 -> _init_01 x param "log2"
        | Log10 -> _init_01 x param "log10"
        | Exp -> _init_01 x param "exp"
        | Sin -> _init_01 x param "sin"
        | Cos -> _init_01 x param "cos"
        | Tan -> _init_01 x param "tan"
        | Sinh -> _init_01 x param "sinh"
        | Cosh -> _init_01 x param "cosh"
        | Tanh -> _init_01 x param "tanh"
        | Asin -> _init_01 x param "asin"
        | Acos -> _init_01 x param "acos"
        | Atan -> _init_01 x param "atan"
        | Asinh -> _init_01 x param "asinh"
        | Acosh -> _init_01 x param "acosh"
        | Atanh -> _init_01 x param "atanh"
        | Min axis -> _init_05 x param "min_along" axis
        | Max axis -> _init_05 x param "max_along" axis
        | Sum axis -> _init_05 x param "sum_along" axis
        | SumReduce _axis -> _init_xx x param
        | Signum -> _init_01 x param "signum"
        | Sigmoid -> _init_01 x param "sigmoid"
        | Relu -> _init_01 x param "relu"
        | Min' -> _init_xx x param
        | Max' -> _init_xx x param
        | Sum' -> _init_xx x param
        | L1norm' -> _init_xx x param
        | L2norm' -> _init_xx x param
        | L2NormSqr' -> _init_xx x param
        | ClipByValue -> failwith "ClipByValue"
        | ClipByL2norm -> failwith "ClipByL2norm"
        | Pow -> _init_02 x param "pow"
        | ScalarPow -> _init_03 x param "scalar_pow"
        | PowScalar -> _init_03 x param "pow_scalar"
        | Atan2 -> _init_02 x param "atan2"
        | ScalarAtan2 -> _init_03 x param "scalar_atan2"
        | Atan2Scalar -> _init_03 x param "atan2_scalar"
        | Hypot -> _init_02 x param "hypot"
        | Min2 -> _init_02 x param "min2"
        | Max2 -> _init_02 x param "max2"
        | Add -> _init_02 x param "add"
        | Sub -> _init_02 x param "sub"
        | Mul -> _init_02 x param "mul"
        | Div -> _init_02 x param "div"
        | AddScalar -> _init_03 x param "add_scalar"
        | SubScalar -> _init_03 x param "sub_scalar"
        | MulScalar -> _init_03 x param "mul_scalar"
        | DivScalar -> _init_03 x param "div_scalar"
        | ScalarAdd -> _init_03 x param "scalar_add"
        | ScalarSub -> _init_03 x param "scalar_sub"
        | ScalarMul -> _init_03 x param "scalar_mul"
        | ScalarDiv -> _init_03 x param "scalar_div"
        | FMA -> _init_xx x param
        | EltEqual -> _init_02 x param "elt_equal"
        | EltNotEqual -> _init_02 x param "elt_not_equal"
        | EltLess -> _init_02 x param "elt_less"
        | EltGreater -> _init_02 x param "elt_greater"
        | EltLessEqual -> _init_02 x param "elt_less_equal"
        | EltGreaterEqual -> _init_02 x param "elt_greater_equal"
        | EltEqualScalar -> _init_03 x param "elt_equal_scalar"
        | EltNotEqualScalar -> _init_03 x param "elt_not_equal_scalar"
        | EltLessScalar -> _init_03 x param "elt_less_scalar"
        | EltGreaterScalar -> _init_03 x param "elt_greater_scalar"
        | EltLessEqualScalar -> _init_03 x param "elt_less_equal_scalar"
        | EltGreaterEqualScalar -> _init_03 x param "elt_greater_equal_scalar"
        | Conv1d (_padding, _stride) -> _init_xx x param
        | Conv2d (_padding, _stride) -> _init_xx x param
        | Conv3d (_padding, _stride) -> _init_xx x param
        | TransposeConv2d (_padding, _stride) -> _init_xx x param
        | MaxPool1d (_padding, _kernel, _stride) -> _init_xx x param
        | MaxPool2d (_padding, _kernel, _stride) -> _init_xx x param
        | MaxPool3d (_padding, _kernel, _stride) -> _init_xx x param
        | AvgPool1d (_padding, _kernel, _stride) -> _init_xx x param
        | AvgPool2d (_padding, _kernel, _stride) -> _init_xx x param
        | AvgPool3d (_padding, _kernel, _stride) -> _init_xx x param
        | Conv1dBackwardInput _stride -> _init_xx x param
        | Conv1dBackwardKernel _stride -> _init_xx x param
        | Conv2dBackwardInput _stride -> _init_xx x param
        | Conv2dBackwardKernel _stride -> _init_xx x param
        | Conv3dBackwardInput _stride -> _init_xx x param
        | Conv3dBackwardKernel _stride -> _init_xx x param
        | TransposeConv2dBackwardInput _stride -> _init_xx x param
        | TransposeConv2dBackwardKernel _stride -> _init_xx x param
        | MaxPool1dBackward (_padding, _kernel, _stride) -> _init_xx x param
        | MaxPool2dBackward (_padding, _kernel, _stride) -> _init_xx x param
        | MaxPool3dBackward (_padding, _kernel, _stride) -> _init_xx x param
        | AvgPool1dBackward (_padding, _kernel, _stride) -> _init_xx x param
        | AvgPool2dBackward (_padding, _kernel, _stride) -> _init_xx x param
        | AvgPool3dBackward (_padding, _kernel, _stride) -> _init_xx x param
        | Row -> failwith "Row"
        | Rows _i -> failwith "Rows"
        | CopyRowTo -> failwith "CopyRowTo"
        | CopyColTo -> failwith "CopyColTo"
        | Dot (_transa, _transb, _alpha, _beta) -> _init_xx x param
        | Inv -> _init_xx x param
        | Trace -> _init_xx x param
        | Transpose _axis -> _init_xx x param
        | ToRows -> failwith "ToRows"
        | OfRows -> failwith "OfRows"
        | Scalar_Add -> _init_03 x param "add"
        | Scalar_Sub -> _init_03 x param "sub"
        | Scalar_Mul -> _init_03 x param "mul"
        | Scalar_Div -> _init_03 x param "div"
        | Scalar_Pow -> _init_03 x param "pow"
        | Scalar_Atan2 -> _init_03 x param "atan2"
        | Scalar_Abs -> _init_01 x param "abs"
        | Scalar_Neg -> _init_01 x param "neg"
        | Scalar_Sqr -> _init_01 x param "sqr"
        | Scalar_Sqrt -> _init_01 x param "sqrt"
        | Scalar_Exp -> _init_01 x param "exp"
        | Scalar_Log -> _init_01 x param "log"
        | Scalar_Log2 -> _init_01 x param "log2"
        | Scalar_Log10 -> _init_01 x param "log10"
        | Scalar_Signum -> _init_01 x param "signum"
        | Scalar_Floor -> _init_01 x param "floor"
        | Scalar_Ceil -> _init_01 x param "ceil"
        | Scalar_Round -> _init_01 x param "round"
        | Scalar_Sin -> _init_01 x param "sin"
        | Scalar_Cos -> _init_01 x param "cos"
        | Scalar_Tan -> _init_01 x param "tan"
        | Scalar_Sinh -> _init_01 x param "sinh"
        | Scalar_Cosh -> _init_01 x param "cosh"
        | Scalar_Tanh -> _init_01 x param "tanh"
        | Scalar_Asin -> _init_01 x param "asin"
        | Scalar_Acos -> _init_01 x param "acos"
        | Scalar_Atan -> _init_01 x param "atan"
        | Scalar_Asinh -> _init_01 x param "asinh"
        | Scalar_Acosh -> _init_01 x param "acosh"
        | Scalar_Atanh -> _init_01 x param "atanh"
        | Scalar_Relu -> _init_01 x param "relu"
        | Scalar_Sigmoid -> _init_01 x param "sigmoid"
        | Fused_Adagrad (_rate, _eps) -> _init_xx x param
        | _ -> failwith "owl_opencl_engine:_eval_term"
      with
      | exn ->
        Owl_log.error "Error in initialising %s" (node_to_str x);
        raise exn)


  and _init_xx _ _ = ()

  (* variables, consts, creation *)
  and _init_00 x param =
    let ctx, _, _ = param in
    allocate_from_parent_0 ctx x


  (* f : arr -> arr *)
  and _init_01 x param fun_name =
    let parent = (parents x).(0) in
    _init_term parent param;
    let ctx, _, program = param in
    allocate_from_parent_1 ctx x parent;
    let a_ptr = Device.get_gpu_ptr (get_value parent).(0) in
    let b_ptr = Device.get_gpu_ptr (get_value x).(0) in
    let kernel = make_kernel x program fun_name in
    Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
    Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr


  (* f : arr -> arr -> arr *)
  and _init_02 x param fun_name =
    let parent_0 = (parents x).(0) in
    let parent_1 = (parents x).(1) in
    _init_term parent_0 param;
    _init_term parent_1 param;
    let parent_0_val = (get_value parent_0).(0) in
    let parent_1_val = (get_value parent_1).(0) in
    let shp_0 = A.shape (value_to_arr parent_0_val) in
    let shp_1 = A.shape (value_to_arr parent_1_val) in
    if Owl_utils_infer_shape.require_broadcasting shp_0 shp_1
    then _init_04 x param fun_name
    else _init_03 x param fun_name


  (* f : arr -> arr -> arr, non-broadcasting *)
  and _init_03 x param fun_name =
    let parent_0 = (parents x).(0) in
    let parent_1 = (parents x).(1) in
    _init_term parent_0 param;
    _init_term parent_1 param;
    let ctx, _, program = param in
    allocate_from_parent_2 ctx x parent_0 parent_1;
    let a_ptr = Device.get_gpu_ptr (get_value parent_0).(0) in
    let b_ptr = Device.get_gpu_ptr (get_value parent_1).(0) in
    let c_ptr = Device.get_gpu_ptr (get_value x).(0) in
    let kernel = make_kernel x program fun_name in
    Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
    Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
    Kernel.set_arg kernel 2 sizeof_cl_mem c_ptr


  (* f : arr -> arr -> arr, broadcasting operation *)
  and _init_04 x param fun_name =
    let parent_0 = (parents x).(0) in
    let parent_1 = (parents x).(1) in
    _init_term parent_0 param;
    _init_term parent_1 param;
    let ctx, _, program = param in
    allocate_from_parent_2 ctx x parent_0 parent_1;
    let parent_0_val = (get_value parent_0).(0) in
    let parent_1_val = (get_value parent_1).(0) in
    let x_val = (get_value x).(0) in
    let a_ptr = Device.get_gpu_ptr parent_0_val in
    let b_ptr = Device.get_gpu_ptr parent_1_val in
    let c_ptr = Device.get_gpu_ptr x_val in
    let dim = A.shape (value_to_arr x_val) |> Array.length in
    let dim_i32 = Int32.of_int dim in
    let dim_ptr = Ctypes.(allocate int32_t dim_i32) in
    let sizeof_int32 = Ctypes.(sizeof (ptr int32_t)) in
    let a_shp = A.shape (value_to_arr parent_0_val) in
    let b_shp = A.shape (value_to_arr parent_1_val) in
    let a_stride, b_stride = Owl_utils_infer_shape.broadcast1_stride a_shp b_shp in
    let a_stride = Array.map Int32.of_int a_stride in
    let b_stride = Array.map Int32.of_int b_stride in
    let a_stride = Owl_dense_ndarray_generic.of_array Int32 a_stride [| dim |] in
    let b_stride = Owl_dense_ndarray_generic.of_array Int32 b_stride [| dim |] in
    let flags = [ cl_MEM_USE_HOST_PTR ] in
    let a_stride_ptr =
      Buffer.create_bigarray ~flags ctx a_stride |> Ctypes.allocate cl_mem
    in
    let b_stride_ptr =
      Buffer.create_bigarray ~flags ctx b_stride |> Ctypes.allocate cl_mem
    in
    let new_name = "broadcast_" ^ fun_name in
    let kernel = make_kernel x program new_name in
    Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
    Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
    Kernel.set_arg kernel 2 sizeof_cl_mem c_ptr;
    Kernel.set_arg kernel 3 sizeof_int32 dim_ptr;
    Kernel.set_arg kernel 4 sizeof_int32 a_stride_ptr;
    Kernel.set_arg kernel 5 sizeof_int32 b_stride_ptr


  (* f : arr -> arr, reduce operation *)
  and _init_05 x param fun_name axis =
    let parent = (parents x).(0) in
    _init_term parent param;
    let ctx, _, program = param in
    allocate_from_parent_0 ctx x;
    let a_ptr = Device.get_gpu_ptr (get_value parent).(0) in
    let b_ptr = Device.get_gpu_ptr (get_value x).(0) in
    let parent_shape = A.shape (value_to_arr (get_value parent).(0)) in
    let dim_i32 = Int32.of_int parent_shape.(axis) in
    let dim_ptr = Ctypes.(allocate int32_t dim_i32) in
    let stride = Owl_utils_ndarray.calc_stride parent_shape in
    let stride_i32 = Int32.of_int stride.(axis) in
    let stride_ptr = Ctypes.(allocate int32_t stride_i32) in
    let sizeof_int32 = Ctypes.(sizeof (ptr int32_t)) in
    let kernel = make_kernel x program fun_name in
    Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
    Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
    Kernel.set_arg kernel 2 sizeof_int32 dim_ptr;
    Kernel.set_arg kernel 3 sizeof_int32 stride_ptr


  (* f : arr array -> arr, non-broadcasting *)
  and _init_10 x param fun_name =
    let parents_val =
      Array.map
        (fun parent ->
          _init_term parent param;
          (get_value parent).(0))
        (parents x)
    in
    let ctx, _, program = param in
    allocate_from_parent_0 ctx x;
    let kernel = make_kernel x program fun_name in
    let args_val = Array.append parents_val [| (get_value x).(0) |] in
    Array.iteri
      (fun i arg_val ->
        let arg_ptr = Device.get_gpu_ptr arg_val in
        Kernel.set_arg kernel i sizeof_cl_mem arg_ptr)
      args_val


  (* f : arr array -> arr, pseudo random number generators *)
  and _init_20 x param fun_name =
    let parents_val =
      Array.map
        (fun parent ->
          _init_term parent param;
          (get_value parent).(0))
        (parents x)
    in
    let ctx, _, program = param in
    allocate_from_parent_0 ctx x;
    let numpu = Owl_opencl_hardware.processing_units () in
    let limit = node_numel x in
    let items, chunk = calc_opt_chunk numpu limit in
    let chunk_ptr = Ctypes.(allocate int32_t) (Int32.of_int chunk) in
    let limit_ptr = Ctypes.(allocate int32_t) (Int32.of_int limit) in
    let streams = Owl_opencl_prng_philox.make items in
    let streams_buf = Owl_opencl_prng_philox.make_stream_buffer ctx streams in
    let streams_ptr = Ctypes.allocate cl_mem streams_buf in
    let kernel = make_kernel x program fun_name in
    Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_int32 chunk_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_int32 limit_ptr;
    Owl_opencl_base.Kernel.set_arg kernel 2 sizeof_cl_mem streams_ptr;
    let args_val = Array.append parents_val [| (get_value x).(0) |] in
    Array.iteri
      (fun i arg_val ->
        let arg_ptr = Device.get_gpu_ptr arg_val in
        Kernel.set_arg kernel (i + 3) sizeof_cl_mem arg_ptr)
      args_val


  (* Core functions to initislise a computation graph *)

  let init_nodes xs param = Array.iter (fun x -> _init_term x param) xs
end
