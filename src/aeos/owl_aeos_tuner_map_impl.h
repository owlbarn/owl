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

#undef NUMBER
#undef NUMBER1
#undef NUMBER2
#undef MAPFN
#undef BASE_FUN4
#undef BASE_FUN15
