/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

#ifndef NUMBER
#define NUMBER double
void __dumb_fun() {};  // define a dumb to avoid warnings
#endif /* NUMBER */

#ifndef STOPFN
#define STOPFN(X, Y) (X < Y)
#endif /* STOPFN */


// function to compare two arrays
#ifdef FUN0

CAMLprim value FUN0(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER *Y_data = (NUMBER *) Y->data;

  NUMBER *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  int r = 1;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    NUMBER y = *start_y;

    if (STOPFN(x, y)) {
      r = 0;
      break;
    }

    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN0 */


// function to compare an array to zero
#ifdef FUN1

CAMLprim value FUN1(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  int r = 1;

  while (start_x != stop_x) {
    NUMBER x = *start_x;

    if (STOPFN(x)) {
      r = 0;
      break;
    }

    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN1 */


// function to count number of non-zero elements
#ifdef FUN2

CAMLprim value FUN2(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  int r = 0;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    if (CHECKFN(x)) r += 1;
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN2 */


// function to compare an array to a specific value
#ifdef FUN16

CAMLprim value FUN16(value vN, value vX, value vA)
{
  CAMLparam3(vN, vX, vA);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  int r = 1;

  while (start_x != stop_x) {
    NUMBER x = *start_x;

    if (STOPFN(x)) {
      r = 0;
      break;
    }

    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN16 */


// function to compare two arrays with regard to a scalar
#ifdef FUN21

CAMLprim value FUN21(value vN, value vX, value vY, value vA)
{
  CAMLparam4(vN, vX, vY, vA);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER *Y_data = (NUMBER *) Y->data;

  NUMBER *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  int r = 1;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    NUMBER y = *start_y;

    if (STOPFN(x, y)) {
      r = 0;
      break;
    }

    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN21 */


// function to compare an array to a specific value A w.r.t to B
#ifdef FUN22

CAMLprim value FUN22(value vN, value vX, value vA, value vB)
{
  CAMLparam4(vN, vX, vA, vB);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  int r = 1;

  while (start_x != stop_x) {
    NUMBER x = *start_x;

    if (STOPFN(x)) {
      r = 0;
      break;
    }

    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN22 */


#undef NUMBER
#undef STOPFN
#undef CHECKFN
#undef MAPFN
#undef INIT
#undef FUN0
#undef FUN1
#undef FUN2
#undef FUN16
#undef FUN21
#undef FUN22
