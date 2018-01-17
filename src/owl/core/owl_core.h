/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <caml/bigarray.h>

extern int owl_ndarray_numel (struct caml_ba_array *X);

extern int owl_ndarray_stride_size (struct caml_ba_array *X, int d);

extern int owl_ndarray_slice_size (struct caml_ba_array *X, int d);


/** Global inline functions **/

// copy x to y with given offset and stride
inline void owl_float32_copy (int N, float* x, int ofsx, int incx, float* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}

// copy x to y with given offset and stride
inline void owl_complex32_copy (int N, _Complex float* x, int ofsx, int incx, _Complex float* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}

// copy x to y with given offset and stride
inline void owl_float64_copy (int N, double* x, int ofsx, int incx, double* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}

// copy x to y with given offset and stride
inline void owl_complex64_copy (int N, _Complex double* x, int ofsx, int incx, _Complex double* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}
