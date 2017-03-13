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
