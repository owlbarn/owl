(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let utility_fun = "

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

"


let broadcast_arr_arr_template = "

__kernel void owl_opencl_FUNNAME (
  __global CLTYP *a,
  __global CLTYP *b,
  __global CLTYP *c,
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

  c[gid] = MAPFUN;
}

"

let broadcast_arr_arr_fun fun_name cl_typ map_fun =
  Owl_opencl_utils.replace_subs broadcast_arr_arr_template [
    ("FUNNAME", fun_name);
    ("MAPFUN", map_fun);
    ("CLTYP", cl_typ);
  ]


let functions = [|
    (* float32 functions *)
    broadcast_arr_arr_fun "float32_broadcast_add"   "float" "a[i1d_a] + b[i1d_b]";
    broadcast_arr_arr_fun "float32_broadcast_sub"   "float" "a[i1d_a] - b[i1d_b]";
    broadcast_arr_arr_fun "float32_broadcast_mul"   "float" "a[i1d_a] * b[i1d_b]";
    broadcast_arr_arr_fun "float32_broadcast_div"   "float" "a[i1d_a] / b[i1d_b]";
    broadcast_arr_arr_fun "float32_broadcast_pow"   "float" "pow(a[i1d_a], b[i1d_b])";
    broadcast_arr_arr_fun "float32_broadcast_min2"  "float" "fmin(a[i1d_a], b[i1d_b])";
    broadcast_arr_arr_fun "float32_broadcast_max2"  "float" "fmax(a[i1d_a], b[i1d_b])";
    broadcast_arr_arr_fun "float32_broadcast_fmod"  "float" "fmod(a[i1d_a], b[i1d_b])";
    broadcast_arr_arr_fun "float32_broadcast_hypot" "float" "hypot(a[i1d_a], b[i1d_b])";
    broadcast_arr_arr_fun "float32_broadcast_atan2" "float" "atan2(a[i1d_a], b[i1d_b])";
  |]


let code () =
  Printf.sprintf "%s\n%s" utility_fun
  (Array.fold_left ( ^ ) "" functions)
