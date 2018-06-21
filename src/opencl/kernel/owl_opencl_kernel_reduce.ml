(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let reduce_arr_template_00 = "
  __kernel void owl_opencl_CLTYP0_sum(
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


let reduce_arr_template_01 = "
__kernel void owl_opencl_FUNNAME(
    __global CLTYP *a,
    __global CLTYP *b,
    int dim,
    int stride)
{
  // project b's 1d-index b1d to a's a1d
  int b1d = get_global_id(0);
  int a1d = (b1d / stride) * dim * stride + (b1d % stride);

  INITFUN;

  for (int i = 0; i < dim; i++) {
    MAPFUN;
    a1d += stride;
  }

}
"


let reduce_arr_fun fun_name cl_typ map_fun init_fun =
  Owl_opencl_utils.replace_subs reduce_arr_template_01 [
    ("FUNNAME", fun_name);
    ("MAPFUN", map_fun);
    ("INITFUN", init_fun);
    ("CLTYP", cl_typ);
  ]
