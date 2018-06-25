/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#include "owl_opencl_prng_philox_kernel.h"


__kernel void owl_opencl_float32_std_uniform (
  __global clrngPhilox432HostStream* streams,
  __global float* out)
{
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);

  out[gid] = clrngPhilox432RandomU01_cl_float(&private_stream);

  clrngPhilox432CopyOverStreamsToGlobal(1, &streams[gid], &private_stream);
}


__kernel void owl_opencl_float32_uniform (
  __global clrngPhilox432HostStream* streams,
  __global const float* ga,
  __global const float* gb,
  __global float* out)
{
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);

  float scale = clrngPhilox432RandomU01_cl_float(&private_stream);
  float a = ga[0];
  float b = gb[0];
  out[gid] = a + (b - a) * scale;

  clrngPhilox432CopyOverStreamsToGlobal(1, &streams[gid], &private_stream);
}
