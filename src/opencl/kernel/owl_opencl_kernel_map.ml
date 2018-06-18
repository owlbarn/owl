(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let map_arr_template = "
  __kernel void owl_opencl_FUNNAME(
    __global CLTYP *a,
    __global CLTYP *b
  )
  {
    int gid = get_global_id(0);
    b[gid] = MAPFUN;
  }
  "

let map_arr_arr_template = "
  __kernel void owl_opencl_FUNNAME(
    __global CLTYP *a,
    __global CLTYP *b,
    __global CLTYP *c)
  {
    int gid = get_global_id(0);
    c[gid] = MAPFUN;
  }
  "

let map_arr_scalar_template = "
  __kernel void owl_opencl_FUNNAME(
    __global CLTYP *a,
             CLTYP  b,
    __global CLTYP *c)
  {
    int gid = get_global_id(0);
    c[gid] = MAPFUN;
  }
  "


let map_arr_fun fun_name cl_typ map_fun =
  Owl_opencl_utils.replace_subs map_arr_template [
    ("FUNNAME", fun_name);
    ("MAPFUN", map_fun);
    ("CLTYP", cl_typ);
  ]


let map_arr_arr_fun fun_name cl_typ map_fun =
  Owl_opencl_utils.replace_subs map_arr_arr_template [
    ("FUNNAME", fun_name);
    ("MAPFUN", map_fun);
    ("CLTYP", cl_typ);
  ]


let map_arr_scalar_fun fun_name cl_typ map_fun =
  Owl_opencl_utils.replace_subs map_arr_scalar_template [
    ("FUNNAME", fun_name);
    ("MAPFUN", map_fun);
    ("CLTYP", cl_typ);
  ]
