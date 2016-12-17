#include <math.h>
#include <caml/mlvalues.h>
#include "owl_macros.h"
#include <stdio.h>

CAMLprim value testfn_stub(value vX, value vY)
{
  CAMLparam2(vX, vY);
  integer X = Int_val(vX);
  integer Y = Int_val(vY);

  caml_enter_blocking_section();  /* Allow other threads */

  integer r = X + Y;

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

CAMLprim value equal_or_greater_double(value vN, value vX, value vY)
{
  CAMLparam2(vX, vY);
  integer GET_INT(N);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused integer dim_X = *big_X->dim;
  double *X_data = ((double *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused integer dim_Y = *big_Y->dim;
  double *Y_data = ((double *) big_Y->data);

  double *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */
  printf("double triggered\n");
  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  integer r = 1;

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


CAMLprim value equal_or_greater_float(value vN, value vX, value vY)
{
  CAMLparam2(vX, vY);
  integer GET_INT(N);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused integer dim_X = *big_X->dim;
  float *X_data = ((float *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused integer dim_Y = *big_Y->dim;
  float *Y_data = ((float *) big_Y->data);

  float *start_x, *stop_x, *start_y;

  caml_enter_blocking_section();  /* Allow other threads */
  printf("float triggered\n");
  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  integer r = 1;

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
