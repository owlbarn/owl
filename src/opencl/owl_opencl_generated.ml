(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated opencl interface file, timestamp:1505577750 *)

open Ctypes

module CI = Cstubs_internals



(** type definition *)

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



(** function definition *)

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



(** stub function definition *)

let clGetPlatformIDs x0 x1 x2 =
  owl_opencl_clGetPlatformIDs x0 (CI.cptr x1) (CI.cptr x2) 

let clGetPlatformInfo x0 x1 x2 x3 x4 =
  owl_opencl_clGetPlatformInfo (CI.cptr x0) x1 x2 (CI.cptr x3) (CI.cptr x4) 

let clGetDeviceIDs x0 x1 x2 x3 x4 =
  owl_opencl_clGetDeviceIDs (CI.cptr x0) x1 x2 (CI.cptr x3) (CI.cptr x4) 

let clGetDeviceInfo x0 x1 x2 x3 x4 =
  owl_opencl_clGetDeviceInfo (CI.cptr x0) x1 x2 (CI.cptr x3) (CI.cptr x4) 



(** constant definition *)

let cl_SUCCESS = 0

let cl_DEVICE_NOT_FOUND = -1

let cl_DEVICE_NOT_AVAILABLE = -2

let cl_COMPILER_NOT_AVAILABLE = -3

let cl_MEM_OBJECT_ALLOCATION_FAILURE = -4

let cl_OUT_OF_RESOURCES = -5

let cl_OUT_OF_HOST_MEMORY = -6

let cl_PROFILING_INFO_NOT_AVAILABLE = -7

let cl_MEM_COPY_OVERLAP = -8

let cl_IMAGE_FORMAT_MISMATCH = -9

let cl_IMAGE_FORMAT_NOT_SUPPORTED = -10

let cl_BUILD_PROGRAM_FAILURE = -11

let cl_MAP_FAILURE = -12

let cl_MISALIGNED_SUB_BUFFER_OFFSET = -13

let cl_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14

let cl_COMPILE_PROGRAM_FAILURE = -15

let cl_LINKER_NOT_AVAILABLE = -16

let cl_LINK_PROGRAM_FAILURE = -17

let cl_DEVICE_PARTITION_FAILED = -18

let cl_KERNEL_ARG_INFO_NOT_AVAILABLE = -19

let cl_INVALID_VALUE = -30

let cl_INVALID_DEVICE_TYPE = -31

let cl_INVALID_PLATFORM = -32

let cl_INVALID_DEVICE = -33

let cl_INVALID_CONTEXT = -34

let cl_INVALID_QUEUE_PROPERTIES = -35

let cl_INVALID_COMMAND_QUEUE = -36

let cl_INVALID_HOST_PTR = -37

let cl_INVALID_MEM_OBJECT = -38

let cl_INVALID_IMAGE_FORMAT_DESCRIPTOR = -39

let cl_INVALID_IMAGE_SIZE = -40

let cl_INVALID_SAMPLER = -41

let cl_INVALID_BINARY = -42

let cl_INVALID_BUILD_OPTIONS = -43

let cl_INVALID_PROGRAM = -44

let cl_INVALID_PROGRAM_EXECUTABLE = -45

let cl_INVALID_KERNEL_NAME = -46

let cl_INVALID_KERNEL_DEFINITION = -47

let cl_INVALID_KERNEL = -48

let cl_INVALID_ARG_INDEX = -49

let cl_INVALID_ARG_VALUE = -50

let cl_INVALID_ARG_SIZE = -51

let cl_INVALID_KERNEL_ARGS = -52

let cl_INVALID_WORK_DIMENSION = -53

let cl_INVALID_WORK_GROUP_SIZE = -54

let cl_INVALID_WORK_ITEM_SIZE = -55

let cl_INVALID_GLOBAL_OFFSET = -56

let cl_INVALID_EVENT_WAIT_LIST = -57

let cl_INVALID_EVENT = -58

let cl_INVALID_OPERATION = -59

let cl_INVALID_GL_OBJECT = -60

let cl_INVALID_BUFFER_SIZE = -61

let cl_INVALID_MIP_LEVEL = -62

let cl_INVALID_GLOBAL_WORK_SIZE = -63

let cl_INVALID_PROPERTY = -64

let cl_INVALID_IMAGE_DESCRIPTOR = -65

let cl_INVALID_COMPILER_OPTIONS = -66

let cl_INVALID_LINKER_OPTIONS = -67

let cl_INVALID_DEVICE_PARTITION_COUNT = -68

let cl_VERSION_1_0 = 1

let cl_VERSION_1_1 = 1

let cl_VERSION_1_2 = 1

let cl_FALSE = 0

let cl_TRUE = 1

let cl_BLOCKING = 1

let cl_NON_BLOCKING = 0

let cl_PLATFORM_PROFILE = 0x0900

let cl_PLATFORM_VERSION = 0x0901

let cl_PLATFORM_NAME = 0x0902

let cl_PLATFORM_VENDOR = 0x0903

let cl_PLATFORM_EXTENSIONS = 0x0904

let cl_DEVICE_TYPE_DEFAULT = (1 lsl 0)

let cl_DEVICE_TYPE_CPU = (1 lsl 1)

let cl_DEVICE_TYPE_GPU = (1 lsl 2)

let cl_DEVICE_TYPE_ACCELERATOR = (1 lsl 3)

let cl_DEVICE_TYPE_CUSTOM = (1 lsl 4)

let cl_DEVICE_TYPE_ALL = 0xFFFFFFFF

let cl_DEVICE_TYPE = 0x1000

let cl_DEVICE_VENDOR_ID = 0x1001

let cl_DEVICE_MAX_COMPUTE_UNITS = 0x1002

let cl_DEVICE_MAX_WORK_ITEM_DIMENSIONS = 0x1003

let cl_DEVICE_MAX_WORK_GROUP_SIZE = 0x1004

let cl_DEVICE_MAX_WORK_ITEM_SIZES = 0x1005

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR = 0x1006

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT = 0x1007

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_INT = 0x1008

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_LONG = 0x1009

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT = 0x100A

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE = 0x100B

let cl_DEVICE_MAX_CLOCK_FREQUENCY = 0x100C

let cl_DEVICE_ADDRESS_BITS = 0x100D

let cl_DEVICE_MAX_READ_IMAGE_ARGS = 0x100E

let cl_DEVICE_MAX_WRITE_IMAGE_ARGS = 0x100F

let cl_DEVICE_MAX_MEM_ALLOC_SIZE = 0x1010

let cl_DEVICE_IMAGE2D_MAX_WIDTH = 0x1011

let cl_DEVICE_IMAGE2D_MAX_HEIGHT = 0x1012

let cl_DEVICE_IMAGE3D_MAX_WIDTH = 0x1013

let cl_DEVICE_IMAGE3D_MAX_HEIGHT = 0x1014

let cl_DEVICE_IMAGE3D_MAX_DEPTH = 0x1015

let cl_DEVICE_IMAGE_SUPPORT = 0x1016

let cl_DEVICE_MAX_PARAMETER_SIZE = 0x1017

let cl_DEVICE_MAX_SAMPLERS = 0x1018

let cl_DEVICE_MEM_BASE_ADDR_ALIGN = 0x1019

let cl_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE = 0x101A

let cl_DEVICE_SINGLE_FP_CONFIG = 0x101B

let cl_DEVICE_GLOBAL_MEM_CACHE_TYPE = 0x101C

let cl_DEVICE_GLOBAL_MEM_CACHELINE_SIZE = 0x101D

let cl_DEVICE_GLOBAL_MEM_CACHE_SIZE = 0x101E

let cl_DEVICE_GLOBAL_MEM_SIZE = 0x101F

let cl_DEVICE_MAX_CONSTANT_BUFFER_SIZE = 0x1020

let cl_DEVICE_MAX_CONSTANT_ARGS = 0x1021

let cl_DEVICE_LOCAL_MEM_TYPE = 0x1022

let cl_DEVICE_LOCAL_MEM_SIZE = 0x1023

let cl_DEVICE_ERROR_CORRECTION_SUPPORT = 0x1024

let cl_DEVICE_PROFILING_TIMER_RESOLUTION = 0x1025

let cl_DEVICE_ENDIAN_LITTLE = 0x1026

let cl_DEVICE_AVAILABLE = 0x1027

let cl_DEVICE_COMPILER_AVAILABLE = 0x1028

let cl_DEVICE_EXECUTION_CAPABILITIES = 0x1029

let cl_DEVICE_QUEUE_PROPERTIES = 0x102A

let cl_DEVICE_NAME = 0x102B

let cl_DEVICE_VENDOR = 0x102C

let cl_DRIVER_VERSION = 0x102D

let cl_DEVICE_PROFILE = 0x102E

let cl_DEVICE_VERSION = 0x102F

let cl_DEVICE_EXTENSIONS = 0x1030

let cl_DEVICE_PLATFORM = 0x1031

let cl_DEVICE_DOUBLE_FP_CONFIG = 0x1032

let cl_DEVICE_HALF_FP_CONFIG = 0x1033

let cl_DEVICE_PREFERRED_VECTOR_WIDTH_HALF = 0x1034

let cl_DEVICE_HOST_UNIFIED_MEMORY = 0x1035

let cl_DEVICE_NATIVE_VECTOR_WIDTH_CHAR = 0x1036

let cl_DEVICE_NATIVE_VECTOR_WIDTH_SHORT = 0x1037

let cl_DEVICE_NATIVE_VECTOR_WIDTH_INT = 0x1038

let cl_DEVICE_NATIVE_VECTOR_WIDTH_LONG = 0x1039

let cl_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT = 0x103A

let cl_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE = 0x103B

let cl_DEVICE_NATIVE_VECTOR_WIDTH_HALF = 0x103C

let cl_DEVICE_OPENCL_C_VERSION = 0x103D

let cl_DEVICE_LINKER_AVAILABLE = 0x103E

let cl_DEVICE_BUILT_IN_KERNELS = 0x103F

let cl_DEVICE_IMAGE_MAX_BUFFER_SIZE = 0x1040

let cl_DEVICE_IMAGE_MAX_ARRAY_SIZE = 0x1041

let cl_DEVICE_PARENT_DEVICE = 0x1042

let cl_DEVICE_PARTITION_MAX_SUB_DEVICES = 0x1043

let cl_DEVICE_PARTITION_PROPERTIES = 0x1044

let cl_DEVICE_PARTITION_AFFINITY_DOMAIN = 0x1045

let cl_DEVICE_PARTITION_TYPE = 0x1046

let cl_DEVICE_REFERENCE_COUNT = 0x1047

let cl_DEVICE_PREFERRED_INTEROP_USER_SYNC = 0x1048

let cl_DEVICE_PRINTF_BUFFER_SIZE = 0x1049

let cl_DEVICE_IMAGE_PITCH_ALIGNMENT = 0x104A

let cl_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT = 0x104B

let cl_FP_DENORM = (1 lsl 0)

let cl_FP_INF_NAN = (1 lsl 1)

let cl_FP_ROUND_TO_NEAREST = (1 lsl 2)

let cl_FP_ROUND_TO_ZERO = (1 lsl 3)

let cl_FP_ROUND_TO_INF = (1 lsl 4)

let cl_FP_FMA = (1 lsl 5)

let cl_FP_SOFT_FLOAT = (1 lsl 6)

let cl_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT = (1 lsl 7)

let cl_NONE = 0x0

let cl_READ_ONLY_CACHE = 0x1

let cl_READ_WRITE_CACHE = 0x2

let cl_LOCAL = 0x1

let cl_GLOBAL = 0x2

let cl_EXEC_KERNEL = (1 lsl 0)

let cl_EXEC_NATIVE_KERNEL = (1 lsl 1)

let cl_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE = (1 lsl 0)

let cl_QUEUE_PROFILING_ENABLE = (1 lsl 1)

let cl_CONTEXT_REFERENCE_COUNT = 0x1080

let cl_CONTEXT_DEVICES = 0x1081

let cl_CONTEXT_PROPERTIES = 0x1082

let cl_CONTEXT_NUM_DEVICES = 0x1083

let cl_CONTEXT_PLATFORM = 0x1084

let cl_CONTEXT_INTEROP_USER_SYNC = 0x1085

let cl_DEVICE_PARTITION_EQUALLY = 0x1086

let cl_DEVICE_PARTITION_BY_COUNTS = 0x1087

let cl_DEVICE_PARTITION_BY_COUNTS_LIST_END = 0x0

let cl_DEVICE_PARTITION_BY_AFFINITY_DOMAIN = 0x1088

let cl_DEVICE_AFFINITY_DOMAIN_NUMA = (1 lsl 0)

let cl_DEVICE_AFFINITY_DOMAIN_L4_CACHE = (1 lsl 1)

let cl_DEVICE_AFFINITY_DOMAIN_L3_CACHE = (1 lsl 2)

let cl_DEVICE_AFFINITY_DOMAIN_L2_CACHE = (1 lsl 3)

let cl_DEVICE_AFFINITY_DOMAIN_L1_CACHE = (1 lsl 4)

let cl_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE = (1 lsl 5)

let cl_QUEUE_CONTEXT = 0x1090

let cl_QUEUE_DEVICE = 0x1091

let cl_QUEUE_REFERENCE_COUNT = 0x1092

let cl_QUEUE_PROPERTIES = 0x1093

let cl_MEM_READ_WRITE = (1 lsl 0)

let cl_MEM_WRITE_ONLY = (1 lsl 1)

let cl_MEM_READ_ONLY = (1 lsl 2)

let cl_MEM_USE_HOST_PTR = (1 lsl 3)

let cl_MEM_ALLOC_HOST_PTR = (1 lsl 4)

let cl_MEM_COPY_HOST_PTR = (1 lsl 5)

let cl_MEM_HOST_WRITE_ONLY = (1 lsl 7)

let cl_MEM_HOST_READ_ONLY = (1 lsl 8)

let cl_MEM_HOST_NO_ACCESS = (1 lsl 9)

let cl_MIGRATE_MEM_OBJECT_HOST = (1 lsl 0)

let cl_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED = (1 lsl 1)

let cl_R = 0x10B0

let cl_A = 0x10B1

let cl_RG = 0x10B2

let cl_RA = 0x10B3

let cl_RGB = 0x10B4

let cl_RGBA = 0x10B5

let cl_BGRA = 0x10B6

let cl_ARGB = 0x10B7

let cl_INTENSITY = 0x10B8

let cl_LUMINANCE = 0x10B9

let cl_Rx = 0x10BA

let cl_RGx = 0x10BB

let cl_RGBx = 0x10BC

let cl_DEPTH = 0x10BD

let cl_DEPTH_STENCIL = 0x10BE

let cl_SNORM_INT8 = 0x10D0

let cl_SNORM_INT16 = 0x10D1

let cl_UNORM_INT8 = 0x10D2

let cl_UNORM_INT16 = 0x10D3

let cl_UNORM_SHORT_565 = 0x10D4

let cl_UNORM_SHORT_555 = 0x10D5

let cl_UNORM_INT_101010 = 0x10D6

let cl_SIGNED_INT8 = 0x10D7

let cl_SIGNED_INT16 = 0x10D8

let cl_SIGNED_INT32 = 0x10D9

let cl_UNSIGNED_INT8 = 0x10DA

let cl_UNSIGNED_INT16 = 0x10DB

let cl_UNSIGNED_INT32 = 0x10DC

let cl_HALF_FLOAT = 0x10DD

let cl_FLOAT = 0x10DE

let cl_UNORM_INT24 = 0x10DF

let cl_MEM_OBJECT_BUFFER = 0x10F0

let cl_MEM_OBJECT_IMAGE2D = 0x10F1

let cl_MEM_OBJECT_IMAGE3D = 0x10F2

let cl_MEM_OBJECT_IMAGE2D_ARRAY = 0x10F3

let cl_MEM_OBJECT_IMAGE1D = 0x10F4

let cl_MEM_OBJECT_IMAGE1D_ARRAY = 0x10F5

let cl_MEM_OBJECT_IMAGE1D_BUFFER = 0x10F6

let cl_MEM_TYPE = 0x1100

let cl_MEM_FLAGS = 0x1101

let cl_MEM_SIZE = 0x1102

let cl_MEM_HOST_PTR = 0x1103

let cl_MEM_MAP_COUNT = 0x1104

let cl_MEM_REFERENCE_COUNT = 0x1105

let cl_MEM_CONTEXT = 0x1106

let cl_MEM_ASSOCIATED_MEMOBJECT = 0x1107

let cl_MEM_OFFSET = 0x1108

let cl_IMAGE_FORMAT = 0x1110

let cl_IMAGE_ELEMENT_SIZE = 0x1111

let cl_IMAGE_ROW_PITCH = 0x1112

let cl_IMAGE_SLICE_PITCH = 0x1113

let cl_IMAGE_WIDTH = 0x1114

let cl_IMAGE_HEIGHT = 0x1115

let cl_IMAGE_DEPTH = 0x1116

let cl_IMAGE_ARRAY_SIZE = 0x1117

let cl_IMAGE_BUFFER = 0x1118

let cl_IMAGE_NUM_MIP_LEVELS = 0x1119

let cl_IMAGE_NUM_SAMPLES = 0x111A

let cl_ADDRESS_NONE = 0x1130

let cl_ADDRESS_CLAMP_TO_EDGE = 0x1131

let cl_ADDRESS_CLAMP = 0x1132

let cl_ADDRESS_REPEAT = 0x1133

let cl_ADDRESS_MIRRORED_REPEAT = 0x1134

let cl_FILTER_NEAREST = 0x1140

let cl_FILTER_LINEAR = 0x1141

let cl_SAMPLER_REFERENCE_COUNT = 0x1150

let cl_SAMPLER_CONTEXT = 0x1151

let cl_SAMPLER_NORMALIZED_COORDS = 0x1152

let cl_SAMPLER_ADDRESSING_MODE = 0x1153

let cl_SAMPLER_FILTER_MODE = 0x1154

let cl_MAP_READ = (1 lsl 0)

let cl_MAP_WRITE = (1 lsl 1)

let cl_MAP_WRITE_INVALIDATE_REGION = (1 lsl 2)

let cl_PROGRAM_REFERENCE_COUNT = 0x1160

let cl_PROGRAM_CONTEXT = 0x1161

let cl_PROGRAM_NUM_DEVICES = 0x1162

let cl_PROGRAM_DEVICES = 0x1163

let cl_PROGRAM_SOURCE = 0x1164

let cl_PROGRAM_BINARY_SIZES = 0x1165

let cl_PROGRAM_BINARIES = 0x1166

let cl_PROGRAM_NUM_KERNELS = 0x1167

let cl_PROGRAM_KERNEL_NAMES = 0x1168

let cl_PROGRAM_BUILD_STATUS = 0x1181

let cl_PROGRAM_BUILD_OPTIONS = 0x1182

let cl_PROGRAM_BUILD_LOG = 0x1183

let cl_PROGRAM_BINARY_TYPE = 0x1184

let cl_PROGRAM_BINARY_TYPE_NONE = 0x0

let cl_PROGRAM_BINARY_TYPE_COMPILED_OBJECT = 0x1

let cl_PROGRAM_BINARY_TYPE_LIBRARY = 0x2

let cl_PROGRAM_BINARY_TYPE_EXECUTABLE = 0x4

let cl_BUILD_SUCCESS = 0

let cl_BUILD_NONE = -1

let cl_BUILD_ERROR = -2

let cl_BUILD_IN_PROGRESS = -3

let cl_KERNEL_FUNCTION_NAME = 0x1190

let cl_KERNEL_NUM_ARGS = 0x1191

let cl_KERNEL_REFERENCE_COUNT = 0x1192

let cl_KERNEL_CONTEXT = 0x1193

let cl_KERNEL_PROGRAM = 0x1194

let cl_KERNEL_ATTRIBUTES = 0x1195

let cl_KERNEL_ARG_ADDRESS_QUALIFIER = 0x1196

let cl_KERNEL_ARG_ACCESS_QUALIFIER = 0x1197

let cl_KERNEL_ARG_TYPE_NAME = 0x1198

let cl_KERNEL_ARG_TYPE_QUALIFIER = 0x1199

let cl_KERNEL_ARG_NAME = 0x119A

let cl_KERNEL_ARG_ADDRESS_GLOBAL = 0x119B

let cl_KERNEL_ARG_ADDRESS_LOCAL = 0x119C

let cl_KERNEL_ARG_ADDRESS_CONSTANT = 0x119D

let cl_KERNEL_ARG_ADDRESS_PRIVATE = 0x119E

let cl_KERNEL_ARG_ACCESS_READ_ONLY = 0x11A0

let cl_KERNEL_ARG_ACCESS_WRITE_ONLY = 0x11A1

let cl_KERNEL_ARG_ACCESS_READ_WRITE = 0x11A2

let cl_KERNEL_ARG_ACCESS_NONE = 0x11A3

let cl_KERNEL_ARG_TYPE_NONE = 0

let cl_KERNEL_ARG_TYPE_CONST = (1 lsl 0)

let cl_KERNEL_ARG_TYPE_RESTRICT = (1 lsl 1)

let cl_KERNEL_ARG_TYPE_VOLATILE = (1 lsl 2)

let cl_KERNEL_WORK_GROUP_SIZE = 0x11B0

let cl_KERNEL_COMPILE_WORK_GROUP_SIZE = 0x11B1

let cl_KERNEL_LOCAL_MEM_SIZE = 0x11B2

let cl_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x11B3

let cl_KERNEL_PRIVATE_MEM_SIZE = 0x11B4

let cl_KERNEL_GLOBAL_WORK_SIZE = 0x11B5

let cl_EVENT_COMMAND_QUEUE = 0x11D0

let cl_EVENT_COMMAND_TYPE = 0x11D1

let cl_EVENT_REFERENCE_COUNT = 0x11D2

let cl_EVENT_COMMAND_EXECUTION_STATUS = 0x11D3

let cl_EVENT_CONTEXT = 0x11D4

let cl_COMMAND_NDRANGE_KERNEL = 0x11F0

let cl_COMMAND_TASK = 0x11F1

let cl_COMMAND_NATIVE_KERNEL = 0x11F2

let cl_COMMAND_READ_BUFFER = 0x11F3

let cl_COMMAND_WRITE_BUFFER = 0x11F4

let cl_COMMAND_COPY_BUFFER = 0x11F5

let cl_COMMAND_READ_IMAGE = 0x11F6

let cl_COMMAND_WRITE_IMAGE = 0x11F7

let cl_COMMAND_COPY_IMAGE = 0x11F8

let cl_COMMAND_COPY_IMAGE_TO_BUFFER = 0x11F9

let cl_COMMAND_COPY_BUFFER_TO_IMAGE = 0x11FA

let cl_COMMAND_MAP_BUFFER = 0x11FB

let cl_COMMAND_MAP_IMAGE = 0x11FC

let cl_COMMAND_UNMAP_MEM_OBJECT = 0x11FD

let cl_COMMAND_MARKER = 0x11FE

let cl_COMMAND_ACQUIRE_GL_OBJECTS = 0x11FF

let cl_COMMAND_RELEASE_GL_OBJECTS = 0x1200

let cl_COMMAND_READ_BUFFER_RECT = 0x1201

let cl_COMMAND_WRITE_BUFFER_RECT = 0x1202

let cl_COMMAND_COPY_BUFFER_RECT = 0x1203

let cl_COMMAND_USER = 0x1204

let cl_COMMAND_BARRIER = 0x1205

let cl_COMMAND_MIGRATE_MEM_OBJECTS = 0x1206

let cl_COMMAND_FILL_BUFFER = 0x1207

let cl_COMMAND_FILL_IMAGE = 0x1208

let cl_COMPLETE = 0x0

let cl_RUNNING = 0x1

let cl_SUBMITTED = 0x2

let cl_QUEUED = 0x3

let cl_BUFFER_CREATE_TYPE_REGION = 0x1220

let cl_PROFILING_COMMAND_QUEUED = 0x1280

let cl_PROFILING_COMMAND_SUBMIT = 0x1281

let cl_PROFILING_COMMAND_START = 0x1282

let cl_PROFILING_COMMAND_END = 0x1283



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

let cl_check_err = function
  |   0l -> ()
  |  -1l -> raise EXN_DEVICE_NOT_FOUND
  |  -2l -> raise EXN_DEVICE_NOT_AVAILABLE
  |  -3l -> raise EXN_COMPILER_NOT_AVAILABLE
  |  -4l -> raise EXN_MEM_OBJECT_ALLOCATION_FAILURE
  |  -5l -> raise EXN_OUT_OF_RESOURCES
  |  -6l -> raise EXN_OUT_OF_HOST_MEMORY
  |  -7l -> raise EXN_PROFILING_INFO_NOT_AVAILABLE
  |  -8l -> raise EXN_MEM_COPY_OVERLAP
  |  -9l -> raise EXN_IMAGE_FORMAT_MISMATCH
  | -10l -> raise EXN_IMAGE_FORMAT_NOT_SUPPORTED
  | -11l -> raise EXN_BUILD_PROGRAM_FAILURE
  | -12l -> raise EXN_MAP_FAILURE
  | -13l -> raise EXN_MISALIGNED_SUB_BUFFER_OFFSET
  | -14l -> raise EXN_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST
  | -15l -> raise EXN_COMPILE_PROGRAM_FAILURE
  | -16l -> raise EXN_LINKER_NOT_AVAILABLE
  | -17l -> raise EXN_LINK_PROGRAM_FAILURE
  | -18l -> raise EXN_DEVICE_PARTITION_FAILED
  | -19l -> raise EXN_KERNEL_ARG_INFO_NOT_AVAILABLE
  | -30l -> raise EXN_INVALID_VALUE
  | -31l -> raise EXN_INVALID_DEVICE_TYPE
  | -32l -> raise EXN_INVALID_PLATFORM
  | -33l -> raise EXN_INVALID_DEVICE
  | -34l -> raise EXN_INVALID_CONTEXT
  | -35l -> raise EXN_INVALID_QUEUE_PROPERTIES
  | -36l -> raise EXN_INVALID_COMMAND_QUEUE
  | -37l -> raise EXN_INVALID_HOST_PTR
  | -38l -> raise EXN_INVALID_MEM_OBJECT
  | -39l -> raise EXN_INVALID_IMAGE_FORMAT_DESCRIPTOR
  | -40l -> raise EXN_INVALID_IMAGE_SIZE
  | -41l -> raise EXN_INVALID_SAMPLER
  | -42l -> raise EXN_INVALID_BINARY
  | -43l -> raise EXN_INVALID_BUILD_OPTIONS
  | -44l -> raise EXN_INVALID_PROGRAM
  | -45l -> raise EXN_INVALID_PROGRAM_EXECUTABLE
  | -46l -> raise EXN_INVALID_KERNEL_NAME
  | -47l -> raise EXN_INVALID_KERNEL_DEFINITION
  | -48l -> raise EXN_INVALID_KERNEL
  | -49l -> raise EXN_INVALID_ARG_INDEX
  | -50l -> raise EXN_INVALID_ARG_VALUE
  | -51l -> raise EXN_INVALID_ARG_SIZE
  | -52l -> raise EXN_INVALID_KERNEL_ARGS
  | -53l -> raise EXN_INVALID_WORK_DIMENSION
  | -54l -> raise EXN_INVALID_WORK_GROUP_SIZE
  | -55l -> raise EXN_INVALID_WORK_ITEM_SIZE
  | -56l -> raise EXN_INVALID_GLOBAL_OFFSET
  | -57l -> raise EXN_INVALID_EVENT_WAIT_LIST
  | -58l -> raise EXN_INVALID_EVENT
  | -59l -> raise EXN_INVALID_OPERATION
  | -60l -> raise EXN_INVALID_GL_OBJECT
  | -61l -> raise EXN_INVALID_BUFFER_SIZE
  | -62l -> raise EXN_INVALID_MIP_LEVEL
  | -63l -> raise EXN_INVALID_GLOBAL_WORK_SIZE
  | -64l -> raise EXN_INVALID_PROPERTY
  | -65l -> raise EXN_INVALID_IMAGE_DESCRIPTOR
  | -66l -> raise EXN_INVALID_COMPILER_OPTIONS
  | -67l -> raise EXN_INVALID_LINKER_OPTIONS
  | -68l -> raise EXN_INVALID_DEVICE_PARTITION_COUNT
  |    _ -> failwith "owl_opencl:unknown"

