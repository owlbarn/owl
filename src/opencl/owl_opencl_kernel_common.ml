(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_kernel_map


let head_s = "

  #ifndef GROUP_SIZE
  #define GROUP_SIZE (64)
  #endif

"


let functions () = [
    (* float32 functions *)
    map_arr_fun        "float32_erf"            "float" "erf(a[gid])";
    map_arr_fun        "float32_erfc"           "float" "erfc(a[gid])";
    map_arr_fun        "float32_abs"            "float" "fabs(a[gid])";
    map_arr_fun        "float32_neg"            "float" "-a[gid]";
    map_arr_fun        "float32_sqr"            "float" "a[gid] * a[gid]";
    map_arr_fun        "float32_sqrt"           "float" "sqrt(a[gid])";
    map_arr_fun        "float32_rsqrt"          "float" "rsqrt(a[gid])";
    map_arr_fun        "float32_cbrt"           "float" "cbrt(a[gid])";
    map_arr_fun        "float32_reci"           "float" "1. / a[gid]";
    map_arr_fun        "float32_sin"            "float" "sin(a[gid])";
    map_arr_fun        "float32_cos"            "float" "cos(a[gid])";
    map_arr_fun        "float32_tan"            "float" "tan(a[gid])";
    map_arr_fun        "float32_asin"           "float" "asin(a[gid])";
    map_arr_fun        "float32_acos"           "float" "acos(a[gid])";
    map_arr_fun        "float32_atan"           "float" "atan(a[gid])";
    map_arr_fun        "float32_sinh"           "float" "sinh(a[gid])";
    map_arr_fun        "float32_cosh"           "float" "cosh(a[gid])";
    map_arr_fun        "float32_tanh"           "float" "tanh(a[gid])";
    map_arr_fun        "float32_asinh"          "float" "asinh(a[gid])";
    map_arr_fun        "float32_acosh"          "float" "acosh(a[gid])";
    map_arr_fun        "float32_atanh"          "float" "atanh(a[gid])";
    map_arr_fun        "float32_atanpi"         "float" "atanpi(a[gid])";
    map_arr_fun        "float32_sinpi"          "float" "sinpi(a[gid])";
    map_arr_fun        "float32_cospi"          "float" "cospi(a[gid])";
    map_arr_fun        "float32_tanpi"          "float" "tanpi(a[gid])";
    map_arr_fun        "float32_floor"          "float" "floor(a[gid])";
    map_arr_fun        "float32_ceil"           "float" "ceil(a[gid])";
    map_arr_fun        "float32_round"          "float" "round(a[gid])";
    map_arr_fun        "float32_exp"            "float" "exp(a[gid])";
    map_arr_fun        "float32_exp2"           "float" "exp2(a[gid])";
    map_arr_fun        "float32_exp10"          "float" "exp10(a[gid])";
    map_arr_fun        "float32_expm1"          "float" "expm1(a[gid])";
    map_arr_fun        "float32_log"            "float" "log(a[gid])";
    map_arr_fun        "float32_log2"           "float" "log2(a[gid])";
    map_arr_fun        "float32_log10"          "float" "log10(a[gid])";
    map_arr_fun        "float32_log1p"          "float" "log1p(a[gid])";
    map_arr_fun        "float32_logb"           "float" "logb(a[gid])";
    map_arr_fun        "float32_relu"           "float" "fmax(a[gid], 0)";
    map_arr_fun        "float32_signum"         "float" "(a[gid] > 0.) ? 1. : (a[gid] < 0.) ? -1. : 0.";
    map_arr_fun        "float32_sigmoid"        "float" "1. / (1. + exp(-a[gid]))";
    map_arr_fun        "float32_softplus"       "float" "log1p(exp(a[gid]))";
    map_arr_fun        "float32_softsign"       "float" "a[gid] / (1. + fabs(a[gid]))";
    map_arr_arr_fun    "float32_add"            "float" "a[gid] + b[gid]";
    map_arr_arr_fun    "float32_sub"            "float" "a[gid] - b[gid]";
    map_arr_arr_fun    "float32_mul"            "float" "a[gid] * b[gid]";
    map_arr_arr_fun    "float32_div"            "float" "a[gid] / b[gid]";
    map_arr_arr_fun    "float32_pow"            "float" "pow(a[gid], b[gid])";
    map_arr_arr_fun    "float32_min2"           "float" "fmin(a[gid], b[gid])";
    map_arr_arr_fun    "float32_max2"           "float" "fmax(a[gid], b[gid])";
    map_arr_arr_fun    "float32_fmod"           "float" "fmod(a[gid], b[gid])";
    map_arr_arr_fun    "float32_hypot"          "float" "hypot(a[gid], b[gid])";
    map_arr_arr_fun    "float32_atan2"          "float" "atan2(a[gid], b[gid])";
    map_arr_arr_fun    "float32_atan2pi"        "float" "atan2pi(a[gid], b[gid])";
    map_arr_scalar_fun "float32_add_scalar"     "float" "a[gid] + b";
    map_arr_scalar_fun "float32_sub_scalar"     "float" "a[gid] - b";
    map_arr_scalar_fun "float32_mul_scalar"     "float" "a[gid] * b";
    map_arr_scalar_fun "float32_div_scalar"     "float" "a[gid] / b";
    map_arr_scalar_fun "float32_pow_scalar"     "float" "pow(a[gid], b)";
    map_arr_scalar_fun "float32_fmod_scalar"    "float" "fmod(a[gid], b)";
    map_arr_scalar_fun "float32_atan2_scalar"   "float" "atan2(a[gid], b)";
    map_arr_scalar_fun "float32_atan2pi_scalar" "float" "atan2pi(a[gid], b)";
  ]


let code () =
  let fun_s = functions () |> List.fold_left ( ^ ) "" in
  let s = head_s ^ fun_s in
  (* FIXME: DEBUG *)
  print_endline s; flush_all ();
  s
