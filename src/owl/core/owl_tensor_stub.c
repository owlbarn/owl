#include "owl_core.h"
#include <string.h>

#define OWL_ENABLE_TEMPLATE

//#define FUNCTION(prefix, name) prefix ## _ ## float32_pool ## _ ## name
//#define FUN_NATIVE(name, dim, fb) stub_float32_tensor ## _ ## name ## _ ## dim ## _ ## fb ## _ ## native
//#define FUN_BYTE(name, dim, fb) stub_float32_tensor ## _ ## name ## _ ## dim ## _ ## fb ## _ ## native
#define OWL_TENSOR_MAX
#define FUN_2DF_NATIVE stub_float32_tensor_maxpool_spatial_native
#define FUN_2DF_BYTE   stub_float32_tensor_maxpool_spatial_bytecode
#define FUN_2DB_NATIVE stub_float32_tensor_maxpool_spatial_backward_native
#define FUN_2DB_BYTE   stub_float32_tensor_maxpool_spatial_backward_bytecode
#define FUN_3DF_NATIVE stub_float32_tensor_maxpool_cuboid_native
#define FUN_3DF_BYTE   stub_float32_tensor_maxpool_cuboid_bytecode
#define FUN_3DB_NATIVE stub_float32_tensor_maxpool_cuboid_backward_native
#define FUN_3DB_BYTE   stub_float32_tensor_maxpool_cuboid_backward_bytecode
#define TYPE float
#define INITACC -INFINITY
#define ACCFN(a, b) if (a < b) a = b
#define UPDATEFN(a, b) a
#include "owl_tensor_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef INITACC
#undef TYPE
#undef FUN_2DF_BYTE
#undef FUN_2DF_NATIVE
#undef FUN_2DB_BYTE
#undef FUN_2DB_NATIVE
#undef FUN_3DF_BYTE
#undef FUN_3DF_NATIVE
#undef FUN_3DB_BYTE
#undef FUN_3DB_NATIVE
#undef OWL_TENSOR_MAX


#define OWL_TENSOR_AVG
#define FUN_2DF_NATIVE stub_float32_tensor_avgpool_spatial_native
#define FUN_2DF_BYTE   stub_float32_tensor_avgpool_spatial_bytecode
#define FUN_2DB_NATIVE stub_float32_tensor_avgpool_spatial_backward_native
#define FUN_2DB_BYTE   stub_float32_tensor_avgpool_spatial_backward_bytecode
#define FUN_3DF_NATIVE stub_float32_tensor_avgpool_cuboid_native
#define FUN_3DF_BYTE   stub_float32_tensor_avgpool_cuboid_bytecode
#define FUN_3DB_NATIVE stub_float32_tensor_avgpool_cuboid_backward_native
#define FUN_3DB_BYTE   stub_float32_tensor_avgpool_cuboid_backward_bytecode
#define TYPE float
#define INITACC 0.
#define ACCFN(a, b) a += b
#define UPDATEFN(a, b) a / b
#include "owl_tensor_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef INITACC
#undef FUN_2DF_BYTE
#undef FUN_2DF_NATIVE
#undef FUN_2DB_BYTE
#undef FUN_2DB_NATIVE
#undef FUN_3DF_BYTE
#undef FUN_3DF_NATIVE
#undef FUN_3DB_BYTE
#undef FUN_3DB_NATIVE
#undef OWL_TENSOR_AVG

#undef OWL_ENABLE_TEMPLATE
