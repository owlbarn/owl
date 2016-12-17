/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
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


CAMLprim value real_float_equal_or_greater(value vN, value vX, value vY)
{
  CAMLparam2(vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  float *X_data = ((float *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  float *Y_data = ((float *) big_Y->data);

  float *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  int r = 1;

  while (start_x != stop_x) {
    float x = *start_x;
    float y = *start_y;
    if (x < y) {
      r = 0;
      break;
    }
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}


CAMLprim value real_double_equal_or_greater(value vN, value vX, value vY)
{
  CAMLparam2(vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  double *X_data = ((double *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  double *Y_data = ((double *) big_Y->data);

  double *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  int r = 1;

  while (start_x != stop_x) {
    double x = *start_x;
    double y = *start_y;
    if (x < y) {
      r = 0;
      break;
    }
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}


CAMLprim value complex_float_equal_or_greater(value vN, value vX, value vY)
{
  CAMLparam2(vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  complex_float *X_data = ((complex_float *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  complex_float *Y_data = ((complex_float *) big_Y->data);

  complex_float *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  int r = 1;

  while (start_x != stop_x) {
    complex_float x = *start_x;
    complex_float y = *start_y;
    if (x.r < y.r || x.i < y.i) {
      r = 0;
      break;
    }
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}


CAMLprim value complex_double_equal_or_greater(value vN, value vX, value vY)
{
  CAMLparam2(vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  complex_double *X_data = ((complex_double *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  complex_double *Y_data = ((complex_double *) big_Y->data);

  complex_double *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  int r = 1;

  while (start_x != stop_x) {
    complex_double x = *start_x;
    complex_double y = *start_y;
    if (x.r < y.r || x.i < y.i) {
      r = 0;
      break;
    }
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}
