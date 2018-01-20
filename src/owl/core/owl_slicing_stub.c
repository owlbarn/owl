/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include "owl_slicing.h"


value float64_ndarray_slicing (value vX, value vY, value vZ) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  float *X_data = (float *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  float *Y_data = (float *) Y->data;

  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  int *z_data = (int *) Z->data;

  //owl_float64_ndarray_slicing (p);

  return Val_unit;
}
