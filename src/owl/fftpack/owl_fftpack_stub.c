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

#include <stdio.h>

#define MAXFAC 13    /* maximum number of factors in factorization of n */

// copy x to y with given offset and stride
inline void owl_fftpack_complex64_copy (int N, _Complex double* x, int ofsx, int stdx, _Complex double* y, int ofsy, int stdy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += stdx;
    ofsy += stdy;
  }
}

inline void owl_fftpack_float64_copy (int N, double* x, int ofsx, int stdx, double* y, int ofsy, int stdy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += stdx;
    ofsy += stdy;
  }
}


// calculate the number of elements given a bigarray
inline int owl_ndarray_numel (struct caml_ba_array *X) {
  int n = 1;

  for (int i = 0; i < X->num_dims; i ++)
    n *= X->dim[i];

  return n;
}

// calculate the stride of a given dimension of a bigarray
inline int owl_ndarray_stride_size (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i > d; i--)
    s *= X->dim[i];

  return s;
}

// calculate the slice size of a given dimension of a bigarray
inline int owl_ndarray_slice_size (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i >= d; i--)
    s *= X->dim[i];

  return s;
}


value owl_stub_cfftf (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex double *X_data = (_Complex double *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex double *Y_data = (_Complex double *) Y->data;

  int d = Long_val(vD);
  int n = X->dim[d];
  size_t ws_sz = 4 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(2 * n * sizeof(Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  owl_fftpack_cffti(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      owl_fftpack_complex64_copy(n, X_data, ofsx + j, stdx, data, 0, 1);
      owl_fftpack_cfftf(n, (Treal*) data, wsave);
      owl_fftpack_complex64_copy(n, data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


value owl_stub_cfftb (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex double *X_data = (_Complex double *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex double *Y_data = (_Complex double *) Y->data;

  int d = Long_val(vD);
  int n = X->dim[d];
  size_t ws_sz = 4 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(2 * n * sizeof(Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  owl_fftpack_cffti(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      owl_fftpack_complex64_copy(n, X_data, ofsx + j, stdx, data, 0, 1);
      owl_fftpack_cfftb(n, (Treal*) data, wsave);
      owl_fftpack_complex64_copy(n, data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


/**
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
**/


// uppack from halfcomplex x to complex y
inline void owl_halfcomplex_unpack (int n, double* x, int ofsx, int incx, _Complex double* y, int ofsy, int incy) {
  int i;
  *(y + ofsy) = *(x + ofsx) + 0 * I;

  for (i = 1; i < n - i; i++) {
    ofsx += incx + incx;
    ofsy += incy;
    double re = *(x + ofsx - incx);
    double im = *(x + ofsx);
    *(y + ofsy) = re + im * I;
  }

  if (i == n - i)
    *(y + ofsy + incy) = *(x + ofsx + incx) + 0 * I;
}


// pack from complex x to halfcomplex y
inline void owl_halfcomplex_pack (int n, _Complex double* x, int ofsx, int incx, double* y, int ofsy, int incy) {
  int i;
  *(y + ofsy) = creal(*(x + ofsx));

  for (i = 1; i < n - i; i++) {
    ofsx += incx;
    ofsy += incy + incy;
    *(y + ofsy - incy) = creal(*(x + ofsx));
    *(y + ofsy) = cimag(*(x + ofsx));
  }

  if (i == n - i)
    *(y + ofsy + incy) = creal(*(x + ofsx + incx));
}


value owl_stub_rfftf (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  double *X_data = (double *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex double *Y_data = (_Complex double *) Y->data;

  int d = Long_val(vD);
  int n = X->dim[d];
  size_t ws_sz = 2 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(n * sizeof(Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  owl_fftpack_rffti(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      owl_fftpack_float64_copy(n, X_data, ofsx + j, stdx, data, 0, 1);
      owl_fftpack_rfftf(n, (Treal*) data, wsave);
      /** for (int k = 0; k < n; k++) {
        printf("%.3f ", *(((Treal *) data) + k));
      }
      printf(" .... ofsy:%i\n", ofsy); **/
      owl_halfcomplex_unpack(n, data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


value owl_stub_rfftb (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex double *X_data = (_Complex double *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  double *Y_data = (double *) Y->data;

  int d = Long_val(vD);
  int n = Y->dim[d];
  size_t ws_sz = 2 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(n * sizeof(_Complex double));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  owl_fftpack_rffti(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      owl_halfcomplex_pack(n, X_data, ofsx + j, stdx, data, 0, 1);
      owl_fftpack_rfftb(n, (Treal*) data, wsave);
      owl_fftpack_float64_copy(n, (Treal*) data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}
