/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#ifndef OWL_OPENCL_KERNEL_COMMON_H
#define OWL_OPENCL_KERNEL_COMMON_H


#pragma OPENCL EXTENSION cl_khr_fp64 : enable

#ifndef GROUP_SIZE
#define GROUP_SIZE (64)
#endif

#define MAX_DIM 16        // constrained by ocaml bigarray


// Dummy function for noop
__kernel void owl_opencl_noop(__local float *a)
{
  return;
}


void index_1d_nd (int dim, int* i1d, int* ind, __global int* stride)
{
  ind[0] = *i1d / stride[0];

  for (int i = 1; i < dim; i++)
    ind[i] = (*i1d % stride[i - 1]) / stride[i];

}


int index_nd_1d (int dim, int* ind, __global int* stride)
{
  int i1d = 0;

  for (int i = 0; i < dim; i++)
    i1d += ind[i] * stride[i];

  return i1d;
}


#endif  /* OWL_OPENCL_KERNEL_COMMON_H */
