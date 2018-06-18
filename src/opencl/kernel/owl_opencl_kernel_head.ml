(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let head_s = "
  #pragma OPENCL EXTENSION cl_khr_fp64 : enable

  #ifndef GROUP_SIZE
  #define GROUP_SIZE (64)
  #endif
"


let noop_s = "
__kernel void owl_opencl_noop(__local float *a)
{
  return;
}
"


let code () =
  Printf.sprintf "%s\n%s" head_s noop_s
