/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"

// compare two numbers (real & complex & int)

int float32_cmp (const void * a, const void * b) {
  return ( *(float*)a < *(float*)b ? -1 : (*(float*)a > *(float*)b ? 1 : 0) );
}

int float64_cmp (const void * a, const void * b) {
  return ( *(double*)a < *(double*)b ? -1 : (*(double*)a > *(double*)b ? 1 : 0) );
}

int complex32_cmp (const void * a, const void * b) {
 return ( CLTF(*(_Complex float*)a,*(_Complex float*)b) ? -1 : (CGTF(*(_Complex float*)a,*(_Complex float*)b) ? 1 : 0) );
}

int complex64_cmp (const void * a, const void * b) {
 return ( CLT(*(_Complex double*)a,*(_Complex double*)b) ? -1 : (CGT(*(_Complex double*)a,*(_Complex double*)b) ? 1 : 0) );
}

int int8_cmp (const void * a, const void * b) {
  return ( *(int8_t*)a < *(int8_t*)b ? -1 : (*(int8_t*)a > *(int8_t*)b ? 1 : 0) );
}

int uint8_cmp (const void * a, const void * b) {
  return ( *(uint8_t*)a < *(uint8_t*)b ? -1 : (*(uint8_t*)a > *(uint8_t*)b ? 1 : 0) );
}

int int16_cmp (const void * a, const void * b) {
  return ( *(int16_t*)a < *(int16_t*)b ? -1 : (*(int16_t*)a > *(int16_t*)b ? 1 : 0) );
}

int uint16_cmp (const void * a, const void * b) {
  return ( *(uint16_t*)a < *(uint16_t*)b ? -1 : (*(uint16_t*)a > *(uint16_t*)b ? 1 : 0) );
}

int int32_cmp (const void * a, const void * b) {
  return ( *(int32_t*)a < *(int32_t*)b ? -1 : (*(int32_t*)a > *(int32_t*)b ? 1 : 0) );
}

int int64_cmp (const void * a, const void * b) {
  return ( *(int64_t*)a < *(int64_t*)b ? -1 : (*(int64_t*)a > *(int64_t*)b ? 1 : 0) );
}


// compare two numbers, used in qsort_r and argsort

int float32_cmp_r (const void * i, const void * j, const void * z) {
  float a = *((float*)z + (*(int64_t*)i));
  float b = *((float*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int float64_cmp_r (const void * i, const void * j, const void * z) {
  double a = *((double*)z + (*(int64_t*)i));
  double b = *((double*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int complex32_cmp_r (const void * i, const void * j, const void * z) {
  _Complex float a = *((_Complex float*)z + (*(int64_t*)i));
  _Complex float b = *((_Complex float*)z + (*(int64_t*)j));
  return ( CLTF(a,b) ? -1 : (CGTF(a,b) ? 1 : 0) );
}

int complex64_cmp_r (const void * i, const void * j, const void * z) {
  _Complex double a = *((_Complex double*)z + (*(int64_t*)i));
  _Complex double b = *((_Complex double*)z + (*(int64_t*)j));
  return ( CLT(a,b) ? -1 : (CGT(a,b) ? 1 : 0) );
}

int int8_cmp_r (const void * i, const void * j, const void * z) {
  int8_t a = *((int8_t*)z + (*(int64_t*)i));
  int8_t b = *((int8_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int uint8_cmp_r (const void * i, const void * j, const void * z) {
  uint8_t a = *((uint8_t*)z + (*(int64_t*)i));
  uint8_t b = *((uint8_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int int16_cmp_r (const void * i, const void * j, const void * z) {
  int16_t a = *((int16_t*)z + (*(int64_t*)i));
  int16_t b = *((int16_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int uint16_cmp_r (const void * i, const void * j, const void * z) {
  uint16_t a = *((uint16_t*)z + (*(int64_t*)i));
  uint16_t b = *((uint16_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int int32_cmp_r (const void * i, const void * j, const void * z) {
  int32_t a = *((int32_t*)z + (*(int64_t*)i));
  int32_t b = *((int32_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int int64_cmp_r (const void * i, const void * j, const void * z) {
  int64_t a = *((int64_t*)z + (*(int64_t*)i));
  int64_t b = *((int64_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}


// calculate the number of elements given a bigarray
int c_ndarray_numel (struct caml_ba_array *X) {
  int n = 1;

  for (int i = 0; i < X->num_dims; i ++)
    n *= X->dim[i];

  return n;
}


// calculate the stride of a given dimension of a bigarray
int c_ndarray_stride_dim (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i > d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the slice size of a given dimension of a bigarray
int c_ndarray_slice_dim (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i >= d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the stride size of all dimensions of a bigarray
void c_ndarray_stride (struct caml_ba_array *X, int *stride) {
  int i = X->num_dims - 1;
  *(stride + i) = 1;

  for ( ; i > 0; i--)
    *(stride + i - 1) = *(stride + i) * X->dim[i];
}


// calculate the slice size of all dimensions of a bigarray
void c_ndarray_slice (struct caml_ba_array *X, int *slice) {
  int i = X->num_dims - 1;
  *(slice + i) = X->dim[i];

  for (; i > 0; i--)
    *(slice + i - 1) = *(slice + i) * X->dim[i - 1];
}


/*
 * calculate the offset of each dimension in output based on a slice definition
 * the slice definition is a list (start,stop,step) triplets.
 *
 * Note that slice may encode information for fancy slicing. In case of L, the
 * stride remains the same.
 */
void c_slicing_stride (struct caml_ba_array *X, int64_t *slice, int *stride) {
  c_ndarray_stride(X, stride);

  for (int i = 0; i < X->num_dims; i++) {
    int64_t start = *(slice + 3 * i);
    int64_t step = *(slice + 3 * i + 2);
    *(stride + i) *= start < 0 ? 1 : step;
  }
}


/*
 * calculate the offset of each dimension in output based on a slice definition
 * the slice definition is a list (start,stop,step) triplets.
 *
 * Note that slice may encode information for fancy slicing. In case of L, we
 * set offset to zero since the elements in L will be used to calculate ofsx.
 */
void c_slicing_offset (struct caml_ba_array *X, int64_t *slice, int *offset) {
  c_ndarray_stride(X, offset);

  for (int i = 0; i < X->num_dims; i++) {
    int64_t start = *(slice + 3 * i);
    *(offset + i) *= start < 0 ? 0 : start;
  }
}
