(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_kernel_map


let head_s = "
  #pragma OPENCL EXTENSION cl_khr_fp64 : enable

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
    map_arr_arr_fun    "float32_equal"          "float" "a[gid] = b[gid]";
    map_arr_arr_fun    "float32_not_equal"      "float" "a[gid] != b[gid]";
    map_arr_scalar_fun "float32_add_scalar"     "float" "a[gid] + b";
    map_arr_scalar_fun "float32_sub_scalar"     "float" "a[gid] - b";
    map_arr_scalar_fun "float32_mul_scalar"     "float" "a[gid] * b";
    map_arr_scalar_fun "float32_div_scalar"     "float" "a[gid] / b";
    map_arr_scalar_fun "float32_pow_scalar"     "float" "pow(a[gid], b)";
    map_arr_scalar_fun "float32_fmod_scalar"    "float" "fmod(a[gid], b)";
    map_arr_scalar_fun "float32_atan2_scalar"   "float" "atan2(a[gid], b)";
    map_arr_scalar_fun "float32_atan2pi_scalar" "float" "atan2pi(a[gid], b)";
    map_arr_scalar_fun "float32_scalar_add"     "float" "b + a[gid]";
    map_arr_scalar_fun "float32_scalar_sub"     "float" "b - a[gid]";
    map_arr_scalar_fun "float32_scalar_mul"     "float" "b * a[gid]";
    map_arr_scalar_fun "float32_scalar_div"     "float" "b / a[gid]";
    map_arr_scalar_fun "float32_scalar_pow"     "float" "pow(b, a[gid])";
    map_arr_scalar_fun "float32_scalar_fmod"    "float" "fmod(b, a[gid])";
    map_arr_scalar_fun "float32_scalar_atan2"   "float" "atan2(b, a[gid])";
    map_arr_scalar_fun "float32_scalar_atan2pi" "float" "atan2pi(b, a[gid])";

    (* float64 functions *)
    (*
    map_arr_fun        "float64_erf"            "double" "erf(a[gid])";
    map_arr_fun        "float64_erfc"           "double" "erfc(a[gid])";
    map_arr_fun        "float64_abs"            "double" "fabs(a[gid])";
    map_arr_fun        "float64_neg"            "double" "-a[gid]";
    map_arr_fun        "float64_sqr"            "double" "a[gid] * a[gid]";
    map_arr_fun        "float64_sqrt"           "double" "sqrt(a[gid])";
    map_arr_fun        "float64_rsqrt"          "double" "rsqrt(a[gid])";
    map_arr_fun        "float64_cbrt"           "double" "cbrt(a[gid])";
    map_arr_fun        "float64_reci"           "double" "1. / a[gid]";
    map_arr_fun        "float64_sin"            "double" "sin(a[gid])";
    map_arr_fun        "float64_cos"            "double" "cos(a[gid])";
    map_arr_fun        "float64_tan"            "double" "tan(a[gid])";
    map_arr_fun        "float64_asin"           "double" "asin(a[gid])";
    map_arr_fun        "float64_acos"           "double" "acos(a[gid])";
    map_arr_fun        "float64_atan"           "double" "atan(a[gid])";
    map_arr_fun        "float64_sinh"           "double" "sinh(a[gid])";
    map_arr_fun        "float64_cosh"           "double" "cosh(a[gid])";
    map_arr_fun        "float64_tanh"           "double" "tanh(a[gid])";
    map_arr_fun        "float64_asinh"          "double" "asinh(a[gid])";
    map_arr_fun        "float64_acosh"          "double" "acosh(a[gid])";
    map_arr_fun        "float64_atanh"          "double" "atanh(a[gid])";
    map_arr_fun        "float64_atanpi"         "double" "atanpi(a[gid])";
    map_arr_fun        "float64_sinpi"          "double" "sinpi(a[gid])";
    map_arr_fun        "float64_cospi"          "double" "cospi(a[gid])";
    map_arr_fun        "float64_tanpi"          "double" "tanpi(a[gid])";
    map_arr_fun        "float64_floor"          "double" "floor(a[gid])";
    map_arr_fun        "float64_ceil"           "double" "ceil(a[gid])";
    map_arr_fun        "float64_round"          "double" "round(a[gid])";
    map_arr_fun        "float64_exp"            "double" "exp(a[gid])";
    map_arr_fun        "float64_exp2"           "double" "exp2(a[gid])";
    map_arr_fun        "float64_exp10"          "double" "exp10(a[gid])";
    map_arr_fun        "float64_expm1"          "double" "expm1(a[gid])";
    map_arr_fun        "float64_log"            "double" "log(a[gid])";
    map_arr_fun        "float64_log2"           "double" "log2(a[gid])";
    map_arr_fun        "float64_log10"          "double" "log10(a[gid])";
    map_arr_fun        "float64_log1p"          "double" "log1p(a[gid])";
    map_arr_fun        "float64_logb"           "double" "logb(a[gid])";
    map_arr_fun        "float64_relu"           "double" "fmax(a[gid], 0)";
    map_arr_fun        "float64_signum"         "double" "(a[gid] > 0.) ? 1. : (a[gid] < 0.) ? -1. : 0.";
    map_arr_fun        "float64_sigmoid"        "double" "1. / (1. + exp(-a[gid]))";
    map_arr_fun        "float64_softplus"       "double" "log1p(exp(a[gid]))";
    map_arr_fun        "float64_softsign"       "double" "a[gid] / (1. + fabs(a[gid]))";
    map_arr_arr_fun    "float64_add"            "double" "a[gid] + b[gid]";
    map_arr_arr_fun    "float64_sub"            "double" "a[gid] - b[gid]";
    map_arr_arr_fun    "float64_mul"            "double" "a[gid] * b[gid]";
    map_arr_arr_fun    "float64_div"            "double" "a[gid] / b[gid]";
    map_arr_arr_fun    "float64_pow"            "double" "pow(a[gid], b[gid])";
    map_arr_arr_fun    "float64_min2"           "double" "fmin(a[gid], b[gid])";
    map_arr_arr_fun    "float64_max2"           "double" "fmax(a[gid], b[gid])";
    map_arr_arr_fun    "float64_fmod"           "double" "fmod(a[gid], b[gid])";
    map_arr_arr_fun    "float64_hypot"          "double" "hypot(a[gid], b[gid])";
    map_arr_arr_fun    "float64_atan2"          "double" "atan2(a[gid], b[gid])";
    map_arr_arr_fun    "float64_atan2pi"        "double" "atan2pi(a[gid], b[gid])";
    map_arr_arr_fun    "float64_equal"          "double" "a[gid] = b[gid]";
    map_arr_arr_fun    "float64_not_equal"      "double" "a[gid] != b[gid]";
    map_arr_scalar_fun "float64_add_scalar"     "double" "a[gid] + b";
    map_arr_scalar_fun "float64_sub_scalar"     "double" "a[gid] - b";
    map_arr_scalar_fun "float64_mul_scalar"     "double" "a[gid] * b";
    map_arr_scalar_fun "float64_div_scalar"     "double" "a[gid] / b";
    map_arr_scalar_fun "float64_pow_scalar"     "double" "pow(a[gid], b)";
    map_arr_scalar_fun "float64_fmod_scalar"    "double" "fmod(a[gid], b)";
    map_arr_scalar_fun "float64_atan2_scalar"   "double" "atan2(a[gid], b)";
    map_arr_scalar_fun "float64_atan2pi_scalar" "double" "atan2pi(a[gid], b)";
    *)

    (* TODO: complex32 functions *)
    (* TODO: int32 functions *)
    (* TODO: int64 functions *)
  ]


let code () =
  let fun_s = functions () |> List.fold_left ( ^ ) "" in
  head_s ^ fun_s


(* ends here *)
