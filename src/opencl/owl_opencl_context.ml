(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_opencl_base

open Owl_opencl_generated


type context = {
  context       : cl_context;
  program       : cl_program;
  command_queue : cl_command_queue;
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


let compile_kernels () =
  let ctx = Context.create_from_type cl_DEVICE_TYPE_GPU in
  let gpu = Context.((get_info ctx).devices).(0) in
  let cmdq = CommandQueue.create ctx gpu in
  let prog_s = Owl_opencl_kernel_common.code () in
  let prog = Program.create_with_source ctx [|prog_s|] in
  Owl_opencl_base.Program.build prog [|gpu|];
  {
    context       = ctx;
    program       = prog;
    command_queue = cmdq;
  }


let default =
  Owl_log.info "OpenCL: compling kernels";
  let ctx = compile_kernels () in
  Owl_log.info "OpenCL: kernels compiled";
  ctx


let mk_kernel
  : type a b. (a, b) kind -> string -> cl_program -> cl_kernel
  = fun kind fun_name program ->
  let kernel_name =
    match kind with
    | Float32 -> "owl_opencl_float32_" ^ fun_name
    | Float64 -> "owl_opencl_float64_" ^ fun_name
    | _       -> failwith "owl_opencl_context:mk_kernel"
  in
  Kernel.create program kernel_name


let init ?devices () = ()


module Default = struct

  let init () = ()

end



(* end here *)
