/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

#ifndef NUMBER
#define NUMBER double
void __dumb_fun_vec_fold() {};  // define a dumb to avoid warnings
#endif /* NUMBER */


// function to accumulate all the elements in x
#ifdef FUN5

CAMLprim value FUN5(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    ACCFN(r,x);
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN5 */


// function to scan all the elements in x then return index
#ifdef FUN6

CAMLprim value FUN6(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;

  NUMBER x = *start_x;
  int r = 0;

  for(int i = 0; i < N; i++) {
    if (CHECKFN(x,*start_x)) {
      x = *start_x;
      r = i;
    };
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN6 */


// function to calculate log_sum_exp specifically
#ifdef FUN8

CAMLprim value FUN8(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x, *max_start, max_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  max_start = start_x;
  max_x = *max_start;

  for (max_start = start_x; max_start != stop_x; max_start += 1)
      max_x = fmax(max_x, *max_start);

  NUMBER1 r = 0.;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    r += exp(x - max_x);
    start_x += 1;
  };

  r = log(r) + max_x;

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(caml_copy_double(r));
}

#endif /* FUN8 */


// function to calculate ssqr
#ifdef FUN9

CAMLprim value FUN9(value vN, value vC, value vX)
{
  CAMLparam3(vN, vC, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    ACCFN(r,x);
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN9 */


// function to fold two vectors x and y to a scalar value r
#ifdef FUN11

CAMLprim value FUN11(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;
  INIT;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    NUMBER  x = *start_x;
    NUMBER1 y = *start_y;
    ACCFN(r,x,y);
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN11 */


// function to fold all the elements in x with extra paramaters A and B
#ifdef FUN23

CAMLprim value FUN23(value vN, value vX, value vA, vB)
{
  CAMLparam4(vN, vX, vA, vB);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  caml_enter_blocking_section();  /* Allow other threads */

  NUMBER *start_x;
  start_x = X_data;

  for(int i = 0; i < N; i++) {
    BFCHKFN;
    if (CHECKFN) {
      AFCHKFN;
    };
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN23 */


// function specifically for folding along a specified axis, aka reduction.
// M: number of slices; N: x's slice size; O: x' strides, also y's slice size;
// X: source; Y: destination. Note that O <= N
#ifdef FUN26

CAMLprim value FUN26(value vM, value vN, value vO, value vX, value vY)
{
  CAMLparam5(vM, vN, vO, vX, vY);
  int M = Long_val(vM);
  int N = Long_val(vN);
  int O = Long_val(vO);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  caml_enter_blocking_section();  /* Allow other threads */

  NUMBER  *start_x = X_data;
  NUMBER1 *start_y = Y_data;
  int incy = 0;

  for (int i = 0; i < M; i++) {

    for (int j = 0; j < N; j++) {
      ACCFN((start_x + j), (start_y + incy));
      incy = incy + 1 == O ? 0 : incy + 1;
    }

    start_x += N;
    start_y += O;
  }

  /*** another solution, similar performance
   * int incx = 0;
   * for (int i = 0; i < M * N; i++) {
   *   ACCFN((start_x + i), (start_y + incy));
   *   start_y += (incx + 1 == N ? O : 0);
   *   incx = incx + 1 == N ? 0 : incx + 1;
   *   incy = incy + 1 == O ? 0 : incy + 1;
   * }
   ***/

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN26 */


#undef NUMBER
#undef NUMBER1
#undef CHECKFN
#undef BFCHKFN
#undef AFCHKFN
#undef COPYNUM
#undef ACCFN
#undef INIT
#undef FUN5
#undef FUN6
#undef FUN8
#undef FUN9
#undef FUN11
#undef FUN23
#undef FUN26
