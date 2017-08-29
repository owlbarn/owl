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
inline double exp10 (double arg) { return exp(LN10 * arg); }

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


// compare two numbers (real & complex)

int real_cmpf (const void * a, const void * b)
{
  return ( *(float*)a < *(float*)b ? -1 : (*(float*)a > *(float*)b ? 1 : 0) );
}

int real_cmp (const void * a, const void * b)
{
  return ( *(double*)a < *(double*)b ? -1 : (*(double*)a > *(double*)b ? 1 : 0) );
}

int complex_cmpf (const void * a, const void * b)
{
 return ( CLTF(*(_Complex float*)a,*(_Complex float*)b) ? -1 : (CGTF(*(_Complex float*)a,*(_Complex float*)b) ? 1 : 0) );
}

int complex_cmp (const void * a, const void * b)
{
 return ( CLT(*(_Complex double*)a,*(_Complex double*)b) ? -1 : (CGT(*(_Complex double*)a,*(_Complex double*)b) ? 1 : 0) );
}


//////////////////// function templates starts ////////////////////


// less

#define FUN0 real_float_less
#define NUMBER float
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_less
#define NUMBER double
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_less
#define NUMBER _Complex float
#define STOPFN(X, Y) CGEF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_less
#define NUMBER _Complex double
#define STOPFN(X, Y) CGE(X,Y)
#include "owl_dense_common_vec_cmp.c"

// greater

#define FUN0 real_float_greater
#define NUMBER float
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_greater
#define NUMBER double
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_greater
#define NUMBER _Complex float
#define STOPFN(X, Y) CLEF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_greater
#define NUMBER _Complex double
#define STOPFN(X, Y) CLE(X,Y)
#include "owl_dense_common_vec_cmp.c"

// less_equal

#define FUN0 real_float_less_equal
#define NUMBER float
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_less_equal
#define NUMBER double
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_less_equal
#define NUMBER _Complex float
#define STOPFN(X, Y) CGTF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_less_equal
#define NUMBER _Complex double
#define STOPFN(X, Y) CGT(X,Y)
#include "owl_dense_common_vec_cmp.c"

// greater_equal

#define FUN0 real_float_greater_equal
#define NUMBER float
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_greater_equal
#define NUMBER double
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_greater_equal
#define NUMBER _Complex float
#define STOPFN(X, Y) CLTF(X,Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_greater_equal
#define NUMBER _Complex double
#define STOPFN(X, Y) CLT(X,Y)
#include "owl_dense_common_vec_cmp.c"

// is_zero

#define FUN1 real_float_is_zero
#define NUMBER float
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_is_zero
#define NUMBER double
#define STOPFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_is_zero
#define NUMBER complex_float
#define STOPFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_zero
#define NUMBER complex_double
#define STOPFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

// is_positive

#define FUN1 real_float_is_positive
#define NUMBER float
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_is_positive
#define NUMBER double
#define STOPFN(X) (X <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_is_positive
#define NUMBER complex_float
#define STOPFN(X) (X.r <= 0 || X.i <= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_positive
#define NUMBER complex_double
#define STOPFN(X) (X.r <= 0 || X.i <= 0)
#include "owl_dense_common_vec_cmp.c"

// is_negative

#define FUN1 real_float_is_negative
#define NUMBER float
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_is_negative
#define NUMBER double
#define STOPFN(X) (X >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_is_negative
#define NUMBER complex_float
#define STOPFN(X) (X.r >= 0 || X.i >= 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_negative
#define NUMBER complex_double
#define STOPFN(X) (X.r >= 0 || X.i >= 0)
#include "owl_dense_common_vec_cmp.c"

// is_nonnegative

#define FUN1 real_float_is_nonnegative
#define NUMBER float
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_is_nonnegative
#define NUMBER double
#define STOPFN(X) (X < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_is_nonnegative
#define NUMBER complex_float
#define STOPFN(X) (X.r < 0 || X.i < 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_nonnegative
#define NUMBER complex_double
#define STOPFN(X) (X.r < 0 || X.i < 0)
#include "owl_dense_common_vec_cmp.c"

// is_nonpositive

#define FUN1 real_float_is_nonpositive
#define NUMBER float
#define STOPFN(X) (X > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_is_nonpositive
#define NUMBER double
#define STOPFN(X) (X > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_is_nonpositive
#define NUMBER complex_float
#define STOPFN(X) (X.r > 0 || X.i > 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_nonpositive
#define NUMBER complex_double
#define STOPFN(X) (X.r > 0 || X.i > 0)
#include "owl_dense_common_vec_cmp.c"

// elt_equal

#define FUN15 real_float_elt_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_elt_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_elt_equal
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = (X->r == Y->r) && (X->i == Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_elt_equal
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = (X->r == Y->r) && (X->i == Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

// elt_not_equal

#define FUN15 real_float_elt_not_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_elt_not_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X != *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_elt_not_equal
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = (X->r != Y->r) || (X->i != Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_elt_not_equal
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = (X->r != Y->r) || (X->i != Y->i); Z->i = 0.
#include "owl_dense_common_vec_map.c"

// elt_less

#define FUN15 real_float_elt_less
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_elt_less
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_elt_less
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CLTF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_elt_less
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CLT(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

// elt_greater

#define FUN15 real_float_elt_greater
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_elt_greater
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X > *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_elt_greater
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CGTF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_elt_greater
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CGT(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

// elt_less_equal

#define FUN15 real_float_elt_less_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_elt_less_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X <= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_elt_less_equal
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CLEF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_elt_less_equal
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CLE(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

// elt_greater_equal

#define FUN15 real_float_elt_greater_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_elt_greater_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (*X >= *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_elt_greater_equal
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) *Z = CGEF(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_elt_greater_equal
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) *Z = CGE(*X,*Y) + 0*I
#include "owl_dense_common_vec_map.c"

// equal_scalar

#define FUN16 real_float_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 real_double_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X != a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_float_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define STOPFN(X) X.r != ar || X.i != ai
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_double_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define STOPFN(X) X.r != ar || X.i != ai
#include "owl_dense_common_vec_cmp.c"

// not_equal_scalar

#define FUN16 real_float_not_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 real_double_not_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X == a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_float_not_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define STOPFN(X) X.r == ar && X.i == ai
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_double_not_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define STOPFN(X) X.r == ar && X.i == ai
#include "owl_dense_common_vec_cmp.c"

// less_scalar

#define FUN16 real_float_less_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 real_double_less_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_float_less_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CGEF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_double_less_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CGE(X,a)
#include "owl_dense_common_vec_cmp.c"

// greater_scalar

#define FUN16 real_float_greater_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 real_double_greater_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X <= a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_float_greater_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CLEF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_double_greater_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CLE(X,a)
#include "owl_dense_common_vec_cmp.c"

// less_equal_scalar

#define FUN16 real_float_less_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 real_double_less_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X > a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_float_less_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CGTF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_double_less_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CGT(X,a)
#include "owl_dense_common_vec_cmp.c"

// greater_equal_scalar

#define FUN16 real_float_greater_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 real_double_greater_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define STOPFN(X) X < a
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_float_greater_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define STOPFN(X) CLTF(X,a)
#include "owl_dense_common_vec_cmp.c"

#define FUN16 complex_double_greater_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define STOPFN(X) CLT(X,a)
#include "owl_dense_common_vec_cmp.c"

// elt_equal_scalar

#define FUN17 real_float_elt_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elt_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X == a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_elt_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (X->r == ar) && (X->i == ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_elt_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (X->r == ar) && (X->i == ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

// elt_not_equal_scalar

#define FUN17 real_float_elt_not_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elt_not_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X != a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_elt_not_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (X->r != ar) || (X->i != ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_elt_not_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (X->r != ar) || (X->i != ai); Y->i = 0.
#include "owl_dense_common_vec_map.c"

// elt_less_scalar

#define FUN17 real_float_elt_less_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elt_less_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X < a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_elt_less_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CLTF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_elt_less_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CLT(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

// elt_greater_scalar

#define FUN17 real_float_elt_greater_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elt_greater_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X > a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_elt_greater_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CGTF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_elt_greater_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CGT(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

// elt_less_equal_scalar

#define FUN17 real_float_elt_less_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elt_less_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X <= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_elt_less_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CLEF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_elt_less_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) CLE(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

// elt_greater_equal_scalar

#define FUN17 real_float_elt_greater_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elt_greater_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X >= a)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_elt_greater_equal_scalar
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CGEF(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_elt_greater_equal_scalar
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CGE(*X,a) + 0*I
#include "owl_dense_common_vec_map.c"

// nnz

#define FUN2 real_float_nnz
#define NUMBER float
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 real_double_nnz
#define NUMBER double
#define CHECKFN(X) (X != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 complex_float_nnz
#define NUMBER complex_float
#define CHECKFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN2 complex_double_nnz
#define NUMBER complex_double
#define CHECKFN(X) (X.r != 0 || X.i != 0)
#include "owl_dense_common_vec_cmp.c"

// min_i

#define FUN6 real_float_min_i
#define NUMBER float
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 real_double_min_i
#define NUMBER double
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex_float_min_i
#define NUMBER _Complex float
#define CHECKFN(X,Y) CGTF(X,Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex_double_min_i
#define NUMBER _Complex double
#define CHECKFN(X,Y) CGT(X,Y)
#include "owl_dense_common_vec_fold.c"

// max_i

#define FUN6 real_float_max_i
#define NUMBER float
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 real_double_max_i
#define NUMBER double
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex_float_max_i
#define NUMBER _Complex float
#define CHECKFN(X,Y) CLTF(X,Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 complex_double_max_i
#define NUMBER _Complex double
#define CHECKFN(X,Y) CLT(X,Y)
#include "owl_dense_common_vec_fold.c"

// minmax_i
// TODO
//#define FUN23 real_float_minmax_i
//#define NUMBER float
//#define INIT
//#define BFCHKFN
//#define CHECKFN(X,Y) X < Y
//#define AFCHKFN
//#include "owl_dense_common_vec_fold.c"


// l1norm

#define FUN5 real_float_l1norm
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += fabsf(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_l1norm
#define INIT double r = 0.
#define NUMBER double
#define ACCFN(A,X) (A += fabs(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_l1norm
#define INIT float r = 0.
#define NUMBER complex_float
#define ACCFN(A,X) (A += sqrtf (X.r * X.r + X.i * X.i))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_l1norm
#define INIT double r = 0.
#define NUMBER complex_double
#define ACCFN(A,X) (A += sqrt (X.r * X.r + X.i * X.i))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

// l2norm_sqr

#define FUN5 real_float_l2norm_sqr
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += X * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_l2norm_sqr
#define INIT double r = 0.
#define NUMBER double
#define ACCFN(A,X) (A += X * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_l2norm_sqr
#define INIT float r = 0.
#define NUMBER complex_float
#define ACCFN(A,X) (A += X.r * X.r + X.i * X.i)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_l2norm_sqr
#define INIT double r = 0.
#define NUMBER complex_double
#define ACCFN(A,X) (A += X.r * X.r + X.i * X.i)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

// sum

#define FUN5 real_float_sum
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_sum
#define INIT double r = 0.
#define NUMBER double
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_sum
#define INIT complex_float r = { 0.0, 0.0 }
#define NUMBER complex_float
#define ACCFN(A,X) A.r += X.r; A.i += X.i
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_sum
#define INIT complex_double r = { 0.0, 0.0 }
#define NUMBER complex_double
#define ACCFN(A,X) A.r += X.r; A.i += X.i
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

// prod

#define FUN5 real_float_prod
#define INIT float r = 1.
#define NUMBER float
#define ACCFN(A,X) (A = A * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_prod
#define INIT double r = 1.
#define NUMBER double
#define ACCFN(A,X) (A = A * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_prod
#define INIT complex_float r = { 1.0, 0.0 }
#define NUMBER complex_float
#define ACCFN(A,X) A.r = A.r * X.r - A.i * X.i; A.i = A.r * X.i + A.i * X.r
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_prod
#define INIT complex_double r = { 1.0, 0.0 }
#define NUMBER complex_double
#define ACCFN(A,X) A.r = A.r * X.r - A.i * X.i; A.i = A.r * X.i + A.i * X.r
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

// neg

#define FUN19 real_float_neg
#define FUN19_IMPL real_float_neg_impl
#define NUMBER float
#define NUMBER1 float
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 real_double_neg
#define FUN19_IMPL real_double_neg_impl
#define NUMBER double
#define NUMBER1 double
#define INIT
#define MAPFN(X,Y) *Y = -(*X)
#include "owl_dense_common_vec_map.c"

#define FUN19 complex_float_neg
#define FUN19_IMPL complex_float_neg_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define INIT
#define MAPFN(X,Y) Y->r = -(X->r); Y->i = -(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN19 complex_double_neg
#define FUN19_IMPL complex_double_neg_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define INIT
#define MAPFN(X,Y) Y->r = -(X->r); Y->i = -(X->i)
#include "owl_dense_common_vec_map.c"

// reci

#define FUN4 real_float_reci
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_reci
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_reci
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_reci
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (1. / X)
#include "owl_dense_common_vec_map.c"

// reci_tol

#define FUN17 real_float_reci_tol
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (fabsf(*X) < a ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_reci_tol
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (fabs(*X) < a ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_reci_tol
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = (CLTF(*X,a) ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_reci_tol
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = (CLT(*X,a) ? 0. : 1. / *X)
#include "owl_dense_common_vec_map.c"

// abs

#define FUN4 real_float_abs
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fabsf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_abs
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fabs(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_abs
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (sqrtf (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_abs
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_map.c"

// abs2

#define FUN4 real_float_abs2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_abs2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_abs2
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (X.r * X.r + X.i * X.i)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_abs2
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (X.r * X.r + X.i * X.i)
#include "owl_dense_common_vec_map.c"

// signum

#define FUN4 real_float_signum
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) ((X > 0.0) ? 1.0 : (X < 0.0) ? -1.0 : X)
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_signum
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) ((X > 0.0) ? 1.0 : (X < 0.0) ? -1.0 : X)
#include "owl_dense_common_vec_map.c"

// sqr

#define FUN4 real_float_sqr
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sqr
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_sqr
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_sqr
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_map.c"

// sqrt

#define FUN4 real_float_sqrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sqrtf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sqrt
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sqrt(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_sqrt
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (csqrtf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_sqrt
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (csqrt(X))
#include "owl_dense_common_vec_map.c"

// cbrt

#define FUN4 real_float_cbrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cbrtf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_cbrt
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cbrt(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_cbrt
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT float _a = 1. / 3.
#define MAPFN(X) (cpowf(X,_a))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_cbrt
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT double _a = 1. / 3.
#define MAPFN(X) (cpow(X,_a))
#include "owl_dense_common_vec_map.c"

// exp

#define FUN4 real_float_exp
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_exp
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_exp
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cexpf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_exp
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cexp(X))
#include "owl_dense_common_vec_map.c"

// exp2

#define FUN4 real_float_exp2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (exp2f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_exp2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp2(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_exp2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cpowf(2.,X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_exp2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cpow(2.,X))
#include "owl_dense_common_vec_map.c"

// exp10

#define FUN4 real_float_exp10
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (exp10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_exp10
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_exp10
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cpowf(10.,X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_exp10
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cpow(10.,X))
#include "owl_dense_common_vec_map.c"

// expm1

#define FUN4 real_float_expm1
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expm1f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_expm1
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (expm1(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_expm1
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cexpf(X) - 1)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_expm1
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cexp(X) - 1)
#include "owl_dense_common_vec_map.c"

// log

#define FUN4 real_float_log
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (logf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_log
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (clogf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_log
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (clog(X))
#include "owl_dense_common_vec_map.c"

// log10

#define FUN4 real_float_log10
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log10f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log10
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_log10
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT float _log10 = logf(10)
#define MAPFN(X) (clogf(X) / _log10)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_log10
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT double _log10 = log(10)
#define MAPFN(X) (clog(X) / _log10)
#include "owl_dense_common_vec_map.c"

// log2

#define FUN4 real_float_log2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log2f(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log2(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_log2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define INIT float _log2 = logf(2)
#define MAPFN(X) (clogf(X) / _log2)
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_log2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define INIT double _log2 = log(2)
#define MAPFN(X) (clog(X) / _log2)
#include "owl_dense_common_vec_map.c"

// log1p

#define FUN4 real_float_log1p
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log1p
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log1p(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_log1p
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (clogf(X + 1))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_log1p
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (clog(X + 1))
#include "owl_dense_common_vec_map.c"

// sin

#define FUN4 real_float_sin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sin(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_sin
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (csinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_sin
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (csin(X))
#include "owl_dense_common_vec_map.c"

// cos

#define FUN4 real_float_cos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_cos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cos(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_cos
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ccosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_cos
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ccos(X))
#include "owl_dense_common_vec_map.c"

// tan

#define FUN4 real_float_tan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_tan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tan(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_tan
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ctanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_tan
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ctan(X))
#include "owl_dense_common_vec_map.c"

// asin

#define FUN4 real_float_asin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_asin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asin(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_asin
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (casinf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_asin
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (casin(X))
#include "owl_dense_common_vec_map.c"

// acos

#define FUN4 real_float_acos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_acos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acos(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_acos
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cacosf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_acos
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cacos(X))
#include "owl_dense_common_vec_map.c"

// atan

#define FUN4 real_float_atan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_atan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atan(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_atan
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (catanf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_atan
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (catan(X))
#include "owl_dense_common_vec_map.c"

// sinh

#define FUN4 real_float_sinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sinh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_sinh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (csinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_sinh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (csinh(X))
#include "owl_dense_common_vec_map.c"

// cosh

#define FUN4 real_float_cosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (coshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_cosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cosh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_cosh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ccoshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_cosh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ccosh(X))
#include "owl_dense_common_vec_map.c"

// tanh

#define FUN4 real_float_tanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_tanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tanh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_tanh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (ctanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_tanh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (ctanh(X))
#include "owl_dense_common_vec_map.c"

// asinh

#define FUN4 real_float_asinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_asinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asinh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_asinh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (casinhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_asinh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (casinh(X))
#include "owl_dense_common_vec_map.c"

// acosh

#define FUN4 real_float_acosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acoshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_acosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acosh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_acosh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cacoshf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_acosh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cacosh(X))
#include "owl_dense_common_vec_map.c"

// atanh

#define FUN4 real_float_atanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_atanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atanh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_float_atanh
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (catanhf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_atanh
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (catanh(X))
#include "owl_dense_common_vec_map.c"

// floor

#define FUN14 real_float_floor
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = floorf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 real_double_floor
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = floor(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_float_floor
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = floorf(X->r); Y->i = floorf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_double_floor
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = floor(X->r); Y->i = floor(X->i)
#include "owl_dense_common_vec_map.c"

// ceil

#define FUN14 real_float_ceil
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = ceilf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 real_double_ceil
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = ceil(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_float_ceil
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = ceilf(X->r); Y->i = ceilf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_double_ceil
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = ceil(X->r); Y->i = ceil(X->i)
#include "owl_dense_common_vec_map.c"

// round

#define FUN14 real_float_round
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = roundf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 real_double_round
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = round(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_float_round
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = roundf(X->r); Y->i = roundf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_double_round
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = round(X->r); Y->i = round(X->i)
#include "owl_dense_common_vec_map.c"

// trunc

#define FUN14 real_float_trunc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = truncf(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 real_double_trunc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = trunc(*X)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_float_trunc
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = truncf(X->r); Y->i = truncf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_double_trunc
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = trunc(X->r); Y->i = trunc(X->i)
#include "owl_dense_common_vec_map.c"

// fix

#define FUN14 real_float_fix
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X < 0. ? ceilf(*X) : floorf(*X))
#include "owl_dense_common_vec_map.c"

#define FUN14 real_double_fix
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X < 0. ? ceil(*X) : floor(*X))
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_float_fix
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = X->r < 0. ? ceilf(X->r) : floorf(X->r); Y->i = X->i < 0. ? ceilf(X->i) : floorf(X->i)
#include "owl_dense_common_vec_map.c"

#define FUN14 complex_double_fix
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = X->r < 0. ? ceil(X->r) : floor(X->r); Y->i = X->i < 0. ? ceil(X->i) : floor(X->i)
#include "owl_dense_common_vec_map.c"

// erf

#define FUN4 real_float_erf
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erff(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_erf
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (erf(X))
#include "owl_dense_common_vec_map.c"

// erfc

#define FUN4 real_float_erfc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erfcf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_erfc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (erfc(X))
#include "owl_dense_common_vec_map.c"

// logistic

#define FUN4 real_float_logistic
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1.0 / (1.0 + expf(-X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_logistic
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1.0 / (1.0 + exp(-X)))
#include "owl_dense_common_vec_map.c"

// elu

#define FUN17 real_float_elu
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (a * (expf(*X) - 1.)))
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_elu
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (a * (exp(*X) - 1.)))
#include "owl_dense_common_vec_map.c"

// relu

#define FUN4 real_float_relu
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fmaxf(X,0))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_relu
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fmax(X,0))
#include "owl_dense_common_vec_map.c"

// leaky_relu

#define FUN17 real_float_leaky_relu
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (*X * a))
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_leaky_relu
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (*X >= 0. ? *X : (*X * a))
#include "owl_dense_common_vec_map.c"

// softplus

#define FUN4 real_float_softplus
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(expf(X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_softplus
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log1p(exp(X)))
#include "owl_dense_common_vec_map.c"

// softsign

#define FUN4 real_float_softsign
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X / (1 + fabsf(X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_softsign
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X / (1 + fabs(X)))
#include "owl_dense_common_vec_map.c"

// sigmoid

#define FUN4 real_float_sigmoid
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sigmoid
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1 / (1 + exp(-X)))
#include "owl_dense_common_vec_map.c"

// log_sum_exp

#define FUN8 real_float_log_sum_exp
#define NUMBER float
#define NUMBER1 float
#include "owl_dense_common_vec_fold.c"

#define FUN8 real_double_log_sum_exp
#define NUMBER double
#define NUMBER1 double
#include "owl_dense_common_vec_fold.c"


////// binary math operator //////

// pow

#define FUN7 real_float_pow
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) Z = powf(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_pow
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) Z = pow(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 complex_float_pow
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) Z = cpowf(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 complex_double_pow
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) Z = cpow(X,Y)
#include "owl_dense_common_vec_combine.c"

// atan2

#define FUN7 real_float_atan2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) Z = atan2f(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_atan2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) Z = atan2(X,Y)
#include "owl_dense_common_vec_combine.c"

// hypot

#define FUN7 real_float_hypot
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) Z = hypotf(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_hypot
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) Z = hypot(X,Y)
#include "owl_dense_common_vec_combine.c"

// min2

#define FUN7 real_float_min2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) Z = fminf(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_min2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) Z = fmin(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 complex_float_min2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) Z = CLTF(X,Y) ? X : Y
#include "owl_dense_common_vec_combine.c"

#define FUN7 complex_double_min2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) Z = CLT(X,Y) ? X : Y
#include "owl_dense_common_vec_combine.c"

// max2

#define FUN7 real_float_max2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) Z = fmaxf(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_max2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) Z = fmax(X,Y)
#include "owl_dense_common_vec_combine.c"

#define FUN7 complex_float_max2
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define NUMBER2 _Complex float
#define MAPFN(X,Y,Z) Z = CGTF(X,Y) ? X : Y
#include "owl_dense_common_vec_combine.c"

#define FUN7 complex_double_max2
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define NUMBER2 _Complex double
#define MAPFN(X,Y,Z) Z = CGT(X,Y) ? X : Y
#include "owl_dense_common_vec_combine.c"

// fmod

#define FUN15 real_float_fmod
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fmodf(*X, *Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_fmod
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = fmod(*X, *Y)
#include "owl_dense_common_vec_map.c"

// fmod_scalar

#define FUN17 real_float_fmod_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmodf(*X,a)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_fmod_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmod(*X,a)
#include "owl_dense_common_vec_map.c"

// scalar_fmod

#define FUN17 real_float_scalar_fmod
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmodf(a,*X)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_scalar_fmod
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmod(a,*X)
#include "owl_dense_common_vec_map.c"

// ssqr

#define FUN9 real_float_ssqr
#define INIT float r = 0.; float c = Double_val(vC); float diff
#define NUMBER float
#define ACCFN(A,X) diff = X - c; A += diff * diff
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN9 real_double_ssqr
#define INIT double r = 0.; double c = Double_val(vC); double diff
#define NUMBER double
#define ACCFN(A,X) diff = X - c; A += diff * diff
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN9 complex_float_ssqr
#define INIT complex_float r = { 0.0, 0.0 }; float cr = Double_field(vC, 0); float ci = Double_field(vC, 1); float diffr; float diffi
#define NUMBER complex_float
#define ACCFN(A,X) diffr = X.r - cr; diffi = X.i - ci; A.r += diffr * diffr - diffi * diffi; A.i += 2 * diffr * diffi
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN9 complex_double_ssqr
#define INIT complex_double r = { 0.0, 0.0 }; double cr = Double_field(vC, 0); double ci = Double_field(vC, 1); double diffr; double diffi
#define NUMBER complex_double
#define ACCFN(A,X) diffr = X.r - cr; diffi = X.i - ci; A.r += diffr * diffr - diffi * diffi; A.i += 2 * diffr * diffi
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

// ssqr_diff

#define FUN11 real_float_ssqr_diff
#define INIT float r = 0.
#define NUMBER float
#define NUMBER1 float
#define ACCFN(A,X,Y) X -= Y; X *= X; A += X
#define COPYNUM(A) (caml_copy_double(A))
#include "owl_dense_common_vec_fold.c"

#define FUN11 real_double_ssqr_diff
#define INIT double r = 0.
#define NUMBER double
#define NUMBER1 double
#define ACCFN(A,X,Y) X -= Y; X *= X; A += X
#define COPYNUM(A) (caml_copy_double(A))
#include "owl_dense_common_vec_fold.c"

#define FUN11 complex_float_ssqr_diff
#define INIT complex_float r = { 0.0, 0.0 }
#define NUMBER complex_float
#define NUMBER1 complex_float
#define ACCFN(A,X,Y) X.r -= Y.r; X.i -= Y.i; A.r += (X.r - X.i) * (X.r + X.i); A.i += 2 * A.r * A.i
#define COPYNUM(A) (cp_two_doubles(A.r, A.i))
#include "owl_dense_common_vec_fold.c"

#define FUN11 complex_double_ssqr_diff
#define INIT complex_double r = { 0.0, 0.0 }
#define NUMBER complex_double
#define NUMBER1 complex_double
#define ACCFN(A,X,Y) X.r -= Y.r; X.i -= Y.i; A.r += (X.r - X.i) * (X.r + X.i); A.i += 2 * A.r * A.i
#define COPYNUM(A) (cp_two_doubles(A.r, A.i))
#include "owl_dense_common_vec_fold.c"

// linspace

#define FUN12 real_float_linspace
#define INIT float a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), x = a
#define NUMBER float
#define MAPFN(X) X = x; x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN12 real_double_linspace
#define INIT double a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), x = a
#define NUMBER double
#define MAPFN(X) X = x; x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN12 complex_float_linspace
#define INIT float ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, xr = ar, xi = ai
#define NUMBER complex_float
#define MAPFN(X) (X).r = xr; (X).i = xi; xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

#define FUN12 complex_double_linspace
#define INIT double ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, xr = ar, xi = ai
#define NUMBER complex_double
#define MAPFN(X) (X).r = xr; (X).i = xi; xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

// logspace

#define FUN13 real_float_logspace
#define INIT float a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), base = Double_val(vBase), x = a, log_base = log(base)
#define NUMBER float
#define MAPFN(X)  *X = exp2f(x); x = a + i * h
#define MAPFN1(X) *X = exp10(x); x = a + i * h
#define MAPFN2(X) *X = expf(x); x = a + i * h
#define MAPFN3(X) *X = expf(x * log_base); x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN13 real_double_logspace
#define INIT double a = Double_val(vA), h = (Double_val(vB) - a)/(N - 1), base = Double_val(vBase), x = a, log_base = log(base)
#define NUMBER double
#define MAPFN(X)  *X = exp2(x); x = a + i * h
#define MAPFN1(X) *X = exp10(x); x = a + i * h
#define MAPFN2(X) *X = exp(x); x = a + i * h
#define MAPFN3(X) *X = exp(x * log_base); x = a + i * h
#include "owl_dense_common_vec_map.c"

#define FUN13 complex_float_logspace
#define INIT float ar = Double_field(vA, 0), ai = Double_field(vA, 1), N1 = N - 1., hr = (Double_field(vB, 0) - ar) / N1, hi = (Double_field(vB, 1) - ai) / N1, base = Double_val(vBase), xr = ar, xi = ai, log_base = log(base)
#define NUMBER complex_float
#define MAPFN(X)  X->r = exp2f(xr); X->i = exp2f(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN1(X) X->r = exp10(xr); X->i = exp10(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN2(X) X->r = expf(xr); X->i = expf(xi); xr = ar + i * hr; xi = ai + i * hi
#define MAPFN3(X) X->r = expf(xr * log_base); X->i = expf(xi * log_base); xr = ar + i * hr; xi = ai + i * hi
#include "owl_dense_common_vec_map.c"

#define FUN13 complex_double_logspace
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

#define FUN19 complex_float_conj
#define FUN19_IMPL complex_float_conj_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define INIT
#define MAPFN(X,Y) Y->r = X->r; Y->i = -X->i
#include "owl_dense_common_vec_map.c"

#define FUN19 complex_double_conj
#define FUN19_IMPL complex_double_conj_impl
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

#define FUN18 real_float_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER float
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 real_double_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER double
#define MAPFN(X) *X = (rand() < a)
#include "owl_dense_common_vec_map.c"

#define FUN18 complex_float_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER complex_float
#define MAPFN(X) X->r = (rand() < a); X->i = 0
#include "owl_dense_common_vec_map.c"

#define FUN18 complex_double_bernoulli
#define INIT int a = Double_val(vA) * RAND_MAX; srand (Int_val(vB))
#define NUMBER complex_double
#define MAPFN(X) X->r = (rand() < a); X->i = 0
#include "owl_dense_common_vec_map.c"

// sequential

#define FUN18 real_float_sequential
#define INIT float a = Double_val(vA); float b = Double_val(vB)
#define NUMBER float
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 real_double_sequential
#define INIT double a = Double_val(vA); double b = Double_val(vB)
#define NUMBER double
#define MAPFN(X) *X = a; a += b
#include "owl_dense_common_vec_map.c"

#define FUN18 complex_float_sequential
#define INIT float ar = Double_field(vA, 0), ai = Double_field(vA, 1); float br = Double_field(vB, 0), bi = Double_field(vB, 1)
#define NUMBER complex_float
#define MAPFN(X) X->r = ar; X->i = ai; ar += br; ai += bi
#include "owl_dense_common_vec_map.c"

#define FUN18 complex_double_sequential
#define INIT double ar = Double_field(vA, 0), ai = Double_field(vA, 1); double br = Double_field(vB, 0), bi = Double_field(vB, 1)
#define NUMBER complex_double
#define MAPFN(X) X->r = ar; X->i = ai; ar += br; ai += bi
#include "owl_dense_common_vec_map.c"

// cumsum

#define FUN20 real_float_cumsum
#define FUN20_IMPL real_float_cumsum_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 real_double_cumsum
#define FUN20_IMPL real_double_cumsum_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_float_cumsum
#define FUN20_IMPL complex_float_cumsum_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = X->r + Y->r; Y->i = X->i + Y->i
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_double_cumsum
#define FUN20_IMPL complex_double_cumsum_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = X->r + Y->r; Y->i = X->i + Y->i
#include "owl_dense_common_vec_map.c"

// cumprod

#define FUN20 real_float_cumprod
#define FUN20_IMPL real_float_cumprod_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 real_double_cumprod
#define FUN20_IMPL real_double_cumprod_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_float_cumprod
#define FUN20_IMPL complex_float_cumprod_impl
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = (Y->r * X->r) - (Y->i * X->i); Y->i = (Y->r * X->i) + (Y->i * X->r)
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_double_cumprod
#define FUN20_IMPL complex_double_cumprod_impl
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = (Y->r * X->r) - (Y->i * X->i); Y->i = (Y->r * X->i) + (Y->i * X->r)
#include "owl_dense_common_vec_map.c"

// cummin

#define FUN20 real_float_cummin
#define FUN20_IMPL real_float_cummin_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fminf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 real_double_cummin
#define FUN20_IMPL real_double_cummin_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmin(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_float_cummin
#define FUN20_IMPL complex_float_cummin_impl
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CLTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_double_cummin
#define FUN20_IMPL complex_double_cummin_impl
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CLT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// cummax

#define FUN20 real_float_cummax
#define FUN20_IMPL real_float_cummax_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmaxf(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 real_double_cummax
#define FUN20_IMPL real_double_cummax_impl
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = fmax(*X,*Y)
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_float_cummax
#define FUN20_IMPL complex_float_cummax_impl
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X,Y) *Y = CGTF(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

#define FUN20 complex_double_cummax
#define FUN20_IMPL complex_double_cummax_impl
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X,Y) *Y = CGT(*X,*Y) ? *X : *Y
#include "owl_dense_common_vec_map.c"

// modf

#define FUN17 real_float_modf
#define NUMBER float
#define NUMBER1 float
#define INIT float a, b;
#define MAPFN(X,Y) a = modff(*X,&b); *X = a; *Y = b
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_modf
#define NUMBER double
#define NUMBER1 double
#define INIT double a, b;
#define MAPFN(X,Y) a = modf(*X,&b); *X = a; *Y = b
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_modf
#define NUMBER complex_float
#define NUMBER1 complex_float
#define INIT float a, b;
#define MAPFN(X,Y) a = modff(X->r,&b); X->r = a; Y->r = b; a = modff(X->i,&b); X->i = a; Y->i = b
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_modf
#define NUMBER complex_double
#define NUMBER1 complex_double
#define INIT double a, b;
#define MAPFN(X,Y) a = modf(X->r,&b); X->r = a; Y->r = b; a = modf(X->i,&b); X->i = a; Y->i = b
#include "owl_dense_common_vec_map.c"

// not_nan

#define FUN1 real_float_not_nan
#define NUMBER float
#define STOPFN(X) fpclassify(X) == FP_NAN
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_not_nan
#define NUMBER double
#define STOPFN(X) fpclassify(X) == FP_NAN
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_not_nan
#define NUMBER complex_float
#define STOPFN(X) (fpclassify(X.r) == FP_NAN || fpclassify(X.i) == FP_NAN)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_not_nan
#define NUMBER complex_double
#define STOPFN(X) (fpclassify(X.r) == FP_NAN || fpclassify(X.i) == FP_NAN)
#include "owl_dense_common_vec_cmp.c"

// not_inf

#define FUN1 real_float_not_inf
#define NUMBER float
#define STOPFN(X) fpclassify(X) == FP_INFINITE
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_not_inf
#define NUMBER double
#define STOPFN(X) fpclassify(X) == FP_INFINITE
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_not_inf
#define NUMBER complex_float
#define STOPFN(X) (fpclassify(X.r) == FP_INFINITE || fpclassify(X.i) == FP_INFINITE)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_not_inf
#define NUMBER complex_double
#define STOPFN(X) (fpclassify(X.r) == FP_INFINITE || fpclassify(X.i) == FP_INFINITE)
#include "owl_dense_common_vec_cmp.c"

// is_normal

#define FUN1 real_float_is_normal
#define NUMBER float
#define STOPFN(X) fpclassify(X) != FP_NORMAL
#include "owl_dense_common_vec_cmp.c"

#define FUN1 real_double_is_normal
#define NUMBER double
#define STOPFN(X) fpclassify(X) != FP_NORMAL
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_float_is_normal
#define NUMBER complex_float
#define STOPFN(X) (fpclassify(X.r) != FP_NORMAL || fpclassify(X.i) != FP_NORMAL)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_normal
#define NUMBER complex_double
#define STOPFN(X) (fpclassify(X.r) != FP_NORMAL || fpclassify(X.i) != FP_NORMAL)
#include "owl_dense_common_vec_cmp.c"

// approx_equal

#define FUN21 real_float_approx_equal
#define NUMBER float
#define INIT float a = Double_val(vA)
#define STOPFN(X,Y) fabsf(X - Y) >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN21 real_double_approx_equal
#define NUMBER double
#define INIT double a = Double_val(vA)
#define STOPFN(X,Y) fabs(X - Y) >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN21 complex_float_approx_equal
#define NUMBER complex_float
#define INIT float a = Double_val(vA)
#define STOPFN(X,Y) fabsf(X.r - Y.r) >= a || fabsf(X.i - Y.i) >= a
#include "owl_dense_common_vec_cmp.c"

#define FUN21 complex_double_approx_equal
#define NUMBER complex_double
#define INIT double a = Double_val(vA)
#define STOPFN(X,Y) fabs(X.r - Y.r) >= a || fabs(X.i - Y.i) >= a
#include "owl_dense_common_vec_cmp.c"

// approx_equal_scalar

#define FUN22 real_float_approx_equal_scalar
#define INIT float a = Double_val(vA); float b = Double_val(vB)
#define NUMBER float
#define STOPFN(X) fabsf(X - a) >= b
#include "owl_dense_common_vec_cmp.c"

#define FUN22 real_double_approx_equal_scalar
#define INIT double a = Double_val(vA); double b = Double_val(vB)
#define NUMBER double
#define STOPFN(X) fabs(X - a) >= b
#include "owl_dense_common_vec_cmp.c"

#define FUN22 complex_float_approx_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1); float b = Double_val(vB)
#define NUMBER complex_float
#define STOPFN(X) (fabsf(X.r - ar) >= b) || (fabsf(X.i - ai) >= b)
#include "owl_dense_common_vec_cmp.c"

#define FUN22 complex_double_approx_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1); double b = Double_val(vB)
#define NUMBER complex_double
#define STOPFN(X) (fabs(X.r - ar) >= b) || (fabs(X.i - ai) >= b)
#include "owl_dense_common_vec_cmp.c"

// approx_elt_equal

#define FUN15 real_float_approx_elt_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (fabsf(*X - *Y) < *Z)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_approx_elt_equal
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y,Z) *Z = (fabs(*X - *Y) < *Z)
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_approx_elt_equal
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = ((fabsf(X->r - Y->r) < Z->r) && (fabsf(X->i - Y->i) < Z->r))
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_approx_elt_equal
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = ((fabs(X->r - Y->r) < Z->r) && (fabs(X->i - Y->i) < Z->r))
#include "owl_dense_common_vec_map.c"

// approx_elt_equal_scalar

#define FUN17 real_float_approx_elt_equal_scalar
#define INIT float a = Double_val(vA)
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = (fabsf(*X - a) < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN17 real_double_approx_elt_equal_scalar
#define INIT double a = Double_val(vA)
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X,Y) *Y = (fabs(*X - a) < *Y)
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_float_approx_elt_equal_scalar
#define INIT float ar = Double_field(vA, 0); float ai = Double_field(vA, 1)
#define NUMBER complex_float
#define NUMBER1 complex_float
#define MAPFN(X,Y) Y->r = ((fabsf(X->r - ar) < Y->r) && (fabsf(X->i - ai) < Y->r))
#include "owl_dense_common_vec_map.c"

#define FUN17 complex_double_approx_elt_equal_scalar
#define INIT double ar = Double_field(vA, 0); double ai = Double_field(vA, 1)
#define NUMBER complex_double
#define NUMBER1 complex_double
#define MAPFN(X,Y) Y->r = ((fabs(X->r - ar) < Y->r) && (fabs(X->i - ai) < Y->r))
#include "owl_dense_common_vec_map.c"

// to_complex

#define FUN15 real_float_to_complex
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = *X; Z->i = *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_to_complex
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = *X; Z->i = *Y
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_float_to_complex
#define NUMBER complex_float
#define NUMBER1 complex_float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = X->r; Z->i = Y->i
#include "owl_dense_common_vec_map.c"

#define FUN15 complex_double_to_complex
#define NUMBER complex_double
#define NUMBER1 complex_double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = X->r; Z->i = Y->i
#include "owl_dense_common_vec_map.c"

// polar

#define FUN15 real_float_polar
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 complex_float
#define MAPFN(X,Y,Z) Z->r = *X * cosf(*Y); Z->i = *X * sinf(*Y)
#include "owl_dense_common_vec_map.c"

#define FUN15 real_double_polar
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 complex_double
#define MAPFN(X,Y,Z) Z->r = *X * cos(*Y); Z->i = *X * sin(*Y)
#include "owl_dense_common_vec_map.c"

// angle

#define FUN4 complex_float_angle
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cargf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_angle
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (carg(X))
#include "owl_dense_common_vec_map.c"

// proj

#define FUN4 complex_float_proj
#define NUMBER _Complex float
#define NUMBER1 _Complex float
#define MAPFN(X) (cprojf(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_proj
#define NUMBER _Complex double
#define NUMBER1 _Complex double
#define MAPFN(X) (cproj(X))
#include "owl_dense_common_vec_map.c"

// clip_by_value

#define FUN12 real_float_clip_by_value
#define INIT float a = Double_val(vA), b = Double_val(vB)
#define NUMBER float
#define MAPFN(X) X = X < a ? a : (X > b ? b : X)
#include "owl_dense_common_vec_map.c"

#define FUN12 real_double_clip_by_value
#define INIT double a = Double_val(vA), b = Double_val(vB)
#define NUMBER double
#define MAPFN(X) X = X < a ? a : (X > b ? b : X)
#include "owl_dense_common_vec_map.c"

#define FUN12 complex_float_clip_by_value
#define INIT _Complex float a = Double_field(vA, 0) + Double_field(vA, 1)*I, b = Double_field(vB, 0) + Double_field(vB, 1)*I
#define NUMBER _Complex float
#define MAPFN(X) CLTF(X,a) ? a : (CGTF(X,b) ? b : X)
#include "owl_dense_common_vec_map.c"

#define FUN12 complex_double_clip_by_value
#define INIT _Complex double a = Double_field(vA, 0) + Double_field(vA, 1)*I, b = Double_field(vB, 0) + Double_field(vB, 1)*I
#define NUMBER _Complex double
#define MAPFN(X) CLT(X,a) ? a : (CGT(X,b) ? b : X)
#include "owl_dense_common_vec_map.c"

// sort

#define FUN3 real_float_sort
#define NUMBER float
#define MAPFN(X) qsort(X,N,sizeof(float),real_cmpf)
#include "owl_dense_common_vec_map.c"

#define FUN3 real_double_sort
#define NUMBER float
#define MAPFN(X) qsort(X,N,sizeof(double),real_cmp)
#include "owl_dense_common_vec_map.c"

#define FUN3 complex_float_sort
#define NUMBER _Complex float
#define MAPFN(X) qsort(X,N,sizeof(_Complex float),complex_cmpf)
#include "owl_dense_common_vec_map.c"

#define FUN3 complex_double_sort
#define NUMBER _Complex double
#define MAPFN(X) qsort(X,N,sizeof(_Complex double),complex_cmp)
#include "owl_dense_common_vec_map.c"


//////////////////// function templates ends ////////////////////
