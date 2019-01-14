/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CORE_H
#define OWL_CORE_H

#include "owl_macros.h"
#include "owl_slicing.h"
#include "owl_ndarray_contract.h"
#include <stdio.h> // DEBUG


/** Core function declaration **/


extern int c_ndarray_numel (struct caml_ba_array *X);

extern int c_ndarray_stride_dim (struct caml_ba_array *X, int d);

extern int c_ndarray_slice_dim (struct caml_ba_array *X, int d);

extern void c_float32_ndarray_transpose (struct slice_pair *sp);

extern void c_float64_ndarray_transpose (struct slice_pair *sp);

extern void c_complex32_ndarray_transpose (struct slice_pair *sp);

extern void c_complex64_ndarray_transpose (struct slice_pair *sp);

extern void c_float32_ndarray_contract_one (struct contract_pair *sp);

extern void c_float64_ndarray_contract_one (struct contract_pair *sp);

extern void c_complex32_ndarray_contract_one (struct contract_pair *sp);

extern void c_complex64_ndarray_contract_one (struct contract_pair *sp);

extern void c_float32_ndarray_contract_two (struct contract_pair *sp);

extern void c_float64_ndarray_contract_two (struct contract_pair *sp);

extern void c_complex32_ndarray_contract_two (struct contract_pair *sp);

extern void c_complex64_ndarray_contract_two (struct contract_pair *sp);

extern void c_float32_matrix_swap_rows (float *x, int m, int n, int i, int j);

extern void c_float64_matrix_swap_rows (double *x, int m, int n, int i, int j);

extern void c_complex32_matrix_swap_rows (_Complex float *x, int m, int n, int i, int j);

extern void c_complex64_matrix_swap_rows (_Complex double *x, int m, int n, int i, int j);

extern void c_float32_matrix_swap_cols (float *x, int m, int n, int i, int j);

extern void c_float64_matrix_swap_cols (double *x, int m, int n, int i, int j);

extern void c_complex32_matrix_swap_cols (_Complex float *x, int m, int n, int i, int j);

extern void c_complex64_matrix_swap_cols (_Complex double *x, int m, int n, int i, int j);

extern void c_float32_matrix_transpose (float *x, float *y, int m, int n);

extern void c_float64_matrix_transpose (double *x, double *y, int m, int n);

extern void c_complex32_matrix_transpose (_Complex float *x, _Complex float *y, int m, int n);

extern void c_complex64_matrix_transpose (_Complex double *x, _Complex double *y, int m, int n);

extern void c_ndarray_stride (struct caml_ba_array *X, int *stride);

extern void c_ndarray_slice (struct caml_ba_array *X, int *slice);

extern void c_slicing_stride (struct caml_ba_array *X, int64_t *slice, int *stride);

extern void c_slicing_offset (struct caml_ba_array *X, int64_t *slice, int *offset);

extern void c_float32_ndarray_get_slice (struct slice_pair *sp);

extern void c_float64_ndarray_get_slice (struct slice_pair *sp);

extern void c_complex32_ndarray_get_slice (struct slice_pair *sp);

extern void c_complex64_ndarray_get_slice (struct slice_pair *sp);

extern void c_float32_ndarray_set_slice (struct slice_pair *sp);

extern void c_float64_ndarray_set_slice (struct slice_pair *sp);

extern void c_complex32_ndarray_set_slice (struct slice_pair *sp);

extern void c_complex64_ndarray_set_slice (struct slice_pair *sp);

extern void c_float32_ndarray_get_fancy (struct fancy_pair *sp);

extern void c_float64_ndarray_get_fancy (struct fancy_pair *sp);

extern void c_complex32_ndarray_get_fancy (struct fancy_pair *sp);

extern void c_complex64_ndarray_get_fancy (struct fancy_pair *sp);

extern void c_float32_ndarray_set_fancy (struct fancy_pair *sp);

extern void c_float64_ndarray_set_fancy (struct fancy_pair *sp);

extern void c_complex32_ndarray_set_fancy (struct fancy_pair *sp);

extern void c_complex64_ndarray_set_fancy (struct fancy_pair *sp);


// compare two numbers (real & complex & int)

#define CEQF(X,Y) ((crealf(X) == crealf(Y)) && (cimagf(X) == cimagf(Y)))

#define CEQ(X,Y) ((creal(X) == creal(Y)) && (cimag(X) == cimag(Y)))

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

extern int complex32_cmp (const void * a, const void * b);

extern int complex64_cmp (const void * a, const void * b);

extern int int8_cmp (const void * a, const void * b);

extern int uint8_cmp (const void * a, const void * b);

extern int int16_cmp (const void * a, const void * b);

extern int uint16_cmp (const void * a, const void * b);

extern int int32_cmp (const void * a, const void * b);

extern int int64_cmp (const void * a, const void * b);

extern int float32_cmp_r (const void * a, const void * b, const void * z);

extern int float64_cmp_r (const void * a, const void * b, const void * z);

extern int complex32_cmp_r (const void * a, const void * b, const void * z);

extern int complex64_cmp_r (const void * a, const void * b, const void * z);

extern int int8_cmp_r (const void * a, const void * b, const void * z);

extern int uint8_cmp_r (const void * a, const void * b, const void * z);

extern int int16_cmp_r (const void * a, const void * b, const void * z);

extern int uint16_cmp_r (const void * a, const void * b, const void * z);

extern int int32_cmp_r (const void * a, const void * b, const void * z);

extern int int64_cmp_r (const void * a, const void * b, const void * z);


// acquire CPU cache sizes

extern void query_cache_sizes(int* l1p, int* l2p, int* l3p);


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
OWL_INLINE void owl_float64_copy (int N, double* x, int ofsx, int incx, double* y, int ofsy, int incy) {
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
OWL_INLINE void owl_complex64_copy (int N, _Complex double* x, int ofsx, int incx, _Complex double* y, int ofsy, int incy) {
  for (int i = 0; i < N; i++) {
    *(y + ofsy) = *(x + ofsx);
    ofsx += incx;
    ofsy += incy;
  }
}


#endif  /* OWL_CORE_H */
