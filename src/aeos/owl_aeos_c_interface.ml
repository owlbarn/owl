(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_types

(* Unary Map *)

external baseline_float32_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_reci"

external baseline_float32_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_abs"

external baseline_float32_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_abs2"

external baseline_float32_signum : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_signum"

external baseline_float32_sqr : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sqr"

external baseline_float32_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sqrt"

external baseline_float32_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_cbrt"

external baseline_float32_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_exp"

external baseline_float32_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_expm1"

external baseline_float32_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_log"

external baseline_float32_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_log1p"

external baseline_float32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sin"

external baseline_float32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_cos"

external baseline_float32_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_tan"

external baseline_float32_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_asin"

external baseline_float32_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_acos"

external baseline_float32_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_atan"

external baseline_float32_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sinh"

external baseline_float32_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_cosh"

external baseline_float32_tanh: int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_tanh"

external baseline_float32_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_asinh"

external baseline_float32_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_acosh"

external baseline_float32_atanh: int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_atanh"

external baseline_float32_erf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_erf"

external baseline_float32_erfc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_erfc"

external baseline_float32_logistic : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_logistic"

external baseline_float32_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_relu"

external baseline_float32_softplus : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_softplus"

external baseline_float32_softsign : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_softsign"

external baseline_float32_sigmoid : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sigmoid"

external openmp_float32_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_reci"

external openmp_float32_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_abs"

external openmp_float32_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_abs2"

external openmp_float32_signum : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_signum"

external openmp_float32_sqr : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_sqr"

external openmp_float32_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_sqrt"

external openmp_float32_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_cbrt"

external openmp_float32_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_exp"

external openmp_float32_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_expm1"

external openmp_float32_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_log"

external openmp_float32_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_log1p"

external openmp_float32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_sin"

external openmp_float32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_cos"

external openmp_float32_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_tan"

external openmp_float32_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_asin"

external openmp_float32_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_acos"

external openmp_float32_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_atan"

external openmp_float32_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_sinh"

external openmp_float32_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_cosh"

external openmp_float32_tanh: int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_tanh"

external openmp_float32_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_asinh"

external openmp_float32_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_acosh"

external openmp_float32_atanh: int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_atanh"

external openmp_float32_erf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_erf"

external openmp_float32_erfc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_erfc"

external openmp_float32_logistic : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_logistic"

external openmp_float32_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_relu"

external openmp_float32_softplus : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_softplus"

external openmp_float32_softsign : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_softsign"

external openmp_float32_sigmoid : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_sigmoid"

(* Binary Map *)

external baseline_float32_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_elt_equal"

external baseline_float32_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_add"

external baseline_float32_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_mul"

external baseline_float32_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_div"

external baseline_float32_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_pow"

external baseline_float32_hypot : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_hypot"

external baseline_float32_atan2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_atan2"

external baseline_float32_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_max2"

external baseline_float32_fmod : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_fmod"

external openmp_float32_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_elt_equal"

external openmp_float32_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_add"

external openmp_float32_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_mul"

external openmp_float32_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_div"

external openmp_float32_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_pow"

external openmp_float32_hypot : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_hypot"

external openmp_float32_atan2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_atan2"

external openmp_float32_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_max2"

external openmp_float32_fmod : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "omp_float32_fmod"


(* Accumulate *)

external _baseline_float32_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_cumsum" "bl_float32_cumsum_impl"

external _baseline_float32_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_cumprod" "bl_float32_cumprod_impl"

external _baseline_float32_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_cummax" "bl_float32_cummax_impl"

external _baseline_float32_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_repeat" "bl_float32_repeat_impl"

external _baseline_float32_diff : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_diff" "bl_float32_diff_impl"


external _baseline_float32_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_cumsum" "bl_float32_cumsum_impl"

external _baseline_float32_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_cumprod" "bl_float32_cumprod_impl"

external _baseline_float32_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_cummax" "bl_float32_cummax_impl"

external _baseline_float32_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_repeat" "bl_float32_repeat_impl"

external _baseline_float32_diff : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "bl_float32_diff" "bl_float32_diff_impl"

external _openmp_float32_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "omp_float32_cumsum" "omp_float32_cumsum_impl"

external _openmp_float32_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "omp_float32_cumprod" "omp_float32_cumprod_impl"

external _openmp_float32_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "omp_float32_cummax" "omp_float32_cummax_impl"

external _openmp_float32_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "omp_float32_repeat" "omp_float32_repeat_impl"

external _openmp_float32_diff : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "omp_float32_diff" "omp_float32_diff_impl"


let cumulative_op ?(axis=(-1)) cumop x y =
  let d = Owl_aeos_utils.num_dims x in
  let a = Owl_aeos_utils.adjust_index axis d in
  let stride = Owl_aeos_utils.strides x in
  let slicez = Owl_aeos_utils.slice_size x in
  let m = (Owl_aeos_utils.numel x) / slicez.(a) in
  let n = slicez.(a) - stride.(a) in
  let incx_m = slicez.(a) in
  let incx_n = 1 in
  let incy_m = slicez.(a) in
  let incy_n = 1 in
  let ofsx = 0 in
  let ofsy = stride.(a) in
  cumop m n x ofsx incx_m incx_n y ofsy incy_m incy_n

let cumulative_wrapper cumop ~axis x =
  let shp = Owl_aeos_utils.shape x in
  let y = Owl_aeos_utils.ones shp in
  cumulative_op ~axis cumop x y;
  y

let baseline_cumsum  = cumulative_wrapper _baseline_float32_cumsum
let baseline_cumprod = cumulative_wrapper _baseline_float32_cumprod
let baseline_cummax  = cumulative_wrapper _baseline_float32_cummax
let baseline_repeat  = cumulative_wrapper _baseline_float32_repeat
let baseline_diff    = cumulative_wrapper _baseline_float32_diff

let openmp_cumsum  = cumulative_wrapper _openmp_float32_cumsum
let openmp_cumprod = cumulative_wrapper _openmp_float32_cumprod
let openmp_cummax  = cumulative_wrapper _openmp_float32_cummax
let openmp_repeat  = cumulative_wrapper _openmp_float32_repeat
let openmp_diff    = cumulative_wrapper _openmp_float32_diff
