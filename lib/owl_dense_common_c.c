/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <math.h>
#include <caml/mlvalues.h>
#include "owl_macros.h"


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
#define NUMBER complex_float
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
#define NUMBER complex_float
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
#define NUMBER complex_float
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
#define NUMBER complex_float
#define STOPFN(X, Y) (X.r < Y.r || X.i < Y.i)
#include "owl_dense_common_vec_cmp.c"
