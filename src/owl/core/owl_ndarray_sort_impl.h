/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUNCTION (stub, sort) (value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  caml_release_runtime_system();  /* Allow other threads */

  MAPFN(X_data);

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}


#endif /* OWL_ENABLE_TEMPLATE */
