/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"

value float32_matrix_transpose (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  float *X_data = (float *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  float *Y_data = (float *) Y->data;

  owl_float32_matrix_transpose (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}


value float64_matrix_transpose (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  double *Y_data = (double *) Y->data;

  owl_float64_matrix_transpose (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}


value complex32_matrix_transpose (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex float *X_data = (_Complex float *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex float *Y_data = (_Complex float *) Y->data;

  owl_complex32_matrix_transpose (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}


value complex64_matrix_transpose (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex double *X_data = (_Complex double *) X->data;
  
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex double *Y_data = (_Complex double *) Y->data;

  owl_complex64_matrix_transpose (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}
