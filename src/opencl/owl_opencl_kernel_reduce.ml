(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let code = "

__kernel void owl_opencl_MLTYP0_sum(
    __global const CLTYP0 *input,
    __global CLTYP0 *output,
    __local CLTYP0 *shared,
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
      shared[local_id] += input[i] + input[i + group_size];
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

  if (local_id == 0) { output[group_id] = shared[0]; }

}

"
