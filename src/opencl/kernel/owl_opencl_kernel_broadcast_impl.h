/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


__kernel void FUNCTION (
  __global TYPE *a,
  __global TYPE *b,
  __global TYPE *c,
  int dim,
  __global int *stride_a,
  __global int *stride_b,
  __global int *stride_c)
{
  int gid = get_global_id(0);

  int ind_c[MAX_DIM];
  index_1d_nd(dim, &gid, ind_c, stride_c);
  int i1d_a = index_nd_1d(dim, ind_c, stride_a);
  int i1d_b = index_nd_1d(dim, ind_c, stride_b);

  MAPFUN(a[i1d_a], b[i1d_b], c[gid]);
}


#endif /* OWL_ENABLE_TEMPLATE */
