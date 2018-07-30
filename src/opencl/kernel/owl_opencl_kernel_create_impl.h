/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


#ifdef CLFUN50

__kernel void CLFUN50 (__global TYPE *a)
{
  int gid = get_global_id(0);
  MAPFUN(a[gid]);
}

#endif /* CLFUN50 */


#ifdef CLFUN51

__kernel void CLFUN51 (__global TYPE *a, __global TYPE *b)
{
  int gid = get_global_id(0);
  MAPFUN(a[0],b[gid]);
}

#endif /* CLFUN51 */


#endif /* OWL_ENABLE_TEMPLATE */
