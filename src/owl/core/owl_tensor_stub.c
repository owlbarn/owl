#include "owl_core.h"
#include <string.h>

#define OWL_ENABLE_TEMPLATE

//#define FUNCTION(prefix, name) prefix ## _ ## float32_pool ## _ ## name
//#define FUN_NATIVE(name, dim, fb) stub_float32_tensor ## _ ## name ## _ ## dim ## _ ## fb ## _ ## native
//#define FUN_BYTE(name, dim, fb) stub_float32_tensor ## _ ## name ## _ ## dim ## _ ## fb ## _ ## native
#define FUN_2DF_NATIVE stub_float32_tensor_maxpool_spatial_native
#define FUN_2DF_BYTE   stub_float32_tensor_maxpool_spatial_bytecode
#define FUN_MAX_2DB_NATIVE stub_float32_tensor_maxpool_spatial_backward_native
#define FUN_MAX_2DB_BYTE   stub_float32_tensor_maxpool_spatial_backward_bytecode
#define FUN_AVG_2DB_NATIVE stub_float32_tensor_avgpool_spatial_backward_native1
#define FUN_AVG_2DB_BYTE   stub_float32_tensor_avgpool_spatial_backward_bytecode1
#define TYPE float
#define INITACC -INFINITY
#define ACCFN(a, b) if (a < b) a = b
#define UPDATEFN(a, b) a
#define ACCFN_2DB(a, b, c, d, e) if (a < b) {a = b; c = d; }
#include "owl_tensor_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef ACCFN_2DB
#undef INITACC
#undef TYPE
#undef FUN_2DF_BYTE
#undef FUN_2DF_NATIVE
#undef FUN_2DB_BYTE
#undef FUN_MAX_2DB_BYTE
#undef FUN_MAX_2DB_NATIVE
#undef FUN_AVG_2DB_BYTE
#undef FUN_AVG_2DB_NATIVE



#define FUN_2DF_NATIVE stub_float32_tensor_avgpool_spatial_native
#define FUN_2DF_BYTE   stub_float32_tensor_avgpool_spatial_bytecode
#define FUN_MAX_2DB_NATIVE stub_float32_tensor_maxpool_spatial_backward_native1
#define FUN_MAX_2DB_BYTE   stub_float32_tensor_maxpool_spatial_backward_bytecode1
#define FUN_AVG_2DB_NATIVE stub_float32_tensor_avgpool_spatial_backward_native
#define FUN_AVG_2DB_BYTE   stub_float32_tensor_avgpool_spatial_backward_bytecode
#define TYPE float
#define INITACC 0.
#define ACCFN(a, b) a += b
#define UPDATEFN(a, b) a / b
#define ACCFN_2DB(a, b, c, d, e) e++;
#include "owl_tensor_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef ACCFN_2DB
#undef TYPE
#undef INITACC
#undef FUN_2DF_BYTE
#undef FUN_2DF_NATIVE
#undef FUN_2DB_BYTE
#undef FUN_MAX_2DB_BYTE
#undef FUN_MAX_2DB_NATIVE
#undef FUN_AVG_2DB_BYTE
#undef FUN_AVG_2DB_NATIVE


#undef OWL_ENABLE_TEMPLATE
