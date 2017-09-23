#!/usr/bin/env owl
#require "owl_opencl"

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

Log.info "pick platform, device, build program ...";;
let l = Owl_opencl.Platform.get_platforms ();;
let m = Owl_opencl.Device.get_devices l.(0);;
let gpu = m.(1);;
let ctx = Owl_opencl.Context.create [|gpu|];;
let cmdq = Owl_opencl.CommandQueue.create ctx gpu;;
let program = Owl_opencl.Program.create_with_source ctx [|prog_s|];;
Owl_opencl.Program.build program [|gpu|];;
let kernel = Owl_opencl.Kernel.create program "hello_kernel";;


Log.info "prepare and set variables ...";;
let a = Dense.Ndarray.S.uniform [|1024|];;
let b = Dense.Ndarray.S.uniform [|1024|];;
let c = Dense.Ndarray.S.zeros [|1024|];;
let a' = Owl_opencl.Buffer.create ~flags:[|Owl_opencl_generated.cl_MEM_USE_HOST_PTR|] ctx a;;
let b' = Owl_opencl.Buffer.create ~flags:[|Owl_opencl_generated.cl_MEM_USE_HOST_PTR|] ctx b;;
let c' = Owl_opencl.Buffer.create ~flags:[|Owl_opencl_generated.cl_MEM_USE_HOST_PTR|] ctx c;;
let len = Ctypes.sizeof Owl_opencl_generated.cl_mem;;
let _a = Ctypes.allocate Owl_opencl_generated.cl_mem a';;
let _b = Ctypes.allocate Owl_opencl_generated.cl_mem b';;
let _c = Ctypes.allocate Owl_opencl_generated.cl_mem c';;
Owl_opencl.Kernel.set_arg kernel 0 len _a;;
Owl_opencl.Kernel.set_arg kernel 1 len _b;;
Owl_opencl.Kernel.set_arg kernel 2 len _c;;


Log.info "execute kernel ...";;
Owl_opencl.Kernel.enqueue_ndrange cmdq kernel 1 [1024];;


Log.info "fetch result ...";;
Owl_opencl.Buffer.enqueue_read cmdq c' 0 len (Ctypes.to_voidp _c);;
Dense.Ndarray.Generic.pp_dsnda Format.std_formatter a;;
Dense.Ndarray.Generic.pp_dsnda Format.std_formatter b;;
Dense.Ndarray.Generic.pp_dsnda Format.std_formatter c;;


Log.info "clean up ...";;
Owl_opencl.Buffer.release a';;
Owl_opencl.Buffer.release b';;
Owl_opencl.Buffer.release c';;
Owl_opencl.Program.release program;;
Owl_opencl.CommandQueue.release cmdq;;
Owl_opencl.Context.release ctx;;
