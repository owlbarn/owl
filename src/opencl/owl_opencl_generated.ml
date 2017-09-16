(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1505520140 *)

open Ctypes

module CI = Cstubs_internals

type _cl_platform_id

type _cl_device_id

type _cl_context

type _cl_command_queue

type _cl_mem

type _cl_program

type _cl_kernel

type _cl_event

type _cl_sampler

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

