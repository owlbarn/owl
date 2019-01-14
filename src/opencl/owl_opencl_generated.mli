(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1517850866 *)

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
(** Constant ``SUCCESS = 0``. *)

val cl_DEVICE_NOT_FOUND : int
(** Constant ``DEVICE_NOT_FOUND = -1``. *)

val cl_DEVICE_NOT_AVAILABLE : int
(** Constant ``DEVICE_NOT_AVAILABLE = -2``. *)

val cl_COMPILER_NOT_AVAILABLE : int
(** Constant ``COMPILER_NOT_AVAILABLE = -3``. *)

val cl_MEM_OBJECT_ALLOCATION_FAILURE : int
(** Constant ``MEM_OBJECT_ALLOCATION_FAILURE = -4``. *)

val cl_OUT_OF_RESOURCES : int
(** Constant ``OUT_OF_RESOURCES = -5``. *)

val cl_OUT_OF_HOST_MEMORY : int
(** Constant ``OUT_OF_HOST_MEMORY = -6``. *)

val cl_PROFILING_INFO_NOT_AVAILABLE : int
(** Constant ``PROFILING_INFO_NOT_AVAILABLE = -7``. *)

val cl_MEM_COPY_OVERLAP : int
(** Constant ``MEM_COPY_OVERLAP = -8``. *)

val cl_IMAGE_FORMAT_MISMATCH : int
(** Constant ``IMAGE_FORMAT_MISMATCH = -9``. *)

val cl_IMAGE_FORMAT_NOT_SUPPORTED : int
(** Constant ``IMAGE_FORMAT_NOT_SUPPORTED = -10``. *)

val cl_BUILD_PROGRAM_FAILURE : int
(** Constant ``BUILD_PROGRAM_FAILURE = -11``. *)

val cl_MAP_FAILURE : int
(** Constant ``MAP_FAILURE = -12``. *)

val cl_MISALIGNED_SUB_BUFFER_OFFSET : int
(** Constant ``MISALIGNED_SUB_BUFFER_OFFSET = -13``. *)

val cl_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST : int
(** Constant ``EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14``. *)

val cl_COMPILE_PROGRAM_FAILURE : int
(** Constant ``COMPILE_PROGRAM_FAILURE = -15``. *)

val cl_LINKER_NOT_AVAILABLE : int
(** Constant ``LINKER_NOT_AVAILABLE = -16``. *)

val cl_LINK_PROGRAM_FAILURE : int
(** Constant ``LINK_PROGRAM_FAILURE = -17``. *)

val cl_DEVICE_PARTITION_FAILED : int
(** Constant ``DEVICE_PARTITION_FAILED = -18``. *)

val cl_KERNEL_ARG_INFO_NOT_AVAILABLE : int
(** Constant ``KERNEL_ARG_INFO_NOT_AVAILABLE = -19``. *)

val cl_INVALID_VALUE : int
(** Constant ``INVALID_VALUE = -30``. *)

val cl_INVALID_DEVICE_TYPE : int
(** Constant ``INVALID_DEVICE_TYPE = -31``. *)

val cl_INVALID_PLATFORM : int
(** Constant ``INVALID_PLATFORM = -32``. *)

val cl_INVALID_DEVICE : int
(** Constant ``INVALID_DEVICE = -33``. *)

val cl_INVALID_CONTEXT : int
(** Constant ``INVALID_CONTEXT = -34``. *)

val cl_INVALID_QUEUE_PROPERTIES : int
(** Constant ``INVALID_QUEUE_PROPERTIES = -35``. *)

val cl_INVALID_COMMAND_QUEUE : int
(** Constant ``INVALID_COMMAND_QUEUE = -36``. *)

val cl_INVALID_HOST_PTR : int
(** Constant ``INVALID_HOST_PTR = -37``. *)

val cl_INVALID_MEM_OBJECT : int
(** Constant ``INVALID_MEM_OBJECT = -38``. *)

val cl_INVALID_IMAGE_FORMAT_DESCRIPTOR : int
(** Constant ``INVALID_IMAGE_FORMAT_DESCRIPTOR = -39``. *)

val cl_INVALID_IMAGE_SIZE : int
(** Constant ``INVALID_IMAGE_SIZE = -40``. *)

val cl_INVALID_SAMPLER : int
(** Constant ``INVALID_SAMPLER = -41``. *)

val cl_INVALID_BINARY : int
(** Constant ``INVALID_BINARY = -42``. *)

val cl_INVALID_BUILD_OPTIONS : int
(** Constant ``INVALID_BUILD_OPTIONS = -43``. *)

val cl_INVALID_PROGRAM : int
(** Constant ``INVALID_PROGRAM = -44``. *)

val cl_INVALID_PROGRAM_EXECUTABLE : int
(** Constant ``INVALID_PROGRAM_EXECUTABLE = -45``. *)

val cl_INVALID_KERNEL_NAME : int
(** Constant ``INVALID_KERNEL_NAME = -46``. *)

val cl_INVALID_KERNEL_DEFINITION : int
(** Constant ``INVALID_KERNEL_DEFINITION = -47``. *)

val cl_INVALID_KERNEL : int
(** Constant ``INVALID_KERNEL = -48``. *)

val cl_INVALID_ARG_INDEX : int
(** Constant ``INVALID_ARG_INDEX = -49``. *)

val cl_INVALID_ARG_VALUE : int
(** Constant ``INVALID_ARG_VALUE = -50``. *)

val cl_INVALID_ARG_SIZE : int
(** Constant ``INVALID_ARG_SIZE = -51``. *)

val cl_INVALID_KERNEL_ARGS : int
(** Constant ``INVALID_KERNEL_ARGS = -52``. *)

val cl_INVALID_WORK_DIMENSION : int
(** Constant ``INVALID_WORK_DIMENSION = -53``. *)

val cl_INVALID_WORK_GROUP_SIZE : int
(** Constant ``INVALID_WORK_GROUP_SIZE = -54``. *)

val cl_INVALID_WORK_ITEM_SIZE : int
(** Constant ``INVALID_WORK_ITEM_SIZE = -55``. *)

val cl_INVALID_GLOBAL_OFFSET : int
(** Constant ``INVALID_GLOBAL_OFFSET = -56``. *)

val cl_INVALID_EVENT_WAIT_LIST : int
(** Constant ``INVALID_EVENT_WAIT_LIST = -57``. *)

val cl_INVALID_EVENT : int
(** Constant ``INVALID_EVENT = -58``. *)

val cl_INVALID_OPERATION : int
(** Constant ``INVALID_OPERATION = -59``. *)

val cl_INVALID_GL_OBJECT : int
(** Constant ``INVALID_GL_OBJECT = -60``. *)

val cl_INVALID_BUFFER_SIZE : int
(** Constant ``INVALID_BUFFER_SIZE = -61``. *)

val cl_INVALID_MIP_LEVEL : int
(** Constant ``INVALID_MIP_LEVEL = -62``. *)

val cl_INVALID_GLOBAL_WORK_SIZE : int
(** Constant ``INVALID_GLOBAL_WORK_SIZE = -63``. *)

val cl_INVALID_PROPERTY : int
(** Constant ``INVALID_PROPERTY = -64``. *)

val cl_INVALID_IMAGE_DESCRIPTOR : int
(** Constant ``INVALID_IMAGE_DESCRIPTOR = -65``. *)

val cl_INVALID_COMPILER_OPTIONS : int
(** Constant ``INVALID_COMPILER_OPTIONS = -66``. *)

val cl_INVALID_LINKER_OPTIONS : int
(** Constant ``INVALID_LINKER_OPTIONS = -67``. *)

val cl_INVALID_DEVICE_PARTITION_COUNT : int
(** Constant ``INVALID_DEVICE_PARTITION_COUNT = -68``. *)

val cl_VERSION_1_0 : int
(** Constant ``VERSION_1_0 = 1``. *)

val cl_VERSION_1_1 : int
(** Constant ``VERSION_1_1 = 1``. *)

val cl_VERSION_1_2 : int
(** Constant ``VERSION_1_2 = 1``. *)

val cl_FALSE : int
(** Constant ``FALSE = 0``. *)

val cl_TRUE : int
(** Constant ``TRUE = 1``. *)

val cl_BLOCKING : int
(** Constant ``BLOCKING = 1``. *)

val cl_NON_BLOCKING : int
(** Constant ``NON_BLOCKING = 0``. *)

val cl_PLATFORM_PROFILE : int
(** Constant ``PLATFORM_PROFILE = 0x0900``. *)

val cl_PLATFORM_VERSION : int
(** Constant ``PLATFORM_VERSION = 0x0901``. *)

val cl_PLATFORM_NAME : int
(** Constant ``PLATFORM_NAME = 0x0902``. *)

val cl_PLATFORM_VENDOR : int
(** Constant ``PLATFORM_VENDOR = 0x0903``. *)

val cl_PLATFORM_EXTENSIONS : int
(** Constant ``PLATFORM_EXTENSIONS = 0x0904``. *)

val cl_DEVICE_TYPE_DEFAULT : int
(** Constant ``DEVICE_TYPE_DEFAULT = (1 lsl 0)``. *)

val cl_DEVICE_TYPE_CPU : int
(** Constant ``DEVICE_TYPE_CPU = (1 lsl 1)``. *)

val cl_DEVICE_TYPE_GPU : int
(** Constant ``DEVICE_TYPE_GPU = (1 lsl 2)``. *)

val cl_DEVICE_TYPE_ACCELERATOR : int
(** Constant ``DEVICE_TYPE_ACCELERATOR = (1 lsl 3)``. *)

val cl_DEVICE_TYPE_CUSTOM : int
(** Constant ``DEVICE_TYPE_CUSTOM = (1 lsl 4)``. *)

val cl_DEVICE_TYPE_ALL : int
(** Constant ``DEVICE_TYPE_ALL = 0xFFFFFFFF``. *)

val cl_DEVICE_TYPE : int
(** Constant ``DEVICE_TYPE = 0x1000``. *)

val cl_DEVICE_VENDOR_ID : int
(** Constant ``DEVICE_VENDOR_ID = 0x1001``. *)

val cl_DEVICE_MAX_COMPUTE_UNITS : int
(** Constant ``DEVICE_MAX_COMPUTE_UNITS = 0x1002``. *)

val cl_DEVICE_MAX_WORK_ITEM_DIMENSIONS : int
(** Constant ``DEVICE_MAX_WORK_ITEM_DIMENSIONS = 0x1003``. *)

val cl_DEVICE_MAX_WORK_GROUP_SIZE : int
(** Constant ``DEVICE_MAX_WORK_GROUP_SIZE = 0x1004``. *)

val cl_DEVICE_MAX_WORK_ITEM_SIZES : int
(** Constant ``DEVICE_MAX_WORK_ITEM_SIZES = 0x1005``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_CHAR = 0x1006``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_SHORT = 0x1007``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_INT : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_INT = 0x1008``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_LONG : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_LONG = 0x1009``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT = 0x100A``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE = 0x100B``. *)

val cl_DEVICE_MAX_CLOCK_FREQUENCY : int
(** Constant ``DEVICE_MAX_CLOCK_FREQUENCY = 0x100C``. *)

val cl_DEVICE_ADDRESS_BITS : int
(** Constant ``DEVICE_ADDRESS_BITS = 0x100D``. *)

val cl_DEVICE_MAX_READ_IMAGE_ARGS : int
(** Constant ``DEVICE_MAX_READ_IMAGE_ARGS = 0x100E``. *)

val cl_DEVICE_MAX_WRITE_IMAGE_ARGS : int
(** Constant ``DEVICE_MAX_WRITE_IMAGE_ARGS = 0x100F``. *)

val cl_DEVICE_MAX_MEM_ALLOC_SIZE : int
(** Constant ``DEVICE_MAX_MEM_ALLOC_SIZE = 0x1010``. *)

val cl_DEVICE_IMAGE2D_MAX_WIDTH : int
(** Constant ``DEVICE_IMAGE2D_MAX_WIDTH = 0x1011``. *)

val cl_DEVICE_IMAGE2D_MAX_HEIGHT : int
(** Constant ``DEVICE_IMAGE2D_MAX_HEIGHT = 0x1012``. *)

val cl_DEVICE_IMAGE3D_MAX_WIDTH : int
(** Constant ``DEVICE_IMAGE3D_MAX_WIDTH = 0x1013``. *)

val cl_DEVICE_IMAGE3D_MAX_HEIGHT : int
(** Constant ``DEVICE_IMAGE3D_MAX_HEIGHT = 0x1014``. *)

val cl_DEVICE_IMAGE3D_MAX_DEPTH : int
(** Constant ``DEVICE_IMAGE3D_MAX_DEPTH = 0x1015``. *)

val cl_DEVICE_IMAGE_SUPPORT : int
(** Constant ``DEVICE_IMAGE_SUPPORT = 0x1016``. *)

val cl_DEVICE_MAX_PARAMETER_SIZE : int
(** Constant ``DEVICE_MAX_PARAMETER_SIZE = 0x1017``. *)

val cl_DEVICE_MAX_SAMPLERS : int
(** Constant ``DEVICE_MAX_SAMPLERS = 0x1018``. *)

val cl_DEVICE_MEM_BASE_ADDR_ALIGN : int
(** Constant ``DEVICE_MEM_BASE_ADDR_ALIGN = 0x1019``. *)

val cl_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE : int
(** Constant ``DEVICE_MIN_DATA_TYPE_ALIGN_SIZE = 0x101A``. *)

val cl_DEVICE_SINGLE_FP_CONFIG : int
(** Constant ``DEVICE_SINGLE_FP_CONFIG = 0x101B``. *)

val cl_DEVICE_GLOBAL_MEM_CACHE_TYPE : int
(** Constant ``DEVICE_GLOBAL_MEM_CACHE_TYPE = 0x101C``. *)

val cl_DEVICE_GLOBAL_MEM_CACHELINE_SIZE : int
(** Constant ``DEVICE_GLOBAL_MEM_CACHELINE_SIZE = 0x101D``. *)

val cl_DEVICE_GLOBAL_MEM_CACHE_SIZE : int
(** Constant ``DEVICE_GLOBAL_MEM_CACHE_SIZE = 0x101E``. *)

val cl_DEVICE_GLOBAL_MEM_SIZE : int
(** Constant ``DEVICE_GLOBAL_MEM_SIZE = 0x101F``. *)

val cl_DEVICE_MAX_CONSTANT_BUFFER_SIZE : int
(** Constant ``DEVICE_MAX_CONSTANT_BUFFER_SIZE = 0x1020``. *)

val cl_DEVICE_MAX_CONSTANT_ARGS : int
(** Constant ``DEVICE_MAX_CONSTANT_ARGS = 0x1021``. *)

val cl_DEVICE_LOCAL_MEM_TYPE : int
(** Constant ``DEVICE_LOCAL_MEM_TYPE = 0x1022``. *)

val cl_DEVICE_LOCAL_MEM_SIZE : int
(** Constant ``DEVICE_LOCAL_MEM_SIZE = 0x1023``. *)

val cl_DEVICE_ERROR_CORRECTION_SUPPORT : int
(** Constant ``DEVICE_ERROR_CORRECTION_SUPPORT = 0x1024``. *)

val cl_DEVICE_PROFILING_TIMER_RESOLUTION : int
(** Constant ``DEVICE_PROFILING_TIMER_RESOLUTION = 0x1025``. *)

val cl_DEVICE_ENDIAN_LITTLE : int
(** Constant ``DEVICE_ENDIAN_LITTLE = 0x1026``. *)

val cl_DEVICE_AVAILABLE : int
(** Constant ``DEVICE_AVAILABLE = 0x1027``. *)

val cl_DEVICE_COMPILER_AVAILABLE : int
(** Constant ``DEVICE_COMPILER_AVAILABLE = 0x1028``. *)

val cl_DEVICE_EXECUTION_CAPABILITIES : int
(** Constant ``DEVICE_EXECUTION_CAPABILITIES = 0x1029``. *)

val cl_DEVICE_QUEUE_PROPERTIES : int
(** Constant ``DEVICE_QUEUE_PROPERTIES = 0x102A``. *)

val cl_DEVICE_NAME : int
(** Constant ``DEVICE_NAME = 0x102B``. *)

val cl_DEVICE_VENDOR : int
(** Constant ``DEVICE_VENDOR = 0x102C``. *)

val cl_DRIVER_VERSION : int
(** Constant ``DRIVER_VERSION = 0x102D``. *)

val cl_DEVICE_PROFILE : int
(** Constant ``DEVICE_PROFILE = 0x102E``. *)

val cl_DEVICE_VERSION : int
(** Constant ``DEVICE_VERSION = 0x102F``. *)

val cl_DEVICE_EXTENSIONS : int
(** Constant ``DEVICE_EXTENSIONS = 0x1030``. *)

val cl_DEVICE_PLATFORM : int
(** Constant ``DEVICE_PLATFORM = 0x1031``. *)

val cl_DEVICE_DOUBLE_FP_CONFIG : int
(** Constant ``DEVICE_DOUBLE_FP_CONFIG = 0x1032``. *)

val cl_DEVICE_HALF_FP_CONFIG : int
(** Constant ``DEVICE_HALF_FP_CONFIG = 0x1033``. *)

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_HALF : int
(** Constant ``DEVICE_PREFERRED_VECTOR_WIDTH_HALF = 0x1034``. *)

val cl_DEVICE_HOST_UNIFIED_MEMORY : int
(** Constant ``DEVICE_HOST_UNIFIED_MEMORY = 0x1035``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_CHAR : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_CHAR = 0x1036``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_SHORT : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_SHORT = 0x1037``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_INT : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_INT = 0x1038``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_LONG : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_LONG = 0x1039``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_FLOAT = 0x103A``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE = 0x103B``. *)

val cl_DEVICE_NATIVE_VECTOR_WIDTH_HALF : int
(** Constant ``DEVICE_NATIVE_VECTOR_WIDTH_HALF = 0x103C``. *)

val cl_DEVICE_OPENCL_C_VERSION : int
(** Constant ``DEVICE_OPENCL_C_VERSION = 0x103D``. *)

val cl_DEVICE_LINKER_AVAILABLE : int
(** Constant ``DEVICE_LINKER_AVAILABLE = 0x103E``. *)

val cl_DEVICE_BUILT_IN_KERNELS : int
(** Constant ``DEVICE_BUILT_IN_KERNELS = 0x103F``. *)

val cl_DEVICE_IMAGE_MAX_BUFFER_SIZE : int
(** Constant ``DEVICE_IMAGE_MAX_BUFFER_SIZE = 0x1040``. *)

val cl_DEVICE_IMAGE_MAX_ARRAY_SIZE : int
(** Constant ``DEVICE_IMAGE_MAX_ARRAY_SIZE = 0x1041``. *)

val cl_DEVICE_PARENT_DEVICE : int
(** Constant ``DEVICE_PARENT_DEVICE = 0x1042``. *)

val cl_DEVICE_PARTITION_MAX_SUB_DEVICES : int
(** Constant ``DEVICE_PARTITION_MAX_SUB_DEVICES = 0x1043``. *)

val cl_DEVICE_PARTITION_PROPERTIES : int
(** Constant ``DEVICE_PARTITION_PROPERTIES = 0x1044``. *)

val cl_DEVICE_PARTITION_AFFINITY_DOMAIN : int
(** Constant ``DEVICE_PARTITION_AFFINITY_DOMAIN = 0x1045``. *)

val cl_DEVICE_PARTITION_TYPE : int
(** Constant ``DEVICE_PARTITION_TYPE = 0x1046``. *)

val cl_DEVICE_REFERENCE_COUNT : int
(** Constant ``DEVICE_REFERENCE_COUNT = 0x1047``. *)

val cl_DEVICE_PREFERRED_INTEROP_USER_SYNC : int
(** Constant ``DEVICE_PREFERRED_INTEROP_USER_SYNC = 0x1048``. *)

val cl_DEVICE_PRINTF_BUFFER_SIZE : int
(** Constant ``DEVICE_PRINTF_BUFFER_SIZE = 0x1049``. *)

val cl_DEVICE_IMAGE_PITCH_ALIGNMENT : int
(** Constant ``DEVICE_IMAGE_PITCH_ALIGNMENT = 0x104A``. *)

val cl_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT : int
(** Constant ``DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT = 0x104B``. *)

val cl_FP_DENORM : int
(** Constant ``FP_DENORM = (1 lsl 0)``. *)

val cl_FP_INF_NAN : int
(** Constant ``FP_INF_NAN = (1 lsl 1)``. *)

val cl_FP_ROUND_TO_NEAREST : int
(** Constant ``FP_ROUND_TO_NEAREST = (1 lsl 2)``. *)

val cl_FP_ROUND_TO_ZERO : int
(** Constant ``FP_ROUND_TO_ZERO = (1 lsl 3)``. *)

val cl_FP_ROUND_TO_INF : int
(** Constant ``FP_ROUND_TO_INF = (1 lsl 4)``. *)

val cl_FP_FMA : int
(** Constant ``FP_FMA = (1 lsl 5)``. *)

val cl_FP_SOFT_FLOAT : int
(** Constant ``FP_SOFT_FLOAT = (1 lsl 6)``. *)

val cl_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT : int
(** Constant ``FP_CORRECTLY_ROUNDED_DIVIDE_SQRT = (1 lsl 7)``. *)

val cl_NONE : int
(** Constant ``NONE = 0x0``. *)

val cl_READ_ONLY_CACHE : int
(** Constant ``READ_ONLY_CACHE = 0x1``. *)

val cl_READ_WRITE_CACHE : int
(** Constant ``READ_WRITE_CACHE = 0x2``. *)

val cl_LOCAL : int
(** Constant ``LOCAL = 0x1``. *)

val cl_GLOBAL : int
(** Constant ``GLOBAL = 0x2``. *)

val cl_EXEC_KERNEL : int
(** Constant ``EXEC_KERNEL = (1 lsl 0)``. *)

val cl_EXEC_NATIVE_KERNEL : int
(** Constant ``EXEC_NATIVE_KERNEL = (1 lsl 1)``. *)

val cl_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE : int
(** Constant ``QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE = (1 lsl 0)``. *)

val cl_QUEUE_PROFILING_ENABLE : int
(** Constant ``QUEUE_PROFILING_ENABLE = (1 lsl 1)``. *)

val cl_CONTEXT_REFERENCE_COUNT : int
(** Constant ``CONTEXT_REFERENCE_COUNT = 0x1080``. *)

val cl_CONTEXT_DEVICES : int
(** Constant ``CONTEXT_DEVICES = 0x1081``. *)

val cl_CONTEXT_PROPERTIES : int
(** Constant ``CONTEXT_PROPERTIES = 0x1082``. *)

val cl_CONTEXT_NUM_DEVICES : int
(** Constant ``CONTEXT_NUM_DEVICES = 0x1083``. *)

val cl_CONTEXT_PLATFORM : int
(** Constant ``CONTEXT_PLATFORM = 0x1084``. *)

val cl_CONTEXT_INTEROP_USER_SYNC : int
(** Constant ``CONTEXT_INTEROP_USER_SYNC = 0x1085``. *)

val cl_DEVICE_PARTITION_EQUALLY : int
(** Constant ``DEVICE_PARTITION_EQUALLY = 0x1086``. *)

val cl_DEVICE_PARTITION_BY_COUNTS : int
(** Constant ``DEVICE_PARTITION_BY_COUNTS = 0x1087``. *)

val cl_DEVICE_PARTITION_BY_COUNTS_LIST_END : int
(** Constant ``DEVICE_PARTITION_BY_COUNTS_LIST_END = 0x0``. *)

val cl_DEVICE_PARTITION_BY_AFFINITY_DOMAIN : int
(** Constant ``DEVICE_PARTITION_BY_AFFINITY_DOMAIN = 0x1088``. *)

val cl_DEVICE_AFFINITY_DOMAIN_NUMA : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_NUMA = (1 lsl 0)``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L4_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L4_CACHE = (1 lsl 1)``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L3_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L3_CACHE = (1 lsl 2)``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L2_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L2_CACHE = (1 lsl 3)``. *)

val cl_DEVICE_AFFINITY_DOMAIN_L1_CACHE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_L1_CACHE = (1 lsl 4)``. *)

val cl_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE : int
(** Constant ``DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE = (1 lsl 5)``. *)

val cl_QUEUE_CONTEXT : int
(** Constant ``QUEUE_CONTEXT = 0x1090``. *)

val cl_QUEUE_DEVICE : int
(** Constant ``QUEUE_DEVICE = 0x1091``. *)

val cl_QUEUE_REFERENCE_COUNT : int
(** Constant ``QUEUE_REFERENCE_COUNT = 0x1092``. *)

val cl_QUEUE_PROPERTIES : int
(** Constant ``QUEUE_PROPERTIES = 0x1093``. *)

val cl_MEM_READ_WRITE : int
(** Constant ``MEM_READ_WRITE = (1 lsl 0)``. *)

val cl_MEM_WRITE_ONLY : int
(** Constant ``MEM_WRITE_ONLY = (1 lsl 1)``. *)

val cl_MEM_READ_ONLY : int
(** Constant ``MEM_READ_ONLY = (1 lsl 2)``. *)

val cl_MEM_USE_HOST_PTR : int
(** Constant ``MEM_USE_HOST_PTR = (1 lsl 3)``. *)

val cl_MEM_ALLOC_HOST_PTR : int
(** Constant ``MEM_ALLOC_HOST_PTR = (1 lsl 4)``. *)

val cl_MEM_COPY_HOST_PTR : int
(** Constant ``MEM_COPY_HOST_PTR = (1 lsl 5)``. *)

val cl_MEM_HOST_WRITE_ONLY : int
(** Constant ``MEM_HOST_WRITE_ONLY = (1 lsl 7)``. *)

val cl_MEM_HOST_READ_ONLY : int
(** Constant ``MEM_HOST_READ_ONLY = (1 lsl 8)``. *)

val cl_MEM_HOST_NO_ACCESS : int
(** Constant ``MEM_HOST_NO_ACCESS = (1 lsl 9)``. *)

val cl_MIGRATE_MEM_OBJECT_HOST : int
(** Constant ``MIGRATE_MEM_OBJECT_HOST = (1 lsl 0)``. *)

val cl_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED : int
(** Constant ``MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED = (1 lsl 1)``. *)

val cl_R : int
(** Constant ``R = 0x10B0``. *)

val cl_A : int
(** Constant ``A = 0x10B1``. *)

val cl_RG : int
(** Constant ``RG = 0x10B2``. *)

val cl_RA : int
(** Constant ``RA = 0x10B3``. *)

val cl_RGB : int
(** Constant ``RGB = 0x10B4``. *)

val cl_RGBA : int
(** Constant ``RGBA = 0x10B5``. *)

val cl_BGRA : int
(** Constant ``BGRA = 0x10B6``. *)

val cl_ARGB : int
(** Constant ``ARGB = 0x10B7``. *)

val cl_INTENSITY : int
(** Constant ``INTENSITY = 0x10B8``. *)

val cl_LUMINANCE : int
(** Constant ``LUMINANCE = 0x10B9``. *)

val cl_Rx : int
(** Constant ``Rx = 0x10BA``. *)

val cl_RGx : int
(** Constant ``RGx = 0x10BB``. *)

val cl_RGBx : int
(** Constant ``RGBx = 0x10BC``. *)

val cl_DEPTH : int
(** Constant ``DEPTH = 0x10BD``. *)

val cl_DEPTH_STENCIL : int
(** Constant ``DEPTH_STENCIL = 0x10BE``. *)

val cl_SNORM_INT8 : int
(** Constant ``SNORM_INT8 = 0x10D0``. *)

val cl_SNORM_INT16 : int
(** Constant ``SNORM_INT16 = 0x10D1``. *)

val cl_UNORM_INT8 : int
(** Constant ``UNORM_INT8 = 0x10D2``. *)

val cl_UNORM_INT16 : int
(** Constant ``UNORM_INT16 = 0x10D3``. *)

val cl_UNORM_SHORT_565 : int
(** Constant ``UNORM_SHORT_565 = 0x10D4``. *)

val cl_UNORM_SHORT_555 : int
(** Constant ``UNORM_SHORT_555 = 0x10D5``. *)

val cl_UNORM_INT_101010 : int
(** Constant ``UNORM_INT_101010 = 0x10D6``. *)

val cl_SIGNED_INT8 : int
(** Constant ``SIGNED_INT8 = 0x10D7``. *)

val cl_SIGNED_INT16 : int
(** Constant ``SIGNED_INT16 = 0x10D8``. *)

val cl_SIGNED_INT32 : int
(** Constant ``SIGNED_INT32 = 0x10D9``. *)

val cl_UNSIGNED_INT8 : int
(** Constant ``UNSIGNED_INT8 = 0x10DA``. *)

val cl_UNSIGNED_INT16 : int
(** Constant ``UNSIGNED_INT16 = 0x10DB``. *)

val cl_UNSIGNED_INT32 : int
(** Constant ``UNSIGNED_INT32 = 0x10DC``. *)

val cl_HALF_FLOAT : int
(** Constant ``HALF_FLOAT = 0x10DD``. *)

val cl_FLOAT : int
(** Constant ``FLOAT = 0x10DE``. *)

val cl_UNORM_INT24 : int
(** Constant ``UNORM_INT24 = 0x10DF``. *)

val cl_MEM_OBJECT_BUFFER : int
(** Constant ``MEM_OBJECT_BUFFER = 0x10F0``. *)

val cl_MEM_OBJECT_IMAGE2D : int
(** Constant ``MEM_OBJECT_IMAGE2D = 0x10F1``. *)

val cl_MEM_OBJECT_IMAGE3D : int
(** Constant ``MEM_OBJECT_IMAGE3D = 0x10F2``. *)

val cl_MEM_OBJECT_IMAGE2D_ARRAY : int
(** Constant ``MEM_OBJECT_IMAGE2D_ARRAY = 0x10F3``. *)

val cl_MEM_OBJECT_IMAGE1D : int
(** Constant ``MEM_OBJECT_IMAGE1D = 0x10F4``. *)

val cl_MEM_OBJECT_IMAGE1D_ARRAY : int
(** Constant ``MEM_OBJECT_IMAGE1D_ARRAY = 0x10F5``. *)

val cl_MEM_OBJECT_IMAGE1D_BUFFER : int
(** Constant ``MEM_OBJECT_IMAGE1D_BUFFER = 0x10F6``. *)

val cl_MEM_TYPE : int
(** Constant ``MEM_TYPE = 0x1100``. *)

val cl_MEM_FLAGS : int
(** Constant ``MEM_FLAGS = 0x1101``. *)

val cl_MEM_SIZE : int
(** Constant ``MEM_SIZE = 0x1102``. *)

val cl_MEM_HOST_PTR : int
(** Constant ``MEM_HOST_PTR = 0x1103``. *)

val cl_MEM_MAP_COUNT : int
(** Constant ``MEM_MAP_COUNT = 0x1104``. *)

val cl_MEM_REFERENCE_COUNT : int
(** Constant ``MEM_REFERENCE_COUNT = 0x1105``. *)

val cl_MEM_CONTEXT : int
(** Constant ``MEM_CONTEXT = 0x1106``. *)

val cl_MEM_ASSOCIATED_MEMOBJECT : int
(** Constant ``MEM_ASSOCIATED_MEMOBJECT = 0x1107``. *)

val cl_MEM_OFFSET : int
(** Constant ``MEM_OFFSET = 0x1108``. *)

val cl_IMAGE_FORMAT : int
(** Constant ``IMAGE_FORMAT = 0x1110``. *)

val cl_IMAGE_ELEMENT_SIZE : int
(** Constant ``IMAGE_ELEMENT_SIZE = 0x1111``. *)

val cl_IMAGE_ROW_PITCH : int
(** Constant ``IMAGE_ROW_PITCH = 0x1112``. *)

val cl_IMAGE_SLICE_PITCH : int
(** Constant ``IMAGE_SLICE_PITCH = 0x1113``. *)

val cl_IMAGE_WIDTH : int
(** Constant ``IMAGE_WIDTH = 0x1114``. *)

val cl_IMAGE_HEIGHT : int
(** Constant ``IMAGE_HEIGHT = 0x1115``. *)

val cl_IMAGE_DEPTH : int
(** Constant ``IMAGE_DEPTH = 0x1116``. *)

val cl_IMAGE_ARRAY_SIZE : int
(** Constant ``IMAGE_ARRAY_SIZE = 0x1117``. *)

val cl_IMAGE_BUFFER : int
(** Constant ``IMAGE_BUFFER = 0x1118``. *)

val cl_IMAGE_NUM_MIP_LEVELS : int
(** Constant ``IMAGE_NUM_MIP_LEVELS = 0x1119``. *)

val cl_IMAGE_NUM_SAMPLES : int
(** Constant ``IMAGE_NUM_SAMPLES = 0x111A``. *)

val cl_ADDRESS_NONE : int
(** Constant ``ADDRESS_NONE = 0x1130``. *)

val cl_ADDRESS_CLAMP_TO_EDGE : int
(** Constant ``ADDRESS_CLAMP_TO_EDGE = 0x1131``. *)

val cl_ADDRESS_CLAMP : int
(** Constant ``ADDRESS_CLAMP = 0x1132``. *)

val cl_ADDRESS_REPEAT : int
(** Constant ``ADDRESS_REPEAT = 0x1133``. *)

val cl_ADDRESS_MIRRORED_REPEAT : int
(** Constant ``ADDRESS_MIRRORED_REPEAT = 0x1134``. *)

val cl_FILTER_NEAREST : int
(** Constant ``FILTER_NEAREST = 0x1140``. *)

val cl_FILTER_LINEAR : int
(** Constant ``FILTER_LINEAR = 0x1141``. *)

val cl_SAMPLER_REFERENCE_COUNT : int
(** Constant ``SAMPLER_REFERENCE_COUNT = 0x1150``. *)

val cl_SAMPLER_CONTEXT : int
(** Constant ``SAMPLER_CONTEXT = 0x1151``. *)

val cl_SAMPLER_NORMALIZED_COORDS : int
(** Constant ``SAMPLER_NORMALIZED_COORDS = 0x1152``. *)

val cl_SAMPLER_ADDRESSING_MODE : int
(** Constant ``SAMPLER_ADDRESSING_MODE = 0x1153``. *)

val cl_SAMPLER_FILTER_MODE : int
(** Constant ``SAMPLER_FILTER_MODE = 0x1154``. *)

val cl_MAP_READ : int
(** Constant ``MAP_READ = (1 lsl 0)``. *)

val cl_MAP_WRITE : int
(** Constant ``MAP_WRITE = (1 lsl 1)``. *)

val cl_MAP_WRITE_INVALIDATE_REGION : int
(** Constant ``MAP_WRITE_INVALIDATE_REGION = (1 lsl 2)``. *)

val cl_PROGRAM_REFERENCE_COUNT : int
(** Constant ``PROGRAM_REFERENCE_COUNT = 0x1160``. *)

val cl_PROGRAM_CONTEXT : int
(** Constant ``PROGRAM_CONTEXT = 0x1161``. *)

val cl_PROGRAM_NUM_DEVICES : int
(** Constant ``PROGRAM_NUM_DEVICES = 0x1162``. *)

val cl_PROGRAM_DEVICES : int
(** Constant ``PROGRAM_DEVICES = 0x1163``. *)

val cl_PROGRAM_SOURCE : int
(** Constant ``PROGRAM_SOURCE = 0x1164``. *)

val cl_PROGRAM_BINARY_SIZES : int
(** Constant ``PROGRAM_BINARY_SIZES = 0x1165``. *)

val cl_PROGRAM_BINARIES : int
(** Constant ``PROGRAM_BINARIES = 0x1166``. *)

val cl_PROGRAM_NUM_KERNELS : int
(** Constant ``PROGRAM_NUM_KERNELS = 0x1167``. *)

val cl_PROGRAM_KERNEL_NAMES : int
(** Constant ``PROGRAM_KERNEL_NAMES = 0x1168``. *)

val cl_PROGRAM_BUILD_STATUS : int
(** Constant ``PROGRAM_BUILD_STATUS = 0x1181``. *)

val cl_PROGRAM_BUILD_OPTIONS : int
(** Constant ``PROGRAM_BUILD_OPTIONS = 0x1182``. *)

val cl_PROGRAM_BUILD_LOG : int
(** Constant ``PROGRAM_BUILD_LOG = 0x1183``. *)

val cl_PROGRAM_BINARY_TYPE : int
(** Constant ``PROGRAM_BINARY_TYPE = 0x1184``. *)

val cl_PROGRAM_BINARY_TYPE_NONE : int
(** Constant ``PROGRAM_BINARY_TYPE_NONE = 0x0``. *)

val cl_PROGRAM_BINARY_TYPE_COMPILED_OBJECT : int
(** Constant ``PROGRAM_BINARY_TYPE_COMPILED_OBJECT = 0x1``. *)

val cl_PROGRAM_BINARY_TYPE_LIBRARY : int
(** Constant ``PROGRAM_BINARY_TYPE_LIBRARY = 0x2``. *)

val cl_PROGRAM_BINARY_TYPE_EXECUTABLE : int
(** Constant ``PROGRAM_BINARY_TYPE_EXECUTABLE = 0x4``. *)

val cl_BUILD_SUCCESS : int
(** Constant ``BUILD_SUCCESS = 0``. *)

val cl_BUILD_NONE : int
(** Constant ``BUILD_NONE = -1``. *)

val cl_BUILD_ERROR : int
(** Constant ``BUILD_ERROR = -2``. *)

val cl_BUILD_IN_PROGRESS : int
(** Constant ``BUILD_IN_PROGRESS = -3``. *)

val cl_KERNEL_FUNCTION_NAME : int
(** Constant ``KERNEL_FUNCTION_NAME = 0x1190``. *)

val cl_KERNEL_NUM_ARGS : int
(** Constant ``KERNEL_NUM_ARGS = 0x1191``. *)

val cl_KERNEL_REFERENCE_COUNT : int
(** Constant ``KERNEL_REFERENCE_COUNT = 0x1192``. *)

val cl_KERNEL_CONTEXT : int
(** Constant ``KERNEL_CONTEXT = 0x1193``. *)

val cl_KERNEL_PROGRAM : int
(** Constant ``KERNEL_PROGRAM = 0x1194``. *)

val cl_KERNEL_ATTRIBUTES : int
(** Constant ``KERNEL_ATTRIBUTES = 0x1195``. *)

val cl_KERNEL_ARG_ADDRESS_QUALIFIER : int
(** Constant ``KERNEL_ARG_ADDRESS_QUALIFIER = 0x1196``. *)

val cl_KERNEL_ARG_ACCESS_QUALIFIER : int
(** Constant ``KERNEL_ARG_ACCESS_QUALIFIER = 0x1197``. *)

val cl_KERNEL_ARG_TYPE_NAME : int
(** Constant ``KERNEL_ARG_TYPE_NAME = 0x1198``. *)

val cl_KERNEL_ARG_TYPE_QUALIFIER : int
(** Constant ``KERNEL_ARG_TYPE_QUALIFIER = 0x1199``. *)

val cl_KERNEL_ARG_NAME : int
(** Constant ``KERNEL_ARG_NAME = 0x119A``. *)

val cl_KERNEL_ARG_ADDRESS_GLOBAL : int
(** Constant ``KERNEL_ARG_ADDRESS_GLOBAL = 0x119B``. *)

val cl_KERNEL_ARG_ADDRESS_LOCAL : int
(** Constant ``KERNEL_ARG_ADDRESS_LOCAL = 0x119C``. *)

val cl_KERNEL_ARG_ADDRESS_CONSTANT : int
(** Constant ``KERNEL_ARG_ADDRESS_CONSTANT = 0x119D``. *)

val cl_KERNEL_ARG_ADDRESS_PRIVATE : int
(** Constant ``KERNEL_ARG_ADDRESS_PRIVATE = 0x119E``. *)

val cl_KERNEL_ARG_ACCESS_READ_ONLY : int
(** Constant ``KERNEL_ARG_ACCESS_READ_ONLY = 0x11A0``. *)

val cl_KERNEL_ARG_ACCESS_WRITE_ONLY : int
(** Constant ``KERNEL_ARG_ACCESS_WRITE_ONLY = 0x11A1``. *)

val cl_KERNEL_ARG_ACCESS_READ_WRITE : int
(** Constant ``KERNEL_ARG_ACCESS_READ_WRITE = 0x11A2``. *)

val cl_KERNEL_ARG_ACCESS_NONE : int
(** Constant ``KERNEL_ARG_ACCESS_NONE = 0x11A3``. *)

val cl_KERNEL_ARG_TYPE_NONE : int
(** Constant ``KERNEL_ARG_TYPE_NONE = 0``. *)

val cl_KERNEL_ARG_TYPE_CONST : int
(** Constant ``KERNEL_ARG_TYPE_CONST = (1 lsl 0)``. *)

val cl_KERNEL_ARG_TYPE_RESTRICT : int
(** Constant ``KERNEL_ARG_TYPE_RESTRICT = (1 lsl 1)``. *)

val cl_KERNEL_ARG_TYPE_VOLATILE : int
(** Constant ``KERNEL_ARG_TYPE_VOLATILE = (1 lsl 2)``. *)

val cl_KERNEL_WORK_GROUP_SIZE : int
(** Constant ``KERNEL_WORK_GROUP_SIZE = 0x11B0``. *)

val cl_KERNEL_COMPILE_WORK_GROUP_SIZE : int
(** Constant ``KERNEL_COMPILE_WORK_GROUP_SIZE = 0x11B1``. *)

val cl_KERNEL_LOCAL_MEM_SIZE : int
(** Constant ``KERNEL_LOCAL_MEM_SIZE = 0x11B2``. *)

val cl_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE : int
(** Constant ``KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x11B3``. *)

val cl_KERNEL_PRIVATE_MEM_SIZE : int
(** Constant ``KERNEL_PRIVATE_MEM_SIZE = 0x11B4``. *)

val cl_KERNEL_GLOBAL_WORK_SIZE : int
(** Constant ``KERNEL_GLOBAL_WORK_SIZE = 0x11B5``. *)

val cl_EVENT_COMMAND_QUEUE : int
(** Constant ``EVENT_COMMAND_QUEUE = 0x11D0``. *)

val cl_EVENT_COMMAND_TYPE : int
(** Constant ``EVENT_COMMAND_TYPE = 0x11D1``. *)

val cl_EVENT_REFERENCE_COUNT : int
(** Constant ``EVENT_REFERENCE_COUNT = 0x11D2``. *)

val cl_EVENT_COMMAND_EXECUTION_STATUS : int
(** Constant ``EVENT_COMMAND_EXECUTION_STATUS = 0x11D3``. *)

val cl_EVENT_CONTEXT : int
(** Constant ``EVENT_CONTEXT = 0x11D4``. *)

val cl_COMMAND_NDRANGE_KERNEL : int
(** Constant ``COMMAND_NDRANGE_KERNEL = 0x11F0``. *)

val cl_COMMAND_TASK : int
(** Constant ``COMMAND_TASK = 0x11F1``. *)

val cl_COMMAND_NATIVE_KERNEL : int
(** Constant ``COMMAND_NATIVE_KERNEL = 0x11F2``. *)

val cl_COMMAND_READ_BUFFER : int
(** Constant ``COMMAND_READ_BUFFER = 0x11F3``. *)

val cl_COMMAND_WRITE_BUFFER : int
(** Constant ``COMMAND_WRITE_BUFFER = 0x11F4``. *)

val cl_COMMAND_COPY_BUFFER : int
(** Constant ``COMMAND_COPY_BUFFER = 0x11F5``. *)

val cl_COMMAND_READ_IMAGE : int
(** Constant ``COMMAND_READ_IMAGE = 0x11F6``. *)

val cl_COMMAND_WRITE_IMAGE : int
(** Constant ``COMMAND_WRITE_IMAGE = 0x11F7``. *)

val cl_COMMAND_COPY_IMAGE : int
(** Constant ``COMMAND_COPY_IMAGE = 0x11F8``. *)

val cl_COMMAND_COPY_IMAGE_TO_BUFFER : int
(** Constant ``COMMAND_COPY_IMAGE_TO_BUFFER = 0x11F9``. *)

val cl_COMMAND_COPY_BUFFER_TO_IMAGE : int
(** Constant ``COMMAND_COPY_BUFFER_TO_IMAGE = 0x11FA``. *)

val cl_COMMAND_MAP_BUFFER : int
(** Constant ``COMMAND_MAP_BUFFER = 0x11FB``. *)

val cl_COMMAND_MAP_IMAGE : int
(** Constant ``COMMAND_MAP_IMAGE = 0x11FC``. *)

val cl_COMMAND_UNMAP_MEM_OBJECT : int
(** Constant ``COMMAND_UNMAP_MEM_OBJECT = 0x11FD``. *)

val cl_COMMAND_MARKER : int
(** Constant ``COMMAND_MARKER = 0x11FE``. *)

val cl_COMMAND_ACQUIRE_GL_OBJECTS : int
(** Constant ``COMMAND_ACQUIRE_GL_OBJECTS = 0x11FF``. *)

val cl_COMMAND_RELEASE_GL_OBJECTS : int
(** Constant ``COMMAND_RELEASE_GL_OBJECTS = 0x1200``. *)

val cl_COMMAND_READ_BUFFER_RECT : int
(** Constant ``COMMAND_READ_BUFFER_RECT = 0x1201``. *)

val cl_COMMAND_WRITE_BUFFER_RECT : int
(** Constant ``COMMAND_WRITE_BUFFER_RECT = 0x1202``. *)

val cl_COMMAND_COPY_BUFFER_RECT : int
(** Constant ``COMMAND_COPY_BUFFER_RECT = 0x1203``. *)

val cl_COMMAND_USER : int
(** Constant ``COMMAND_USER = 0x1204``. *)

val cl_COMMAND_BARRIER : int
(** Constant ``COMMAND_BARRIER = 0x1205``. *)

val cl_COMMAND_MIGRATE_MEM_OBJECTS : int
(** Constant ``COMMAND_MIGRATE_MEM_OBJECTS = 0x1206``. *)

val cl_COMMAND_FILL_BUFFER : int
(** Constant ``COMMAND_FILL_BUFFER = 0x1207``. *)

val cl_COMMAND_FILL_IMAGE : int
(** Constant ``COMMAND_FILL_IMAGE = 0x1208``. *)

val cl_COMPLETE : int
(** Constant ``COMPLETE = 0x0``. *)

val cl_RUNNING : int
(** Constant ``RUNNING = 0x1``. *)

val cl_SUBMITTED : int
(** Constant ``SUBMITTED = 0x2``. *)

val cl_QUEUED : int
(** Constant ``QUEUED = 0x3``. *)

val cl_BUFFER_CREATE_TYPE_REGION : int
(** Constant ``BUFFER_CREATE_TYPE_REGION = 0x1220``. *)

val cl_PROFILING_COMMAND_QUEUED : int
(** Constant ``PROFILING_COMMAND_QUEUED = 0x1280``. *)

val cl_PROFILING_COMMAND_SUBMIT : int
(** Constant ``PROFILING_COMMAND_SUBMIT = 0x1281``. *)

val cl_PROFILING_COMMAND_START : int
(** Constant ``PROFILING_COMMAND_START = 0x1282``. *)

val cl_PROFILING_COMMAND_END : int
(** Constant ``PROFILING_COMMAND_END = 0x1283``. *)



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

