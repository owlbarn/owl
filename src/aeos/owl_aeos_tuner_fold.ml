open Owl
open Owl_core_types
open Bigarray

module N = Dense.Ndarray.S
module M = Dense.Matrix.S

(* C function interface *)

external baseline_float32_sum : int -> ('a, 'b) owl_arr -> 'a = "bl_float32_sum"

external baseline_float32_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "bl_float32_prod_along"


let step_measure_fold xs base_f f msg =
  let n   = Array.length xs in
  let y1  = Array.make n 0. in
  let y2  = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_fold f x) msg in
    let v2, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_fold base_f x) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y1 - y2)


let step_measure_fold_along xs a base_f f msg =
  let n   = Array.length xs in
  let y1  = Array.make n 0. in
  let y2  = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_fold_along f x a) msg in
    let v2, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_fold_along base_f x a) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y1 - y2)


(* Sum tuning module *)
module Sum = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op04 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_SUM";
    params  = max_int;
    x = Owl_aeos_utils.make_step_fold 10 5 10;
    fs = [| (Owl_ndarray._owl_sum Float32); baseline_float32_sum |]
  }

  let tune t =
    Owl_log.info "AEOS: tune sum ...";
    let y = step_measure_fold t.x t.fs.(0) t.fs.(1) "sum" in
    let x = Owl_aeos_utils.fold_arr_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


module Prod_along = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array array;
    mutable fs      : (float, float32_elt) Owl_core_types.owl_arr_op21 array
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_PROD_ALONG";
    params  = max_int;
    x = Owl_aeos_utils.make_step_fold 10 5 10;
    fs = [| (Owl_ndarray._owl_prod_along Float32); baseline_float32_prod_along |]
  }

  let tune t =
    Owl_log.info "AEOS: tune prod_along ...";
    let y = step_measure_fold_along t.x 0 t.fs.(0) t.fs.(1) "prod_along" in
    let x = Owl_aeos_utils.fold_arr_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end
