/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef BASE_FUN5

CAMLprim value BASE_FUN5(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  for (int i = 0; i < N; i++) {
    ACCFN(r, start_x[i]);
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* BASE_FUN5 */


#ifdef BASE_FUN26

CAMLprim value BASE_FUN26(value vM, value vN, value vO, value vX, value vY)
{
  CAMLparam5(vM, vN, vO, vX, vY);
  int M = Long_val(vM);
  int N = Long_val(vN);
  int O = Long_val(vO);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  caml_release_runtime_system();  /* Allow other threads */

  NUMBER  *start_x = X_data;
  NUMBER1 *start_y = Y_data;
  int incy = 0;

  // case 1: optimisation
  if (N == O) {
    for (int i = 0; i < M * N; i++) {
      ACCFN((start_x + i), (start_y + i));
    }
  }
  // case 2: optimisation
  else if (O == 1) {
    for (int i = 0; i < M; i++) {
      for (int j = 0; j < N; j++) {
        ACCFN((start_x + j), start_y);
      }
      start_x += N;
      start_y += 1;
    }
  }
  // case 3: common reduction
  else {
    for (int i = 0; i < M; i++) {
      for (int j = 0; j < N; j++) {
        ACCFN((start_x + j), (start_y + incy));
        incy = incy + 1 == O ? 0 : incy + 1;
      }
      start_x += N;
      start_y += O;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* BASE_FUN26 */


#undef INIT
#undef ACCFN
#undef NUMBER
#undef COPYNUM
#undef BASE_FUN5
#undef BASE_FUN26
