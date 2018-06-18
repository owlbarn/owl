/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"
#include "philox432.h"
#include "ctypes_cstubs_internals.h"


CAMLprim value owl_clrng_philox_create_streams_stub (value vN, value vCreator, value vBufsz, value vStatus)
{
  int n = Long_val(vN);
  size_t* bufsz = CTYPES_ADDR_OF_FATPTR(vBufsz);
  clrngPhilox432StreamCreator* creator = CTYPES_ADDR_OF_FATPTR(vCreator);
  clrngStatus* status = CTYPES_ADDR_OF_FATPTR(vStatus);
  clrngPhilox432Stream *streams = clrngPhilox432CreateStreams(creator, n, bufsz, status);

  return CTYPES_FROM_PTR(streams);
}


CAMLprim value owl_clrng_philox_destroy_streams_stub (value vStreams)
{
  clrngPhilox432Stream* streams = CTYPES_ADDR_OF_FATPTR(vStreams);
  clrngPhilox432DestroyStreams(streams);

  return Val_unit;
}


CAMLprim value owl_clrng_philox_create_over_streams_stub (value vN, value vCreator, value vStreams)
{
  size_t n = Long_val(vN);
  clrngPhilox432StreamCreator* creator = CTYPES_ADDR_OF_FATPTR(vCreator);
  clrngPhilox432Stream *streams = CTYPES_ADDR_OF_FATPTR(vStreams);
  clrngPhilox432CreateOverStreams(creator, n, streams);

  return Val_unit;
}


CAMLprim value owl_clrng_philox_rewind_streams_stub (value vN, value vStreams)
{
  size_t n = ctypes_size_t_val(vN);;
  clrngPhilox432Stream *streams = CTYPES_ADDR_OF_FATPTR(vStreams);
  clrngPhilox432RewindStreams (n, streams);

  return Val_unit;
}


CAMLprim value owl_clrng_philox_uniform_float_stub (value vStreams)
{
  clrngPhilox432Stream *streams = CTYPES_ADDR_OF_FATPTR(vStreams);
  float x = clrngPhilox432RandomU01_cl_float (streams);

  return caml_copy_double(x);
}


CAMLprim value owl_clrng_philox_uniform_double_stub (value vStreams)
{
  clrngPhilox432Stream *streams = CTYPES_ADDR_OF_FATPTR(vStreams);
  double x = clrngPhilox432RandomU01_cl_double (streams);

  return caml_copy_double(x);
}
