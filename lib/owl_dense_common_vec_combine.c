/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

#ifndef NUMBER
#define NUMBER double
void __dumb_fun_vec_combine() {};  // define a dumb to avoid warnings
#endif /* NUMBER */


// function to combine x and y and save to z
#ifdef FUN7

void FUN7(value vN, value vX, value vY, value vZ)
{
  CAMLparam4(vN, vX, vY, vZ);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  struct caml_ba_array *big_Z = Caml_ba_array_val(vZ);
  CAMLunused int dim_Z = *big_Z->dim;
  NUMBER2 *Z_data = ((NUMBER2 *) big_Z->data);

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;
  NUMBER2 *start_z;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;
  start_z = Z_data;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    NUMBER1 y = *start_y;
    MAPFN(x,y,*start_z);

    start_x += 1;
    start_y += 1;
    start_z += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn0;
}

#endif /* FUN7 */


// function to combine a scalar [c] and a vector [x] then save to vector [y]
// NOTE: not tested yet
#ifdef FUN10

void FUN10(value vN, value vC, value vX, value vY)
{
  CAMLparam4(vN, vC, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;
  INIT;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    MAPFN(x,*start_y);

    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn0;
}

#endif /* FUN10 */


#undef NUMBER
#undef NUMBER1
#undef NUMBER2
#undef MAPFN
#undef INIT
#undef FUN7
#undef FUN10
