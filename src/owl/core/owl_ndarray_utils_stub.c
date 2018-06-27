/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


// reshape the ndarray without creating new structure
CAMLprim value stub_ndarray_reshape
(value *vX, value *vY, value vD)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  intnat *shape = (intnat *) Y->data;

  int d = Long_val(vD);
  intnat *dim = malloc(sizeof(intnat) * d);
  free(X->dim);
  X->num_dims = d;
  X->dim = &dim[0]; 

  for (int i = 0; i < d; i++)
    dim[i] = shape[i];

  return Val_unit;
}
