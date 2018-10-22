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

external baseline_float32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sin"

let baseline_sin : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> baseline_float32_sin l x y
  | _         -> failwith "sin_baseline: unsupported operation"

(* measurement method for arr -> arr type functions *)

let step_measure xs base_f f msg =
  let n = Array.length xs in
  let y1  = Array.make n 0. in
  let y2  = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_single_op f x) msg in
    let v2, _ = Owl_aeos_utils.timing
      (Owl_aeos_utils.eval_single_op base_f x) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;
  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y1 - y2)

(* utils function *)

let make_step_array start step n =
  let x = Array.make n 0 in
  for i = 0 to n - 1 do
    x.(i) <- start + i * step
  done;
  x

let array_to_mat a =
  let a = Array.map float_of_int a in
  M.of_array a (Array.length a) 1


(* Sin tuning module *)
module Sin = struct

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
  }

  let make () = {
    c_macro = "OWL_OMP_THRESHOLD_SIN"; (* [| OWL_OMP_THRESHOLD_SIN |] *)
    params  = max_int;
    x = make_step_array 1000 10000 50
  }

  let tune t =
    Owl_log.info "AEOS: tune sin ...";
    let y = step_measure t.x Owl_ndarray._owl_sin baseline_sin "sin" in
    let x = array_to_mat t.x in
    t.params <- Owl_aeos_utils.regression ~p:true x y;
    ()

  let to_string t =
    Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)

end


type tuner =
  | Sin of Sin.t


let tuning = function
  | Sin x -> Sin.tune x
