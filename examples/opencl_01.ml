#!/usr/bin/env owl
#require "owl-opencl"

open Owl


let prog_s = "
  __kernel void hello_kernel(__global const float *a,
                             __global const float *b,
                             __global float *result)
  {
    int gid = get_global_id(0);
    result[gid] = a[gid] + b[gid];
  }
";;


Owl_log.info "pick platform, device, build program ...";;
let l = Owl_opencl_base.Platform.get_platforms ();;
let m = Owl_opencl_base.Device.get_devices l.(0);;
let gpu = m.(0);;
let ctx = Owl_opencl_base.Context.create [|gpu|];;
let cmdq = Owl_opencl_base.CommandQueue.create ctx gpu;;
let program = Owl_opencl_base.Program.create_with_source ctx [|prog_s|];;
Owl_opencl_base.Program.build program [|gpu|];;
let kernel = Owl_opencl_base.Kernel.create program "hello_kernel";;

print_endline (Owl_opencl_base.Platform.to_string l.(0));;
print_endline (Owl_opencl_base.Device.to_string gpu);;
print_endline (Owl_opencl_base.Context.to_string ctx);;
print_endline (Owl_opencl_base.Program.to_string program);;
print_endline (Owl_opencl_base.Kernel.to_string kernel);;


Owl_log.info "prepare variables ...";;
let _size = 10_000_000;;
let a = Dense.Ndarray.S.uniform [|_size|];;
let b = Dense.Ndarray.S.uniform [|_size|];;
let c = Dense.Ndarray.S.zeros [|_size|];;


Owl_log.info "set args ...";;
let a' = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx a;;
let b' = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx b;;
let c' = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx c;;
let len = Ctypes.sizeof Owl_opencl_generated.cl_mem;;
let _a = Ctypes.allocate Owl_opencl_generated.cl_mem a';;
let _b = Ctypes.allocate Owl_opencl_generated.cl_mem b';;
let _c = Ctypes.allocate Owl_opencl_generated.cl_mem c';;
Owl_opencl_base.Kernel.set_arg kernel 0 len _a;;
Owl_opencl_base.Kernel.set_arg kernel 1 len _b;;
Owl_opencl_base.Kernel.set_arg kernel 2 len _c;;


Owl_log.info "execute kernel ...";;
Owl_opencl_base.Kernel.enqueue_ndrange cmdq kernel 1 [_size];;


Owl_log.info "fetch result ...";;
Owl_opencl_base.Buffer.enqueue_read cmdq c' 0 len (Ctypes.to_voidp _c);;
Dense.Ndarray.Generic.pp_dsnda Format.std_formatter a;;
Dense.Ndarray.Generic.pp_dsnda Format.std_formatter b;;
Dense.Ndarray.Generic.pp_dsnda Format.std_formatter c;;


Owl_log.info "clean up ...";;
Owl_opencl_base.Buffer.release a';;
Owl_opencl_base.Buffer.release b';;
Owl_opencl_base.Buffer.release c';;
Owl_opencl_base.Program.release program;;
Owl_opencl_base.CommandQueue.release cmdq;;
Owl_opencl_base.Context.release ctx;;
