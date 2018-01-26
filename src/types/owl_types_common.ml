(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* type of slice definition *)

type index =
  | I of int       (* single index *)
  | L of int list  (* list of indices *)
  | R of int list  (* index range *)

type slice = index list

(* type of slice definition for internal use in owl_slicing module *)

type index_ =
  | I_ of int
  | L_ of int array
  | R_ of int array

type slice_ = index_ array

(* type of padding in conv?d and maxpool operations *)

type padding = SAME | VALID
