(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let code = "

#ifndef GROUP_SIZE
#define GROUP_SIZE (64)
#endif


__kernel void owl_opencl_MLTYP0_add(
  __global CLTYP0 *a,
  __global CLTYP0 *b,
  __global CLTYP0 *c)
{
  int gid = get_global_id(0);
  c[gid] = a[gid] + b[gid];
}


__kernel void owl_opencl_MLTYP0_add_scalar(
  __global CLTYP0 *a,
  CLTYP0 b,
  __global CLTYP0 *c)
{
  int gid = get_global_id(0);
  c[gid] = a[gid] + b;
}


__kernel void owl_opencl_MLTYP0_sin(
  __global CLTYP0 *a,
  __global CLTYP0 *b
)
{
  int gid = get_global_id(0);
  b[gid] = sin(a[gid]);
}


__kernel void owl_opencl_MLTYP0_cos(
  __global CLTYP0 *a,
  __global CLTYP0 *b
)
{
  int gid = get_global_id(0);
  b[gid] = cos(a[gid]);
}


"
