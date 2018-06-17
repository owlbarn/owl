/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"
#include "philox432.h"
#include "ctypes_cstubs_internals.h"


CAMLprim value owl_clrng_philox_create_streams_stub
  (value vN, value vBufsz, value vStatus)
{
  int n = Long_val(vN);
  size_t* bufsz = CTYPES_ADDR_OF_FATPTR(vBufsz);
  clrngStatus** status = CTYPES_ADDR_OF_FATPTR(vStatus);
  clrngPhilox432Stream *streams = clrngPhilox432CreateStreams(NULL, n, bufsz, status);

  return CTYPES_FROM_PTR(streams);
}


CAMLprim value owl_clrng_philox_destroy_streams_stub (value vStreams)
{
  clrngPhilox432Stream* streams = CTYPES_ADDR_OF_FATPTR(vStreams);
  clrngPhilox432DestroyStreams(streams);

  return Val_unit;
}
