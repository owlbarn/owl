(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl
open Owl_core_types
open Bigarray

module N = Dense.Ndarray.S
module M = Dense.Matrix.S

(* C function interface *)

external baseline_float32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_sin"

external baseline_float32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_cos"

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
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op09 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_SIN";
    params  = max_int;
    x = Owl_aeos_utils.make_step_array 1000 1000 50;
    fs = [| (Owl_ndarray._owl_sin Float32); baseline_float32_sin |]
  }

  let tune t =
    let op = "sin" in
    Owl_log.info "AEOS: tune %s ..." op;
    let y = step_measure_map_unary t.x t.fs.(0) t.fs.(1) op in
    let x = Owl_aeos_utils.array_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:op x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


(* Cos tuning module *)
module Cos = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op09 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_COS";
    params  = max_int;
    x = Owl_aeos_utils.make_step_array 1000 1000 60;
    fs = [| (Owl_ndarray._owl_cos Float32); baseline_float32_cos |]
  }

  let tune t =
    let op = "cos" in
    Owl_log.info "AEOS: tune %s ..." op;
    let y = step_measure_map_unary t.x t.fs.(0) t.fs.(1) op in
    let x = Owl_aeos_utils.array_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:op x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end

(* Add tuning module *)
module Add = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op03 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_ADD";
    params  = max_int;
    x = Owl_aeos_utils.make_step_array 1000 20000 50;
    fs = [| (Owl_ndarray._owl_add Float32); baseline_float32_add |]
  }

  let tune t =
    let op = "add" in
    Owl_log.info "AEOS: tune %s ..." op;
    let y = step_measure_map_binary t.x t.fs.(0) t.fs.(1) op in
    let x = Owl_aeos_utils.array_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:op x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


module Div = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op03 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_DIV";
    params  = max_int;
    x = Owl_aeos_utils.make_step_array 1000 20000 50;
    fs = [| (Owl_ndarray._owl_div Float32); baseline_float32_div |]
  }

  let tune t =
    let op = "div" in
    Owl_log.info "AEOS: tune %s ..." op;
    let y = step_measure_map_binary t.x t.fs.(0) t.fs.(1) op in
    let x = Owl_aeos_utils.array_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:op x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


module Atan2 = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op03 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_ATAN2";
    params  = max_int;
    x = Owl_aeos_utils.make_step_array 1000 1000 50;
    fs = [| (Owl_ndarray._owl_atan2 Float32); baseline_float32_atan2 |]
  }

  let tune t =
    let op = "atan2" in
    Owl_log.info "AEOS: tune %s ..." op;
    let y = step_measure_map_binary t.x t.fs.(0) t.fs.(1) op in
    let x = Owl_aeos_utils.array_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true ~m:op x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end
