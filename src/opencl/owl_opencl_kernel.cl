//
// OWL - an OCaml numerical library for scientific computing
// Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
//


__kernel void owl_opencl_float32_add(
  __global float *a,
  __global float *b,
  __global float *c)
{
  int gid = get_global_id(0);
  c[gid] = a[gid] + b[gid];
}


__kernel void owl_opencl_float32_add_scalar(
  __global float *a,
  float b,
  __global float *c)
{
  int gid = get_global_id(0);
  c[gid] = a[gid] + b;
}


__kernel void owl_opencl_float32_sin(
  __global float *a,
  __global float *b
)
{
  int gid = get_global_id(0);
  b[gid] = sin(a[gid]);
}


__kernel void owl_opencl_float32_cos(
  __global float *a,
  __global float *b
)
{
  int gid = get_global_id(0);
  b[gid] = cos(a[gid]);
}


__kernel void owl_opencl_float32_sum(
    __global const float *input,
    __global float *output,
    __local float *shared,
    const unsigned int n)
{
  const unsigned int group_id = get_global_id(0) / get_local_size(0);
  const unsigned int group_size = 64;
  const unsigned int group_stride = 2 * group_size;
  const size_t local_stride = group_stride * group_size;
}
