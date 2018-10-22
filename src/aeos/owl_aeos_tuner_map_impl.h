/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

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

#undef NUMBER
#undef NUMBER1
#undef MAPFN
#undef FUN4
