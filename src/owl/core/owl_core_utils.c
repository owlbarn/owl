/*
 * OWL - an OCaml numerical library for scientific computing
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

int complex32_cmpf (const void * a, const void * b) {
 return ( CLTF(*(_Complex float*)a,*(_Complex float*)b) ? -1 : (CGTF(*(_Complex float*)a,*(_Complex float*)b) ? 1 : 0) );
}

int complex64_cmpf (const void * a, const void * b) {
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


// calculate the number of elements given a bigarray
int owl_ndarray_numel (struct caml_ba_array *X) {
  int n = 1;

  for (int i = 0; i < X->num_dims; i ++)
    n *= X->dim[i];

  return n;
}


// calculate the stride of a given dimension of a bigarray
int owl_ndarray_stride_dim (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i > d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the slice size of a given dimension of a bigarray
int owl_ndarray_slice_dim (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i >= d; i--)
    s *= X->dim[i];

  return s;
}

// calculate the slice size of all dimensions of a bigarray
void owl_ndarray_stride (struct caml_ba_array *X, int *stride) {
  int i = X->num_dims - 1;
  *(stride + i) = 1;

  for ( ; i > 0; i--)
    *(stride + i - 1) = *(stride + i) * X->dim[i];
}


// calculate the offset of each dimension in output based on a slice definition
// the slice definition is a list (start,stop,step) triplets.
void owl_slicing_stride (struct caml_ba_array *X, int64_t *slice, int *stride) {
  owl_ndarray_stride(X, stride);

  for (int i = 0; i < X->num_dims; i++)
    *(stride + i) *= *(slice + 3 * i + 2);
}


// calculate the offset of each dimension in output based on a slice definition
// the slice definition is a list (start,stop,step) triplets.
void owl_slicing_offset (struct caml_ba_array *X, int64_t *slice, int *offset) {
  owl_ndarray_stride(X, offset);

  for (int i = 0; i < X->num_dims; i++)
    *(offset + i) *= *(slice + 3 * i);
}
