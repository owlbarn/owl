/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef FUN4

CAMLprim value FUN4(value vN, value vX, value vY) {
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

#endif /* FUN4 */

#ifdef FUN15

CAMLprim value FUN15(value vN, value vX, value vY, value vZ)
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

  while (start_x != stop_x) {
    MAPFN(start_x, start_y, start_z);
    start_x += 1;
    start_y += 1;
    start_z += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN15 */

#undef NUMBER
#undef NUMBER1
#undef NUMBER2
#undef MAPFN
#undef FUN4
#undef FUN15