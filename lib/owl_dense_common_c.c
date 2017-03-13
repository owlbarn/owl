/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <math.h>
#include <caml/mlvalues.h>
#include "owl_macros.h"

// some helper functions
float sqr_float(x) { return x * x; }
double sqr_double(x) { return x * x; }

CAMLprim value testfn_stub(value vX, value vY)
{
  CAMLparam2(vX, vY);
  int X = Int_val(vX);
  int Y = Int_val(vY);

  caml_enter_blocking_section();  /* Allow other threads */

  int r = X + Y;

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
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

// sigmoid

#define FUN3 real_float_sigmoid
#define NUMBER float
#define MAPFN(X) (1 / (1 + exp(-X)))
#include "owl_dense_common_vec_cmp.c"

#define FUN3 real_double_sigmoid
#define NUMBER double
#define MAPFN(X) (1 / (1 + exp(-X)))
#include "owl_dense_common_vec_cmp.c"

// abs
// note: abs has not been checked carefully
#define FUN4 real_float_abs
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fabsf(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_abs
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fabs(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 complex_float_abs
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 complex_double_abs
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_cmp.c"

// l1norm

#define FUN5 real_float_l1norm
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fabsf(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN5 real_double_l1norm
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fabs(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN5 complex_float_l1norm
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_cmp.c"

#define FUN5 complex_double_l1norm
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (sqrt (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_cmp.c"

// l2norm

#define FUN5 real_float_l2norm_sqr
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_cmp.c"

#define FUN5 real_double_l2norm_sqr
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X * X)
#include "owl_dense_common_vec_cmp.c"

#define FUN5 complex_float_l2norm_sqr
#define NUMBER complex_float
#define NUMBER1 float
#define MAPFN(X) (sqr_float (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_cmp.c"

#define FUN5 complex_double_l2norm_sqr
#define NUMBER complex_double
#define NUMBER1 double
#define MAPFN(X) (sqr_double (X.r * X.r + X.i * X.i))
#include "owl_dense_common_vec_cmp.c"

// asin

#define FUN4 real_float_asin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asin(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_asin
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asin(X))
#include "owl_dense_common_vec_cmp.c"

// acos

#define FUN4 real_float_acos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acos(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_acos
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acos(X))
#include "owl_dense_common_vec_cmp.c"

// atan

#define FUN4 real_float_atan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atan(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_atan
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atan(X))
#include "owl_dense_common_vec_cmp.c"

// sinh

#define FUN4 real_float_sinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinh(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_sinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (sinh(X))
#include "owl_dense_common_vec_cmp.c"

// cosh

#define FUN4 real_float_cosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosh(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_cosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (cosh(X))
#include "owl_dense_common_vec_cmp.c"

// tanh

#define FUN4 real_float_tanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanh(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_tanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (tanh(X))
#include "owl_dense_common_vec_cmp.c"

// asinh

#define FUN4 real_float_asinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinh(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_asinh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (asinh(X))
#include "owl_dense_common_vec_cmp.c"

// acosh

#define FUN4 real_float_acosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acosh(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_acosh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (acosh(X))
#include "owl_dense_common_vec_cmp.c"

// atanh

#define FUN4 real_float_atanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanh(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_atanh
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (atanh(X))
#include "owl_dense_common_vec_cmp.c"

// floor

#define FUN4 real_float_floor
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (floor(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_floor
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (floor(X))
#include "owl_dense_common_vec_cmp.c"

// ceil

#define FUN4 real_float_ceil
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (ceil(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_ceil
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (ceil(X))
#include "owl_dense_common_vec_cmp.c"

// round

#define FUN4 real_float_round
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (round(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_round
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (round(X))
#include "owl_dense_common_vec_cmp.c"

// trunc

#define FUN4 real_float_trunc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (trunc(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_trunc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (trunc(X))
#include "owl_dense_common_vec_cmp.c"

// erf

#define FUN4 real_float_erf
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erf(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_erf
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (erf(X))
#include "owl_dense_common_vec_cmp.c"

// erfc

#define FUN4 real_float_erfc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erfc(X))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_erfc
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (erfc(X))
#include "owl_dense_common_vec_cmp.c"

// logistic

#define FUN4 real_float_logistic
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1.0 / (1.0 + exp(-X)))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_logistic
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (1.0 / (1.0 + exp(-X)))
#include "owl_dense_common_vec_cmp.c"

// relu

#define FUN4 real_float_relu
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fmax(X,0))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_relu
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (fmax(X,0))
#include "owl_dense_common_vec_cmp.c"

// softplus

#define FUN4 real_float_softplus
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1p(exp(X)))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_softplus
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (log1p(exp(X)))
#include "owl_dense_common_vec_cmp.c"

// softsign

#define FUN4 real_float_softsign
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X / (1 + fabs(X)))
#include "owl_dense_common_vec_cmp.c"

#define FUN4 real_double_softsign
#define NUMBER double
#define NUMBER1 double
#define MAPFN(X) (X / (1 + fabs(X)))
#include "owl_dense_common_vec_cmp.c"

// min_i

#define FUN6 real_float_min_i
#define NUMBER float
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN6 real_double_min_i
#define NUMBER double
#define CHECKFN(X,Y) (X > Y)
#include "owl_dense_common_vec_cmp.c"

// max_i

#define FUN6 real_float_max_i
#define NUMBER float
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"

#define FUN6 real_double_max_i
#define NUMBER double
#define CHECKFN(X,Y) (X < Y)
#include "owl_dense_common_vec_cmp.c"


//////////////////// function templates ends ////////////////////
