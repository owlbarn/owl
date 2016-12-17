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

CAMLprim value d_is_greater(value vN, value vX, value vY)
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

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  integer r = 1;

  while (start_x != stop_x) {
    double x = *start_x;
    double y = *start_y;
    printf("%f, %f\n", x, y);
    if (x <= y) {
      r = 0;
      break;
    }
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

// The following implementation is incorrect.
CAMLprim value dd_is_greater(
  value vN,
  value vOFSX, value vINCX, value vX,
  value vOFSY, value vINCY, value vY)
{
  CAMLparam2(vX, vY);

  integer GET_INT(N),
          GET_INT(INCX),
          GET_INT(INCY);

  VEC_PARAMS(X);
  VEC_PARAMS(Y);

  NUMBER *start1, *last1, *dst;

  caml_enter_blocking_section();  /* Allow other threads */

  if (INCX > 0) {
      start1 = X_data;
      last1 = start1 + N*INCX;
    } else {
      start1 = X_data - (N - 1)*INCX;
      last1 = X_data + INCX;
    };

    if (INCY > 0) dst = Y_data;
    else dst = Y_data - (N - 1)*INCY;

  integer r = 1;

  while (start1 != last1) {
    NUMBER x = *start1;
    NUMBER y = *dst;
    if (x <= y) {
      r = 0;
      break;
    }
    start1 += INCX;
    dst += INCY;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}
