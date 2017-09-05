/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

#ifndef NUMBER
#define NUMBER double
void __dumb_fun_vec_map() {};  // define a dumb to avoid warnings
#endif /* NUMBER */

#ifndef INIT
#define INIT
#endif /* INIT */


// function to perform in-place sorting
#ifdef FUN3

CAMLprim value FUN3(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  caml_enter_blocking_section();  /* Allow other threads */

  MAPFN(X_data);

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN3 */


// function to perform mapping of elements from x to y
#ifdef FUN4

CAMLprim value FUN4(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    *start_y = (MAPFN(x));

    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN4 */


// function to perform mapping of elements in x with regards to scalar values
#ifdef FUN12

CAMLprim value FUN12(value vN, value vA, value vB, value vX)
{
  CAMLparam1(vX);
  int i, N = Long_val(vN);
  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  caml_enter_blocking_section();  /* Allow other threads */

  for (i = 1; i <= N; i++) {
    MAPFN(*X_data);
    X_data++;
  }

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN12 */


// function to calculate logspace function
#ifdef FUN13

CAMLprim value FUN13(value vN, value vBase, value vA, value vB, value vX)
{
  CAMLparam1(vX);
  int i, N = Long_val(vN);
  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  caml_enter_blocking_section();  /* Allow other threads */

  if (base == 2.0)
    for (i = 1; i <= N; i++) {
      MAPFN(X_data);
      X_data++;
    }
  else if (base == 10.0)
    for (i = 1; i <= N; i++) {
      MAPFN1(X_data);
      X_data++;
    }
  else if (base == 2.7182818284590452353602874713526625L)
    for (i = 1; i <= N; i++) {
      MAPFN2(X_data);
      X_data++;
    }
  else {
    for (i = 1; i <= N; i++) {
      MAPFN3(X_data);
      X_data++;
    }
  }

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN13 */


// TODO: this needs to be unified with FUN4 in future
// similar to FUN4, but mostly for complex numbers
#ifdef FUN14

CAMLprim value FUN14(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    MAPFN(start_x, start_y);
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN14 */


// function to map pairwise elements in x and y then save results to z
#ifdef FUN15

CAMLprim value FUN15(value vN, value vX, value vY, value vZ)
{
  CAMLparam4(vN, vX, vY, vZ);
  int N = Long_val(vN);

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  struct caml_ba_array *big_Z = Caml_ba_array_val(vZ);
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
    MAPFN(start_x, start_y, start_z);
    start_x += 1;
    start_y += 1;
    start_z += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN15 */


// function to map all elements in [x] w.r.t to [a] then save results to [y]
#ifdef FUN17

CAMLprim value FUN17(value vN, value vX, value vY, value vA)
{
  CAMLparam4(vN, vX, vY, vA);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    MAPFN(start_x, start_y);
    start_x += 1;
    start_y += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN17 */


// function of a and b then save results to x
#ifdef FUN18

CAMLprim value FUN18(value vN, value vX, value vA, value vB)
{
  CAMLparam4(vN, vX, vA, vB);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  NUMBER *start_x, *stop_x;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    MAPFN(start_x);
    start_x += 1;
  };

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN18 */


// function to map x to y with explicit offset, step size, number of ops
#ifdef FUN19

CAMLprim value FUN19_IMPL(
  value vN,
  value vX, value vOFSX, value vINCX,
  value vY, value vOFSY, value vINCY
)
{
  CAMLparam5(vN, vX, vOFSX, vINCX, vY);
  CAMLxparam2(vOFSY, vINCY);
  int N = Long_val(vN);
  int ofsx = Long_val(vOFSX);
  int incx = Long_val(vINCX);
  int ofsy = Long_val(vOFSY);
  int incy = Long_val(vINCY);

  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  NUMBER  *start_x;
  NUMBER1 *start_y;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x = X_data + ofsx;
  start_y = Y_data + ofsy;

  for (int i = 0; i < N; i++) {
    MAPFN(start_x, start_y);
    start_x += incx;
    start_y += incy;
  }

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN19(value *argv, int __unused_argn)
{
  return FUN19_IMPL(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

#endif /* FUN19 */


// function to map x to y with explicit offset, step size, number of ops
// more general version of FUN19, so more control over the access pattern to
// the data with two embedded loops.
#ifdef FUN20

CAMLprim value FUN20_IMPL(
  value vM, value vN,
  value vX, value vOFSX, value vINCX_M, value vINCX_N,
  value vY, value vOFSY, value vINCY_M, value vINCY_N
)
{
  CAMLparam2(vM, vN);
  CAMLxparam4(vX, vOFSX, vINCX_M, vINCX_N);
  CAMLxparam4(vY, vOFSY, vINCY_M, vINCY_N);
  int M = Long_val(vM);
  int N = Long_val(vN);
  int ofsx = Long_val(vOFSX);
  int incx_m = Long_val(vINCX_M);
  int incx_n = Long_val(vINCX_N);
  int ofsy = Long_val(vOFSY);
  int incy_m = Long_val(vINCY_M);
  int incy_n = Long_val(vINCY_N);

  INIT;

  struct caml_ba_array *big_X = Caml_ba_array_val(vX);
  NUMBER *X_data = ((NUMBER *) big_X->data);

  struct caml_ba_array *big_Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = ((NUMBER1 *) big_Y->data);

  NUMBER  *start_x_m;
  NUMBER  *start_x_n;
  NUMBER1 *start_y_m;
  NUMBER1 *start_y_n;

  caml_enter_blocking_section();  /* Allow other threads */

  start_x_m = X_data + ofsx;
  start_y_m = Y_data + ofsy;

  for (int i = 0; i < M; i++) {
    start_x_n = start_x_m;
    start_y_n = start_y_m;

    for (int j = 0; j < N; j++) {
      MAPFN(start_x_n, start_y_n);
      start_x_n += incx_n;
      start_y_n += incy_n;
    }

    start_x_m += incx_m;
    start_y_m += incy_m;
  }

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN20(value *argv, int __unused_argn)
{
  return FUN20_IMPL(
    argv[0], argv[1], argv[2], argv[3], argv[4],
    argv[5], argv[6], argv[7], argv[8], argv[9]
  );
}

#endif /* FUN20 */


// broadcast function of x and y then save the result to z
#ifdef FUN24

void FUN24_CODE (
  int d,
  struct caml_ba_array *X, int64_t *stride_x, int ofs_x,
  struct caml_ba_array *Y, int64_t *stride_y, int ofs_y,
  struct caml_ba_array *Z, int64_t *stride_z, int ofs_z
)
{
  int inc_x = X->dim[d] == Z->dim[d] ? stride_x[d] : 0;
  int inc_y = Y->dim[d] == Z->dim[d] ? stride_y[d] : 0;
  int inc_z = stride_z[d];

  NUMBER *x = (NUMBER *) X->data;
  NUMBER *y = (NUMBER *) Y->data;
  NUMBER *z = (NUMBER *) Z->data;


  if (d == X->num_dims - 1) {
    for (int i = 0; i < Z->dim[d]; i++) {
      MAPFN((x + ofs_x), (y + ofs_y), (z + ofs_z));
      ofs_x += inc_x;
      ofs_y += inc_y;
      ofs_z += inc_z;
    }
  }
  else {
    for (int i = 0; i < Z->dim[d]; i++) {
      FUN24_CODE (d+1, X, stride_x, ofs_x, Y, stride_y, ofs_y, Z, stride_z, ofs_z);
      ofs_x += inc_x;
      ofs_y += inc_y;
      ofs_z += inc_z;
    }
  }

  return;
}

CAMLprim value FUN24_IMPL(
  value vX, value vSTRIDE_X,
  value vY, value vSTRIDE_Y,
  value vZ, value vSTRIDE_Z
)
{
  CAMLparam4(vX, vSTRIDE_X, vY, vSTRIDE_Y);
  CAMLxparam2(vZ, vSTRIDE_Z);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  struct caml_ba_array *Z = Caml_ba_array_val(vZ);

  struct caml_ba_array *stride_X = Caml_ba_array_val(vSTRIDE_X);
  int64_t *stride_x = (int64_t *) stride_X->data;
  struct caml_ba_array *stride_Y = Caml_ba_array_val(vSTRIDE_Y);
  int64_t *stride_y = (int64_t *) stride_Y->data;
  struct caml_ba_array *stride_Z = Caml_ba_array_val(vSTRIDE_Z);
  int64_t *stride_z = (int64_t *) stride_Z->data;

  caml_enter_blocking_section();  /* Allow other threads */

  FUN24_CODE (0, X, stride_x, 0, Y, stride_y, 0, Z, stride_z, 0);

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN24(value *argv, int __unused_argn)
{
  return FUN24_IMPL(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

#endif /* FUN24 */


#undef NUMBER
#undef NUMBER1
#undef NUMBER2
#undef MAPFN
#undef MAPFN1
#undef MAPFN2
#undef MAPFN3
#undef INIT
#undef FUN3
#undef FUN4
#undef FUN12
#undef FUN13
#undef FUN14
#undef FUN15
#undef FUN17
#undef FUN18
#undef FUN19
#undef FUN19_IMPL
#undef FUN20
#undef FUN20_IMPL
#undef FUN24
#undef FUN24_IMPL
#undef FUN24_CODE
