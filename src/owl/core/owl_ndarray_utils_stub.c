/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


// reshape the ndarray without creating new structure
CAMLprim value stub_ndarray_same_data (value *vX, value *vY)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  int same = (X->data == Y->data);

  return Val_long(same);
}
