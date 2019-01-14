/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// f : arr -> arr
#ifdef CLFUN01

__kernel void CLFUN01 (
  __global TYPE *a,
  __global TYPE *b
)
{
  int gid = get_global_id(0);
  MAPFUN(a[gid], b[gid]);
}

#endif /* CLFUN01 */


// f : arr -> arr -> arr
#ifdef CLFUN02

__kernel void CLFUN02 (
  __global TYPE *a,
  __global TYPE *b,
  __global TYPE *c)
{
  int gid = get_global_id(0);
  MAPFUN(a[gid], b[gid], c[gid]);
}

#endif /* CLFUN02 */


// f : arr -> elt -> arr
#ifdef CLFUN03

__kernel void CLFUN03 (
  __global TYPE *a,
  __global TYPE *b,
  __global TYPE *c)
{
  int gid = get_global_id(0);
  MAPFUN(a[gid], b[0], c[gid]);
}

#endif /* CLFUN03 */


// f : elt -> arr -> arr
#ifdef CLFUN04

__kernel void CLFUN04 (
  __global TYPE *a,
  __global TYPE *b,
  __global TYPE *c)
{
  int gid = get_global_id(0);
  MAPFUN(a[0], b[gid], c[gid]);
}

#endif /* CLFUN04 */


#endif /* OWL_ENABLE_TEMPLATE */
