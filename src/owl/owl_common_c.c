/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"
#include "SFMT.h"


CAMLprim value seed(value vX)
{
  CAMLparam1(vX);
  unsigned int x = Int_val(vX);

  caml_enter_blocking_section();  /* Allow other threads */

  srand(x);

  caml_leave_blocking_section();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}
