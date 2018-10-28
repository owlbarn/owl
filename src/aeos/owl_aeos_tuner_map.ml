(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl
open Bigarray

module N = Dense.Ndarray.S
module M = Dense.Matrix.S

(* C function interface *)

external baseline_float32_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_reci"

external baseline_float32_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_abs"

external baseline_float32_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_abs2"

external baseline_float32_signum : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_signum"

external baseline_float32_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_sqrt"

external baseline_float32_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_cbrt"

external baseline_float32_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_exp"

external baseline_float32_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_expm1"

external baseline_float32_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_log"

external baseline_float32_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_log1p"

external baseline_float32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sin"

external baseline_float32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_cos"

external baseline_float32_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_tan"

external baseline_float32_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_asin"

external baseline_float32_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_acos"

external baseline_float32_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_atan"

external baseline_float32_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sinh"

external baseline_float32_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_cosh"

external baseline_float32_tanh: int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_tanh"

external baseline_float32_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_asinh"

external baseline_float32_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_acosh"

external baseline_float32_atanh: int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_atanh"

external baseline_float32_erf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_erf"

external baseline_float32_erfc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_erfc"

external baseline_float32_logistic : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_logistic"

external baseline_float32_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_relu"

external baseline_float32_softplus : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_softplus"

external baseline_float32_softsign : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_softsign"

external baseline_float32_sigmoid : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_owl_sigmoid"

external baseline_float32_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_add"

external baseline_float32_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_div"

external baseline_float32_atan2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_atan2"

(* measurement method for arr -> arr type functions *)

let step_measure_map_unary xs f base_f msg =
  let n = Array.length xs in
  let y1 = Array.make n 0. in
  let y2 = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_map_unary f x) msg in
    let v2, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_map_unary base_f x) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y2 - y1)


let step_measure_map_binary xs f base_f msg =
  let n = Array.length xs in
  let y1 = Array.make n 0. in
  let y2 = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_map_binary f x) msg in
    let v2, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_map_binary base_f x) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y2 - y1)


(* Sin tuning module *)
module Sin = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "sin";
    param = "OWL_OMP_THRESHOLD_SIN";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_map 1000 1000 30;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sin Float32 in
    let f2 = baseline_float32_sin in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


(* Cos tuning module *)
module Cos = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "cos";
    param = "OWL_OMP_THRESHOLD_COS";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_map 1000 1000 30;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_cos Float32 in
    let f2 = baseline_float32_cos in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Add = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "add";
    param = "OWL_OMP_THRESHOLD_ADD";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_map 1000 20000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_add Float32 in
    let f2 = baseline_float32_add in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Div = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "div";
    param = "OWL_OMP_THRESHOLD_DIV";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_map 1000 20000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_div Float32 in
    let f2 = baseline_float32_div in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Atan2 = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "atan2";
    param = "OWL_OMP_THRESHOLD_ATAN2";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_map 1000 1000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_atan2 Float32 in
    let f2 = baseline_float32_atan2 in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end
