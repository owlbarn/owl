/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"
#include "philox432.h"


CAMLprim value owl_clrng_philox_create_streams(value vN)
{
  CAMLparam0();

  int n = Long_val(vN);
  clrngPhilox432Stream* streams = clrngPhilox432CreateStreams(NULL, n, NULL, NULL);

  CAMLreturn(Val_unit);
}


CAMLprim value owl_clrng_philox_destroy_streams(value vStreams)
{
  CAMLparam1(vStreams);
  
  clrngPhilox432Stream* streams = Data_custom_val(vStreams);
  clrngPhilox432DestroyStreams(streams);

  CAMLreturn(Val_unit);
}
