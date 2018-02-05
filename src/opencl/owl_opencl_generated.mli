(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1517848191 *)

open Ctypes



(** {6 Type definition} *)

type cl_platform_id
(** Type of cl_platform_id *)

val cl_platform_id : cl_platform_id Ctypes.typ
(** Value of cl_platform_id *)

val cl_platform_id_null : cl_platform_id
(** Null value of cl_platform_id *)

val cl_platform_id_ptr_null : cl_platform_id Ctypes.ptr
(** Null pointer of cl_platform_id *)


type cl_device_id
(** Type of cl_device_id *)

val cl_device_id : cl_device_id Ctypes.typ
(** Value of cl_device_id *)

val cl_device_id_null : cl_device_id
(** Null value of cl_device_id *)

val cl_device_id_ptr_null : cl_device_id Ctypes.ptr
(** Null pointer of cl_device_id *)


type cl_context
(** Type of cl_context *)

val cl_context : cl_context Ctypes.typ
(** Value of cl_context *)

val cl_context_null : cl_context
(** Null value of cl_context *)

val cl_context_ptr_null : cl_context Ctypes.ptr
(** Null pointer of cl_context *)


type cl_command_queue
(** Type of cl_command_queue *)

val cl_command_queue : cl_command_queue Ctypes.typ
(** Value of cl_command_queue *)

val cl_command_queue_null : cl_command_queue
(** Null value of cl_command_queue *)

val cl_command_queue_ptr_null : cl_command_queue Ctypes.ptr
(** Null pointer of cl_command_queue *)


type cl_mem
(** Type of cl_mem *)

val cl_mem : cl_mem Ctypes.typ
(** Value of cl_mem *)

val cl_mem_null : cl_mem
(** Null value of cl_mem *)

val cl_mem_ptr_null : cl_mem Ctypes.ptr
(** Null pointer of cl_mem *)


type cl_program
(** Type of cl_program *)

val cl_program : cl_program Ctypes.typ
(** Value of cl_program *)

val cl_program_null : cl_program
(** Null value of cl_program *)

val cl_program_ptr_null : cl_program Ctypes.ptr
(** Null pointer of cl_program *)


type cl_kernel
(** Type of cl_kernel *)

val cl_kernel : cl_kernel Ctypes.typ
(** Value of cl_kernel *)

val cl_kernel_null : cl_kernel
(** Null value of cl_kernel *)

val cl_kernel_ptr_null : cl_kernel Ctypes.ptr
(** Null pointer of cl_kernel *)


type cl_event
(** Type of cl_event *)

val cl_event : cl_event Ctypes.typ
(** Value of cl_event *)

val cl_event_null : cl_event
(** Null value of cl_event *)

val cl_event_ptr_null : cl_event Ctypes.ptr
(** Null pointer of cl_event *)


type cl_sampler
(** Type of cl_sampler *)

val cl_sampler : cl_sampler Ctypes.typ
(** Value of cl_sampler *)

val cl_sampler_null : cl_sampler
(** Null value of cl_sampler *)

val cl_sampler_ptr_null : cl_sampler Ctypes.ptr
(** Null pointer of cl_sampler *)




(** {6 Function definition} *)

val cl_check_err : int32 -> unit
(** ``cl_check_err`` checks error code of return value. *)

val clGetPlatformIDs : Unsigned.uint32 -> cl_platform_id ptr -> Unsigned.uint32 ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetPlatformInfo : cl_platform_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetDeviceIDs : cl_platform_id -> Unsigned.ULong.t -> Unsigned.uint32 -> cl_device_id ptr -> Unsigned.uint32 ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetDeviceInfo : cl_device_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateSubDevices : cl_device_id -> Intptr.t ptr -> Unsigned.uint32 -> cl_device_id ptr -> Unsigned.uint32 ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainDevice : cl_device_id -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseDevice : cl_device_id -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateContext : Intptr.t ptr -> Unsigned.uint32 -> cl_device_id ptr -> unit ptr -> unit ptr -> int32 ptr -> cl_context
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateContextFromType : Intptr.t ptr -> Unsigned.ULong.t -> unit ptr -> unit ptr -> int32 ptr -> cl_context
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainContext : cl_context -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseContext : cl_context -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetContextInfo : cl_context -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateCommandQueue : cl_context -> cl_device_id -> Unsigned.ULong.t -> int32 ptr -> cl_command_queue
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainCommandQueue : cl_command_queue -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseCommandQueue : cl_command_queue -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetCommandQueueInfo : cl_command_queue -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateBuffer : cl_context -> Unsigned.ULong.t -> Unsigned.size_t -> unit ptr -> int32 ptr -> cl_mem
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateSubBuffer : cl_mem -> Unsigned.ULong.t -> Unsigned.uint32 -> unit ptr -> int32 ptr -> cl_mem
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainMemObject : cl_mem -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseMemObject : cl_mem -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetMemObjectInfo : cl_mem -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetImageInfo : cl_mem -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clSetMemObjectDestructorCallback : cl_mem -> unit ptr -> unit ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateSampler : cl_context -> Unsigned.uint32 -> Unsigned.uint32 -> Unsigned.uint32 -> int32 ptr -> cl_sampler
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainSampler : cl_sampler -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseSampler : cl_sampler -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetSamplerInfo : cl_sampler -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateProgramWithSource : cl_context -> Unsigned.uint32 -> char ptr ptr -> Unsigned.size_t ptr -> int32 ptr -> cl_program
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateProgramWithBinary : cl_context -> Unsigned.uint32 -> cl_device_id ptr -> Unsigned.size_t ptr -> Unsigned.UChar.t ptr ptr -> int32 ptr -> int32 ptr -> cl_program
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateProgramWithBuiltInKernels : cl_context -> Unsigned.uint32 -> cl_device_id ptr -> char ptr -> int32 ptr -> cl_program
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainProgram : cl_program -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseProgram : cl_program -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clBuildProgram : cl_program -> Unsigned.uint32 -> cl_device_id ptr -> char ptr -> unit ptr -> unit ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCompileProgram : cl_program -> Unsigned.uint32 -> cl_device_id ptr -> char ptr -> Unsigned.uint32 -> cl_program ptr -> char ptr ptr -> unit ptr -> unit ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clLinkProgram : cl_context -> Unsigned.uint32 -> cl_device_id ptr -> char ptr -> Unsigned.uint32 -> cl_program ptr -> unit ptr -> unit ptr -> int32 ptr -> cl_program
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clUnloadPlatformCompiler : cl_platform_id -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetProgramInfo : cl_program -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetProgramBuildInfo : cl_program -> cl_device_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateKernel : cl_program -> char ptr -> int32 ptr -> cl_kernel
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateKernelsInProgram : cl_program -> Unsigned.uint32 -> cl_kernel ptr -> Unsigned.uint32 ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainKernel : cl_kernel -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseKernel : cl_kernel -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clSetKernelArg : cl_kernel -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetKernelInfo : cl_kernel -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetKernelArgInfo : cl_kernel -> Unsigned.uint32 -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetKernelWorkGroupInfo : cl_kernel -> cl_device_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clWaitForEvents : Unsigned.uint32 -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetEventInfo : cl_event -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clCreateUserEvent : cl_context -> int32 ptr -> cl_event
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clRetainEvent : cl_event -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clReleaseEvent : cl_event -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clSetUserEventStatus : cl_event -> int32 -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clSetEventCallback : cl_event -> int32 -> unit ptr -> unit ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetEventProfilingInfo : cl_event -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clFlush : cl_command_queue -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clFinish : cl_command_queue -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueReadBuffer : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.size_t -> Unsigned.size_t -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueReadBufferRect : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueWriteBuffer : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.size_t -> Unsigned.size_t -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueWriteBufferRect : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueFillBuffer : cl_command_queue -> cl_mem -> unit ptr -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueCopyBuffer : cl_command_queue -> cl_mem -> cl_mem -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueCopyBufferRect : cl_command_queue -> cl_mem -> cl_mem -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueReadImage : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t -> Unsigned.size_t -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueWriteImage : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t -> Unsigned.size_t -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueFillImage : cl_command_queue -> cl_mem -> unit ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueCopyImage : cl_command_queue -> cl_mem -> cl_mem -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueCopyImageToBuffer : cl_command_queue -> cl_mem -> cl_mem -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueCopyBufferToImage : cl_command_queue -> cl_mem -> cl_mem -> Unsigned.size_t -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueMapBuffer : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.ULong.t -> Unsigned.size_t -> Unsigned.size_t -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32 ptr -> unit ptr
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueMapImage : cl_command_queue -> cl_mem -> Unsigned.uint32 -> Unsigned.ULong.t -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32 ptr -> unit ptr
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueUnmapMemObject : cl_command_queue -> cl_mem -> unit ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueMigrateMemObjects : cl_command_queue -> Unsigned.uint32 -> cl_mem ptr -> Unsigned.ULong.t -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueNDRangeKernel : cl_command_queue -> cl_kernel -> Unsigned.uint32 -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.size_t ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueTask : cl_command_queue -> cl_kernel -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueNativeKernel : cl_command_queue -> unit ptr -> unit ptr -> Unsigned.size_t -> Unsigned.uint32 -> cl_mem ptr -> unit ptr ptr -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueMarkerWithWaitList : cl_command_queue -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clEnqueueBarrierWithWaitList : cl_command_queue -> Unsigned.uint32 -> cl_event ptr -> cl_event ptr -> int32
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)

val clGetExtensionFunctionAddressForPlatform : cl_platform_id -> char ptr -> unit ptr
(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)



(** {6 Constant definition} *)

val cl_SUCCESS : int
(** Constant ``SUCCESS``. *)

val cl_DEVICE_NOT_FOUND : int
(** Constant ``DEVICE_NOT_FOUND``. *)

val cl_DEVICE_NOT_AVAILABLE : int
(** Constant ``DEVICE_NOT_AVAILABLE``. *)

val cl_COMPILER_NOT_AVAILABLE : int
(** Constant ``COMPILER_NOT_AVAILABLE``. *)

val cl_MEM_OBJECT_ALLOCATION_FAILURE : int
(** Constant ``MEM_OBJECT_ALLOCATION_FAILURE``. *)

val cl_OUT_OF_RESOURCES : int
(** Constant ``OUT_OF_RESOURCES``. *)

val cl_OUT_OF_HOST_MEMORY : int
(** Constant ``OUT_OF_HOST_MEMORY``. *)

val cl_PROFILING_INFO_NOT_AVAILABLE : int
(** Constant ``PROFILING_INFO_NOT_AVAILABLE``. *)

val cl_MEM_COPY_OVERLAP : int
(** Constant ``MEM_COPY_OVERLAP``. *)

val cl_IMAGE_FORMAT_MISMATCH : int
(** Constant ``IMAGE_FORMAT_MISMATCH``. *)

val cl_IMAGE_FORMAT_NOT_SUPPORTED : int
(** Constant ``IMAGE_FORMAT_NOT_SUPPORTED``. *)

val cl_BUILD_PROGRAM_FAILURE : int
(** Constant ``BUILD_PROGRAM_FAILURE``. *)

val cl_MAP_FAILURE : int
(** Constant ``MAP_FAILURE``. *)

val cl_MISALIGNED_SUB_BUFFER_OFFSET : int
(** Constant ``MISALIGNED_SUB_BUFFER_OFFSET``. *)

val cl_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST : int
(** Constant ``EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST``. *)

val cl_COMPILE_PROGRAM_FAILURE : int
(** Constant ``COMPILE_PROGRAM_FAILURE``. *)

val cl_LINKER_NOT_AVAILABLE : int
(** Constant ``LINKER_NOT_AVAILABLE``. *)

val cl_LINK_PROGRAM_FAILURE : int
(** Constant ``LINK_PROGRAM_FAILURE``. *)

val cl_DEVICE_PARTITION_FAILED : int
(** Constant ``DEVICE_PARTITION_FAILED``. *)

val cl_KERNEL_ARG_INFO_NOT_AVAILABLE : int
(** Constant ``KERNEL_ARG_INFO_NOT_AVAILABLE``. *)

val cl_INVALID_VALUE : int
(** Constant ``INVALID_VALUE``. *)

val cl_INVALID_DEVICE_TYPE : int
(** Constant ``INVALID_DEVICE_TYPE``. *)

val cl_INVALID_PLATFORM : int
(** Constant ``INVALID_PLATFORM``. *)

val cl_INVALID_DEVICE : int
(** Constant ``INVALID_DEVICE``. *)

val cl_INVALID_CONTEXT : int
(** Constant ``INVALID_CONTEXT``. *)

val cl_INVALID_QUEUE_PROPERTIES : int
(** Constant ``INVALID_QUEUE_PROPERTIES``. *)

val cl_INVALID_COMMAND_QUEUE : int
(** Constant ``INVALID_COMMAND_QUEUE``. *)

val cl_INVALID_HOST_PTR : int
(** Constant ``INVALID_HOST_PTR``. *)

val cl_INVALID_MEM_OBJECT : int
(** Constant ``INVALID_MEM_OBJECT``. *)

val cl_INVALID_IMAGE_FORMAT_DESCRIPTOR : int
(** Constant ``INVALID_IMAGE_FORMAT_DESCRIPTOR``. *)

val cl_INVALID_IMAGE_SIZE : int
(** Constant ``INVALID_IMAGE_SIZE``. *)

val cl_INVALID_SAMPLER : int
(** Constant ``INVALID_SAMPLER``. *)

val cl_INVALID_BINARY : int
(** Constant ``INVALID_BINARY``. *)

val cl_INVALID_BUILD_OPTIONS : int
(** Constant ``INVALID_BUILD_OPTIONS``. *)

val cl_INVALID_PROGRAM : int
(** Constant ``INVALID_PROGRAM``. *)

val cl_INVALID_PROGRAM_EXECUTABLE : int
(** Constant ``INVALID_PROGRAM_EXECUTABLE``. *)

val cl_INVALID_KERNEL_NAME : int
(** Constant ``INVALID_KERNEL_NAME``. *)

val cl_INVALID_KERNEL_DEFINITION : int
(** Constant ``INVALID_KERNEL_DEFINITION``. *)

val cl_INVALID_KERNEL : int
(** Constant ``INVALID_KERNEL``. *)

val cl_INVALID_ARG_INDEX : int
(** Constant ``INVALID_ARG_INDEX``. *)

val cl_INVALID_ARG_VALUE : int
(** Constant ``INVALID_ARG_VALUE``. *)

val cl_INVALID_ARG_SIZE : int
(** Constant ``INVALID_ARG_SIZE``. *)

val cl_INVALID_KERNEL_ARGS : int
(** Constant ``INVALID_KERNEL_ARGS``. *)

val cl_INVALID_WORK_DIMENSION : int
(** Constant ``INVALID_WORK_DIMENSION``. *)

val cl_INVALID_WORK_GROUP_SIZE : int
(** Constant ``INVALID_WORK_GROUP_SIZE``. *)

val cl_INVALID_WORK_ITEM_SIZE : int
(** Constant ``INVALID_WORK_ITEM_SIZE``. *)

val cl_INVALID_GLOBAL_OFFSET : int
(** Constant ``INVALID_GLOBAL_OFFSET``. *)

val cl_INVALID_EVENT_WAIT_LIST : int
(** Constant ``INVALID_EVENT_WAIT_LIST``. *)

val cl_INVALID_EVENT : int
(** Constant ``INVALID_EVENT``. *)

val cl_INVALID_OPERATION : int
(** Constant ``INVALID_OPERATION``. *)

val cl_INVALID_GL_OBJECT : int
(** Constant ``INVALID_GL_OBJECT``. *)

val cl_INVALID_BUFFER_SIZE : int
(** Constant ``INVALID_BUFFER_SIZE``. *)

val cl_INVALID_MIP_LEVEL : int
(** Constant ``INVALID_MIP_LEVEL``. *)

val cl_INVALID_GLOBAL_WORK_SIZE : int
(** Constant ``INVALID_GLOBAL_WORK_SIZE``. *)

val cl_INVALID_PROPERTY : int
(** Constant ``INVALID_PROPERTY``. *)

val cl_INVALID_IMAGE_DESCRIPTOR : int
(** Constant ``INVALID_IMAGE_DESCRIPTOR``. *)

val cl_INVALID_COMPILER_OPTIONS : int
(** Constant ``INVALID_COMPILER_OPTIONS``. *)

val cl_INVALID_LINKER_OPTIONS : int
(** Constant ``INVALID_LINKER_OPTIONS``. *)

val cl_INVALID_DEVICE_PARTITION_COUNT : int
(** Constant ``INVALID_DEVICE_PARTITION_COUNT``. *)

val cl_VERSION_1_0 : int
(** Constant ``VERSION_1_0``. *)

val cl_VERSION_1_1 : int
(** Constant ``VERSION_1_1``. *)

val cl_VERSION_1_2 : int
(** Constant ``VERSION_1_2``. *)

val cl_FALSE : int
(** Constant ``FALSE``. *)

val cl_TRUE : int
(** Constant ``TRUE``. *)

val cl_BLOCKING : int
(** Constant ``BLOCKING``. *)

val cl_NON_BLOCKING : int
(** Constant ``NON_BLOCKING``. *)

val cl_PLATFORM_PROFILE : int
(** Constant ``PLATFORM_PROFILE``. *)

val cl_PLATFORM_VERSION : int
(** Constant ``PLATFORM_VERSION``. *)

val cl_PLATFORM_NAME : int
(** Constant ``PLATFORM_NAME``. *)

val cl_PLATFORM_VENDOR : int
(** Constant ``PLATFORM_VENDOR``. *)

val cl_PLATFORM_EXTENSIONS : int
(** Constant ``PLATFORM_EXTENSIONS``. *)

val cl_DEVICE_TYPE_DEFAULT : int
(** Constant ``DEVICE_TYPE_DEFAULT``. *)

val cl_DEVICE_TYPE_CPU : int
(** Constant ``DEVICE_TYPE_CPU``. *)

val cl_DEVICE_TYPE_GPU : int
(** Constant ``DEVICE_TYPE_GPU``. *)

val cl_DEVICE_TYPE_ACCELERATOR : int
(** Constant ``DEVICE_TYPE_ACCELERATOR``. *)

val cl_DEVICE_TYPE_CUSTOM : int
(** Constant ``DEVICE_TYPE_CUSTOM``. *)

val cl_DEVICE_TYPE_ALL : int
(** Constant ``DEVICE_TYPE_ALL``. *)

val cl_DEVICE_TYPE : int
(** Constant ``DEVICE_TYPE``. *)

val cl_DEVICE_VENDOR_ID : int
(** Constant ``DEVICE_VENDOR_ID``. *)

val cl_DEVICE_MAX_COMPUTE_UNITS : int
(** Constant ``DEVICE_MAX_COMPUTE_UNITS``. *)

val cl_DEVICE_MAX_WORK_ITEM_DIMENSIONS : int
(** Constant ``DEVICE_MAX_WORK_ITEM_DIMENSIONS``. *)

val cl_DEVICE_MAX_WORK_GROUP_SIZE : int
(** Constant ``DEVICE_MAX_WORK_GROUP_SIZE``. *)

val cl_DEVICE_MAX_WORK_ITEM_SIZES : int
(** Constant ``DEVICE_MAX_WORK_ITEM_SIZES``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_CHAR``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_SHORT``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_INT : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_INT``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_LONG : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_LONG``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE``. *)

val cl_DEVICE_MAX_CLOCK_FREQUENCY : int
(** Constant ``DEVICE_MAX_CLOCK_FREQUENCY``. *)

val cl_DEVICE_ADDRESS_BITS : int
(** Constant ``DEVICE_ADDRESS_BITS``. *)

val cl_DEVICE_MAX_READ_IMAGE_ARGS : int
(** Constant ``DEVICE_MAX_READ_IMAGE_ARGS``. *)

val cl_DEVICE_MAX_WRITE_IMAGE_ARGS : int
(** Constant ``DEVICE_MAX_WRITE_IMAGE_ARGS``. *)

val cl_DEVICE_MAX_MEM_ALLOC_SIZE : int
(** Constant ``DEVICE_MAX_MEM_ALLOC_SIZE``. *)

val cl_DEVICE_IMAGE2D_MAX_WIDTH : int
(** Constant ``DEVICE_IMAGE2D_MAX_WIDTH``. *)

val cl_DEVICE_IMAGE2D_MAX_HEIGHT : int
(** Constant ``DEVICE_IMAGE2D_MAX_HEIGHT``. *)

val cl_DEVICE_IMAGE3D_MAX_WIDTH : int
(** Constant ``DEVICE_IMAGE3D_MAX_WIDTH``. *)

val cl_DEVICE_IMAGE3D_MAX_HEIGHT : int
(** Constant ``DEVICE_IMAGE3D_MAX_HEIGHT``. *)

val cl_DEVICE_IMAGE3D_MAX_DEPTH : int
(** Constant ``DEVICE_IMAGE3D_MAX_DEPTH``. *)

val cl_DEVICE_IMAGE_SUPPORT : int
(** Constant ``DEVICE_IMAGE_SUPPORT``. *)

val cl_DEVICE_MAX_PARAMETER_SIZE : int
(** Constant ``DEVICE_MAX_PARAMETER_SIZE``. *)

val cl_DEVICE_MAX_SAMPLERS : int
(** Constant ``DEVICE_MAX_SAMPLERS``. *)

val cl_DEVICE_MEM_BASE_ADDR_ALIGN : int
(** Constant ``DEVICE_MEM_BASE_ADDR_ALIGN``. *)

val cl_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE : int
(** Constant ``DEVICE_MIN_DATA_TYPE_ALIGN_SIZE``. *)

val cl_DEVICE_SINGLE_FP_CONFIG : int
(** Constant ``DEVICE_SINGLE_FP_CONFIG``. *)

val cl_DEVICE_GLOBAL_MEM_CACHE_TYPE : int
(** Constant ``DEVICE_GLOBAL_MEM_CACHE_TYPE``. *)

val cl_DEVICE_GLOBAL_MEM_CACHELINE_SIZE : int
(** Constant ``DEVICE_GLOBAL_MEM_CACHELINE_SIZE``. *)

val cl_DEVICE_GLOBAL_MEM_CACHE_SIZE : int
(** Constant ``DEVICE_GLOBAL_MEM_CACHE_SIZE``. *)

val cl_DEVICE_GLOBAL_MEM_SIZE : int
(** Constant ``DEVICE_GLOBAL_MEM_SIZE``. *)

val cl_DEVICE_MAX_CONSTANT_BUFFER_SIZE : int
(** Constant ``DEVICE_MAX_CONSTANT_BUFFER_SIZE``. *)

val cl_DEVICE_MAX_CONSTANT_ARGS : int
(** Constant ``DEVICE_MAX_CONSTANT_ARGS``. *)

val cl_DEVICE_LOCAL_MEM_TYPE : int
(** Constant ``DEVICE_LOCAL_MEM_TYPE``. *)

val cl_DEVICE_LOCAL_MEM_SIZE : int
(** Constant ``DEVICE_LOCAL_MEM_SIZE``. *)

val cl_DEVICE_ERROR_CORRECTION_SUPPORT : int
(** Constant ``DEVICE_ERROR_CORRECTION_SUPPORT``. *)

val cl_DEVICE_PROFILING_TIMER_RESOLUTION : int
(** Constant ``DEVICE_PROFILING_TIMER_RESOLUTION``. *)

val cl_DEVICE_ENDIAN_LITTLE : int
(** Constant ``DEVICE_ENDIAN_LITTLE``. *)

val cl_DEVICE_AVAILABLE : int
(** Constant ``DEVICE_AVAILABLE``. *)

val cl_DEVICE_COMPILER_AVAILABLE : int
(** Constant ``DEVICE_COMPILER_AVAILABLE``. *)

val cl_DEVICE_EXECUTION_CAPABILITIES : int
(** Constant ``DEVICE_EXECUTION_CAPABILITIES``. *)

val cl_DEVICE_QUEUE_PROPERTIES : int
(** Constant ``DEVICE_QUEUE_PROPERTIES``. *)

val cl_DEVICE_NAME : int
(** Constant ``DEVICE_NAME``. *)

val cl_DEVICE_VENDOR : int
(** Constant ``DEVICE_VENDOR``. *)

val cl_DRIVER_VERSION : int
(** Constant ``DRIVER_VERSION``. *)

val cl_DEVICE_PROFILE : int
(** Constant ``DEVICE_PROFILE``. *)

val cl_DEVICE_VERSION : int
(** Constant ``DEVICE_VERSION``. *)

val cl_DEVICE_EXTENSIONS : int
(** Constant ``DEVICE_EXTENSIONS``. *)

val cl_DEVICE_PLATFORM : int
(** Constant ``DEVICE_PLATFORM``. *)

val cl_DEVICE_DOUBLE_FP_CONFIG : int
(** Constant ``DEVICE_DOUBLE_FP_CONFIG``. *)

val cl_DEVICE_HALF_FP_CONFIG : int
(** Constant ``DEVICE_HALF_FP_CONFIG``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_HALF : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_HALF``. *)

val cl_DEVICE_HOST_UNIFIED_MEMORY : int
(** Constant ``DEVICE_HOST_UNIFIED_MEMORY``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_CHAR : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_CHAR``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_SHORT : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_SHORT``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_INT : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_INT``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_LONG : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_LONG``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_FLOAT``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_HALF : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_HALF``. *)

val cl_DEVICE_OPENCL_C_VERSION : int
(** Constant ``DEVICE_OPENCL_C_VERSION``. *)

val cl_DEVICE_LINKER_AVAILABLE : int
(** Constant ``DEVICE_LINKER_AVAILABLE``. *)

val cl_DEVICE_BUILT_IN_KERNELS : int
(** Constant ``DEVICE_BUILT_IN_KERNELS``. *)

val cl_DEVICE_IMAGE_MAX_BUFFER_SIZE : int
(** Constant ``DEVICE_IMAGE_MAX_BUFFER_SIZE``. *)

val cl_DEVICE_IMAGE_MAX_ARRAY_SIZE : int
(** Constant ``DEVICE_IMAGE_MAX_ARRAY_SIZE``. *)

val cl_DEVICE_PARENT_DEVICE : int
(** Constant ``DEVICE_PARENT_DEVICE``. *)

val cl_DEVICE_PARTITION_MAX_SUB_DEVICES : int
(** Constant ``DEVICE_PARTITION_MAX_SUB_DEVICES``. *)

val cl_DEVICE_PARTITION_PROPERTIES : int
(** Constant ``DEVICE_PARTITION_PROPERTIES``. *)

val cl_DEVICE_PARTITION_AFFINITY_DOMAIN : int
(** Constant ``DEVICE_PARTITION_AFFINITY_DOMAIN``. *)

val cl_DEVICE_PARTITION_TYPE : int
(** Constant ``DEVICE_PARTITION_TYPE``. *)

val cl_DEVICE_REFERENCE_COUNT : int
(** Constant ``DEVICE_REFERENCE_COUNT``. *)

val cl_DEVICE_PREFERRED_INTEROP_USER_SYNC : int
(** Constant ``DEVICE_PREFERRED_INTEROP_USER_SYNC``. *)

val cl_DEVICE_PRINTF_BUFFER_SIZE : int
(** Constant ``DEVICE_PRINTF_BUFFER_SIZE``. *)

val cl_DEVICE_IMAGE_PITCH_ALIGNMENT : int
(** Constant ``DEVICE_IMAGE_PITCH_ALIGNMENT``. *)

val cl_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT : int
(** Constant ``DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT``. *)

val cl_FP_DENORM : int
(** Constant ``FP_DENORM``. *)

val cl_FP_INF_NAN : int
(** Constant ``FP_INF_NAN``. *)

val cl_FP_ROUND_TO_NEAREST : int
(** Constant ``FP_ROUND_TO_NEAREST``. *)

val cl_FP_ROUND_TO_ZERO : int
(** Constant ``FP_ROUND_TO_ZERO``. *)

val cl_FP_ROUND_TO_INF : int
(** Constant ``FP_ROUND_TO_INF``. *)

val cl_FP_FMA : int
(** Constant ``FP_FMA``. *)

val cl_FP_SOFT_FLOAT : int
(** Constant ``FP_SOFT_FLOAT``. *)

val cl_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT : int
(** Constant ``FP_CORRECTLY_ROUNDED_DIVIDE_SQRT``. *)

val cl_NONE : int
(** Constant ``NONE``. *)

val cl_READ_ONLY_CACHE : int
(** Constant ``READ_ONLY_CACHE``. *)

val cl_READ_WRITE_CACHE : int
(** Constant ``READ_WRITE_CACHE``. *)

val cl_LOCAL : int
(** Constant ``LOCAL``. *)

val cl_GLOBAL : int
(** Constant ``GLOBAL``. *)

val cl_EXEC_KERNEL : int
(** Constant ``EXEC_KERNEL``. *)

val cl_EXEC_NATIVE_KERNEL : int
(** Constant ``EXEC_NATIVE_KERNEL``. *)

val cl_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE : int
(** Constant ``QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE``. *)

val cl_QUEUE_PROFILING_ENABLE : int
(** Constant ``QUEUE_PROFILING_ENABLE``. *)

val cl_CONTEXT_REFERENCE_COUNT : int
(** Constant ``CONTEXT_REFERENCE_COUNT``. *)

val cl_CONTEXT_DEVICES : int
(** Constant ``CONTEXT_DEVICES``. *)

val cl_CONTEXT_PROPERTIES : int
(** Constant ``CONTEXT_PROPERTIES``. *)

val cl_CONTEXT_NUM_DEVICES : int
(** Constant ``CONTEXT_NUM_DEVICES``. *)

val cl_CONTEXT_PLATFORM : int
(** Constant ``CONTEXT_PLATFORM``. *)

val cl_CONTEXT_INTEROP_USER_SYNC : int
(** Constant ``CONTEXT_INTEROP_USER_SYNC``. *)

val cl_DEVICE_PARTITION_EQUALLY : int
(** Constant ``DEVICE_PARTITION_EQUALLY``. *)

val cl_DEVICE_PARTITION_BY_COUNTS : int
(** Constant ``DEVICE_PARTITION_BY_COUNTS``. *)

val cl_DEVICE_PARTITION_BY_COUNTS_LIST_END : int
(** Constant ``DEVICE_PARTITION_BY_COUNTS_LIST_END``. *)

val cl_DEVICE_PARTITION_BY_AFFINITY_DOMAIN : int
(** Constant ``DEVICE_PARTITION_BY_AFFINITY_DOMAIN``. *)

val cl_DEVICE_AFFINITY_DOMAIN_NUMA : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_NUMA``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L4_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L4_CACHE``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L3_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L3_CACHE``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L2_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L2_CACHE``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L1_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L1_CACHE``. *)

val cl_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE``. *)

val cl_QUEUE_CONTEXT : int
(** Constant ``QUEUE_CONTEXT``. *)

val cl_QUEUE_DEVICE : int
(** Constant ``QUEUE_DEVICE``. *)

val cl_QUEUE_REFERENCE_COUNT : int
(** Constant ``QUEUE_REFERENCE_COUNT``. *)

val cl_QUEUE_PROPERTIES : int
(** Constant ``QUEUE_PROPERTIES``. *)

val cl_MEM_READ_WRITE : int
(** Constant ``MEM_READ_WRITE``. *)

val cl_MEM_WRITE_ONLY : int
(** Constant ``MEM_WRITE_ONLY``. *)

val cl_MEM_READ_ONLY : int
(** Constant ``MEM_READ_ONLY``. *)

val cl_MEM_USE_HOST_PTR : int
(** Constant ``MEM_USE_HOST_PTR``. *)

val cl_MEM_ALLOC_HOST_PTR : int
(** Constant ``MEM_ALLOC_HOST_PTR``. *)

val cl_MEM_COPY_HOST_PTR : int
(** Constant ``MEM_COPY_HOST_PTR``. *)

val cl_MEM_HOST_WRITE_ONLY : int
(** Constant ``MEM_HOST_WRITE_ONLY``. *)

val cl_MEM_HOST_READ_ONLY : int
(** Constant ``MEM_HOST_READ_ONLY``. *)

val cl_MEM_HOST_NO_ACCESS : int
(** Constant ``MEM_HOST_NO_ACCESS``. *)

val cl_MIGRATE_MEM_OBJECT_HOST : int
(** Constant ``MIGRATE_MEM_OBJECT_HOST``. *)

val cl_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED : int
(** Constant ``MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED``. *)

val cl_R : int
(** Constant ``R``. *)

val cl_A : int
(** Constant ``A``. *)

val cl_RG : int
(** Constant ``RG``. *)

val cl_RA : int
(** Constant ``RA``. *)

val cl_RGB : int
(** Constant ``RGB``. *)

val cl_RGBA : int
(** Constant ``RGBA``. *)

val cl_BGRA : int
(** Constant ``BGRA``. *)

val cl_ARGB : int
(** Constant ``ARGB``. *)

val cl_INTENSITY : int
(** Constant ``INTENSITY``. *)

val cl_LUMINANCE : int
(** Constant ``LUMINANCE``. *)

val cl_Rx : int
(** Constant ``Rx``. *)

val cl_RGx : int
(** Constant ``RGx``. *)

val cl_RGBx : int
(** Constant ``RGBx``. *)

val cl_DEPTH : int
(** Constant ``DEPTH``. *)

val cl_DEPTH_STENCIL : int
(** Constant ``DEPTH_STENCIL``. *)

val cl_SNORM_INT8 : int
(** Constant ``SNORM_INT8``. *)

val cl_SNORM_INT16 : int
(** Constant ``SNORM_INT16``. *)

val cl_UNORM_INT8 : int
(** Constant ``UNORM_INT8``. *)

val cl_UNORM_INT16 : int
(** Constant ``UNORM_INT16``. *)

val cl_UNORM_SHORT_565 : int
(** Constant ``UNORM_SHORT_565``. *)

val cl_UNORM_SHORT_555 : int
(** Constant ``UNORM_SHORT_555``. *)

val cl_UNORM_INT_101010 : int
(** Constant ``UNORM_INT_101010``. *)

val cl_SIGNED_INT8 : int
(** Constant ``SIGNED_INT8``. *)

val cl_SIGNED_INT16 : int
(** Constant ``SIGNED_INT16``. *)

val cl_SIGNED_INT32 : int
(** Constant ``SIGNED_INT32``. *)

val cl_UNSIGNED_INT8 : int
(** Constant ``UNSIGNED_INT8``. *)

val cl_UNSIGNED_INT16 : int
(** Constant ``UNSIGNED_INT16``. *)

val cl_UNSIGNED_INT32 : int
(** Constant ``UNSIGNED_INT32``. *)

val cl_HALF_FLOAT : int
(** Constant ``HALF_FLOAT``. *)

val cl_FLOAT : int
(** Constant ``FLOAT``. *)

val cl_UNORM_INT24 : int
(** Constant ``UNORM_INT24``. *)

val cl_MEM_OBJECT_BUFFER : int
(** Constant ``MEM_OBJECT_BUFFER``. *)

val cl_MEM_OBJECT_IMAGE2D : int
(** Constant ``MEM_OBJECT_IMAGE2D``. *)

val cl_MEM_OBJECT_IMAGE3D : int
(** Constant ``MEM_OBJECT_IMAGE3D``. *)

val cl_MEM_OBJECT_IMAGE2D_ARRAY : int
(** Constant ``MEM_OBJECT_IMAGE2D_ARRAY``. *)

val cl_MEM_OBJECT_IMAGE1D : int
(** Constant ``MEM_OBJECT_IMAGE1D``. *)

val cl_MEM_OBJECT_IMAGE1D_ARRAY : int
(** Constant ``MEM_OBJECT_IMAGE1D_ARRAY``. *)

val cl_MEM_OBJECT_IMAGE1D_BUFFER : int
(** Constant ``MEM_OBJECT_IMAGE1D_BUFFER``. *)

val cl_MEM_TYPE : int
(** Constant ``MEM_TYPE``. *)

val cl_MEM_FLAGS : int
(** Constant ``MEM_FLAGS``. *)

val cl_MEM_SIZE : int
(** Constant ``MEM_SIZE``. *)

val cl_MEM_HOST_PTR : int
(** Constant ``MEM_HOST_PTR``. *)

val cl_MEM_MAP_COUNT : int
(** Constant ``MEM_MAP_COUNT``. *)

val cl_MEM_REFERENCE_COUNT : int
(** Constant ``MEM_REFERENCE_COUNT``. *)

val cl_MEM_CONTEXT : int
(** Constant ``MEM_CONTEXT``. *)

val cl_MEM_ASSOCIATED_MEMOBJECT : int
(** Constant ``MEM_ASSOCIATED_MEMOBJECT``. *)

val cl_MEM_OFFSET : int
(** Constant ``MEM_OFFSET``. *)

val cl_IMAGE_FORMAT : int
(** Constant ``IMAGE_FORMAT``. *)

val cl_IMAGE_ELEMENT_SIZE : int
(** Constant ``IMAGE_ELEMENT_SIZE``. *)

val cl_IMAGE_ROW_PITCH : int
(** Constant ``IMAGE_ROW_PITCH``. *)

val cl_IMAGE_SLICE_PITCH : int
(** Constant ``IMAGE_SLICE_PITCH``. *)

val cl_IMAGE_WIDTH : int
(** Constant ``IMAGE_WIDTH``. *)

val cl_IMAGE_HEIGHT : int
(** Constant ``IMAGE_HEIGHT``. *)

val cl_IMAGE_DEPTH : int
(** Constant ``IMAGE_DEPTH``. *)

val cl_IMAGE_ARRAY_SIZE : int
(** Constant ``IMAGE_ARRAY_SIZE``. *)

val cl_IMAGE_BUFFER : int
(** Constant ``IMAGE_BUFFER``. *)

val cl_IMAGE_NUM_MIP_LEVELS : int
(** Constant ``IMAGE_NUM_MIP_LEVELS``. *)

val cl_IMAGE_NUM_SAMPLES : int
(** Constant ``IMAGE_NUM_SAMPLES``. *)

val cl_ADDRESS_NONE : int
(** Constant ``ADDRESS_NONE``. *)

val cl_ADDRESS_CLAMP_TO_EDGE : int
(** Constant ``ADDRESS_CLAMP_TO_EDGE``. *)

val cl_ADDRESS_CLAMP : int
(** Constant ``ADDRESS_CLAMP``. *)

val cl_ADDRESS_REPEAT : int
(** Constant ``ADDRESS_REPEAT``. *)

val cl_ADDRESS_MIRRORED_REPEAT : int
(** Constant ``ADDRESS_MIRRORED_REPEAT``. *)

val cl_FILTER_NEAREST : int
(** Constant ``FILTER_NEAREST``. *)

val cl_FILTER_LINEAR : int
(** Constant ``FILTER_LINEAR``. *)

val cl_SAMPLER_REFERENCE_COUNT : int
(** Constant ``SAMPLER_REFERENCE_COUNT``. *)

val cl_SAMPLER_CONTEXT : int
(** Constant ``SAMPLER_CONTEXT``. *)

val cl_SAMPLER_NORMALIZED_COORDS : int
(** Constant ``SAMPLER_NORMALIZED_COORDS``. *)

val cl_SAMPLER_ADDRESSING_MODE : int
(** Constant ``SAMPLER_ADDRESSING_MODE``. *)

val cl_SAMPLER_FILTER_MODE : int
(** Constant ``SAMPLER_FILTER_MODE``. *)

val cl_MAP_READ : int
(** Constant ``MAP_READ``. *)

val cl_MAP_WRITE : int
(** Constant ``MAP_WRITE``. *)

val cl_MAP_WRITE_INVALIDATE_REGION : int
(** Constant ``MAP_WRITE_INVALIDATE_REGION``. *)

val cl_PROGRAM_REFERENCE_COUNT : int
(** Constant ``PROGRAM_REFERENCE_COUNT``. *)

val cl_PROGRAM_CONTEXT : int
(** Constant ``PROGRAM_CONTEXT``. *)

val cl_PROGRAM_NUM_DEVICES : int
(** Constant ``PROGRAM_NUM_DEVICES``. *)

val cl_PROGRAM_DEVICES : int
(** Constant ``PROGRAM_DEVICES``. *)

val cl_PROGRAM_SOURCE : int
(** Constant ``PROGRAM_SOURCE``. *)

val cl_PROGRAM_BINARY_SIZES : int
(** Constant ``PROGRAM_BINARY_SIZES``. *)

val cl_PROGRAM_BINARIES : int
(** Constant ``PROGRAM_BINARIES``. *)

val cl_PROGRAM_NUM_KERNELS : int
(** Constant ``PROGRAM_NUM_KERNELS``. *)

val cl_PROGRAM_KERNEL_NAMES : int
(** Constant ``PROGRAM_KERNEL_NAMES``. *)

val cl_PROGRAM_BUILD_STATUS : int
(** Constant ``PROGRAM_BUILD_STATUS``. *)

val cl_PROGRAM_BUILD_OPTIONS : int
(** Constant ``PROGRAM_BUILD_OPTIONS``. *)

val cl_PROGRAM_BUILD_LOG : int
(** Constant ``PROGRAM_BUILD_LOG``. *)

val cl_PROGRAM_BINARY_TYPE : int
(** Constant ``PROGRAM_BINARY_TYPE``. *)

val cl_PROGRAM_BINARY_TYPE_NONE : int
(** Constant ``PROGRAM_BINARY_TYPE_NONE``. *)

val cl_PROGRAM_BINARY_TYPE_COMPILED_OBJECT : int
(** Constant ``PROGRAM_BINARY_TYPE_COMPILED_OBJECT``. *)

val cl_PROGRAM_BINARY_TYPE_LIBRARY : int
(** Constant ``PROGRAM_BINARY_TYPE_LIBRARY``. *)

val cl_PROGRAM_BINARY_TYPE_EXECUTABLE : int
(** Constant ``PROGRAM_BINARY_TYPE_EXECUTABLE``. *)

val cl_BUILD_SUCCESS : int
(** Constant ``BUILD_SUCCESS``. *)

val cl_BUILD_NONE : int
(** Constant ``BUILD_NONE``. *)

val cl_BUILD_ERROR : int
(** Constant ``BUILD_ERROR``. *)

val cl_BUILD_IN_PROGRESS : int
(** Constant ``BUILD_IN_PROGRESS``. *)

val cl_KERNEL_FUNCTION_NAME : int
(** Constant ``KERNEL_FUNCTION_NAME``. *)

val cl_KERNEL_NUM_ARGS : int
(** Constant ``KERNEL_NUM_ARGS``. *)

val cl_KERNEL_REFERENCE_COUNT : int
(** Constant ``KERNEL_REFERENCE_COUNT``. *)

val cl_KERNEL_CONTEXT : int
(** Constant ``KERNEL_CONTEXT``. *)

val cl_KERNEL_PROGRAM : int
(** Constant ``KERNEL_PROGRAM``. *)

val cl_KERNEL_ATTRIBUTES : int
(** Constant ``KERNEL_ATTRIBUTES``. *)

val cl_KERNEL_ARG_ADDRESS_QUALIFIER : int
(** Constant ``KERNEL_ARG_ADDRESS_QUALIFIER``. *)

val cl_KERNEL_ARG_ACCESS_QUALIFIER : int
(** Constant ``KERNEL_ARG_ACCESS_QUALIFIER``. *)

val cl_KERNEL_ARG_TYPE_NAME : int
(** Constant ``KERNEL_ARG_TYPE_NAME``. *)

val cl_KERNEL_ARG_TYPE_QUALIFIER : int
(** Constant ``KERNEL_ARG_TYPE_QUALIFIER``. *)

val cl_KERNEL_ARG_NAME : int
(** Constant ``KERNEL_ARG_NAME``. *)

val cl_KERNEL_ARG_ADDRESS_GLOBAL : int
(** Constant ``KERNEL_ARG_ADDRESS_GLOBAL``. *)

val cl_KERNEL_ARG_ADDRESS_LOCAL : int
(** Constant ``KERNEL_ARG_ADDRESS_LOCAL``. *)

val cl_KERNEL_ARG_ADDRESS_CONSTANT : int
(** Constant ``KERNEL_ARG_ADDRESS_CONSTANT``. *)

val cl_KERNEL_ARG_ADDRESS_PRIVATE : int
(** Constant ``KERNEL_ARG_ADDRESS_PRIVATE``. *)

val cl_KERNEL_ARG_ACCESS_READ_ONLY : int
(** Constant ``KERNEL_ARG_ACCESS_READ_ONLY``. *)

val cl_KERNEL_ARG_ACCESS_WRITE_ONLY : int
(** Constant ``KERNEL_ARG_ACCESS_WRITE_ONLY``. *)

val cl_KERNEL_ARG_ACCESS_READ_WRITE : int
(** Constant ``KERNEL_ARG_ACCESS_READ_WRITE``. *)

val cl_KERNEL_ARG_ACCESS_NONE : int
(** Constant ``KERNEL_ARG_ACCESS_NONE``. *)

val cl_KERNEL_ARG_TYPE_NONE : int
(** Constant ``KERNEL_ARG_TYPE_NONE``. *)

val cl_KERNEL_ARG_TYPE_CONST : int
(** Constant ``KERNEL_ARG_TYPE_CONST``. *)

val cl_KERNEL_ARG_TYPE_RESTRICT : int
(** Constant ``KERNEL_ARG_TYPE_RESTRICT``. *)

val cl_KERNEL_ARG_TYPE_VOLATILE : int
(** Constant ``KERNEL_ARG_TYPE_VOLATILE``. *)

val cl_KERNEL_WORK_GROUP_SIZE : int
(** Constant ``KERNEL_WORK_GROUP_SIZE``. *)

val cl_KERNEL_COMPILE_WORK_GROUP_SIZE : int
(** Constant ``KERNEL_COMPILE_WORK_GROUP_SIZE``. *)

val cl_KERNEL_LOCAL_MEM_SIZE : int
(** Constant ``KERNEL_LOCAL_MEM_SIZE``. *)

val cl_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE : int
(** Constant ``KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE``. *)

val cl_KERNEL_PRIVATE_MEM_SIZE : int
(** Constant ``KERNEL_PRIVATE_MEM_SIZE``. *)

val cl_KERNEL_GLOBAL_WORK_SIZE : int
(** Constant ``KERNEL_GLOBAL_WORK_SIZE``. *)

val cl_EVENT_COMMAND_QUEUE : int
(** Constant ``EVENT_COMMAND_QUEUE``. *)

val cl_EVENT_COMMAND_TYPE : int
(** Constant ``EVENT_COMMAND_TYPE``. *)

val cl_EVENT_REFERENCE_COUNT : int
(** Constant ``EVENT_REFERENCE_COUNT``. *)

val cl_EVENT_COMMAND_EXECUTION_STATUS : int
(** Constant ``EVENT_COMMAND_EXECUTION_STATUS``. *)

val cl_EVENT_CONTEXT : int
(** Constant ``EVENT_CONTEXT``. *)

val cl_COMMAND_NDRANGE_KERNEL : int
(** Constant ``COMMAND_NDRANGE_KERNEL``. *)

val cl_COMMAND_TASK : int
(** Constant ``COMMAND_TASK``. *)

val cl_COMMAND_NATIVE_KERNEL : int
(** Constant ``COMMAND_NATIVE_KERNEL``. *)

val cl_COMMAND_READ_BUFFER : int
(** Constant ``COMMAND_READ_BUFFER``. *)

val cl_COMMAND_WRITE_BUFFER : int
(** Constant ``COMMAND_WRITE_BUFFER``. *)

val cl_COMMAND_COPY_BUFFER : int
(** Constant ``COMMAND_COPY_BUFFER``. *)

val cl_COMMAND_READ_IMAGE : int
(** Constant ``COMMAND_READ_IMAGE``. *)

val cl_COMMAND_WRITE_IMAGE : int
(** Constant ``COMMAND_WRITE_IMAGE``. *)

val cl_COMMAND_COPY_IMAGE : int
(** Constant ``COMMAND_COPY_IMAGE``. *)

val cl_COMMAND_COPY_IMAGE_TO_BUFFER : int
(** Constant ``COMMAND_COPY_IMAGE_TO_BUFFER``. *)

val cl_COMMAND_COPY_BUFFER_TO_IMAGE : int
(** Constant ``COMMAND_COPY_BUFFER_TO_IMAGE``. *)

val cl_COMMAND_MAP_BUFFER : int
(** Constant ``COMMAND_MAP_BUFFER``. *)

val cl_COMMAND_MAP_IMAGE : int
(** Constant ``COMMAND_MAP_IMAGE``. *)

val cl_COMMAND_UNMAP_MEM_OBJECT : int
(** Constant ``COMMAND_UNMAP_MEM_OBJECT``. *)

val cl_COMMAND_MARKER : int
(** Constant ``COMMAND_MARKER``. *)

val cl_COMMAND_ACQUIRE_GL_OBJECTS : int
(** Constant ``COMMAND_ACQUIRE_GL_OBJECTS``. *)

val cl_COMMAND_RELEASE_GL_OBJECTS : int
(** Constant ``COMMAND_RELEASE_GL_OBJECTS``. *)

val cl_COMMAND_READ_BUFFER_RECT : int
(** Constant ``COMMAND_READ_BUFFER_RECT``. *)

val cl_COMMAND_WRITE_BUFFER_RECT : int
(** Constant ``COMMAND_WRITE_BUFFER_RECT``. *)

val cl_COMMAND_COPY_BUFFER_RECT : int
(** Constant ``COMMAND_COPY_BUFFER_RECT``. *)

val cl_COMMAND_USER : int
(** Constant ``COMMAND_USER``. *)

val cl_COMMAND_BARRIER : int
(** Constant ``COMMAND_BARRIER``. *)

val cl_COMMAND_MIGRATE_MEM_OBJECTS : int
(** Constant ``COMMAND_MIGRATE_MEM_OBJECTS``. *)

val cl_COMMAND_FILL_BUFFER : int
(** Constant ``COMMAND_FILL_BUFFER``. *)

val cl_COMMAND_FILL_IMAGE : int
(** Constant ``COMMAND_FILL_IMAGE``. *)

val cl_COMPLETE : int
(** Constant ``COMPLETE``. *)

val cl_RUNNING : int
(** Constant ``RUNNING``. *)

val cl_SUBMITTED : int
(** Constant ``SUBMITTED``. *)

val cl_QUEUED : int
(** Constant ``QUEUED``. *)

val cl_BUFFER_CREATE_TYPE_REGION : int
(** Constant ``BUFFER_CREATE_TYPE_REGION``. *)

val cl_PROFILING_COMMAND_QUEUED : int
(** Constant ``PROFILING_COMMAND_QUEUED``. *)

val cl_PROFILING_COMMAND_SUBMIT : int
(** Constant ``PROFILING_COMMAND_SUBMIT``. *)

val cl_PROFILING_COMMAND_START : int
(** Constant ``PROFILING_COMMAND_START``. *)

val cl_PROFILING_COMMAND_END : int
(** Constant ``PROFILING_COMMAND_END``. *)



(** {6 Exception definition} *)

exception EXN_SUCCESS
(** Exception ``EXN_SUCCESS``. *)

exception EXN_DEVICE_NOT_FOUND
(** Exception ``EXN_DEVICE_NOT_FOUND``. *)

exception EXN_DEVICE_NOT_AVAILABLE
(** Exception ``EXN_DEVICE_NOT_AVAILABLE``. *)

exception EXN_COMPILER_NOT_AVAILABLE
(** Exception ``EXN_COMPILER_NOT_AVAILABLE``. *)

exception EXN_MEM_OBJECT_ALLOCATION_FAILURE
(** Exception ``EXN_MEM_OBJECT_ALLOCATION_FAILURE``. *)

exception EXN_OUT_OF_RESOURCES
(** Exception ``EXN_OUT_OF_RESOURCES``. *)

exception EXN_OUT_OF_HOST_MEMORY
(** Exception ``EXN_OUT_OF_HOST_MEMORY``. *)

exception EXN_PROFILING_INFO_NOT_AVAILABLE
(** Exception ``EXN_PROFILING_INFO_NOT_AVAILABLE``. *)

exception EXN_MEM_COPY_OVERLAP
(** Exception ``EXN_MEM_COPY_OVERLAP``. *)

exception EXN_IMAGE_FORMAT_MISMATCH
(** Exception ``EXN_IMAGE_FORMAT_MISMATCH``. *)

exception EXN_IMAGE_FORMAT_NOT_SUPPORTED
(** Exception ``EXN_IMAGE_FORMAT_NOT_SUPPORTED``. *)

exception EXN_BUILD_PROGRAM_FAILURE
(** Exception ``EXN_BUILD_PROGRAM_FAILURE``. *)

exception EXN_MAP_FAILURE
(** Exception ``EXN_MAP_FAILURE``. *)

exception EXN_MISALIGNED_SUB_BUFFER_OFFSET
(** Exception ``EXN_MISALIGNED_SUB_BUFFER_OFFSET``. *)

exception EXN_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST
(** Exception ``EXN_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST``. *)

exception EXN_COMPILE_PROGRAM_FAILURE
(** Exception ``EXN_COMPILE_PROGRAM_FAILURE``. *)

exception EXN_LINKER_NOT_AVAILABLE
(** Exception ``EXN_LINKER_NOT_AVAILABLE``. *)

exception EXN_LINK_PROGRAM_FAILURE
(** Exception ``EXN_LINK_PROGRAM_FAILURE``. *)

exception EXN_DEVICE_PARTITION_FAILED
(** Exception ``EXN_DEVICE_PARTITION_FAILED``. *)

exception EXN_KERNEL_ARG_INFO_NOT_AVAILABLE
(** Exception ``EXN_KERNEL_ARG_INFO_NOT_AVAILABLE``. *)

exception EXN_INVALID_VALUE
(** Exception ``EXN_INVALID_VALUE``. *)

exception EXN_INVALID_DEVICE_TYPE
(** Exception ``EXN_INVALID_DEVICE_TYPE``. *)

exception EXN_INVALID_PLATFORM
(** Exception ``EXN_INVALID_PLATFORM``. *)

exception EXN_INVALID_DEVICE
(** Exception ``EXN_INVALID_DEVICE``. *)

exception EXN_INVALID_CONTEXT
(** Exception ``EXN_INVALID_CONTEXT``. *)

exception EXN_INVALID_QUEUE_PROPERTIES
(** Exception ``EXN_INVALID_QUEUE_PROPERTIES``. *)

exception EXN_INVALID_COMMAND_QUEUE
(** Exception ``EXN_INVALID_COMMAND_QUEUE``. *)

exception EXN_INVALID_HOST_PTR
(** Exception ``EXN_INVALID_HOST_PTR``. *)

exception EXN_INVALID_MEM_OBJECT
(** Exception ``EXN_INVALID_MEM_OBJECT``. *)

exception EXN_INVALID_IMAGE_FORMAT_DESCRIPTOR
(** Exception ``EXN_INVALID_IMAGE_FORMAT_DESCRIPTOR``. *)

exception EXN_INVALID_IMAGE_SIZE
(** Exception ``EXN_INVALID_IMAGE_SIZE``. *)

exception EXN_INVALID_SAMPLER
(** Exception ``EXN_INVALID_SAMPLER``. *)

exception EXN_INVALID_BINARY
(** Exception ``EXN_INVALID_BINARY``. *)

exception EXN_INVALID_BUILD_OPTIONS
(** Exception ``EXN_INVALID_BUILD_OPTIONS``. *)

exception EXN_INVALID_PROGRAM
(** Exception ``EXN_INVALID_PROGRAM``. *)

exception EXN_INVALID_PROGRAM_EXECUTABLE
(** Exception ``EXN_INVALID_PROGRAM_EXECUTABLE``. *)

exception EXN_INVALID_KERNEL_NAME
(** Exception ``EXN_INVALID_KERNEL_NAME``. *)

exception EXN_INVALID_KERNEL_DEFINITION
(** Exception ``EXN_INVALID_KERNEL_DEFINITION``. *)

exception EXN_INVALID_KERNEL
(** Exception ``EXN_INVALID_KERNEL``. *)

exception EXN_INVALID_ARG_INDEX
(** Exception ``EXN_INVALID_ARG_INDEX``. *)

exception EXN_INVALID_ARG_VALUE
(** Exception ``EXN_INVALID_ARG_VALUE``. *)

exception EXN_INVALID_ARG_SIZE
(** Exception ``EXN_INVALID_ARG_SIZE``. *)

exception EXN_INVALID_KERNEL_ARGS
(** Exception ``EXN_INVALID_KERNEL_ARGS``. *)

exception EXN_INVALID_WORK_DIMENSION
(** Exception ``EXN_INVALID_WORK_DIMENSION``. *)

exception EXN_INVALID_WORK_GROUP_SIZE
(** Exception ``EXN_INVALID_WORK_GROUP_SIZE``. *)

exception EXN_INVALID_WORK_ITEM_SIZE
(** Exception ``EXN_INVALID_WORK_ITEM_SIZE``. *)

exception EXN_INVALID_GLOBAL_OFFSET
(** Exception ``EXN_INVALID_GLOBAL_OFFSET``. *)

exception EXN_INVALID_EVENT_WAIT_LIST
(** Exception ``EXN_INVALID_EVENT_WAIT_LIST``. *)

exception EXN_INVALID_EVENT
(** Exception ``EXN_INVALID_EVENT``. *)

exception EXN_INVALID_OPERATION
(** Exception ``EXN_INVALID_OPERATION``. *)

exception EXN_INVALID_GL_OBJECT
(** Exception ``EXN_INVALID_GL_OBJECT``. *)

exception EXN_INVALID_BUFFER_SIZE
(** Exception ``EXN_INVALID_BUFFER_SIZE``. *)

exception EXN_INVALID_MIP_LEVEL
(** Exception ``EXN_INVALID_MIP_LEVEL``. *)

exception EXN_INVALID_GLOBAL_WORK_SIZE
(** Exception ``EXN_INVALID_GLOBAL_WORK_SIZE``. *)

exception EXN_INVALID_PROPERTY
(** Exception ``EXN_INVALID_PROPERTY``. *)

exception EXN_INVALID_IMAGE_DESCRIPTOR
(** Exception ``EXN_INVALID_IMAGE_DESCRIPTOR``. *)

exception EXN_INVALID_COMPILER_OPTIONS
(** Exception ``EXN_INVALID_COMPILER_OPTIONS``. *)

exception EXN_INVALID_LINKER_OPTIONS
(** Exception ``EXN_INVALID_LINKER_OPTIONS``. *)

exception EXN_INVALID_DEVICE_PARTITION_COUNT
(** Exception ``EXN_INVALID_DEVICE_PARTITION_COUNT``. *)

