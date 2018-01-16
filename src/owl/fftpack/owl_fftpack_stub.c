/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <stdlib.h>
#include <complex.h>
#include <caml/alloc.h>
#include <caml/memory.h>

#include "owl_macros.h"
#include "fftpack.h"

#define MAXFAC 13    /* maximum number of factors in factorization of n */


inline int owl_ndarray_numel (struct caml_ba_array *X) {
  int n = 1;

  for (int i = 0; i < X->num_dims; i ++)
    n *= X->dim[i];

  return n;
}


value owl_stub_cfftf (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;
  int n = owl_ndarray_numel(X);

  size_t ws_sz = 4 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  owl_fftpack_cffti(n, wsave);

  owl_fftpack_cfftf(n, X_data, wsave);

  free(wsave);

  return Val_unit;
}


value owl_stub_cfftb (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;
  int n = owl_ndarray_numel(X);

  size_t ws_sz = 4 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  owl_fftpack_cffti(n, wsave);

  owl_fftpack_cfftb(n, X_data, wsave);

  free(wsave);

  return Val_unit;
}


value owl_stub_rfftf (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;
  int n = owl_ndarray_numel(X);

  size_t ws_sz = 2 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  owl_fftpack_rffti(n, wsave);

  owl_fftpack_rfftf(n, X_data, wsave);

  free(wsave);

  return Val_unit;
}


value owl_stub_rfftb (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;
  int n = owl_ndarray_numel(X);

  size_t ws_sz = 2 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  owl_fftpack_rffti(n, wsave);

  owl_fftpack_rfftb(n, X_data, wsave);

  free(wsave);

  return Val_unit;
}


value owl_stub_halfcomplex_unpack (value vX, value vY) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex double *Y_data = (_Complex double *) Y->data;

  int n = owl_ndarray_numel(X);
  int stride = 1;
  int i;

  *Y_data = *X_data + 0 * I;

  for (i = 1; i < n - i; i++) {
    double re = *(X_data + (2 * i - 1) * stride);
    double im = *(X_data + 2 * i * stride);
    *(Y_data + i * stride) = re + im * I;
  }

  if (i == n - i)
    *(Y_data + i * stride) = *(X_data + (n - 1) * stride) + 0 * I;

  return Val_unit;
}
