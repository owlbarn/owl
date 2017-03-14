/*
#include "owl_dense_common_copy.h"

extern void FUN(copy)(
  int *N,
  NUMBER *X, int *INCX,
  NUMBER *Y, int *INCY);

CAMLprim value LFUN(copy_stub)(
  value vN,
  value vOFSY, value vINCY, value vY,
  value vOFSX, value vINCX, value vX)
{
  CAMLparam2(vX, vY);

  int GET_INT(N),
          GET_INT(INCX),
          GET_INT(INCY);

  VEC_PARAMS(X);
  VEC_PARAMS(Y);

  caml_enter_blocking_section();
  FUN(copy)(
    &N,
    X_data, &INCX,
    Y_data, &INCY);
  caml_leave_blocking_section();

  CAMLreturn(Val_unit);
}

CAMLprim value LFUN(copy_stub_bc)(value *argv, int __unused argn)
{
  return LFUN(copy_stub)(
    argv[0], argv[1], argv[2], argv[3],
    argv[4], argv[5], argv[6]);
}
*/

#include "owl_macros.h"

#define GET_INT(V) V = Long_val(v##V)

extern void scopy(
  int *N,
  float *X, int *INCX,
  float *Y, int *INCY);

CAMLprim value s_copy_stub(
  value vN,
  value vOFSY, value vINCY, value vY,
  value vOFSX, value vINCX, value vX)
{
  CAMLparam2(vX, vY);

  int GET_INT(N),
          GET_INT(INCX),
          GET_INT(INCY);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  float *X_data = ((float *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  float *Y_data = ((float *) big_Y->data);

  caml_enter_blocking_section();  /* Allow other threads */
  scopy(
    &N,
    X_data, &INCX,
    Y_data, &INCY);
  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value s_copy_stub_bc(value *argv, int __unused argn)
{
  return s_copy_stub(
    argv[0], argv[1], argv[2], argv[3],
    argv[4], argv[5], argv[6]);
}


extern void dcopy(
  int *N,
  double *X, int *INCX,
  double *Y, int *INCY);

CAMLprim value d_copy_stub(
  value vN,
  value vOFSY, value vINCY, value vY,
  value vOFSX, value vINCX, value vX)
{
  CAMLparam2(vX, vY);

  int GET_INT(N),
          GET_INT(INCX),
          GET_INT(INCY);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  CAMLunused int dim_X = *big_X->dim;
  double *X_data = ((double *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  CAMLunused int dim_Y = *big_Y->dim;
  double *Y_data = ((double *) big_Y->data);

  caml_enter_blocking_section();  /* Allow other threads */
  dcopy(
    &N,
    X_data, &INCX,
    Y_data, &INCY);
  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value d_copy_stub_bc(value *argv, int __unused argn)
{
  return d_copy_stub(
    argv[0], argv[1], argv[2], argv[3],
    argv[4], argv[5], argv[6]);
}
