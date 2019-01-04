/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#include "owl_opencl_prng_philox_kernel.h"


__kernel void owl_opencl_float32_std_uniform (
  __private int chunk,
  __private int limit,
  __global clrngPhilox432HostStream* streams,
  __global float* out)
{
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);

  int start = chunk * gid;
  int stop = min(start + chunk, limit);

  for (int i = start; i < stop; i++) {
    out[i] = clrngPhilox432RandomU01_cl_float(&private_stream);
  }

  clrngPhilox432CopyOverStreamsToGlobal(1, &streams[gid], &private_stream);
}


__kernel void owl_opencl_float32_uniform (
  __private int chunk,
  __private int limit,
  __global clrngPhilox432HostStream* streams,
  __global const float* ga,
  __global const float* gb,
  __global float* out)
{
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);

  float scale;
  float a = ga[0];
  float b = gb[0] - a;

  int start = chunk * gid;
  int stop = min(start + chunk, limit);

  for (int i = start; i < stop; i++) {
    scale = clrngPhilox432RandomU01_cl_float(&private_stream);
    out[i] = a + b * scale;
 }

  clrngPhilox432CopyOverStreamsToGlobal(1, &streams[gid], &private_stream);
}


__kernel void owl_opencl_float32_gaussian (
  __private int chunk,
  __private int limit,
  __global clrngPhilox432HostStream* streams,
  __global const float* ga,
  __global const float* gb,
  __global float* out)
{
  /** Ratio-of-Uniforms Method **/

  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);

  float e1 = 1. / 2.718281828459045235360287471352662498;
  float mu = ga[0];
  float sigma = gb[0];
  float u1, u2;

  int start = chunk * gid;
  int stop = min(start + chunk, limit);

  for (int i = start; i < stop; i++) {
    do {
      u1 = clrngPhilox432RandomU01_cl_float(&private_stream);
      u2 = clrngPhilox432RandomU01_cl_float(&private_stream);
      u2 = (2 * u2 - 1) * sqrt(2 * e1);
    }
    while ((-4 * u1 * u1 * log(u1)) < (u2 * u2));

    out[i] = mu + (u2 / u1) * sigma;
  }

  clrngPhilox432CopyOverStreamsToGlobal(1, &streams[gid], &private_stream);
}


__kernel void owl_opencl_float32_bernoulli (
  __private int chunk,
  __private int limit,
  __global clrngPhilox432HostStream* streams,
  __global const float* ga,
  __global float* out)
{
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);

  float e1 = 1. / 2.718281828459045235360287471352662498;
  float p = ga[0];

  int start = chunk * gid;
  int stop = min(start + chunk, limit);

  for (int i = start; i < stop; i++) {
    float u = clrngPhilox432RandomU01_cl_float(&private_stream);
    out[i] = u < p;
  }

  clrngPhilox432CopyOverStreamsToGlobal(1, &streams[gid], &private_stream);
}
