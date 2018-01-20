/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


value float32_ndarray_slicing (value vX, value vY, value vZ) {
  return Val_unit;
}


value float64_ndarray_slicing (value vX, value vY, value vZ) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  float *X_data = (float *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  float *Y_data = (float *) Y->data;

  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  int64_t *slice = (int64_t *) Z->data;

  struct slice_pair * sp = calloc(1, sizeof(struct slice_pair));
  sp->dim = X->num_dims;
  sp->dep = 0;
  sp->n = Y->dim;
  sp->x = X_data;
  sp->y = Y_data;
  sp->posx = 0;
  sp->posy = 0;
  sp->ofsx = calloc(sp->dim, sizeof(int));
  sp->ofsy = calloc(sp->dim, sizeof(int));
  sp->incx = calloc(sp->dim, sizeof(int));
  sp->incy = calloc(sp->dim, sizeof(int));
  owl_slicing_offset(X, slice, sp->ofsx);
  owl_slicing_stride(X, slice, sp->incx);
  owl_ndarray_stride(Y, sp->incy);
  owl_float64_ndarray_slicing (sp);
  free(sp->ofsx);
  free(sp->ofsy);
  free(sp->incx);
  free(sp->incy);
  free(sp);

  return Val_unit;
}


value complex32_ndarray_slicing (value vX, value vY, value vZ) {
  return Val_unit;
}


value complex64_ndarray_slicing (value vX, value vY, value vZ) {
  return Val_unit;
}
