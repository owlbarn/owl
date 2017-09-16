(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1505567121 *)

open Ctypes

module CI = Cstubs_internals

type cl_platform_id = unit Ctypes.ptr
let cl_platform_id : cl_platform_id Ctypes.typ = Ctypes.(ptr void)
let cl_platform_id_null : cl_platform_id = Ctypes.null
let cl_platform_id_ptr_null : cl_platform_id Ctypes.ptr = Obj.magic Ctypes.null

type cl_device_id = unit Ctypes.ptr
let cl_device_id : cl_device_id Ctypes.typ = Ctypes.(ptr void)
let cl_device_id_null : cl_device_id = Ctypes.null
let cl_device_id_ptr_null : cl_device_id Ctypes.ptr = Obj.magic Ctypes.null

type cl_context = unit Ctypes.ptr
let cl_context : cl_context Ctypes.typ = Ctypes.(ptr void)
let cl_context_null : cl_context = Ctypes.null
let cl_context_ptr_null : cl_context Ctypes.ptr = Obj.magic Ctypes.null

type cl_command_queue = unit Ctypes.ptr
let cl_command_queue : cl_command_queue Ctypes.typ = Ctypes.(ptr void)
let cl_command_queue_null : cl_command_queue = Ctypes.null
let cl_command_queue_ptr_null : cl_command_queue Ctypes.ptr = Obj.magic Ctypes.null

type cl_mem = unit Ctypes.ptr
let cl_mem : cl_mem Ctypes.typ = Ctypes.(ptr void)
let cl_mem_null : cl_mem = Ctypes.null
let cl_mem_ptr_null : cl_mem Ctypes.ptr = Obj.magic Ctypes.null

type cl_program = unit Ctypes.ptr
let cl_program : cl_program Ctypes.typ = Ctypes.(ptr void)
let cl_program_null : cl_program = Ctypes.null
let cl_program_ptr_null : cl_program Ctypes.ptr = Obj.magic Ctypes.null

type cl_kernel = unit Ctypes.ptr
let cl_kernel : cl_kernel Ctypes.typ = Ctypes.(ptr void)
let cl_kernel_null : cl_kernel = Ctypes.null
let cl_kernel_ptr_null : cl_kernel Ctypes.ptr = Obj.magic Ctypes.null

type cl_event = unit Ctypes.ptr
let cl_event : cl_event Ctypes.typ = Ctypes.(ptr void)
let cl_event_null : cl_event = Ctypes.null
let cl_event_ptr_null : cl_event Ctypes.ptr = Obj.magic Ctypes.null

type cl_sampler = unit Ctypes.ptr
let cl_sampler : cl_sampler Ctypes.typ = Ctypes.(ptr void)
let cl_sampler_null : cl_sampler = Ctypes.null
let cl_sampler_ptr_null : cl_sampler Ctypes.ptr = Obj.magic Ctypes.null

external owl_opencl_clGetPlatformIDs
  : Unsigned.uint32 -> _ CI.fatptr -> _ CI.fatptr -> int32
  = "owl_opencl_stub_1_clGetPlatformIDs"

external owl_opencl_clGetPlatformInfo
  : _ CI.fatptr -> Unsigned.uint32 -> Unsigned.size_t -> _ CI.fatptr -> _ CI.fatptr -> int32
  = "owl_opencl_stub_2_clGetPlatformInfo"

external owl_opencl_clGetDeviceIDs
  : _ CI.fatptr -> Unsigned.uint64 -> Unsigned.uint32 -> _ CI.fatptr -> _ CI.fatptr -> int32
  = "owl_opencl_stub_3_clGetDeviceIDs"

external owl_opencl_clGetDeviceInfo
  : _ CI.fatptr -> Unsigned.uint32 -> Unsigned.size_t -> _ CI.fatptr -> _ CI.fatptr -> int32
  = "owl_opencl_stub_4_clGetDeviceInfo"

let clGetPlatformIDs x0 x1 x2 =
  owl_opencl_clGetPlatformIDs x0 (CI.cptr x1) (CI.cptr x2) 

let clGetPlatformInfo x0 x1 x2 x3 x4 =
  owl_opencl_clGetPlatformInfo (CI.cptr x0) x1 x2 (CI.cptr x3) (CI.cptr x4) 

let clGetDeviceIDs x0 x1 x2 x3 x4 =
  owl_opencl_clGetDeviceIDs (CI.cptr x0) x1 x2 (CI.cptr x3) (CI.cptr x4) 

let clGetDeviceInfo x0 x1 x2 x3 x4 =
  owl_opencl_clGetDeviceInfo (CI.cptr x0) x1 x2 (CI.cptr x3) (CI.cptr x4) 

