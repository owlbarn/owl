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
      (Owl_aeos_utils.eval_fold base_f x) (msg ^ "-bm") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y2 - y1)


let step_measure_fold_along xs a base_f f msg =
  let n   = Array.length xs in
  let y1  = Array.make n 0. in
  let y2  = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_fold_along f x a) msg in
    let v2, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_fold_along base_f x a) (msg ^ "-bm") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y2 - y1)


module Sum = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "sum";
    param = "OWL_OMP_THRESHOLD_SUM";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sum Float32 in
    let f2 = baseline_float32_sum in
    t.y <- step_measure_fold t.input f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_fold t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_fold t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Prod_along = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "sum";
    param = "OWL_OMP_THRESHOLD_SUM";
    value = max_int;
    input = Owl_aeos_utils.generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_prod_along Float32 in
    let f2 = baseline_float32_prod_along in
    t.y <- step_measure_fold_along t.input 0 f1 f2 t.name;
    let x = Owl_aeos_utils.size2mat_fold t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = Owl_aeos_utils.size2mat_fold t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end
