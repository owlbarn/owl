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

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  NUMBER *X_data = ((NUMBER *) big_X->data);

  NUMBER *start_x, *stop_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  NUMBER1 r = 0.;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    r += (MAPFN(x));
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(caml_copy_double(r));
}

#endif /* FUN5 */


// function to scan all the elements in x then return index
#ifdef FUN6

CAMLprim value FUN6(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  NUMBER *X_data = ((NUMBER *) big_X->data);

  NUMBER *start_x, *stop_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

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

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  NUMBER *X_data = ((NUMBER *) big_X->data);

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

  CAMLreturn(caml_copy_double(r ));
}

#endif /* FUN8 */


#undef NUMBER
#undef NUMBER1
#undef CHECKFN
#undef MAPFN
#undef FUN5
#undef FUN6
#undef FUN8
