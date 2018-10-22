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

  #pragma omp parallel for reduction(+ : r)
  for (int i = 0; i < N; i++) {
    //int tid = omp_get_thread_num();
    //fprintf(stderr, "Plus rom omp thread %d for fun5 \n", tid);
    ACCFN(r, start_x[i]);
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* BASE_FUN5 */

#undef INIT
#undef ACCFN
#undef NUMBER
#undef COPYNUM
#undef BASE_FUN5
