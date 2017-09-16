(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1505520140 *)

open Ctypes

type _cl_platform_id

type _cl_device_id

type _cl_context

type _cl_command_queue

type _cl_mem

type _cl_program

type _cl_kernel

type _cl_event

type _cl_sampler

val clGetPlatformIDs : Unsigned.uint32 -> _cl_platform_id ptr ptr -> Unsigned.uint32 ptr -> int32

val clGetPlatformInfo : _cl_platform_id ptr -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32

val clGetDeviceIDs : _cl_platform_id ptr -> Unsigned.uint64 -> Unsigned.uint32 -> _cl_device_id ptr ptr -> Unsigned.uint32 ptr -> int32

val clGetDeviceInfo : _cl_device_id ptr -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32

