(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(* return [0, n - 1] *)
let uniform_int_rvs n = Random.int n

let std_uniform_rvs () = Random.float 1.

let uniform_rvs ~a ~b = a +. ((b -. a) *. Random.float 1.)

(* The constants below are Printf.printf "%h,%h" (Float.succ 0.) (Float.pred 1.)
  Also [Float.succ 0. +. Float.pred 1. < 1.]
 *)
let rand01_exclusive () = 0x0.0000000000001p-1022 +. Random.float 0x1.fffffffffffffp-1
