/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <math.h>
#include <complex.h>
#include <caml/mlvalues.h>
#include "owl_macros.h"

// some helper functions

#define LN10 2.30258509299404568402  /* log_e 10 */
#define exp10f(X) expf(LN10 * X)
#define exp10(X) exp(LN10 * X)

value cp_two_doubles(double d0, double d1)
{
  value res = caml_alloc_small(2 * Double_wosize, Double_array_tag);
  Store_double_field(res, 0, d0);
  Store_double_field(res, 1, d1);
  return res;
}


// compare two complex numbers

#define CLTF(X,Y) ((cabsf(X) < cabsf(Y)) || ((cabsf(X) == cabsf(Y)) && (cargf(X) < cargf(Y))))

#define CGTF(X,Y) ((cabsf(X) > cabsf(Y)) || ((cabsf(X) == cabsf(Y)) && (cargf(X) > cargf(Y))))

#define CLEF(X,Y) !CGTF(X,Y)

#define CGEF(X,Y) !CLTF(X,Y)

#define CLT(X,Y) ((cabs(X) < cabs(Y)) || ((cabs(X) == cabs(Y)) && (carg(X) < carg(Y))))

#define CGT(X,Y) ((cabs(X) > cabs(Y)) || ((cabs(X) == cabs(Y)) && (carg(X) > carg(Y))))

#define CLE(X,Y) !CGT(X,Y)

#define CGE(X,Y) !CLT(X,Y)


// compare two numbers (real & complex & int)

int float32_cmp (const void * a, const void * b)
{
  return ( *(float*)a < *(float*)b ? -1 : (*(float*)a > *(float*)b ? 1 : 0) );
}

int float64_cmp (const void * a, const void * b)
{
  return ( *(double*)a < *(double*)b ? -1 : (*(double*)a > *(double*)b ? 1 : 0) );
}

int complex32_cmpf (const void * a, const void * b)
{
 return ( CLTF(*(_Complex float*)a,*(_Complex float*)b) ? -1 : (CGTF(*(_Complex float*)a,*(_Complex float*)b) ? 1 : 0) );
}

int complex64_cmpf (const void * a, const void * b)
{
 return ( CLT(*(_Complex double*)a,*(_Complex double*)b) ? -1 : (CGT(*(_Complex double*)a,*(_Complex double*)b) ? 1 : 0) );
}

int int8_cmp (const void * a, const void * b)
{
  return ( *(int8_t*)a < *(int8_t*)b ? -1 : (*(int8_t*)a > *(int8_t*)b ? 1 : 0) );
}

int uint8_cmp (const void * a, const void * b)
{
  return ( *(uint8_t*)a < *(uint8_t*)b ? -1 : (*(uint8_t*)a > *(uint8_t*)b ? 1 : 0) );
}

int int16_cmp (const void * a, const void * b)
{
  return ( *(int16_t*)a < *(int16_t*)b ? -1 : (*(int16_t*)a > *(int16_t*)b ? 1 : 0) );
}

int uint16_cmp (const void * a, const void * b)
{
  return ( *(uint16_t*)a < *(uint16_t*)b ? -1 : (*(uint16_t*)a > *(uint16_t*)b ? 1 : 0) );
}

int int32_cmp (const void * a, const void * b)
{
  return ( *(int32_t*)a < *(int32_t*)b ? -1 : (*(int32_t*)a > *(int32_t*)b ? 1 : 0) );
}

int int64_cmp (const void * a, const void * b)
{
  return ( *(int64_t*)a < *(int64_t*)b ? -1 : (*(int64_t*)a > *(int64_t*)b ? 1 : 0) );
}


//////////////////// function templates starts ////////////////////


// copy

#define FUN19 float32_copy
#define FUN19_IMPL float32_copy_impl
#define NUMBER float
#define NUMBER1 float
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 float64_copy
#define FUN19_IMPL float64_copy_impl
#define NUMBER double
#define NUMBER1 double
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 complex32_copy
#define FUN19_IMPL complex32_copy_impl
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 complex64_copy
#define FUN19_IMPL complex64_copy_impl
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 char_copy
#define FUN19_IMPL char_copy_impl
#define NUMBER char
#define NUMBER1 char
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 int8_copy
#define FUN19_IMPL int8_copy_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 uint8_copy
#define FUN19_IMPL uint8_copy_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 int16_copy
#define FUN19_IMPL int16_copy_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 uint16_copy
#define FUN19_IMPL uint16_copy_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 int32_copy
#define FUN19_IMPL int32_copy_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN19 int64_copy
#define FUN19_IMPL int64_copy_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define INIT
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

// less

#define FUN0 float32_less
#define NUMBER float
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 float64_less
#define NUMBER double
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex32_less
#define NUMBER _Complex float
#define STOPFN(X, Y) CGEF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex64_less
#define NUMBER _Complex double
#define STOPFN(X, Y) CGE(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int8_less
#define NUMBER int8_t
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint8_less
#define NUMBER uint8_t
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int16_less
#define NUMBER int16_t
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint16_less
#define NUMBER uint16_t
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int32_less
#define NUMBER int32_t
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int64_less
#define NUMBER int64_t
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

// greater

#define FUN0 float32_greater
#define NUMBER float
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 float64_greater
#define NUMBER double
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex32_greater
#define NUMBER _Complex float
#define STOPFN(X, Y) CLEF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex64_greater
#define NUMBER _Complex double
#define STOPFN(X, Y) CLE(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int8_greater
#define NUMBER int8_t
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint8_greater
#define NUMBER uint8_t
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int16_greater
#define NUMBER int16_t
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint16_greater
#define NUMBER uint16_t
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int32_greater
#define NUMBER int32_t
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int64_greater
#define NUMBER int64_t
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

// less_equal

#define FUN0 float32_less_equal
#define NUMBER float
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 float64_less_equal
#define NUMBER double
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex32_less_equal
#define NUMBER _Complex float
#define STOPFN(X, Y) CGTF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex64_less_equal
#define NUMBER _Complex double
#define STOPFN(X, Y) CGT(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int8_less_equal
#define NUMBER int8_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint8_less_equal
#define NUMBER uint8_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int16_less_equal
#define NUMBER int16_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint16_less_equal
#define NUMBER uint16_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int32_less_equal
#define NUMBER int32_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int64_less_equal
#define NUMBER int64_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

// greater_equal

#define FUN0 float32_greater_equal
#define NUMBER float
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 float64_greater_equal
#define NUMBER double
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex32_greater_equal
#define NUMBER _Complex float
#define STOPFN(X, Y) CLTF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex64_greater_equal
#define NUMBER _Complex double
#define STOPFN(X, Y) CLT(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int8_greater_equal
#define NUMBER int8_t
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint8_greater_equal
#define NUMBER uint8_t
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int16_greater_equal
#define NUMBER int16_t
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint16_greater_equal
#define NUMBER uint16_t
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int32_greater_equal
#define NUMBER int32_t
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int64_greater_equal
#define NUMBER int64_t
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

// is_zero

#define FUN1 float32_is_zero
#define NUMBER float
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_is_zero
#define NUMBER double
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_is_zero
#define NUMBER complex_float
#define STOPFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_is_zero
#define NUMBER complex_double
#define STOPFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int8_is_zero
#define NUMBER int8_t
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint8_is_zero
#define NUMBER uint8_t
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int16_is_zero
#define NUMBER int16_t
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint16_is_zero
#define NUMBER uint16_t
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int32_is_zero
#define NUMBER int32_t
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int64_is_zero
#define NUMBER int64_t
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

// is_positive

#define FUN1 float32_is_positive
#define NUMBER float
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_is_positive
#define NUMBER double
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_is_positive
#define NUMBER complex_float
#define STOPFN(X) (X.r <= 0 || X.i <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_is_positive
#define NUMBER complex_double
#define STOPFN(X) (X.r <= 0 || X.i <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int8_is_positive
#define NUMBER int8_t
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint8_is_positive
#define NUMBER uint8_t
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int16_is_positive
#define NUMBER int16_t
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint16_is_positive
#define NUMBER uint16_t
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int32_is_positive
#define NUMBER int32_t
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int64_is_positive
#define NUMBER int64_t
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

// is_negative

#define FUN1 float32_is_negative
#define NUMBER float
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_is_negative
#define NUMBER double
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_is_negative
#define NUMBER complex_float
#define STOPFN(X) (X.r >= 0 || X.i >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_is_negative
#define NUMBER complex_double
#define STOPFN(X) (X.r >= 0 || X.i >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int8_is_negative
#define NUMBER int8_t
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint8_is_negative
#define NUMBER uint8_t
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int16_is_negative
#define NUMBER int16_t
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint16_is_negative
#define NUMBER uint16_t
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int32_is_negative
#define NUMBER int32_t
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int64_is_negative
#define NUMBER int64_t
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

// is_nonnegative

#define FUN1 float32_is_nonnegative
#define NUMBER float
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_is_nonnegative
#define NUMBER double
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_is_nonnegative
#define NUMBER complex_float
#define STOPFN(X) (X.r < 0 || X.i < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_is_nonnegative
#define NUMBER complex_double
#define STOPFN(X) (X.r < 0 || X.i < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int8_is_nonnegative
#define NUMBER int8_t
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint8_is_nonnegative
#define NUMBER uint8_t
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int16_is_nonnegative
#define NUMBER int16_t
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 uint16_is_nonnegative
#define NUMBER uint16_t
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int32_is_nonnegative
#define NUMBER int32_t
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 int64_is_nonnegative
#define NUMBER int64_t
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

// is_nonpositive

#define FUN1 float32_is_nonpositive
#define NUMBER float
#define STOPFN(X) (X > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_is_nonpositive
#define NUMBER double
#define STOPFN(X) (X > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_is_nonpositive
#define NUMBER complex_float
#define STOPFN(X) (X.r > 0 || X.i > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_is_nonpositive
#define NUMBER complex_double
#define STOPFN(X) (X.r > 0 || X.i > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int8_is_nonpositive
#define NUMBER int8_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint8_is_nonpositive
#define NUMBER uint8_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int16_is_nonpositive
#define NUMBER int16_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 uint16_is_nonpositive
#define NUMBER uint16_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int32_is_nonpositive
#define NUMBER int32_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 int64_is_nonpositive
#define NUMBER int64_t
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

// elt_equal

#define FUN15 float32_elt_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_elt_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_elt_equal
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = (X->r == Y->r) && (X->i == Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_elt_equal
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = (X->r == Y->r) && (X->i == Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_elt_equal
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_elt_equal
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_elt_equal
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_elt_equal
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_elt_equal
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_elt_equal
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

// elt_not_equal

#define FUN15 float32_elt_not_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_elt_not_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_elt_not_equal
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = (X->r != Y->r) || (X->i != Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_elt_not_equal
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = (X->r != Y->r) || (X->i != Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_elt_not_equal
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_elt_not_equal
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_elt_not_equal
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_elt_not_equal
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_elt_not_equal
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_elt_not_equal
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

// elt_less

#define FUN15 float32_elt_less
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_elt_less
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_elt_less
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CLTF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_elt_less
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CLT(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_elt_less
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_elt_less
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_elt_less
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_elt_less
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_elt_less
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_elt_less
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

// elt_greater

#define FUN15 float32_elt_greater
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_elt_greater
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_elt_greater
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CGTF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_elt_greater
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CGT(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_elt_greater
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_elt_greater
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_elt_greater
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_elt_greater
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_elt_greater
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_elt_greater
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

// elt_less_equal

#define FUN15 float32_elt_less_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_elt_less_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_elt_less_equal
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CLEF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_elt_less_equal
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CLE(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_elt_less_equal
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_elt_less_equal
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_elt_less_equal
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_elt_less_equal
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_elt_less_equal
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_elt_less_equal
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

// elt_greater_equal

#define FUN15 float32_elt_greater_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_elt_greater_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_elt_greater_equal
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CGEF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_elt_greater_equal
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CGE(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_elt_greater_equal
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_elt_greater_equal
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_elt_greater_equal
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_elt_greater_equal
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_elt_greater_equal
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_elt_greater_equal
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

// equal_scalar

#define FUN16 float32_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 float64_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex32_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define STOPFN(X) X.r != ar || X.i != ai
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex64_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define STOPFN(X) X.r != ar || X.i != ai
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int8_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint8_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int16_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint16_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int32_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int64_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

// not_equal_scalar

#define FUN16 float32_not_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 float64_not_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex32_not_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define STOPFN(X) X.r == ar && X.i == ai
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex64_not_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define STOPFN(X) X.r == ar && X.i == ai
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int8_not_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint8_not_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int16_not_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint16_not_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int32_not_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int64_not_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

// less_scalar

#define FUN16 float32_less_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 float64_less_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex32_less_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CGEF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex64_less_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CGE(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int8_less_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint8_less_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int16_less_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint16_less_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int32_less_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int64_less_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

// greater_scalar

#define FUN16 float32_greater_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 float64_greater_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex32_greater_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CLEF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex64_greater_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CLE(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int8_greater_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint8_greater_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int16_greater_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint16_greater_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int32_greater_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int64_greater_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

// less_equal_scalar

#define FUN16 float32_less_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 float64_less_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex32_less_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CGTF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex64_less_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CGT(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int8_less_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint8_less_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int16_less_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint16_less_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int32_less_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int64_less_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

// greater_equal_scalar

#define FUN16 float32_greater_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 float64_greater_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex32_greater_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CLTF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex64_greater_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CLT(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int8_greater_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint8_greater_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int16_greater_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 uint16_greater_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int32_greater_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 int64_greater_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

// elt_equal_scalar

#define FUN17 float32_elt_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elt_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_elt_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (X->r == ar) && (X->i == ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_elt_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (X->r == ar) && (X->i == ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_elt_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_elt_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_elt_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_elt_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_elt_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_elt_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

// elt_not_equal_scalar

#define FUN17 float32_elt_not_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elt_not_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_elt_not_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (X->r != ar) || (X->i != ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_elt_not_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (X->r != ar) || (X->i != ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_elt_not_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_elt_not_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_elt_not_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_elt_not_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_elt_not_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_elt_not_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

// elt_less_scalar

#define FUN17 float32_elt_less_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elt_less_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_elt_less_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CLTF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_elt_less_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CLT(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_elt_less_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_elt_less_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_elt_less_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_elt_less_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_elt_less_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_elt_less_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

// elt_greater_scalar

#define FUN17 float32_elt_greater_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elt_greater_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_elt_greater_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CGTF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_elt_greater_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CGT(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_elt_greater_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_elt_greater_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_elt_greater_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_elt_greater_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_elt_greater_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_elt_greater_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

// elt_less_equal_scalar

#define FUN17 float32_elt_less_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elt_less_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_elt_less_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CLEF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_elt_less_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) CLE(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_elt_less_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_elt_less_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_elt_less_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_elt_less_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_elt_less_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_elt_less_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

// elt_greater_equal_scalar

#define FUN17 float32_elt_greater_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elt_greater_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_elt_greater_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CGEF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_elt_greater_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CGE(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_elt_greater_equal_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_elt_greater_equal_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_elt_greater_equal_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_elt_greater_equal_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_elt_greater_equal_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_elt_greater_equal_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

// nnz

#define FUN2 float32_nnz
#define NUMBER float
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 float64_nnz
#define NUMBER double
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 complex32_nnz
#define NUMBER complex_float
#define CHECKFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 complex64_nnz
#define NUMBER complex_double
#define CHECKFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 int8_nnz
#define NUMBER int8_t
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 uint8_nnz
#define NUMBER uint8_t
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 int16_nnz
#define NUMBER int16_t
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 uint16_nnz
#define NUMBER uint16_t
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 int32_nnz
#define NUMBER int32_t
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 int64_nnz
#define NUMBER int64_t
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

// min_i

#define FUN6 float32_min_i
#define NUMBER float
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 float64_min_i
#define NUMBER double
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex32_min_i
#define NUMBER _Complex float
#define CHECKFN(X,Y) CGTF(X,Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex64_min_i
#define NUMBER _Complex double
#define CHECKFN(X,Y) CGT(X,Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int8_min_i
#define NUMBER int8_t
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 uint8_min_i
#define NUMBER uint8_t
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int16_min_i
#define NUMBER int16_t
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 uint16_min_i
#define NUMBER uint16_t
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int32_min_i
#define NUMBER int32_t
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int64_min_i
#define NUMBER int64_t
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

// min_along

#define FUN26 float32_min_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y = fminf(*X,*Y)
#include "owl_dense_common_vec_fold.c"

#define FUN26 float64_min_along
#define NUMBER double
#define NUMBER1 double
#define ACCFN(X,Y) *Y = fmin(*X,*Y)
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex32_min_along
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define ACCFN(X,Y) *Y = CLTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex64_min_along
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define ACCFN(X,Y) *Y = CLT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int8_min_along
#define NUMBER int8_t
#define NUMBER1 int8_t
#define ACCFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint8_min_along
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define ACCFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int16_min_along
#define NUMBER int16_t
#define NUMBER1 int16_t
#define ACCFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint16_min_along
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define ACCFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int32_min_along
#define NUMBER int32_t
#define NUMBER1 int32_t
#define ACCFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int64_min_along
#define NUMBER int64_t
#define NUMBER1 int64_t
#define ACCFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

// max_i

#define FUN6 float32_max_i
#define NUMBER float
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 float64_max_i
#define NUMBER double
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex32_max_i
#define NUMBER _Complex float
#define CHECKFN(X,Y) CLTF(X,Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex64_max_i
#define NUMBER _Complex double
#define CHECKFN(X,Y) CLT(X,Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int8_max_i
#define NUMBER int8_t
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 uint8_max_i
#define NUMBER uint8_t
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int16_max_i
#define NUMBER int16_t
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 uint16_max_i
#define NUMBER uint16_t
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int32_max_i
#define NUMBER int32_t
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 int64_max_i
#define NUMBER int64_t
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

// max_along

#define FUN26 float32_max_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y = fmaxf(*X,*Y)
#include "owl_dense_common_vec_fold.c"

#define FUN26 float64_max_along
#define NUMBER double
#define NUMBER1 double
#define ACCFN(X,Y) *Y = fmax(*X,*Y)
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex32_max_along
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define ACCFN(X,Y) *Y = CGTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex64_max_along
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define ACCFN(X,Y) *Y = CGT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int8_max_along
#define NUMBER int8_t
#define NUMBER1 int8_t
#define ACCFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint8_max_along
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define ACCFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int16_max_along
#define NUMBER int16_t
#define NUMBER1 int16_t
#define ACCFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint16_max_along
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define ACCFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int32_max_along
#define NUMBER int32_t
#define NUMBER1 int32_t
#define ACCFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

#define FUN26 int64_max_along
#define NUMBER int64_t
#define NUMBER1 int64_t
#define ACCFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_fold.c"

// minmax_i
// TODO
//#define FUN23 float32_minmax_i
//#define NUMBER float
//#define INIT
//#define BFCHKFN
//#define CHECKFN(X,Y) X < Y
//#define AFCHKFN
//#include "owl_dense_common_vec_fold.c"


// l1norm

#define FUN5 float32_l1norm
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += fabsf(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 float64_l1norm
#define INIT double r = 0.
#define NUMBER double
#define ACCFN(A,X) (A += fabs(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex32_l1norm
#define INIT float r = 0.
#define NUMBER _Complex float
#define ACCFN(A,X) (A += cabsf(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex64_l1norm
#define INIT double r = 0.
#define NUMBER _Complex double
#define ACCFN(A,X) (A += cabs(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

// l1norm_along

#define FUN26 float32_l1norm_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y += fabsf(*X)
#include "owl_dense_common_vec_fold.c"

#define FUN26 float64_l1norm_along
#define NUMBER double
#define NUMBER1 double
#define ACCFN(X,Y) *Y += fabs(*X)
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex32_l1norm_along
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define ACCFN(X,Y) *Y += cabsf(*X)
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex64_l1norm_along
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define ACCFN(X,Y) *Y += cabs(*X)
#include "owl_dense_common_vec_fold.c"

// l2norm_sqr

#define FUN5 float32_l2norm_sqr
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += X * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 float64_l2norm_sqr
#define INIT double r = 0.
#define NUMBER double
#define ACCFN(A,X) (A += X * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex32_l2norm_sqr
#define INIT float r = 0.
#define NUMBER complex_float
#define ACCFN(A,X) (A += X.r * X.r + X.i * X.i)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex64_l2norm_sqr
#define INIT double r = 0.
#define NUMBER complex_double
#define ACCFN(A,X) (A += X.r * X.r + X.i * X.i)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

// l2norm_sqr_along

#define FUN26 float32_l2norm_sqr_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y += *X * *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 float64_l2norm_sqr_along
#define NUMBER double
#define NUMBER1 double
#define ACCFN(X,Y) *Y += *X * *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex32_l2norm_sqr_along
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define ACCFN(X,Y) *Y += *X * conjf(*X)
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex64_l2norm_sqr_along
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define ACCFN(X,Y) *Y += *X * conj(*X)
#include "owl_dense_common_vec_fold.c"

// sum

#define FUN5 float32_sum
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 float64_sum
#define INIT double r = 0.
#define NUMBER double
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex32_sum
#define INIT complex_float r = { 0.0, 0.0 }
#define NUMBER complex_float
#define ACCFN(A,X) A.r += X.r; A.i += X.i
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex64_sum
#define INIT complex_double r = { 0.0, 0.0 }
#define NUMBER complex_double
#define ACCFN(A,X) A.r += X.r; A.i += X.i
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int8_sum
#define INIT int r = 0
#define NUMBER int8_t
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 uint8_sum
#define INIT int r = 0
#define NUMBER uint8_t
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int16_sum
#define INIT int r = 0
#define NUMBER int16_t
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 uint16_sum
#define INIT int r = 0
#define NUMBER uint16_t
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int32_sum
#define INIT int r = 0
#define NUMBER int32_t
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_int32(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int64_sum
#define INIT int r = 0
#define NUMBER int64_t
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_int64(r))
#include "owl_dense_common_vec_fold.c"

// sum_along

#define FUN26 float32_sum_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 float64_sum_along
#define NUMBER double
#define NUMBER1 double
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex32_sum_along
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex64_sum_along
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int8_sum_along
#define NUMBER int8_t
#define NUMBER1 int8_t
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint8_sum_along
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int16_sum_along
#define NUMBER int16_t
#define NUMBER1 int16_t
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint16_sum_along
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int32_sum_along
#define NUMBER int32_t
#define NUMBER1 int32_t
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int64_sum_along
#define NUMBER int64_t
#define NUMBER1 int64_t
#define ACCFN(X,Y) *Y += *X
#include "owl_dense_common_vec_fold.c"

// prod

#define FUN5 float32_prod
#define INIT float r = 1.
#define NUMBER float
#define ACCFN(A,X) (A = A * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 float64_prod
#define INIT double r = 1.
#define NUMBER double
#define ACCFN(A,X) (A = A * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex32_prod
#define INIT complex_float r = { 1.0, 0.0 }
#define NUMBER complex_float
#define ACCFN(A,X) A.r = A.r * X.r - A.i * X.i; A.i = A.r * X.i + A.i * X.r
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex64_prod
#define INIT complex_double r = { 1.0, 0.0 }
#define NUMBER complex_double
#define ACCFN(A,X) A.r = A.r * X.r - A.i * X.i; A.i = A.r * X.i + A.i * X.r
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int8_prod
#define INIT int r = 0
#define NUMBER int8_t
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 uint8_prod
#define INIT int r = 0
#define NUMBER uint8_t
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int16_prod
#define INIT int r = 0
#define NUMBER int16_t
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 uint16_prod
#define INIT int r = 0
#define NUMBER uint16_t
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (Val_int(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int32_prod
#define INIT int r = 0
#define NUMBER int32_t
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (caml_copy_int32(r))
#include "owl_dense_common_vec_fold.c"

#define FUN5 int64_prod
#define INIT int r = 0
#define NUMBER int64_t
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (caml_copy_int64(r))
#include "owl_dense_common_vec_fold.c"

// prod_along

#define FUN26 float32_prod_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 float64_prod_along
#define NUMBER double
#define NUMBER1 double
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex32_prod_along
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 complex64_prod_along
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int8_prod_along
#define NUMBER int8_t
#define NUMBER1 int8_t
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint8_prod_along
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int16_prod_along
#define NUMBER int16_t
#define NUMBER1 int16_t
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 uint16_prod_along
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int32_prod_along
#define NUMBER int32_t
#define NUMBER1 int32_t
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

#define FUN26 int64_prod_along
#define NUMBER int64_t
#define NUMBER1 int64_t
#define ACCFN(X,Y) *Y *= *X
#include "owl_dense_common_vec_fold.c"

// neg

#define FUN19 float32_neg
#define FUN19_IMPL float32_neg_impl
#define NUMBER float
#define NUMBER1 float
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 float64_neg
#define FUN19_IMPL float64_neg_impl
#define NUMBER double
#define NUMBER1 double
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 complex32_neg
#define FUN19_IMPL complex32_neg_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define INIT
#define MAPFN(X,Y) Y->r = -(X->r); Y->i = -(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN19 complex64_neg
#define FUN19_IMPL complex64_neg_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define INIT
#define MAPFN(X,Y) Y->r = -(X->r); Y->i = -(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN19 int8_neg
#define FUN19_IMPL int8_neg_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 uint8_neg
#define FUN19_IMPL uint8_neg_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 int16_neg
#define FUN19_IMPL int16_neg_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 uint16_neg
#define FUN19_IMPL uint16_neg_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 int32_neg
#define FUN19_IMPL int32_neg_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 int64_neg
#define FUN19_IMPL int64_neg_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

// reci

#define FUN4 float32_reci
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_reci
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_reci
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_reci
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

// reci_tol

#define FUN17 float32_reci_tol
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (fabsf(*X) < a ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_reci_tol
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (fabs(*X) < a ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_reci_tol
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = (CLTF(*X,a) ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_reci_tol
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = (CLT(*X,a) ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

// abs

#define FUN4 float32_abs
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fabsf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_abs
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fabs(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_abs
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (sqrtf (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_abs
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_map.c"

// abs2

#define FUN4 float32_abs2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_abs2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_abs2
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (X.r * X.r + X.i * X.i)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_abs2
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (X.r * X.r + X.i * X.i)
#include "owl_dense_common_vec_map.c"

// signum

#define FUN4 float32_signum
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) ((X > 0.0) ? 1.0 : (X < 0.0) ? -1.0 : X)
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_signum
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) ((X > 0.0) ? 1.0 : (X < 0.0) ? -1.0 : X)
#include "owl_dense_common_vec_map.c"

// sqr

#define FUN4 float32_sqr
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_sqr
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_sqr
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_sqr
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

// sqrt

#define FUN4 float32_sqrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sqrtf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_sqrt
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sqrt(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_sqrt
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (csqrtf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_sqrt
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (csqrt(X))
#include "owl_dense_common_vec_map.c"

// cbrt

#define FUN4 float32_cbrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cbrtf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_cbrt
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cbrt(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_cbrt
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT float _a = 1. / 3.
#define MAPFN(X) (cpowf(X,_a))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_cbrt
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT double _a = 1. / 3.
#define MAPFN(X) (cpow(X,_a))
#include "owl_dense_common_vec_map.c"

// exp

#define FUN4 float32_exp
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_exp
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_exp
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cexpf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_exp
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cexp(X))
#include "owl_dense_common_vec_map.c"

// exp2

#define FUN4 float32_exp2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (exp2f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_exp2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp2(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_exp2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cpowf(2.,X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_exp2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cpow(2.,X))
#include "owl_dense_common_vec_map.c"

// exp10

#define FUN4 float32_exp10
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (exp10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_exp10
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_exp10
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cpowf(10.,X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_exp10
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cpow(10.,X))
#include "owl_dense_common_vec_map.c"

// expm1

#define FUN4 float32_expm1
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expm1f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_expm1
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (expm1(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_expm1
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cexpf(X) - 1)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_expm1
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cexp(X) - 1)
#include "owl_dense_common_vec_map.c"

// log

#define FUN4 float32_log
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (logf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_log
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_log
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (clogf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_log
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (clog(X))
#include "owl_dense_common_vec_map.c"

// log10

#define FUN4 float32_log10
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log10f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_log10
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_log10
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT float _log10 = logf(10)
#define MAPFN(X) (clogf(X) / _log10)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_log10
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT double _log10 = log(10)
#define MAPFN(X) (clog(X) / _log10)
#include "owl_dense_common_vec_map.c"

// log2

#define FUN4 float32_log2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log2f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_log2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log2(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_log2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT float _log2 = logf(2)
#define MAPFN(X) (clogf(X) / _log2)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_log2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT double _log2 = log(2)
#define MAPFN(X) (clog(X) / _log2)
#include "owl_dense_common_vec_map.c"

// log1p

#define FUN4 float32_log1p
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_log1p
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log1p(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_log1p
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (clogf(X + 1))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_log1p
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (clog(X + 1))
#include "owl_dense_common_vec_map.c"

// sin

#define FUN4 float32_sin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_sin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sin(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_sin
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (csinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_sin
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (csin(X))
#include "owl_dense_common_vec_map.c"

// cos

#define FUN4 float32_cos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_cos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cos(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_cos
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ccosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_cos
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ccos(X))
#include "owl_dense_common_vec_map.c"

// tan

#define FUN4 float32_tan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_tan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tan(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_tan
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ctanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_tan
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ctan(X))
#include "owl_dense_common_vec_map.c"

// asin

#define FUN4 float32_asin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_asin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asin(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_asin
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (casinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_asin
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (casin(X))
#include "owl_dense_common_vec_map.c"

// acos

#define FUN4 float32_acos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_acos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acos(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_acos
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cacosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_acos
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cacos(X))
#include "owl_dense_common_vec_map.c"

// atan

#define FUN4 float32_atan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_atan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atan(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_atan
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (catanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_atan
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (catan(X))
#include "owl_dense_common_vec_map.c"

// sinh

#define FUN4 float32_sinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_sinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sinh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_sinh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (csinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_sinh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (csinh(X))
#include "owl_dense_common_vec_map.c"

// cosh

#define FUN4 float32_cosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (coshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_cosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cosh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_cosh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ccoshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_cosh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ccosh(X))
#include "owl_dense_common_vec_map.c"

// tanh

#define FUN4 float32_tanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_tanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tanh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_tanh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ctanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_tanh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ctanh(X))
#include "owl_dense_common_vec_map.c"

// asinh

#define FUN4 float32_asinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_asinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asinh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_asinh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (casinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_asinh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (casinh(X))
#include "owl_dense_common_vec_map.c"

// acosh

#define FUN4 float32_acosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acoshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_acosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acosh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_acosh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cacoshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_acosh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cacosh(X))
#include "owl_dense_common_vec_map.c"

// atanh

#define FUN4 float32_atanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_atanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atanh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex32_atanh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (catanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_atanh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (catanh(X))
#include "owl_dense_common_vec_map.c"

// floor

#define FUN14 float32_floor
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = floorf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 float64_floor
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = floor(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex32_floor
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = floorf(X->r); Y->i = floorf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex64_floor
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = floor(X->r); Y->i = floor(X->i)
#include "owl_dense_common_vec_map.c"

// ceil

#define FUN14 float32_ceil
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = ceilf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 float64_ceil
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = ceil(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex32_ceil
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = ceilf(X->r); Y->i = ceilf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex64_ceil
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = ceil(X->r); Y->i = ceil(X->i)
#include "owl_dense_common_vec_map.c"

// round

#define FUN14 float32_round
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = roundf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 float64_round
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = round(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex32_round
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = roundf(X->r); Y->i = roundf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex64_round
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = round(X->r); Y->i = round(X->i)
#include "owl_dense_common_vec_map.c"

// trunc

#define FUN14 float32_trunc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = truncf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 float64_trunc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = trunc(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex32_trunc
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = truncf(X->r); Y->i = truncf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex64_trunc
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = trunc(X->r); Y->i = trunc(X->i)
#include "owl_dense_common_vec_map.c"

// fix

#define FUN14 float32_fix
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X < 0. ? ceilf(*X) : floorf(*X))
#include "owl_dense_common_vec_map.c"

#define FUN14 float64_fix
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X < 0. ? ceil(*X) : floor(*X))
#include "owl_dense_common_vec_map.c"

#define FUN14 complex32_fix
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = X->r < 0. ? ceilf(X->r) : floorf(X->r); Y->i = X->i < 0. ? ceilf(X->i) : floorf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex64_fix
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = X->r < 0. ? ceil(X->r) : floor(X->r); Y->i = X->i < 0. ? ceil(X->i) : floor(X->i)
#include "owl_dense_common_vec_map.c"

// erf

#define FUN4 float32_erf
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erff(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_erf
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (erf(X))
#include "owl_dense_common_vec_map.c"

// erfc

#define FUN4 float32_erfc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erfcf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_erfc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (erfc(X))
#include "owl_dense_common_vec_map.c"

// logistic

#define FUN4 float32_logistic
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_logistic
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1 / (1 + exp(-X)))
#include "owl_dense_common_vec_map.c"

// elu

#define FUN17 float32_elu
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (a * (expf(*X) - 1.)))
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_elu
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (a * (exp(*X) - 1.)))
#include "owl_dense_common_vec_map.c"

// relu

#define FUN4 float32_relu
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fmaxf(X,0))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_relu
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fmax(X,0))
#include "owl_dense_common_vec_map.c"

// leaky_relu

#define FUN17 float32_leaky_relu
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (*X * a))
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_leaky_relu
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (*X * a))
#include "owl_dense_common_vec_map.c"

// softplus

#define FUN4 float32_softplus
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(expf(X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_softplus
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log1p(exp(X)))
#include "owl_dense_common_vec_map.c"

// softsign

#define FUN4 float32_softsign
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X / (1 + fabsf(X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_softsign
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X / (1 + fabs(X)))
#include "owl_dense_common_vec_map.c"

// sigmoid

#define FUN4 float32_sigmoid
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 float64_sigmoid
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1 / (1 + exp(-X)))
#include "owl_dense_common_vec_map.c"

// log_sum_exp

#define FUN8 float32_log_sum_exp
#define NUMBER float
#define NUMBER1 float
#include "owl_dense_common_vec_fold.c"

#define FUN8 float64_log_sum_exp
#define NUMBER double
#define NUMBER1 double
#include "owl_dense_common_vec_fold.c"


////// binary math operator //////

// add

#define FUN15 float32_add
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_add
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_add
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_add
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_add
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_add
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_add
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_add
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_add
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_add
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

// sub

#define FUN15 float32_sub
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_sub
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_sub
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_sub
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_sub
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_sub
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_sub
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_sub
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_sub
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_sub
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

// mul

#define FUN15 float32_mul
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_mul
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_mul
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_mul
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_mul
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_mul
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_mul
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_mul
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_mul
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_mul
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

// div

#define FUN15 float32_div
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_div
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_div
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_div
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_div
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_div
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_div
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_div
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_div
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_div
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

// add_scalar

#define FUN17 float32_add_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_add_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_add_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_add_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_add_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_add_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_add_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_add_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_add_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_add_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = *X + a
#include "owl_dense_common_vec_map.c"

// mul_scalar

#define FUN17 float32_mul_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_mul_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_mul_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_mul_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_mul_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_mul_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_mul_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_mul_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_mul_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_mul_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = *X * a
#include "owl_dense_common_vec_map.c"

// div_scalar

#define FUN17 float32_div_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_div_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_div_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_div_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_div_scalar
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_div_scalar
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_div_scalar
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_div_scalar
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_div_scalar
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_div_scalar
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = *X / a
#include "owl_dense_common_vec_map.c"

// scalar_sub

#define FUN17 float32_scalar_sub
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_scalar_sub
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_scalar_sub
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_scalar_sub
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_scalar_sub
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_scalar_sub
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_scalar_sub
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_scalar_sub
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_scalar_sub
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_scalar_sub
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = a - *X
#include "owl_dense_common_vec_map.c"

// scalar_div

#define FUN17 float32_scalar_div
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_scalar_div
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_scalar_div
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_scalar_div
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int8_scalar_div
#define INIT int8_t a = Int_val(vA)
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 uint8_scalar_div
#define INIT uint8_t a = Int_val(vA)
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int16_scalar_div
#define INIT int16_t a = Int_val(vA)
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 uint16_scalar_div
#define INIT uint16_t a = Int_val(vA)
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int32_scalar_div
#define INIT int32_t a = Int32_val(vA)
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

#define FUN17 int64_scalar_div
#define INIT int64_t a = Int64_val(vA)
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = a / *X
#include "owl_dense_common_vec_map.c"

// scalar_pow

#define FUN17 float32_scalar_pow
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = powf(a,*X)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_scalar_pow
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = pow(a,*X)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_scalar_pow
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = cpowf(a,*X)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_scalar_pow
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = cpow(a,*X)
#include "owl_dense_common_vec_map.c"

// pow_scalar

#define FUN17 float32_pow_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = powf(*X,a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_pow_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = pow(*X,a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_pow_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = cpowf(*X,a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_pow_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = cpow(*X,a)
#include "owl_dense_common_vec_map.c"

// scalar_atan2

#define FUN17 float32_scalar_atan2
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = atan2f(a,*X)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_scalar_atan2
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = atan2(a,*X)
#include "owl_dense_common_vec_map.c"

// atan2_scalar

#define FUN17 float32_atan2_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = atan2f(*X,a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_atan2_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = atan2(*X,a)
#include "owl_dense_common_vec_map.c"

// pow

#define FUN15 float32_pow
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = powf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_pow
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = pow(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_pow
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = cpowf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_pow
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = cpow(*X,*Y)
#include "owl_dense_common_vec_map.c"

// atan2

#define FUN15 float32_atan2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = atan2f(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_atan2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = atan2(*X,*Y)
#include "owl_dense_common_vec_map.c"

// hypot

#define FUN15 float32_hypot
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = hypotf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_hypot
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = hypot(*X,*Y)
#include "owl_dense_common_vec_map.c"

// min2

#define FUN15 float32_min2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fminf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_min2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = fmin(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_min2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CLTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_min2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CLT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_min2
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_min2
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_min2
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_min2
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_min2
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_min2
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// max2

#define FUN15 float32_max2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fmaxf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_max2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = fmax(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_max2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CGTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_max2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CGT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int8_max2
#define NUMBER int8_t
#define NUMBER1 int8_t
#define NUMBER2 int8_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint8_max2
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define NUMBER2 uint8_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int16_max2
#define NUMBER int16_t
#define NUMBER1 int16_t
#define NUMBER2 int16_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 uint16_max2
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define NUMBER2 uint16_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int32_max2
#define NUMBER int32_t
#define NUMBER1 int32_t
#define NUMBER2 int32_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 int64_max2
#define NUMBER int64_t
#define NUMBER1 int64_t
#define NUMBER2 int64_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// fmod

#define FUN15 float32_fmod
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fmodf(*X, *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_fmod
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = fmod(*X, *Y)
#include "owl_dense_common_vec_map.c"

// fmod_scalar

#define FUN17 float32_fmod_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmodf(*X,a)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_fmod_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmod(*X,a)
#include "owl_dense_common_vec_map.c"

// scalar_fmod

#define FUN17 float32_scalar_fmod
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmodf(a,*X)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_scalar_fmod
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmod(a,*X)
#include "owl_dense_common_vec_map.c"

// ssqr

#define FUN9 float32_ssqr
#define INIT float r = 0.; float c = Double_val(vC); float diff
#define NUMBER float
#define ACCFN(A,X) diff = X - c; A += diff * diff
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN9 float64_ssqr
#define INIT double r = 0.; double c = Double_val(vC); double diff
#define NUMBER double
#define ACCFN(A,X) diff = X - c; A += diff * diff
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN9 complex32_ssqr
#define INIT complex_float r = { 0.0, 0.0 }; float cr = Double_field(vC, 0); float ci = Double_field(vC, 1); float diffr; float diffi
#define NUMBER complex_float
#define ACCFN(A,X) diffr = X.r - cr; diffi = X.i - ci; A.r += diffr * diffr - diffi * diffi; A.i += 2 * diffr * diffi
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN9 complex64_ssqr
#define INIT complex_double r = { 0.0, 0.0 }; double cr = Double_field(vC, 0); double ci = Double_field(vC, 1); double diffr; double diffi
#define NUMBER complex_double
#define ACCFN(A,X) diffr = X.r - cr; diffi = X.i - ci; A.r += diffr * diffr - diffi * diffi; A.i += 2 * diffr * diffi
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

// ssqr_diff

#define FUN11 float32_ssqr_diff
#define INIT float r = 0.
#define NUMBER float
#define NUMBER1 float
#define ACCFN(A,X,Y) X -= Y; X *= X; A += X
#define COPYNUM(A) (caml_copy_double(A))
#include "owl_dense_common_vec_fold.c"

#define FUN11 float64_ssqr_diff
#define INIT double r = 0.
#define NUMBER double
#define NUMBER1 double
#define ACCFN(A,X,Y) X -= Y; X *= X; A += X
#define COPYNUM(A) (caml_copy_double(A))
#include "owl_dense_common_vec_fold.c"

#define FUN11 complex32_ssqr_diff
#define INIT complex_float r = { 0.0, 0.0 }
#define NUMBER complex_float
#define NUMBER1 complex_float
#define ACCFN(A,X,Y) X.r -= Y.r; X.i -= Y.i; A.r += (X.r - X.i) * (X.r + X.i); A.i += 2 * A.r * A.i
#define COPYNUM(A) (cp_two_doubles(A.r, A.i))
#include "owl_dense_common_vec_fold.c"

#define FUN11 complex64_ssqr_diff
#define INIT complex_double r = { 0.0, 0.0 }
#define NUMBER complex_double
#define NUMBER1 complex_double
#define ACCFN(A,X,Y) X.r -= Y.r; X.i -= Y.i; A.r += (X.r - X.i) * (X.r + X.i); A.i += 2 * A.r * A.i
#define COPYNUM(A) (cp_two_doubles(A.r, A.i))
#include "owl_dense_common_vec_fold.c"

// linspace

#define FUN12 float32_linspace
#define INIT float a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), x = a
#define NUMBER float
#define MAPFN(X) X = x; x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN12 float64_linspace
#define INIT double a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), x = a
#define NUMBER double
#define MAPFN(X) X = x; x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN12 complex32_linspace
#define INIT float ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, xr = ar, xi = ai
#define NUMBER complex_float
#define MAPFN(X) (X).r = xr; (X).i = xi; xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

#define FUN12 complex64_linspace
#define INIT double ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, xr = ar, xi = ai
#define NUMBER complex_double
#define MAPFN(X) (X).r = xr; (X).i = xi; xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

// logspace

#define FUN13 float32_logspace
#define INIT float a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), base = Double_val(vBase), x = a, log_base = log(base)
#define NUMBER float
#define MAPFN(X)  *X = exp2f(x); x = a + i * h
#define MAPFN1(X) *X = exp10f(x); x = a + i * h
#define MAPFN2(X) *X = expf(x); x = a + i * h
#define MAPFN3(X) *X = expf(x * log_base); x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN13 float64_logspace
#define INIT double a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), base = Double_val(vBase), x = a, log_base = log(base)
#define NUMBER double
#define MAPFN(X)  *X = exp2(x); x = a + i * h
#define MAPFN1(X) *X = exp10(x); x = a + i * h
#define MAPFN2(X) *X = exp(x); x = a + i * h
#define MAPFN3(X) *X = exp(x * log_base); x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN13 complex32_logspace
#define INIT float ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, base = Double_val(vBase), xr = ar, xi = ai, log_base = log(base)
#define NUMBER complex_float
#define MAPFN(X)  X->r = exp2f(xr); X->i = exp2f(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN1(X) X->r = exp10f(xr); X->i = exp10f(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN2(X) X->r = expf(xr); X->i = expf(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN3(X) X->r = expf(xr * log_base); X->i = expf(xi * log_base); xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

#define FUN13 complex64_logspace
#define INIT double ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, base = Double_val(vBase), xr = ar, xi = ai, log_base = log(base)
#define NUMBER complex_double
#define MAPFN(X)  X->r = exp2(xr); X->i = exp2(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN1(X) X->r = exp10(xr); X->i = exp10(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN2(X) X->r = exp(xr); X->i = exp(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN3(X) X->r = exp(xr * log_base); X->i = exp(xi * log_base); xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

// re

#define FUN14 re_c2s
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = X->r
#include "owl_dense_common_vec_map.c"

#define FUN14 re_z2d
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = X->r
#include "owl_dense_common_vec_map.c"

// im

#define FUN14 im_c2s
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = X->i
#include "owl_dense_common_vec_map.c"

#define FUN14 im_z2d
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = X->i
#include "owl_dense_common_vec_map.c"

// conj

#define FUN19 complex32_conj
#define FUN19_IMPL complex32_conj_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define INIT
#define MAPFN(X,Y) Y->r = X->r; Y->i = -X->i
#include "owl_dense_common_vec_map.c"

#define FUN19 complex64_conj
#define FUN19_IMPL complex64_conj_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define INIT
#define MAPFN(X,Y) Y->r = X->r; Y->i = -X->i
#include "owl_dense_common_vec_map.c"

// cast functions

#define FUN14 cast_s2d
#define NUMBER float
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (double) (*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_d2s
#define NUMBER double
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (float) (*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_c2z
#define NUMBER complex_float
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (double) X->r; Y->i = (double) X->i
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_z2c
#define NUMBER complex_double
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (float) X->r; Y->i = (float) X->i
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_s2c
#define NUMBER float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = *X; Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_d2z
#define NUMBER double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = *X; Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_s2z
#define NUMBER float
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (double) *X; Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN14 cast_d2c
#define NUMBER double
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (float) *X; Y->i = 0.
#include "owl_dense_common_vec_map.c"

// bernoulli

#define FUN18 float32_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER float
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 float64_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER double
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 complex32_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER complex_float
#define MAPFN(X) X->r = (rand() < a); X->i = 0
#include "owl_dense_common_vec_map.c"

#define FUN18 complex64_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER complex_double
#define MAPFN(X) X->r = (rand() < a); X->i = 0
#include "owl_dense_common_vec_map.c"

#define FUN18 int8_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER int8_t
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 uint8_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER uint8_t
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 int16_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER int16_t
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 uint16_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER uint16_t
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 int32_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER int32_t
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 int64_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER int64_t
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

// sequential

#define FUN18 float32_sequential
#define INIT float a = Double_val(vA); float b = Double_val(vB)
#define NUMBER float
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 float64_sequential
#define INIT double a = Double_val(vA); double b = Double_val(vB)
#define NUMBER double
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 complex32_sequential
#define INIT float ar = Double_field(vA, 0), ai = Double_field(vA, 1); float br = Double_field(vB, 0), bi = Double_field(vB, 1)
#define NUMBER complex_float
#define MAPFN(X) X->r = ar; X->i = ai; ar += br; ai += bi
#include "owl_dense_common_vec_map.c"

#define FUN18 complex64_sequential
#define INIT double ar = Double_field(vA, 0), ai = Double_field(vA, 1); double br = Double_field(vB, 0), bi = Double_field(vB, 1)
#define NUMBER complex_double
#define MAPFN(X) X->r = ar; X->i = ai; ar += br; ai += bi
#include "owl_dense_common_vec_map.c"

#define FUN18 int8_sequential
#define INIT int8_t a = Int_val(vA); int8_t b = Int_val(vB)
#define NUMBER int8_t
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 uint8_sequential
#define INIT uint8_t a = Int_val(vA); uint8_t b = Int_val(vB)
#define NUMBER uint8_t
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 int16_sequential
#define INIT int16_t a = Int_val(vA); int16_t b = Int_val(vB)
#define NUMBER int16_t
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 uint16_sequential
#define INIT uint16_t a = Int_val(vA); uint16_t b = Int_val(vB)
#define NUMBER uint16_t
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 int32_sequential
#define INIT int32_t a = Int32_val(vA); int32_t b = Int32_val(vB)
#define NUMBER int32_t
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 int64_sequential
#define INIT int64_t a = Int64_val(vA); int64_t b = Int64_val(vB)
#define NUMBER int64_t
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

// cumsum

#define FUN20 float32_cumsum
#define FUN20_IMPL float32_cumsum_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 float64_cumsum
#define FUN20_IMPL float64_cumsum_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex32_cumsum
#define FUN20_IMPL complex32_cumsum_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = X->r + Y->r; Y->i = X->i + Y->i
#include "owl_dense_common_vec_map.c"

#define FUN20 complex64_cumsum
#define FUN20_IMPL complex64_cumsum_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = X->r + Y->r; Y->i = X->i + Y->i
#include "owl_dense_common_vec_map.c"

#define FUN20 int8_cumsum
#define FUN20_IMPL int8_cumsum_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint8_cumsum
#define FUN20_IMPL uint8_cumsum_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int16_cumsum
#define FUN20_IMPL int16_cumsum_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint16_cumsum
#define FUN20_IMPL uint16_cumsum_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int32_cumsum
#define FUN20_IMPL int32_cumsum_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int64_cumsum
#define FUN20_IMPL int64_cumsum_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

// cumprod

#define FUN20 float32_cumprod
#define FUN20_IMPL float32_cumprod_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 float64_cumprod
#define FUN20_IMPL float64_cumprod_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex32_cumprod
#define FUN20_IMPL complex32_cumprod_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (Y->r * X->r) - (Y->i * X->i); Y->i = (Y->r * X->i) + (Y->i * X->r)
#include "owl_dense_common_vec_map.c"

#define FUN20 complex64_cumprod
#define FUN20_IMPL complex64_cumprod_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (Y->r * X->r) - (Y->i * X->i); Y->i = (Y->r * X->i) + (Y->i * X->r)
#include "owl_dense_common_vec_map.c"

#define FUN20 int8_cumprod
#define FUN20_IMPL int8_cumprod_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint8_cumprod
#define FUN20_IMPL uint8_cumprod_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int16_cumprod
#define FUN20_IMPL int16_cumprod_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint16_cumprod
#define FUN20_IMPL uint16_cumprod_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int32_cumprod
#define FUN20_IMPL int32_cumprod_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int64_cumprod
#define FUN20_IMPL int64_cumprod_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

// cummin

#define FUN20 float32_cummin
#define FUN20_IMPL float32_cummin_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fminf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 float64_cummin
#define FUN20_IMPL float64_cummin_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmin(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 complex32_cummin
#define FUN20_IMPL complex32_cummin_impl
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CLTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex64_cummin
#define FUN20_IMPL complex64_cummin_impl
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CLT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int8_cummin
#define FUN20_IMPL int8_cummin_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint8_cummin
#define FUN20_IMPL uint8_cummin_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int16_cummin
#define FUN20_IMPL int16_cummin_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint16_cummin
#define FUN20_IMPL uint16_cummin_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int32_cummin
#define FUN20_IMPL int32_cummin_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int64_cummin
#define FUN20_IMPL int64_cummin_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// cummax

#define FUN20 float32_cummax
#define FUN20_IMPL float32_cummax_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmaxf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 float64_cummax
#define FUN20_IMPL float64_cummax_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmax(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 complex32_cummax
#define FUN20_IMPL complex32_cummax_impl
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CGTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex64_cummax
#define FUN20_IMPL complex64_cummax_impl
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CGT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int8_cummax
#define FUN20_IMPL int8_cummax_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint8_cummax
#define FUN20_IMPL uint8_cummax_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int16_cummax
#define FUN20_IMPL int16_cummax_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 uint16_cummax
#define FUN20_IMPL uint16_cummax_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int32_cummax
#define FUN20_IMPL int32_cummax_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 int64_cummax
#define FUN20_IMPL int64_cummax_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// modf

#define FUN17 float32_modf
#define NUMBER float
#define NUMBER1 float
#define INIT float a, b;
#define MAPFN(X,Y) a = modff(*X,&b); *X = a; *Y = b
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_modf
#define NUMBER double
#define NUMBER1 double
#define INIT double a, b;
#define MAPFN(X,Y) a = modf(*X,&b); *X = a; *Y = b
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_modf
#define NUMBER complex_float
#define NUMBER1 complex_float
#define INIT float a, b;
#define MAPFN(X,Y) a = modff(X->r,&b); X->r = a; Y->r = b; a = modff(X->i,&b); X->i = a; Y->i = b
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_modf
#define NUMBER complex_double
#define NUMBER1 complex_double
#define INIT double a, b;
#define MAPFN(X,Y) a = modf(X->r,&b); X->r = a; Y->r = b; a = modf(X->i,&b); X->i = a; Y->i = b
#include "owl_dense_common_vec_map.c"

// not_nan

#define FUN1 float32_not_nan
#define NUMBER float
#define STOPFN(X) fpclassify(X) == FP_NAN
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_not_nan
#define NUMBER double
#define STOPFN(X) fpclassify(X) == FP_NAN
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_not_nan
#define NUMBER complex_float
#define STOPFN(X) (fpclassify(X.r) == FP_NAN || fpclassify(X.i) == FP_NAN)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_not_nan
#define NUMBER complex_double
#define STOPFN(X) (fpclassify(X.r) == FP_NAN || fpclassify(X.i) == FP_NAN)
#include "owl_dense_common_vec_cmp.c"

// not_inf

#define FUN1 float32_not_inf
#define NUMBER float
#define STOPFN(X) fpclassify(X) == FP_INFINITE
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_not_inf
#define NUMBER double
#define STOPFN(X) fpclassify(X) == FP_INFINITE
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_not_inf
#define NUMBER complex_float
#define STOPFN(X) (fpclassify(X.r) == FP_INFINITE || fpclassify(X.i) == FP_INFINITE)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_not_inf
#define NUMBER complex_double
#define STOPFN(X) (fpclassify(X.r) == FP_INFINITE || fpclassify(X.i) == FP_INFINITE)
#include "owl_dense_common_vec_cmp.c"

// is_normal

#define FUN1 float32_is_normal
#define NUMBER float
#define STOPFN(X) fpclassify(X) != FP_NORMAL
#include "owl_dense_common_vec_cmp.c"

#define FUN1 float64_is_normal
#define NUMBER double
#define STOPFN(X) fpclassify(X) != FP_NORMAL
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex32_is_normal
#define NUMBER complex_float
#define STOPFN(X) (fpclassify(X.r) != FP_NORMAL || fpclassify(X.i) != FP_NORMAL)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex64_is_normal
#define NUMBER complex_double
#define STOPFN(X) (fpclassify(X.r) != FP_NORMAL || fpclassify(X.i) != FP_NORMAL)
#include "owl_dense_common_vec_cmp.c"

// approx_equal

#define FUN21 float32_approx_equal
#define NUMBER float
#define INIT float a = Double_val(vA)
#define STOPFN(X,Y) fabsf(X - Y) >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN21 float64_approx_equal
#define NUMBER double
#define INIT double a = Double_val(vA)
#define STOPFN(X,Y) fabs(X - Y) >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN21 complex32_approx_equal
#define NUMBER complex_float
#define INIT float a = Double_val(vA)
#define STOPFN(X,Y) fabsf(X.r - Y.r) >= a || fabsf(X.i - Y.i) >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN21 complex64_approx_equal
#define NUMBER complex_double
#define INIT double a = Double_val(vA)
#define STOPFN(X,Y) fabs(X.r - Y.r) >= a || fabs(X.i - Y.i) >= a
#include "owl_dense_common_vec_cmp.c"

// approx_equal_scalar

#define FUN22 float32_approx_equal_scalar
#define INIT float a = Double_val(vA); float b = Double_val(vB)
#define NUMBER float
#define STOPFN(X) fabsf(X - a) >= b
#include "owl_dense_common_vec_cmp.c"

#define FUN22 float64_approx_equal_scalar
#define INIT double a = Double_val(vA); double b = Double_val(vB)
#define NUMBER double
#define STOPFN(X) fabs(X - a) >= b
#include "owl_dense_common_vec_cmp.c"

#define FUN22 complex32_approx_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1); float b = Double_val(vB)
#define NUMBER complex_float
#define STOPFN(X) (fabsf(X.r - ar) >= b) || (fabsf(X.i - ai) >= b)
#include "owl_dense_common_vec_cmp.c"

#define FUN22 complex64_approx_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1); double b = Double_val(vB)
#define NUMBER complex_double
#define STOPFN(X) (fabs(X.r - ar) >= b) || (fabs(X.i - ai) >= b)
#include "owl_dense_common_vec_cmp.c"

// approx_elt_equal

#define FUN15 float32_approx_elt_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (fabsf(*X - *Y) < *Z)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_approx_elt_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (fabs(*X - *Y) < *Z)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_approx_elt_equal
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = ((fabsf(X->r - Y->r) < Z->r) && (fabsf(X->i - Y->i) < Z->r))
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_approx_elt_equal
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = ((fabs(X->r - Y->r) < Z->r) && (fabs(X->i - Y->i) < Z->r))
#include "owl_dense_common_vec_map.c"

// approx_elt_equal_scalar

#define FUN17 float32_approx_elt_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (fabsf(*X - a) < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN17 float64_approx_elt_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (fabs(*X - a) < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex32_approx_elt_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = ((fabsf(X->r - ar) < Y->r) && (fabsf(X->i - ai) < Y->r))
#include "owl_dense_common_vec_map.c"

#define FUN17 complex64_approx_elt_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = ((fabs(X->r - ar) < Y->r) && (fabs(X->i - ai) < Y->r))
#include "owl_dense_common_vec_map.c"

// to_complex

#define FUN15 float32_to_complex
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = *X; Z->i = *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_to_complex
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = *X; Z->i = *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex32_to_complex
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = X->r; Z->i = Y->i
#include "owl_dense_common_vec_map.c"

#define FUN15 complex64_to_complex
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = X->r; Z->i = Y->i
#include "owl_dense_common_vec_map.c"

// polar

#define FUN15 float32_polar
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = *X * cosf(*Y); Z->i = *X * sinf(*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 float64_polar
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = *X * cos(*Y); Z->i = *X * sin(*Y)
#include "owl_dense_common_vec_map.c"

// angle

#define FUN4 complex32_angle
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cargf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_angle
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (carg(X))
#include "owl_dense_common_vec_map.c"

// proj

#define FUN4 complex32_proj
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cprojf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex64_proj
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cproj(X))
#include "owl_dense_common_vec_map.c"

// clip_by_value

#define FUN12 float32_clip_by_value
#define INIT float a = Double_val(vA), b = Double_val(vB)
#define NUMBER float
#define MAPFN(X) X = X < a ? a : (X > b ? b : X)
#include "owl_dense_common_vec_map.c"

#define FUN12 float64_clip_by_value
#define INIT double a = Double_val(vA), b = Double_val(vB)
#define NUMBER double
#define MAPFN(X) X = X < a ? a : (X > b ? b : X)
#include "owl_dense_common_vec_map.c"

#define FUN12 complex32_clip_by_value
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I, b = Double_field(vB, 0) + Double_field(vB, 1)*I
#define NUMBER _Complex float
#define MAPFN(X) CLTF(X,a) ? a : (CGTF(X,b) ? b : X)
#include "owl_dense_common_vec_map.c"

#define FUN12 complex64_clip_by_value
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I, b = Double_field(vB, 0) + Double_field(vB, 1)*I
#define NUMBER _Complex double
#define MAPFN(X) CLT(X,a) ? a : (CGT(X,b) ? b : X)
#include "owl_dense_common_vec_map.c"

// sort

#define FUN3 float32_sort
#define NUMBER float
#define MAPFN(X) qsort(X,N,sizeof(float),float32_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 float64_sort
#define NUMBER float
#define MAPFN(X) qsort(X,N,sizeof(double),float64_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 complex32_sort
#define NUMBER _Complex float
#define MAPFN(X) qsort(X,N,sizeof(_Complex float),complex32_cmpf)
#include "owl_dense_common_vec_map.c"

#define FUN3 complex64_sort
#define NUMBER _Complex double
#define MAPFN(X) qsort(X,N,sizeof(_Complex double),complex64_cmpf)
#include "owl_dense_common_vec_map.c"

#define FUN3 int8_sort
#define NUMBER int8_t
#define MAPFN(X) qsort(X,N,sizeof(int8_t),int8_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 uint8_sort
#define NUMBER uint8_t
#define MAPFN(X) qsort(X,N,sizeof(uint8_t),uint8_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 int16_sort
#define NUMBER int16_t
#define MAPFN(X) qsort(X,N,sizeof(int16_t),int16_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 uint16_sort
#define NUMBER uint16_t
#define MAPFN(X) qsort(X,N,sizeof(uint16_t),uint16_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 int32_sort
#define NUMBER int32_t
#define MAPFN(X) qsort(X,N,sizeof(int32_t),int32_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 int64_sort
#define NUMBER int64_t
#define MAPFN(X) qsort(X,N,sizeof(int64_t),int64_cmp)
#include "owl_dense_common_vec_map.c"

// repeat

#define FUN20 float32_repeat
#define FUN20_IMPL float32_repeat_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 float64_repeat
#define FUN20_IMPL float64_repeat_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 complex32_repeat
#define FUN20_IMPL complex32_repeat_impl
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 complex64_repeat
#define FUN20_IMPL complex64_repeat_impl
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 int8_repeat
#define FUN20_IMPL int8_repeat_impl
#define NUMBER int8_t
#define NUMBER1 int8_t
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 uint8_repeat
#define FUN20_IMPL uint8_repeat_impl
#define NUMBER uint8_t
#define NUMBER1 uint8_t
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 int16_repeat
#define FUN20_IMPL int16_repeat_impl
#define NUMBER int16_t
#define NUMBER1 int16_t
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 uint16_repeat
#define FUN20_IMPL uint16_repeat_impl
#define NUMBER uint16_t
#define NUMBER1 uint16_t
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 int32_repeat
#define FUN20_IMPL int32_repeat_impl
#define NUMBER int32_t
#define NUMBER1 int32_t
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

#define FUN20 int64_repeat
#define FUN20_IMPL int64_repeat_impl
#define NUMBER int64_t
#define NUMBER1 int64_t
#define MAPFN(X,Y) *Y = *X
#include "owl_dense_common_vec_map.c"

// broadcast_add

#define FUN24 float32_broadcast_add
#define FUN24_IMPL float32_broadcast_add_impl
#define FUN24_CODE float32_broadcast_add_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_add
#define FUN24_IMPL float64_broadcast_add_impl
#define FUN24_CODE float64_broadcast_add_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_add
#define FUN24_IMPL complex32_broadcast_add_impl
#define FUN24_CODE complex32_broadcast_add_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_add
#define FUN24_IMPL complex64_broadcast_add_impl
#define FUN24_CODE complex64_broadcast_add_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int8_broadcast_add
#define FUN24_IMPL int8_broadcast_add_impl
#define FUN24_CODE int8_broadcast_add_code
#define NUMBER int8_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint8_broadcast_add
#define FUN24_IMPL uint8_broadcast_add_impl
#define FUN24_CODE uint8_broadcast_add_code
#define NUMBER uint8_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int16_broadcast_add
#define FUN24_IMPL int16_broadcast_add_impl
#define FUN24_CODE int16_broadcast_add_code
#define NUMBER int16_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint16_broadcast_add
#define FUN24_IMPL uint16_broadcast_add_impl
#define FUN24_CODE uint16_broadcast_add_code
#define NUMBER uint16_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int32_broadcast_add
#define FUN24_IMPL int32_broadcast_add_impl
#define FUN24_CODE int32_broadcast_add_code
#define NUMBER int32_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int64_broadcast_add
#define FUN24_IMPL int64_broadcast_add_impl
#define FUN24_CODE int64_broadcast_add_code
#define NUMBER int64_t
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_dense_common_vec_map.c"

// broadcast_sub

#define FUN24 float32_broadcast_sub
#define FUN24_IMPL float32_broadcast_sub_impl
#define FUN24_CODE float32_broadcast_sub_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_sub
#define FUN24_IMPL float64_broadcast_sub_impl
#define FUN24_CODE float64_broadcast_sub_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_sub
#define FUN24_IMPL complex32_broadcast_sub_impl
#define FUN24_CODE complex32_broadcast_sub_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_sub
#define FUN24_IMPL complex64_broadcast_sub_impl
#define FUN24_CODE complex64_broadcast_sub_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int8_broadcast_sub
#define FUN24_IMPL int8_broadcast_sub_impl
#define FUN24_CODE int8_broadcast_sub_code
#define NUMBER int8_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint8_broadcast_sub
#define FUN24_IMPL uint8_broadcast_sub_impl
#define FUN24_CODE uint8_broadcast_sub_code
#define NUMBER uint8_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int16_broadcast_sub
#define FUN24_IMPL int16_broadcast_sub_impl
#define FUN24_CODE int16_broadcast_sub_code
#define NUMBER int16_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint16_broadcast_sub
#define FUN24_IMPL uint16_broadcast_sub_impl
#define FUN24_CODE uint16_broadcast_sub_code
#define NUMBER uint16_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int32_broadcast_sub
#define FUN24_IMPL int32_broadcast_sub_impl
#define FUN24_CODE int32_broadcast_sub_code
#define NUMBER int32_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int64_broadcast_sub
#define FUN24_IMPL int64_broadcast_sub_impl
#define FUN24_CODE int64_broadcast_sub_code
#define NUMBER int64_t
#define MAPFN(X,Y,Z) *Z = *X - *Y
#include "owl_dense_common_vec_map.c"

// broadcast_mul

#define FUN24 float32_broadcast_mul
#define FUN24_IMPL float32_broadcast_mul_impl
#define FUN24_CODE float32_broadcast_mul_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_mul
#define FUN24_IMPL float64_broadcast_mul_impl
#define FUN24_CODE float64_broadcast_mul_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_mul
#define FUN24_IMPL complex32_broadcast_mul_impl
#define FUN24_CODE complex32_broadcast_mul_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_mul
#define FUN24_IMPL complex64_broadcast_mul_impl
#define FUN24_CODE complex64_broadcast_mul_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int8_broadcast_mul
#define FUN24_IMPL int8_broadcast_mul_impl
#define FUN24_CODE int8_broadcast_mul_code
#define NUMBER int8_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint8_broadcast_mul
#define FUN24_IMPL uint8_broadcast_mul_impl
#define FUN24_CODE uint8_broadcast_mul_code
#define NUMBER uint8_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int16_broadcast_mul
#define FUN24_IMPL int16_broadcast_mul_impl
#define FUN24_CODE int16_broadcast_mul_code
#define NUMBER int16_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint16_broadcast_mul
#define FUN24_IMPL uint16_broadcast_mul_impl
#define FUN24_CODE uint16_broadcast_mul_code
#define NUMBER uint16_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int32_broadcast_mul
#define FUN24_IMPL int32_broadcast_mul_impl
#define FUN24_CODE int32_broadcast_mul_code
#define NUMBER int32_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int64_broadcast_mul
#define FUN24_IMPL int64_broadcast_mul_impl
#define FUN24_CODE int64_broadcast_mul_code
#define NUMBER int64_t
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_dense_common_vec_map.c"

// broadcast_div

#define FUN24 float32_broadcast_div
#define FUN24_IMPL float32_broadcast_div_impl
#define FUN24_CODE float32_broadcast_div_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_div
#define FUN24_IMPL float64_broadcast_div_impl
#define FUN24_CODE float64_broadcast_div_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_div
#define FUN24_IMPL complex32_broadcast_div_impl
#define FUN24_CODE complex32_broadcast_div_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_div
#define FUN24_IMPL complex64_broadcast_div_impl
#define FUN24_CODE complex64_broadcast_div_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int8_broadcast_div
#define FUN24_IMPL int8_broadcast_div_impl
#define FUN24_CODE int8_broadcast_div_code
#define NUMBER int8_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint8_broadcast_div
#define FUN24_IMPL uint8_broadcast_div_impl
#define FUN24_CODE uint8_broadcast_div_code
#define NUMBER uint8_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int16_broadcast_div
#define FUN24_IMPL int16_broadcast_div_impl
#define FUN24_CODE int16_broadcast_div_code
#define NUMBER int16_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint16_broadcast_div
#define FUN24_IMPL uint16_broadcast_div_impl
#define FUN24_CODE uint16_broadcast_div_code
#define NUMBER uint16_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int32_broadcast_div
#define FUN24_IMPL int32_broadcast_div_impl
#define FUN24_CODE int32_broadcast_div_code
#define NUMBER int32_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int64_broadcast_div
#define FUN24_IMPL int64_broadcast_div_impl
#define FUN24_CODE int64_broadcast_div_code
#define NUMBER int64_t
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_dense_common_vec_map.c"

// broadcast_min2

#define FUN24 float32_broadcast_min2
#define FUN24_IMPL float32_broadcast_min2_impl
#define FUN24_CODE float32_broadcast_min2_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = fminf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_min2
#define FUN24_IMPL float64_broadcast_min2_impl
#define FUN24_CODE float64_broadcast_min2_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = fmin(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_min2
#define FUN24_IMPL complex32_broadcast_min2_impl
#define FUN24_CODE complex32_broadcast_min2_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = CLTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_min2
#define FUN24_IMPL complex64_broadcast_min2_impl
#define FUN24_CODE complex64_broadcast_min2_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = CLT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int8_broadcast_min2
#define FUN24_IMPL int8_broadcast_min2_impl
#define FUN24_CODE int8_broadcast_min2_code
#define NUMBER int8_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint8_broadcast_min2
#define FUN24_IMPL uint8_broadcast_min2_impl
#define FUN24_CODE uint8_broadcast_min2_code
#define NUMBER uint8_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int16_broadcast_min2
#define FUN24_IMPL int16_broadcast_min2_impl
#define FUN24_CODE int16_broadcast_min2_code
#define NUMBER int16_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint16_broadcast_min2
#define FUN24_IMPL uint16_broadcast_min2_impl
#define FUN24_CODE uint16_broadcast_min2_code
#define NUMBER uint16_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int32_broadcast_min2
#define FUN24_IMPL int32_broadcast_min2_impl
#define FUN24_CODE int32_broadcast_min2_code
#define NUMBER int32_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int64_broadcast_min2
#define FUN24_IMPL int64_broadcast_min2_impl
#define FUN24_CODE int64_broadcast_min2_code
#define NUMBER int64_t
#define MAPFN(X,Y,Z) *Z = (*X < *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// broadcast_max2

#define FUN24 float32_broadcast_max2
#define FUN24_IMPL float32_broadcast_max2_impl
#define FUN24_CODE float32_broadcast_max2_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = fmaxf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_max2
#define FUN24_IMPL float64_broadcast_max2_impl
#define FUN24_CODE float64_broadcast_max2_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = fmax(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_max2
#define FUN24_IMPL complex32_broadcast_max2_impl
#define FUN24_CODE complex32_broadcast_max2_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = CGTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_max2
#define FUN24_IMPL complex64_broadcast_max2_impl
#define FUN24_CODE complex64_broadcast_max2_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = CGT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int8_broadcast_max2
#define FUN24_IMPL int8_broadcast_max2_impl
#define FUN24_CODE int8_broadcast_max2_code
#define NUMBER int8_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint8_broadcast_max2
#define FUN24_IMPL uint8_broadcast_max2_impl
#define FUN24_CODE uint8_broadcast_max2_code
#define NUMBER uint8_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int16_broadcast_max2
#define FUN24_IMPL int16_broadcast_max2_impl
#define FUN24_CODE int16_broadcast_max2_code
#define NUMBER int16_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 uint16_broadcast_max2
#define FUN24_IMPL uint16_broadcast_max2_impl
#define FUN24_CODE uint16_broadcast_max2_code
#define NUMBER uint16_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int32_broadcast_max2
#define FUN24_IMPL int32_broadcast_max2_impl
#define FUN24_CODE int32_broadcast_max2_code
#define NUMBER int32_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN24 int64_broadcast_max2
#define FUN24_IMPL int64_broadcast_max2_impl
#define FUN24_CODE int64_broadcast_max2_code
#define NUMBER int64_t
#define MAPFN(X,Y,Z) *Z = (*X > *Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// broadcast_pow

#define FUN24 float32_broadcast_pow
#define FUN24_IMPL float32_broadcast_pow_impl
#define FUN24_CODE float32_broadcast_pow_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = powf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_pow
#define FUN24_IMPL float64_broadcast_pow_impl
#define FUN24_CODE float64_broadcast_pow_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = pow(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 complex32_broadcast_pow
#define FUN24_IMPL complex32_broadcast_pow_impl
#define FUN24_CODE complex32_broadcast_pow_code
#define NUMBER _Complex float
#define MAPFN(X,Y,Z) *Z = cpowf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 complex64_broadcast_pow
#define FUN24_IMPL complex64_broadcast_pow_impl
#define FUN24_CODE complex64_broadcast_pow_code
#define NUMBER _Complex double
#define MAPFN(X,Y,Z) *Z = cpow(*X,*Y)
#include "owl_dense_common_vec_map.c"

// broadcast_atan2

#define FUN24 float32_broadcast_atan2
#define FUN24_IMPL float32_broadcast_atan2_impl
#define FUN24_CODE float32_broadcast_atan2_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = atan2f(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_atan2
#define FUN24_IMPL float64_broadcast_atan2_impl
#define FUN24_CODE float64_broadcast_atan2_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = atan2(*X,*Y)
#include "owl_dense_common_vec_map.c"

// broadcast_hypot

#define FUN24 float32_broadcast_hypot
#define FUN24_IMPL float32_broadcast_hypot_impl
#define FUN24_CODE float32_broadcast_hypot_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = hypotf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_hypot
#define FUN24_IMPL float64_broadcast_hypot_impl
#define FUN24_CODE float64_broadcast_hypot_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = hypot(*X,*Y)
#include "owl_dense_common_vec_map.c"

// broadcast_fmod

#define FUN24 float32_broadcast_fmod
#define FUN24_IMPL float32_broadcast_fmod_impl
#define FUN24_CODE float32_broadcast_fmod_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = fmodf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN24 float64_broadcast_fmod
#define FUN24_IMPL float64_broadcast_fmod_impl
#define FUN24_CODE float64_broadcast_fmod_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = fmod(*X,*Y)
#include "owl_dense_common_vec_map.c"

//////////////////// function templates ends ////////////////////
