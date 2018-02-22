(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_opencl_base

open Owl_opencl_generated

open Owl_opencl_utils


type num =
  | F   of float
  | F32 of (float, float32_elt) Owl_dense_ndarray_generic.t
  | F64 of (float, float64_elt) Owl_dense_ndarray_generic.t


type t = {
  mutable device        : cl_device_id array;
  mutable context       : cl_context;
  mutable program       : cl_program;
  mutable progsrc       : string array;
  mutable command_queue : (cl_device_id, cl_command_queue) Hashtbl.t;
}


let make_t device context program progsrc command_queue = {
  device;
  context;
  program;
  progsrc;
  command_queue;
}


let platforms () = Platform.get_platforms ()


let devices () =
  let devs = Owl_utils.Stack.make () in
  Array.iter (fun p ->
    Array.iter (fun d ->
      Owl_utils.Stack.push devs d
    ) (Device.get_devices p)
  ) (platforms ());
  Owl_utils.Stack.to_array devs


let cpu_devices () =
  Owl_utils.Array.filter (fun d ->
    let info = Device.get_info d in
    Device.(info.typ) = cl_DEVICE_TYPE_CPU
  ) (devices ())


let gpu_devices () =
  Owl_utils.Array.filter (fun d ->
    let info = Device.get_info d in
    Device.(info.typ) = cl_DEVICE_TYPE_GPU
  ) (devices ())


let accelerators () =
  Owl_utils.Array.filter (fun d ->
    let info = Device.get_info d in
    Device.(info.typ) = cl_DEVICE_TYPE_ACCELERATOR
  ) (devices ())


let kernels ctx =
  let info = Program.get_info ctx.program in
  Program.(info.kernel_names)


let add_kernels ctx code =
  let progsrc = Array.append ctx.progsrc code in
  let program = Program.create_with_source ctx.context progsrc in
  Owl_opencl_base.Program.build program ctx.device;
  ctx.progsrc <- progsrc;
  ctx.program <- program


let make_kernel ctx kernel_name = Kernel.create ctx.program kernel_name


let ba_kernel
  : type a b. (a, b) kind -> string -> cl_program -> cl_kernel
  = fun kind fun_name program ->
  let kernel_name =
    match kind with
    | Float32 -> "owl_opencl_float32_" ^ fun_name
    | Float64 -> "owl_opencl_float64_" ^ fun_name
    | _       -> failwith "owl_opencl_context:mk_kernel"
  in
  Kernel.create program kernel_name


let create devs code =
  let ctx = Context.create devs in
  let command_queue = Hashtbl.create 32 in
  Array.iter (fun dev ->
    let cmdq = CommandQueue.create ctx dev in
    Hashtbl.add command_queue dev cmdq;
  ) devs;

  let core_src = Owl_opencl_kernel_common.code () in
  let prog_src = Array.append [|core_src|] code in
  let prog = Program.create_with_source ctx prog_src in
  Owl_opencl_base.Program.build prog devs;

  make_t devs ctx prog prog_src command_queue


let get_opencl_ctx ctx = ctx.context


let get_program ctx = ctx.program


let get_dev ctx idx = ctx.device.(idx)


let get_cmdq ctx dev = Hashtbl.find ctx.command_queue dev


let default =
  let devs = gpu_devices () in
  let code = [||] in
  Owl_log.info "OpenCL: initialising context ...";
  let ctx = create devs code in
  Owl_log.info "OpenCL: finished initialisation.";
  ctx


let eval ?(param=[||]) ?(ctx=default) ?(dev_id=0) fun_name =
  let dev = get_dev ctx dev_id in
  let cmdq = get_cmdq ctx dev in
  let kernel = make_kernel ctx fun_name in
  let opencl_ctx = ctx.context in
  let work_dim = 1 in
  let work_sz = ref 0 in

  (* set up parameters *)
  Array.iteri (fun i p ->
    match p with
    | F a_val   -> (
        let a_ptr = Ctypes.allocate Ctypes.float a_val in
        Kernel.set_arg kernel i sizeof_float_ptr a_ptr;
      )
    | F32 a_val -> (
        if !work_sz = 0 then work_sz := Owl_dense_ndarray_generic.numel a_val;
        let a_mem = Buffer.create ~flags:[cl_MEM_USE_HOST_PTR] opencl_ctx a_val in
        let a_ptr = Ctypes.allocate cl_mem a_mem in
        Owl_opencl_base.Kernel.set_arg kernel i sizeof_cl_mem a_ptr;
      )
    | F64 a_val -> (
        if !work_sz = 0 then work_sz := Owl_dense_ndarray_generic.numel a_val;
        let a_mem = Buffer.create ~flags:[cl_MEM_USE_HOST_PTR] opencl_ctx a_val in
        let a_ptr = Ctypes.allocate cl_mem a_mem in
        Owl_opencl_base.Kernel.set_arg kernel i sizeof_cl_mem a_ptr;
      )
  ) param;

  (* execute kernel *)
  let _ = Kernel.enqueue_ndrange cmdq kernel work_dim [!work_sz] in
  CommandQueue.finish cmdq


(* end here *)
