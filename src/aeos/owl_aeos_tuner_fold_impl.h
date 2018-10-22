/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef FUN5

CAMLprim value FUN5(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    ACCFN(r, (*start_x));
    start_x += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN5 */

#undef INIT
#undef ACCFN
#undef NUMBER
#undef COPYNUM
#undef FUN5
