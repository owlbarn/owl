/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef BASE_FUN4

CAMLprim value BASE_FUN4(value vN, value vX, value vY) {
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    NUMBER x = *start_x;
    *start_y = MAPFN(x);

    start_x += 1;
    start_y += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* BASE_FUN4 */

#include <stdio.h>

#ifdef BASE_FUN15

CAMLprim value BASE_FUN15(value vN, value vX, value vY, value vZ)
{
  CAMLparam4(vN, vX, vY, vZ);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  NUMBER2 *Z_data = (NUMBER2 *) Z->data;

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;
  NUMBER2 *start_z;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;
  start_z = Z_data;

  for (int i = 0; i < N; i++) {
    MAPFN((start_x + i), (start_y + i), (start_z + i));
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* BASE_FUN15 */


#ifdef BASE_FUN20

CAMLprim value BASE_FUN20_IMPL(
  value vM, value vN,
  value vX, value vOFSX, value vINCX_M, value vINCX_N,
  value vY, value vOFSY, value vINCY_M, value vINCY_N
) {
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

  //INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER  *start_x_m;
  NUMBER  *start_x_n;
  NUMBER1 *start_y_m;
  NUMBER1 *start_y_n;

  caml_release_runtime_system();

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

  caml_acquire_runtime_system();

  CAMLreturn(Val_unit);
}

CAMLprim value BASE_FUN20(value *argv, int __unused_argn) {
  return BASE_FUN20_IMPL(
    argv[0], argv[1], argv[2], argv[3], argv[4],
    argv[5], argv[6], argv[7], argv[8], argv[9]
  );
}

#endif /* BASE_FUN20 */

#undef NUMBER
#undef NUMBER1
#undef NUMBER2
#undef MAPFN
#undef BASE_FUN4
#undef BASE_FUN15
#undef BASE_FUN20
#undef BASE_FUN20_IMPL
