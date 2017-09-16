(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1505567121 *)

open Ctypes

type cl_platform_id
val cl_platform_id : cl_platform_id Ctypes.typ
val cl_platform_id_null : cl_platform_id
val cl_platform_id_ptr_null : cl_platform_id Ctypes.ptr

type cl_device_id
val cl_device_id : cl_device_id Ctypes.typ
val cl_device_id_null : cl_device_id
val cl_device_id_ptr_null : cl_device_id Ctypes.ptr

type cl_context
val cl_context : cl_context Ctypes.typ
val cl_context_null : cl_context
val cl_context_ptr_null : cl_context Ctypes.ptr

type cl_command_queue
val cl_command_queue : cl_command_queue Ctypes.typ
val cl_command_queue_null : cl_command_queue
val cl_command_queue_ptr_null : cl_command_queue Ctypes.ptr

type cl_mem
val cl_mem : cl_mem Ctypes.typ
val cl_mem_null : cl_mem
val cl_mem_ptr_null : cl_mem Ctypes.ptr

type cl_program
val cl_program : cl_program Ctypes.typ
val cl_program_null : cl_program
val cl_program_ptr_null : cl_program Ctypes.ptr

type cl_kernel
val cl_kernel : cl_kernel Ctypes.typ
val cl_kernel_null : cl_kernel
val cl_kernel_ptr_null : cl_kernel Ctypes.ptr

type cl_event
val cl_event : cl_event Ctypes.typ
val cl_event_null : cl_event
val cl_event_ptr_null : cl_event Ctypes.ptr

type cl_sampler
val cl_sampler : cl_sampler Ctypes.typ
val cl_sampler_null : cl_sampler
val cl_sampler_ptr_null : cl_sampler Ctypes.ptr

val clGetPlatformIDs : Unsigned.uint32 -> cl_platform_id ptr -> Unsigned.uint32 ptr -> int32

val clGetPlatformInfo : cl_platform_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32

val clGetDeviceIDs : cl_platform_id -> Unsigned.uint64 -> Unsigned.uint32 -> cl_device_id ptr -> Unsigned.uint32 ptr -> int32

val clGetDeviceInfo : cl_device_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32

