/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CORE_H
#define OWL_CORE_H

#include "owl_macros.h"


/** Core function declaration **/


extern int owl_ndarray_numel (struct caml_ba_array *X);

extern int owl_ndarray_stride_size (struct caml_ba_array *X, int d);

extern int owl_ndarray_slice_size (struct caml_ba_array *X, int d);

extern void owl_float32_matrix_transpose (float *x, float *y, int m, int n);

extern void owl_float64_matrix_transpose (double *x, double *y, int m, int n);

extern void owl_complex32_matrix_transpose (_Complex float *x, _Complex float *y, int m, int n);

extern void owl_complex64_matrix_transpose (_Complex double *x, _Complex double *y, int m, int n);


// compare two numbers (real & complex & int)

#define CEQF(X,Y) ((crealf(X) == crealf(Y)) && (cimagf(X) < cimagf(Y)))

#define CEQ(X,Y) ((creal(X) == creal(Y)) && (cimag(X) < cimag(Y)))

#define CNEQF(X,Y) ((crealf(X) != crealf(Y)) || (cimagf(X) != cimagf(Y)))

#define CNEQ(X,Y) ((creal(X) != creal(Y)) || (cimag(X) != cimag(Y)))

#define CLTF(X,Y) ((cabsf(X) < cabsf(Y)) || ((cabsf(X) == cabsf(Y)) && (cargf(X) < cargf(Y))))

#define CGTF(X,Y) ((cabsf(X) > cabsf(Y)) || ((cabsf(X) == cabsf(Y)) && (cargf(X) > cargf(Y))))

#define CLEF(X,Y) !CGTF(X,Y)

#define CGEF(X,Y) !CLTF(X,Y)

#define CLT(X,Y) ((cabs(X) < cabs(Y)) || ((cabs(X) == cabs(Y)) && (carg(X) < carg(Y))))

#define CGT(X,Y) ((cabs(X) > cabs(Y)) || ((cabs(X) == cabs(Y)) && (carg(X) > carg(Y))))

#define CLE(X,Y) !CGT(X,Y)

#define CGE(X,Y) !CLT(X,Y)

extern int float32_cmp (const void * a, const void * b);

extern int float64_cmp (const void * a, const void * b);

extern int complex32_cmpf (const void * a, const void * b);

extern int complex64_cmpf (const void * a, const void * b);

extern int int8_cmp (const void * a, const void * b);

extern int uint8_cmp (const void * a, const void * b);

extern int int16_cmp (const void * a, const void * b);

extern int uint16_cmp (const void * a, const void * b);

extern int int32_cmp (const void * a, const void * b);

extern int int64_cmp (const void * a, const void * b);


// copy two double type numbers, for interfacing to foreign functions
OWL_INLINE value cp_two_doubles(double d0, double d1) {
  value res = caml_alloc_small(2 * Double_wosize, Double_array_tag);
  Store_double_field(res, 0, d0);
  Store_double_field(res, 1, d1);
  return res;
}

// copy x to y with given offset and stride
OWL_INLINE void owl_float32_copy (int N, float* x, int ofsx, int incx, float* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}

// copy x to y with given offset and stride
OWL_INLINE void owl_complex32_copy (int N, _Complex float* x, int ofsx, int incx, _Complex float* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}

// copy x to y with given offset and stride
OWL_INLINE void owl_float64_copy (int N, double* x, int ofsx, int incx, double* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}

// copy x to y with given offset and stride
OWL_INLINE void owl_complex64_copy (int N, _Complex double* x, int ofsx, int incx, _Complex double* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}


#endif  /* OWL_CORE_H */
