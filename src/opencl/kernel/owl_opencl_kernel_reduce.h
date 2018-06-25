/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// f : arr -> elt
#ifdef CLFUN05

__kernel void CLFUN05 (
    __global const TYPE *a,
    __global TYPE *b,
    __local TYPE *shared,
    const unsigned int n)
{
  size_t local_id = get_local_id(0);
  size_t group_id = get_group_id(0);
  size_t group_size = GROUP_SIZE;
  size_t group_stride = 2 * group_size;
  size_t local_stride = group_stride * group_size;

  size_t i = group_id * group_stride + local_id;
  shared[local_id] = 0;

  while (i < n)
  {
      shared[local_id] += a[i] + a[i + group_size];
      i += local_stride;
  }

  barrier(CLK_LOCAL_MEM_FENCE);

  #if (GROUP_SIZE >= 512)
    if (local_id < 256) { shared[local_id] += shared[local_id + 256]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 256)
    if (local_id < 128) { shared[local_id] += shared[local_id + 128]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 128)
    if (local_id <  64) { shared[local_id] += shared[local_id +  64]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 64)
    if (local_id <  32) { shared[local_id] += shared[local_id +  32]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 32)
    if (local_id <  16) { shared[local_id] += shared[local_id +  16]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 16)
    if (local_id <   8) { shared[local_id] += shared[local_id +   8]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 8)
    if (local_id <   4) { shared[local_id] += shared[local_id +   4]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 4)
    if (local_id <   2) { shared[local_id] += shared[local_id +   2]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  #if (GROUP_SIZE >= 2)
    if (local_id <   1) { shared[local_id] += shared[local_id +   1]; }
    barrier(CLK_LOCAL_MEM_FENCE);
  #endif

  if (local_id == 0) { b[group_id] = shared[0]; }

}

#endif /* CLFUN05 */


// f : arr -> axis -> arr
#ifdef CLFUN06

__kernel void CLFUN06 (
    __global TYPE *a,
    __global TYPE *b,
    int dim,
    int stride)
{
  // project b's 1d-index b1d to a's a1d
  int b1d = get_global_id(0);
  int a1d = (b1d / stride) * dim * stride + (b1d % stride);

  INITFUN(a[a1d], b[b1d]);

  for (int i = 0; i < dim; i++) {
    MAPFUN(a[a1d], b[b1d]);
    a1d += stride;
  }

}

#endif /* CLFUN06 */


#endif /* OWL_ENABLE_TEMPLATE */
