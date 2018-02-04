#include "owl_core.h"

#define OWL_ENABLE_TEMPLATE

//#define FUNCTION(prefix, name) prefix ## _ ## float32_pool ## _ ## name
#define FUN_NATIVE stub_float32_tensor_maxpool_spatial_native
#define FUN_BYTE   stub_float32_tensor_maxpool_spatial_bytecode
#define TYPE float
#define INITACC -INFINITY
#define ACCFN(x, y) if (x < y) x = y
#define UPDATEFN(x, y) x
#include "owl_tensor_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef FUN_NATIVE
#undef FUN_BYTE

#define FUN_NATIVE stub_float32_tensor_avgpool_spatial_native
#define FUN_BYTE   stub_float32_tensor_avgpool_spatial_bytecode
#define TYPE float
#define INITACC 0.
#define ACCFN(x, y) x += y
#define UPDATEFN(x, y) x / c
#include "owl_tensor_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef FUN_NATIVE
#undef FUN_BYTE

#undef OWL_ENABLE_TEMPLATE
