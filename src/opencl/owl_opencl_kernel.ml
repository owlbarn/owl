(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_kernel_map


let functions () = [
    (* float32 functions *)
    map_arr_fun        "float32_sin" "float" "sin(a[gid])";
    map_arr_fun        "float32_cos" "float" "cos(a[gid])";
    map_arr_fun        "float32_tan" "float" "tan(a[gid])";
    map_arr_fun        "float32_asin" "float" "asin(a[gid])";
    map_arr_fun        "float32_acos" "float" "acos(a[gid])";
    map_arr_fun        "float32_atan" "float" "atan(a[gid])";
    map_arr_fun        "float32_sinh" "float" "sinh(a[gid])";
    map_arr_fun        "float32_cosh" "float" "cosh(a[gid])";
    map_arr_fun        "float32_tanh" "float" "tanh(a[gid])";
    map_arr_fun        "float32_asinh" "float" "asinh(a[gid])";
    map_arr_fun        "float32_acosh" "float" "acosh(a[gid])";
    map_arr_fun        "float32_atanh" "float" "atanh(a[gid])";
    map_arr_fun        "float32_floor" "float" "floor(a[gid])";
    map_arr_fun        "float32_ceil" "float" "ceil(a[gid])";
    map_arr_fun        "float32_round" "float" "round(a[gid])";
    map_arr_fun        "float32_exp" "float" "exp(a[gid])";
    map_arr_fun        "float32_exp2" "float" "exp2(a[gid])";
    map_arr_fun        "float32_exp10" "float" "exp10(a[gid])";
    map_arr_fun        "float32_expm1" "float" "expm1(a[gid])";
    map_arr_fun        "float32_log" "float" "log(a[gid])";
    map_arr_fun        "float32_log2" "float" "log2(a[gid])";
    map_arr_fun        "float32_log10" "float" "log10(a[gid])";
    map_arr_fun        "float32_log1p" "float" "log1p(a[gid])";
    map_arr_fun        "float32_lobb" "float" "logb(a[gid])";
    map_arr_arr_fun    "float32_add" "float" "a[gid] + b[gid]";
    map_arr_arr_fun    "float32_sub" "float" "a[gid] - b[gid]";
    map_arr_arr_fun    "float32_mul" "float" "a[gid] * b[gid]";
    map_arr_arr_fun    "float32_div" "float" "a[gid] / b[gid]";
    map_arr_scalar_fun "fun32_add_scalar" "float" "a[gid] + b";
    map_arr_scalar_fun "fun32_sub_scalar" "float" "a[gid] - b";
    map_arr_scalar_fun "fun32_mul_scalar" "float" "a[gid] * b";
    map_arr_scalar_fun "fun32_div_scalar" "float" "a[gid] / b";
  ]


let code () =
  let fun_s = functions () |> List.fold_left ( ^ ) "" in
  let s = Owl_opencl_kernel_common.code ^ fun_s in
  (* FIXME: DEBUG *)
  print_endline s; flush_all ();
  s
