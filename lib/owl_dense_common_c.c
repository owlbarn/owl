/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <math.h>
#include <caml/mlvalues.h>
#include "owl_macros.h"

// some helper functions

value cp_two_doubles(double d0, double d1)
{
  value res = caml_alloc_small(2 * Double_wosize, Double_array_tag);
  Store_double_field(res, 0, d0);
  Store_double_field(res, 1, d1);
  return res;
}

//////////////////// function templates starts ////////////////////


// is_smaller

#define FUN0 real_float_is_smaller
#define NUMBER float
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_is_smaller
#define NUMBER double
#define STOPFN(X, Y) (X >= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_is_smaller
#define NUMBER complex_float
#define STOPFN(X, Y) (X.r >= Y.r || X.i >= Y.i)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_is_smaller
#define NUMBER complex_double
#define STOPFN(X, Y) (X.r >= Y.r || X.i >= Y.i)
#include "owl_dense_common_vec_cmp.c"

// is_greater

#define FUN0 real_float_is_greater
#define NUMBER float
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_is_greater
#define NUMBER double
#define STOPFN(X, Y) (X <= Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_is_greater
#define NUMBER complex_float
#define STOPFN(X, Y) (X.r <= Y.r || X.i <= Y.i)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_is_greater
#define NUMBER complex_double
#define STOPFN(X, Y) (X.r <= Y.r || X.i <= Y.i)
#include "owl_dense_common_vec_cmp.c"

// equal_or_smaller

#define FUN0 real_float_equal_or_smaller
#define NUMBER float
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_equal_or_smaller
#define NUMBER double
#define STOPFN(X, Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_equal_or_smaller
#define NUMBER complex_float
#define STOPFN(X, Y) (X.r > Y.r || X.i > Y.i)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_equal_or_smaller
#define NUMBER complex_double
#define STOPFN(X, Y) (X.r > Y.r || X.i > Y.i)
#include "owl_dense_common_vec_cmp.c"

// equal_or_greater

#define FUN0 real_float_equal_or_greater
#define NUMBER float
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 real_double_equal_or_greater
#define NUMBER double
#define STOPFN(X, Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_float_equal_or_greater
#define NUMBER complex_float
#define STOPFN(X, Y) (X.r < Y.r || X.i < Y.i)
#include "owl_dense_common_vec_cmp.c"

#define FUN0 complex_double_equal_or_greater
#define NUMBER complex_double
#define STOPFN(X, Y) (X.r < Y.r || X.i < Y.i)
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
#define STOPFN(X) (X.r == 0 && X.i == 0)
#include "owl_dense_common_vec_cmp.c"

#define FUN1 complex_double_is_zero
#define NUMBER complex_double
#define STOPFN(X) (X.r == 0 && X.i == 0)
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

// max_i

#define FUN6 real_float_max_i
#define NUMBER float
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

#define FUN6 real_double_max_i
#define NUMBER double
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_fold.c"

// l1norm

#define FUN5 real_float_l1norm
#define INIT 0.
#define NUMBER float
#define NUMBER1 float
#define ACCFN(A,X) (A += fabsf(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_l1norm
#define INIT 0.
#define NUMBER double
#define NUMBER1 double
#define ACCFN(A,X) (A += fabs(X))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_l1norm
#define INIT 0.
#define NUMBER complex_float
#define NUMBER1 float
#define ACCFN(A,X) (A += sqrt (X.r * X.r + X.i * X.i))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_l1norm
#define INIT 0.
#define NUMBER complex_double
#define NUMBER1 double
#define ACCFN(A,X) (A += sqrt (X.r * X.r + X.i * X.i))
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

// l2norm_sqr

#define FUN5 real_float_l2norm_sqr
#define INIT 0.
#define NUMBER float
#define NUMBER1 float
#define ACCFN(A,X) (A += X * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_l2norm_sqr
#define INIT 0.
#define NUMBER double
#define NUMBER1 double
#define ACCFN(A,X) (A += X * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_l2norm_sqr
#define INIT 0.
#define NUMBER complex_float
#define NUMBER1 float
#define ACCFN(A,X) (A += X.r * X.r - X.i * X.i + 2 * X.r * X.i)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_l2norm_sqr
#define INIT 0.
#define NUMBER complex_double
#define NUMBER1 double
#define ACCFN(A,X) (A += X.r * X.r - X.i * X.i + 2 * X.r * X.i)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

// sum

#define FUN5 real_float_sum
#define INIT 0.
#define NUMBER float
#define NUMBER1 float
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_sum
#define INIT 0.
#define NUMBER double
#define NUMBER1 double
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_sum
#define INIT { 0.0, 0.0 }
#define NUMBER complex_float
#define NUMBER1 complex_float
#define ACCFN(A,X) A.r += X.r; A.i += X.i
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_sum
#define INIT { 0.0, 0.0 }
#define NUMBER complex_double
#define NUMBER1 complex_double
#define ACCFN(A,X) A.r += X.r; A.i += X.i
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

// prod

#define FUN5 real_float_prod
#define INIT 1.
#define NUMBER float
#define NUMBER1 float
#define ACCFN(A,X) (A = A * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 real_double_prod
#define INIT 1.
#define NUMBER double
#define NUMBER1 double
#define ACCFN(A,X) (A = A * X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_float_prod
#define INIT { 1.0, 0.0 }
#define NUMBER complex_float
#define NUMBER1 complex_float
#define ACCFN(A,X) A.r = A.r * X.r - A.i * X.i; A.i = A.r * X.i + A.i * X.r
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

#define FUN5 complex_double_prod
#define INIT { 1.0, 0.0 }
#define NUMBER complex_double
#define NUMBER1 complex_double
#define ACCFN(A,X) A.r = A.r * X.r - A.i * X.i; A.i = A.r * X.i + A.i * X.r
#define COPYNUM(X) (cp_two_doubles(X.r, X.i))
#include "owl_dense_common_vec_fold.c"

// neg

#define FUN4 real_float_neg
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (-X)
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_neg
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (-X)
#include "owl_dense_common_vec_map.c"

// reci

#define FUN4 real_float_reci
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1.0 / X)
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_reci
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1.0 / X)
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
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_map.c"

#define FUN4 complex_double_abs
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
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

// sqrt

#define FUN4 real_float_sqrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sqrt(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sqrt
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sqrt(X))
#include "owl_dense_common_vec_map.c"

// cbrt

#define FUN4 real_float_cbrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cbrt(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_cbrt
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cbrt(X))
#include "owl_dense_common_vec_map.c"

// exp

#define FUN4 real_float_exp
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (exp(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_exp
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp(X))
#include "owl_dense_common_vec_map.c"

// exp2

#define FUN4 real_float_exp2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (exp2(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_exp2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (exp2(X))
#include "owl_dense_common_vec_map.c"

// expm1

#define FUN4 real_float_expm1
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expm1(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_expm1
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (expm1(X))
#include "owl_dense_common_vec_map.c"

// log

#define FUN4 real_float_log
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log(X))
#include "owl_dense_common_vec_map.c"

// log10

#define FUN4 real_float_log10
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log10(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log10
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log10(X))
#include "owl_dense_common_vec_map.c"

// log2

#define FUN4 real_float_log2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log2(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log2
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log2(X))
#include "owl_dense_common_vec_map.c"

// log1p

#define FUN4 real_float_log1p
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1p(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_log1p
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log1p(X))
#include "owl_dense_common_vec_map.c"

// sin

#define FUN4 real_float_sin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sin(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sin(X))
#include "owl_dense_common_vec_map.c"

// cos

#define FUN4 real_float_cos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cos(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_cos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cos(X))
#include "owl_dense_common_vec_map.c"

// tan

#define FUN4 real_float_tan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tan(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_tan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tan(X))
#include "owl_dense_common_vec_map.c"

// asin

#define FUN4 real_float_asin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asin(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_asin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asin(X))
#include "owl_dense_common_vec_map.c"

// acos

#define FUN4 real_float_acos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acos(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_acos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acos(X))
#include "owl_dense_common_vec_map.c"

// atan

#define FUN4 real_float_atan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atan(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_atan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atan(X))
#include "owl_dense_common_vec_map.c"

// sinh

#define FUN4 real_float_sinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_sinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sinh(X))
#include "owl_dense_common_vec_map.c"

// cosh

#define FUN4 real_float_cosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_cosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cosh(X))
#include "owl_dense_common_vec_map.c"

// tanh

#define FUN4 real_float_tanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_tanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tanh(X))
#include "owl_dense_common_vec_map.c"

// asinh

#define FUN4 real_float_asinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_asinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asinh(X))
#include "owl_dense_common_vec_map.c"

// acosh

#define FUN4 real_float_acosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acosh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_acosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acosh(X))
#include "owl_dense_common_vec_map.c"

// atanh

#define FUN4 real_float_atanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanh(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_atanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atanh(X))
#include "owl_dense_common_vec_map.c"

// floor

#define FUN4 real_float_floor
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (floor(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_floor
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (floor(X))
#include "owl_dense_common_vec_map.c"

// ceil

#define FUN4 real_float_ceil
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (ceil(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_ceil
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (ceil(X))
#include "owl_dense_common_vec_map.c"

// round

#define FUN4 real_float_round
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (round(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_round
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (round(X))
#include "owl_dense_common_vec_map.c"

// trunc

#define FUN4 real_float_trunc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (trunc(X))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_trunc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (trunc(X))
#include "owl_dense_common_vec_map.c"

// erf

#define FUN4 real_float_erf
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erf(X))
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
#define MAPFN(X) (erfc(X))
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
#define MAPFN(X) (1.0 / (1.0 + exp(-X)))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_logistic
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1.0 / (1.0 + exp(-X)))
#include "owl_dense_common_vec_map.c"

// relu

#define FUN4 real_float_relu
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fmax(X,0))
#include "owl_dense_common_vec_map.c"

#define FUN4 real_double_relu
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fmax(X,0))
#include "owl_dense_common_vec_map.c"

// softplus

#define FUN4 real_float_softplus
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1p(exp(X)))
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
#define MAPFN(X) (X / (1 + fabs(X)))
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
#define MAPFN(X) (1 / (1 + exp(-X)))
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
#define MAPFN(X,Y) (pow(X,Y))
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_pow
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y) (pow(X,Y))
#include "owl_dense_common_vec_combine.c"

// atan2

#define FUN7 real_float_atan2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y) (atan2(X,Y))
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_atan2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y) (atan2(X,Y))
#include "owl_dense_common_vec_combine.c"

// hypot

#define FUN7 real_float_hypot
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y) (hypot(X,Y))
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_hypot
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y) (hypot(X,Y))
#include "owl_dense_common_vec_combine.c"

// min2

#define FUN7 real_float_min2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y) (fmin(X,Y))
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_min2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y) (fmin(X,Y))
#include "owl_dense_common_vec_combine.c"

// max2

#define FUN7 real_float_max2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y) (fmax(X,Y))
#include "owl_dense_common_vec_combine.c"

#define FUN7 real_double_max2
#define NUMBER double
#define NUMBER1 double
#define NUMBER2 double
#define MAPFN(X,Y) (fmax(X,Y))
#include "owl_dense_common_vec_combine.c"


//////////////////// function templates ends ////////////////////
