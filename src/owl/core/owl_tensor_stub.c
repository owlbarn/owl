#include "owl_core.h"

#define OWL_ENABLE_TEMPLATE

/*
CAMLprim
value c_tensor_op(value vX, value vY) {
  CAMLparam2(vX, vY);
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  float *X_data = (float *) X->data;
  int y = Long_val(vY);
  return Val_unit;
}
*/


//#define FUNCTION(prefix, name) prefix ## _ ## float32_pool ## _ ## name
#define TYPE float
//#define MAPFUN(x, y) y = x
#include "owl_tensor_impl.c"
//#undef MAPFUN
#undef TYPE
//#undef FUNCTION

/*
void c_tensor_add(value arr, value x)
{
  int x = Long_val(x);
  float* x53 = CTYPES_ADDR_OF_FATPTR(arr);
  return;
}

*/

#undef OWL_ENABLE_TEMPLATE
