(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1505577750 *)

open Ctypes



(** type definition *)

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



(** function definition *)

val cl_check_err : int32 -> unit

val clGetPlatformIDs : Unsigned.uint32 -> cl_platform_id ptr -> Unsigned.uint32 ptr -> int32

val clGetPlatformInfo : cl_platform_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32

val clGetDeviceIDs : cl_platform_id -> Unsigned.uint64 -> Unsigned.uint32 -> cl_device_id ptr -> Unsigned.uint32 ptr -> int32

val clGetDeviceInfo : cl_device_id -> Unsigned.uint32 -> Unsigned.size_t -> unit ptr -> Unsigned.size_t ptr -> int32



(** constant definition *)

val cl_SUCCESS : int

val cl_DEVICE_NOT_FOUND : int

val cl_DEVICE_NOT_AVAILABLE : int

val cl_COMPILER_NOT_AVAILABLE : int

val cl_MEM_OBJECT_ALLOCATION_FAILURE : int

val cl_OUT_OF_RESOURCES : int

val cl_OUT_OF_HOST_MEMORY : int

val cl_PROFILING_INFO_NOT_AVAILABLE : int

val cl_MEM_COPY_OVERLAP : int

val cl_IMAGE_FORMAT_MISMATCH : int

val cl_IMAGE_FORMAT_NOT_SUPPORTED : int

val cl_BUILD_PROGRAM_FAILURE : int

val cl_MAP_FAILURE : int

val cl_MISALIGNED_SUB_BUFFER_OFFSET : int

val cl_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST : int

val cl_COMPILE_PROGRAM_FAILURE : int

val cl_LINKER_NOT_AVAILABLE : int

val cl_LINK_PROGRAM_FAILURE : int

val cl_DEVICE_PARTITION_FAILED : int

val cl_KERNEL_ARG_INFO_NOT_AVAILABLE : int

val cl_INVALID_VALUE : int

val cl_INVALID_DEVICE_TYPE : int

val cl_INVALID_PLATFORM : int

val cl_INVALID_DEVICE : int

val cl_INVALID_CONTEXT : int

val cl_INVALID_QUEUE_PROPERTIES : int

val cl_INVALID_COMMAND_QUEUE : int

val cl_INVALID_HOST_PTR : int

val cl_INVALID_MEM_OBJECT : int

val cl_INVALID_IMAGE_FORMAT_DESCRIPTOR : int

val cl_INVALID_IMAGE_SIZE : int

val cl_INVALID_SAMPLER : int

val cl_INVALID_BINARY : int

val cl_INVALID_BUILD_OPTIONS : int

val cl_INVALID_PROGRAM : int

val cl_INVALID_PROGRAM_EXECUTABLE : int

val cl_INVALID_KERNEL_NAME : int

val cl_INVALID_KERNEL_DEFINITION : int

val cl_INVALID_KERNEL : int

val cl_INVALID_ARG_INDEX : int

val cl_INVALID_ARG_VALUE : int

val cl_INVALID_ARG_SIZE : int

val cl_INVALID_KERNEL_ARGS : int

val cl_INVALID_WORK_DIMENSION : int

val cl_INVALID_WORK_GROUP_SIZE : int

val cl_INVALID_WORK_ITEM_SIZE : int

val cl_INVALID_GLOBAL_OFFSET : int

val cl_INVALID_EVENT_WAIT_LIST : int

val cl_INVALID_EVENT : int

val cl_INVALID_OPERATION : int

val cl_INVALID_GL_OBJECT : int

val cl_INVALID_BUFFER_SIZE : int

val cl_INVALID_MIP_LEVEL : int

val cl_INVALID_GLOBAL_WORK_SIZE : int

val cl_INVALID_PROPERTY : int

val cl_INVALID_IMAGE_DESCRIPTOR : int

val cl_INVALID_COMPILER_OPTIONS : int

val cl_INVALID_LINKER_OPTIONS : int

val cl_INVALID_DEVICE_PARTITION_COUNT : int

val cl_VERSION_1_0 : int

val cl_VERSION_1_1 : int

val cl_VERSION_1_2 : int

val cl_FALSE : int

val cl_TRUE : int

val cl_BLOCKING : int

val cl_NON_BLOCKING : int

val cl_PLATFORM_PROFILE : int

val cl_PLATFORM_VERSION : int

val cl_PLATFORM_NAME : int

val cl_PLATFORM_VENDOR : int

val cl_PLATFORM_EXTENSIONS : int

val cl_DEVICE_TYPE_DEFAULT : int

val cl_DEVICE_TYPE_CPU : int

val cl_DEVICE_TYPE_GPU : int

val cl_DEVICE_TYPE_ACCELERATOR : int

val cl_DEVICE_TYPE_CUSTOM : int

val cl_DEVICE_TYPE_ALL : int

val cl_DEVICE_TYPE : int

val cl_DEVICE_VENDOR_ID : int

val cl_DEVICE_MAX_COMPUTE_UNITS : int

val cl_DEVICE_MAX_WORK_ITEM_DIMENSIONS : int

val cl_DEVICE_MAX_WORK_GROUP_SIZE : int

val cl_DEVICE_MAX_WORK_ITEM_SIZES : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_INT : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_LONG : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE : int

val cl_DEVICE_MAX_CLOCK_FREQUENCY : int

val cl_DEVICE_ADDRESS_BITS : int

val cl_DEVICE_MAX_READ_IMAGE_ARGS : int

val cl_DEVICE_MAX_WRITE_IMAGE_ARGS : int

val cl_DEVICE_MAX_MEM_ALLOC_SIZE : int

val cl_DEVICE_IMAGE2D_MAX_WIDTH : int

val cl_DEVICE_IMAGE2D_MAX_HEIGHT : int

val cl_DEVICE_IMAGE3D_MAX_WIDTH : int

val cl_DEVICE_IMAGE3D_MAX_HEIGHT : int

val cl_DEVICE_IMAGE3D_MAX_DEPTH : int

val cl_DEVICE_IMAGE_SUPPORT : int

val cl_DEVICE_MAX_PARAMETER_SIZE : int

val cl_DEVICE_MAX_SAMPLERS : int

val cl_DEVICE_MEM_BASE_ADDR_ALIGN : int

val cl_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE : int

val cl_DEVICE_SINGLE_FP_CONFIG : int

val cl_DEVICE_GLOBAL_MEM_CACHE_TYPE : int

val cl_DEVICE_GLOBAL_MEM_CACHELINE_SIZE : int

val cl_DEVICE_GLOBAL_MEM_CACHE_SIZE : int

val cl_DEVICE_GLOBAL_MEM_SIZE : int

val cl_DEVICE_MAX_CONSTANT_BUFFER_SIZE : int

val cl_DEVICE_MAX_CONSTANT_ARGS : int

val cl_DEVICE_LOCAL_MEM_TYPE : int

val cl_DEVICE_LOCAL_MEM_SIZE : int

val cl_DEVICE_ERROR_CORRECTION_SUPPORT : int

val cl_DEVICE_PROFILING_TIMER_RESOLUTION : int

val cl_DEVICE_ENDIAN_LITTLE : int

val cl_DEVICE_AVAILABLE : int

val cl_DEVICE_COMPILER_AVAILABLE : int

val cl_DEVICE_EXECUTION_CAPABILITIES : int

val cl_DEVICE_QUEUE_PROPERTIES : int

val cl_DEVICE_NAME : int

val cl_DEVICE_VENDOR : int

val cl_DRIVER_VERSION : int

val cl_DEVICE_PROFILE : int

val cl_DEVICE_VERSION : int

val cl_DEVICE_EXTENSIONS : int

val cl_DEVICE_PLATFORM : int

val cl_DEVICE_DOUBLE_FP_CONFIG : int

val cl_DEVICE_HALF_FP_CONFIG : int

val cl_DEVICE_PREFERRED_VECTOR_WIDTH_HALF : int

val cl_DEVICE_HOST_UNIFIED_MEMORY : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_CHAR : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_SHORT : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_INT : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_LONG : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE : int

val cl_DEVICE_NATIVE_VECTOR_WIDTH_HALF : int

val cl_DEVICE_OPENCL_C_VERSION : int

val cl_DEVICE_LINKER_AVAILABLE : int

val cl_DEVICE_BUILT_IN_KERNELS : int

val cl_DEVICE_IMAGE_MAX_BUFFER_SIZE : int

val cl_DEVICE_IMAGE_MAX_ARRAY_SIZE : int

val cl_DEVICE_PARENT_DEVICE : int

val cl_DEVICE_PARTITION_MAX_SUB_DEVICES : int

val cl_DEVICE_PARTITION_PROPERTIES : int

val cl_DEVICE_PARTITION_AFFINITY_DOMAIN : int

val cl_DEVICE_PARTITION_TYPE : int

val cl_DEVICE_REFERENCE_COUNT : int

val cl_DEVICE_PREFERRED_INTEROP_USER_SYNC : int

val cl_DEVICE_PRINTF_BUFFER_SIZE : int

val cl_DEVICE_IMAGE_PITCH_ALIGNMENT : int

val cl_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT : int

val cl_FP_DENORM : int

val cl_FP_INF_NAN : int

val cl_FP_ROUND_TO_NEAREST : int

val cl_FP_ROUND_TO_ZERO : int

val cl_FP_ROUND_TO_INF : int

val cl_FP_FMA : int

val cl_FP_SOFT_FLOAT : int

val cl_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT : int

val cl_NONE : int

val cl_READ_ONLY_CACHE : int

val cl_READ_WRITE_CACHE : int

val cl_LOCAL : int

val cl_GLOBAL : int

val cl_EXEC_KERNEL : int

val cl_EXEC_NATIVE_KERNEL : int

val cl_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE : int

val cl_QUEUE_PROFILING_ENABLE : int

val cl_CONTEXT_REFERENCE_COUNT : int

val cl_CONTEXT_DEVICES : int

val cl_CONTEXT_PROPERTIES : int

val cl_CONTEXT_NUM_DEVICES : int

val cl_CONTEXT_PLATFORM : int

val cl_CONTEXT_INTEROP_USER_SYNC : int

val cl_DEVICE_PARTITION_EQUALLY : int

val cl_DEVICE_PARTITION_BY_COUNTS : int

val cl_DEVICE_PARTITION_BY_COUNTS_LIST_END : int

val cl_DEVICE_PARTITION_BY_AFFINITY_DOMAIN : int

val cl_DEVICE_AFFINITY_DOMAIN_NUMA : int

val cl_DEVICE_AFFINITY_DOMAIN_L4_CACHE : int

val cl_DEVICE_AFFINITY_DOMAIN_L3_CACHE : int

val cl_DEVICE_AFFINITY_DOMAIN_L2_CACHE : int

val cl_DEVICE_AFFINITY_DOMAIN_L1_CACHE : int

val cl_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE : int

val cl_QUEUE_CONTEXT : int

val cl_QUEUE_DEVICE : int

val cl_QUEUE_REFERENCE_COUNT : int

val cl_QUEUE_PROPERTIES : int

val cl_MEM_READ_WRITE : int

val cl_MEM_WRITE_ONLY : int

val cl_MEM_READ_ONLY : int

val cl_MEM_USE_HOST_PTR : int

val cl_MEM_ALLOC_HOST_PTR : int

val cl_MEM_COPY_HOST_PTR : int

val cl_MEM_HOST_WRITE_ONLY : int

val cl_MEM_HOST_READ_ONLY : int

val cl_MEM_HOST_NO_ACCESS : int

val cl_MIGRATE_MEM_OBJECT_HOST : int

val cl_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED : int

val cl_R : int

val cl_A : int

val cl_RG : int

val cl_RA : int

val cl_RGB : int

val cl_RGBA : int

val cl_BGRA : int

val cl_ARGB : int

val cl_INTENSITY : int

val cl_LUMINANCE : int

val cl_Rx : int

val cl_RGx : int

val cl_RGBx : int

val cl_DEPTH : int

val cl_DEPTH_STENCIL : int

val cl_SNORM_INT8 : int

val cl_SNORM_INT16 : int

val cl_UNORM_INT8 : int

val cl_UNORM_INT16 : int

val cl_UNORM_SHORT_565 : int

val cl_UNORM_SHORT_555 : int

val cl_UNORM_INT_101010 : int

val cl_SIGNED_INT8 : int

val cl_SIGNED_INT16 : int

val cl_SIGNED_INT32 : int

val cl_UNSIGNED_INT8 : int

val cl_UNSIGNED_INT16 : int

val cl_UNSIGNED_INT32 : int

val cl_HALF_FLOAT : int

val cl_FLOAT : int

val cl_UNORM_INT24 : int

val cl_MEM_OBJECT_BUFFER : int

val cl_MEM_OBJECT_IMAGE2D : int

val cl_MEM_OBJECT_IMAGE3D : int

val cl_MEM_OBJECT_IMAGE2D_ARRAY : int

val cl_MEM_OBJECT_IMAGE1D : int

val cl_MEM_OBJECT_IMAGE1D_ARRAY : int

val cl_MEM_OBJECT_IMAGE1D_BUFFER : int

val cl_MEM_TYPE : int

val cl_MEM_FLAGS : int

val cl_MEM_SIZE : int

val cl_MEM_HOST_PTR : int

val cl_MEM_MAP_COUNT : int

val cl_MEM_REFERENCE_COUNT : int

val cl_MEM_CONTEXT : int

val cl_MEM_ASSOCIATED_MEMOBJECT : int

val cl_MEM_OFFSET : int

val cl_IMAGE_FORMAT : int

val cl_IMAGE_ELEMENT_SIZE : int

val cl_IMAGE_ROW_PITCH : int

val cl_IMAGE_SLICE_PITCH : int

val cl_IMAGE_WIDTH : int

val cl_IMAGE_HEIGHT : int

val cl_IMAGE_DEPTH : int

val cl_IMAGE_ARRAY_SIZE : int

val cl_IMAGE_BUFFER : int

val cl_IMAGE_NUM_MIP_LEVELS : int

val cl_IMAGE_NUM_SAMPLES : int

val cl_ADDRESS_NONE : int

val cl_ADDRESS_CLAMP_TO_EDGE : int

val cl_ADDRESS_CLAMP : int

val cl_ADDRESS_REPEAT : int

val cl_ADDRESS_MIRRORED_REPEAT : int

val cl_FILTER_NEAREST : int

val cl_FILTER_LINEAR : int

val cl_SAMPLER_REFERENCE_COUNT : int

val cl_SAMPLER_CONTEXT : int

val cl_SAMPLER_NORMALIZED_COORDS : int

val cl_SAMPLER_ADDRESSING_MODE : int

val cl_SAMPLER_FILTER_MODE : int

val cl_MAP_READ : int

val cl_MAP_WRITE : int

val cl_MAP_WRITE_INVALIDATE_REGION : int

val cl_PROGRAM_REFERENCE_COUNT : int

val cl_PROGRAM_CONTEXT : int

val cl_PROGRAM_NUM_DEVICES : int

val cl_PROGRAM_DEVICES : int

val cl_PROGRAM_SOURCE : int

val cl_PROGRAM_BINARY_SIZES : int

val cl_PROGRAM_BINARIES : int

val cl_PROGRAM_NUM_KERNELS : int

val cl_PROGRAM_KERNEL_NAMES : int

val cl_PROGRAM_BUILD_STATUS : int

val cl_PROGRAM_BUILD_OPTIONS : int

val cl_PROGRAM_BUILD_LOG : int

val cl_PROGRAM_BINARY_TYPE : int

val cl_PROGRAM_BINARY_TYPE_NONE : int

val cl_PROGRAM_BINARY_TYPE_COMPILED_OBJECT : int

val cl_PROGRAM_BINARY_TYPE_LIBRARY : int

val cl_PROGRAM_BINARY_TYPE_EXECUTABLE : int

val cl_BUILD_SUCCESS : int

val cl_BUILD_NONE : int

val cl_BUILD_ERROR : int

val cl_BUILD_IN_PROGRESS : int

val cl_KERNEL_FUNCTION_NAME : int

val cl_KERNEL_NUM_ARGS : int

val cl_KERNEL_REFERENCE_COUNT : int

val cl_KERNEL_CONTEXT : int

val cl_KERNEL_PROGRAM : int

val cl_KERNEL_ATTRIBUTES : int

val cl_KERNEL_ARG_ADDRESS_QUALIFIER : int

val cl_KERNEL_ARG_ACCESS_QUALIFIER : int

val cl_KERNEL_ARG_TYPE_NAME : int

val cl_KERNEL_ARG_TYPE_QUALIFIER : int

val cl_KERNEL_ARG_NAME : int

val cl_KERNEL_ARG_ADDRESS_GLOBAL : int

val cl_KERNEL_ARG_ADDRESS_LOCAL : int

val cl_KERNEL_ARG_ADDRESS_CONSTANT : int

val cl_KERNEL_ARG_ADDRESS_PRIVATE : int

val cl_KERNEL_ARG_ACCESS_READ_ONLY : int

val cl_KERNEL_ARG_ACCESS_WRITE_ONLY : int

val cl_KERNEL_ARG_ACCESS_READ_WRITE : int

val cl_KERNEL_ARG_ACCESS_NONE : int

val cl_KERNEL_ARG_TYPE_NONE : int

val cl_KERNEL_ARG_TYPE_CONST : int

val cl_KERNEL_ARG_TYPE_RESTRICT : int

val cl_KERNEL_ARG_TYPE_VOLATILE : int

val cl_KERNEL_WORK_GROUP_SIZE : int

val cl_KERNEL_COMPILE_WORK_GROUP_SIZE : int

val cl_KERNEL_LOCAL_MEM_SIZE : int

val cl_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE : int

val cl_KERNEL_PRIVATE_MEM_SIZE : int

val cl_KERNEL_GLOBAL_WORK_SIZE : int

val cl_EVENT_COMMAND_QUEUE : int

val cl_EVENT_COMMAND_TYPE : int

val cl_EVENT_REFERENCE_COUNT : int

val cl_EVENT_COMMAND_EXECUTION_STATUS : int

val cl_EVENT_CONTEXT : int

val cl_COMMAND_NDRANGE_KERNEL : int

val cl_COMMAND_TASK : int

val cl_COMMAND_NATIVE_KERNEL : int

val cl_COMMAND_READ_BUFFER : int

val cl_COMMAND_WRITE_BUFFER : int

val cl_COMMAND_COPY_BUFFER : int

val cl_COMMAND_READ_IMAGE : int

val cl_COMMAND_WRITE_IMAGE : int

val cl_COMMAND_COPY_IMAGE : int

val cl_COMMAND_COPY_IMAGE_TO_BUFFER : int

val cl_COMMAND_COPY_BUFFER_TO_IMAGE : int

val cl_COMMAND_MAP_BUFFER : int

val cl_COMMAND_MAP_IMAGE : int

val cl_COMMAND_UNMAP_MEM_OBJECT : int

val cl_COMMAND_MARKER : int

val cl_COMMAND_ACQUIRE_GL_OBJECTS : int

val cl_COMMAND_RELEASE_GL_OBJECTS : int

val cl_COMMAND_READ_BUFFER_RECT : int

val cl_COMMAND_WRITE_BUFFER_RECT : int

val cl_COMMAND_COPY_BUFFER_RECT : int

val cl_COMMAND_USER : int

val cl_COMMAND_BARRIER : int

val cl_COMMAND_MIGRATE_MEM_OBJECTS : int

val cl_COMMAND_FILL_BUFFER : int

val cl_COMMAND_FILL_IMAGE : int

val cl_COMPLETE : int

val cl_RUNNING : int

val cl_SUBMITTED : int

val cl_QUEUED : int

val cl_BUFFER_CREATE_TYPE_REGION : int

val cl_PROFILING_COMMAND_QUEUED : int

val cl_PROFILING_COMMAND_SUBMIT : int

val cl_PROFILING_COMMAND_START : int

val cl_PROFILING_COMMAND_END : int



(** exception definition *)

exception EXN_SUCCESS

exception EXN_DEVICE_NOT_FOUND

exception EXN_DEVICE_NOT_AVAILABLE

exception EXN_COMPILER_NOT_AVAILABLE

exception EXN_MEM_OBJECT_ALLOCATION_FAILURE

exception EXN_OUT_OF_RESOURCES

exception EXN_OUT_OF_HOST_MEMORY

exception EXN_PROFILING_INFO_NOT_AVAILABLE

exception EXN_MEM_COPY_OVERLAP

exception EXN_IMAGE_FORMAT_MISMATCH

exception EXN_IMAGE_FORMAT_NOT_SUPPORTED

exception EXN_BUILD_PROGRAM_FAILURE

exception EXN_MAP_FAILURE

exception EXN_MISALIGNED_SUB_BUFFER_OFFSET

exception EXN_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST

exception EXN_COMPILE_PROGRAM_FAILURE

exception EXN_LINKER_NOT_AVAILABLE

exception EXN_LINK_PROGRAM_FAILURE

exception EXN_DEVICE_PARTITION_FAILED

exception EXN_KERNEL_ARG_INFO_NOT_AVAILABLE

exception EXN_INVALID_VALUE

exception EXN_INVALID_DEVICE_TYPE

exception EXN_INVALID_PLATFORM

exception EXN_INVALID_DEVICE

exception EXN_INVALID_CONTEXT

exception EXN_INVALID_QUEUE_PROPERTIES

exception EXN_INVALID_COMMAND_QUEUE

exception EXN_INVALID_HOST_PTR

exception EXN_INVALID_MEM_OBJECT

exception EXN_INVALID_IMAGE_FORMAT_DESCRIPTOR

exception EXN_INVALID_IMAGE_SIZE

exception EXN_INVALID_SAMPLER

exception EXN_INVALID_BINARY

exception EXN_INVALID_BUILD_OPTIONS

exception EXN_INVALID_PROGRAM

exception EXN_INVALID_PROGRAM_EXECUTABLE

exception EXN_INVALID_KERNEL_NAME

exception EXN_INVALID_KERNEL_DEFINITION

exception EXN_INVALID_KERNEL

exception EXN_INVALID_ARG_INDEX

exception EXN_INVALID_ARG_VALUE

exception EXN_INVALID_ARG_SIZE

exception EXN_INVALID_KERNEL_ARGS

exception EXN_INVALID_WORK_DIMENSION

exception EXN_INVALID_WORK_GROUP_SIZE

exception EXN_INVALID_WORK_ITEM_SIZE

exception EXN_INVALID_GLOBAL_OFFSET

exception EXN_INVALID_EVENT_WAIT_LIST

exception EXN_INVALID_EVENT

exception EXN_INVALID_OPERATION

exception EXN_INVALID_GL_OBJECT

exception EXN_INVALID_BUFFER_SIZE

exception EXN_INVALID_MIP_LEVEL

exception EXN_INVALID_GLOBAL_WORK_SIZE

exception EXN_INVALID_PROPERTY

exception EXN_INVALID_IMAGE_DESCRIPTOR

exception EXN_INVALID_COMPILER_OPTIONS

exception EXN_INVALID_LINKER_OPTIONS

exception EXN_INVALID_DEVICE_PARTITION_COUNT

