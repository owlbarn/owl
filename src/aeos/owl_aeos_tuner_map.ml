(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl
open Owl_aeos_types
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
    mutable name    : string;
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : fun_map1 array
  }

  let make () = {
    name = "sin";
    c_macro = "OWL_OMP_THRESHOLD_SIN";
    params  = max_int;
    x = Owl_aeos_utils.generate_sizes_map 1000 1000 50;
    fs = [| (Owl_ndarray._owl_sin Float32); baseline_float32_sin |]
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let y = step_measure_map_unary t.x t.fs.(0) t.fs.(1) t.name in
    let x = Owl_aeos_utils.size2mat_map t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:t.name x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


(* Cos tuning module *)
module Cos = struct

  type t = {
    mutable name    : string;
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : fun_map1 array
  }

  let make () = {
    name = "cos";
    c_macro = "OWL_OMP_THRESHOLD_COS";
    params = max_int;
    x = Owl_aeos_utils.generate_sizes_map 1000 1000 50;
    fs = [| (Owl_ndarray._owl_cos Float32); baseline_float32_cos |]
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let y = step_measure_map_unary t.x t.fs.(0) t.fs.(1) t.name in
    let x = Owl_aeos_utils.size2mat_map t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:t.name x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end

(* Add tuning module *)
module Add = struct

  type t = {
    mutable name    : string;
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : fun_map2 array
  }

  let make () = {
    name = "add";
    c_macro = "OWL_OMP_THRESHOLD_ADD";
    params  = max_int;
    x = Owl_aeos_utils.generate_sizes_map 1000 20000 50;
    fs = [| (Owl_ndarray._owl_add Float32); baseline_float32_add |]
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let y = step_measure_map_binary t.x t.fs.(0) t.fs.(1) t.name in
    let x = Owl_aeos_utils.size2mat_map t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:t.name x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


module Div = struct

  type t = {
    mutable name    : string;
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : fun_map2 array
  }

  let make () = {
    name = "div";
    c_macro = "OWL_OMP_THRESHOLD_DIV";
    params  = max_int;
    x = Owl_aeos_utils.generate_sizes_map 1000 20000 50;
    fs = [| (Owl_ndarray._owl_div Float32); baseline_float32_div |]
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let y = step_measure_map_binary t.x t.fs.(0) t.fs.(1) t.name in
    let x = Owl_aeos_utils.size2mat_map t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:t.name x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


module Atan2 = struct

  type t = {
    mutable name    : string;
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : fun_map2 array
  }

  let make () = {
    name = "atan2";
    c_macro = "OWL_OMP_THRESHOLD_ATAN2";
    params  = max_int;
    x = Owl_aeos_utils.generate_sizes_map 1000 1000 50;
    fs = [|(Owl_ndarray._owl_atan2 Float32); baseline_float32_atan2|]
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let y = step_measure_map_binary t.x t.fs.(0) t.fs.(1) t.name in
    let x = Owl_aeos_utils.size2mat_map t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:t.name x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end
