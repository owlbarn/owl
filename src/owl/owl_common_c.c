/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

// Internal state of PRNG
sfmt_t sfmt_state;


CAMLprim value owl_sfmt_seed(value vX)
{
  CAMLparam1(vX);
  unsigned int x = Int_val(vX);

  caml_enter_blocking_section();
  sfmt_init_gen_rand(&sfmt_state, x);
  caml_leave_blocking_section();

  CAMLreturn(Val_unit);
}


CAMLprim value owl_sfmt_rand_int()
{
  CAMLparam0();

  caml_enter_blocking_section();
  int x = sfmt_genrand_uint64(&sfmt_state);
  caml_leave_blocking_section();

  CAMLreturn(Val_int(x));
}
