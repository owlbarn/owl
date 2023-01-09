(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(* basic number type *)

type number =
  | F32 (* single precision float number *)
  | F64 (* double precision float number *)
  | C32 (* single precision complex number *)
  | C64

(* double precision complex number *)

(* basic ndarray type *)

type ('a, 'b) owl_arr = ('a, 'b, Bigarray.c_layout) Bigarray.Genarray.t

(* type of slice definition *)

type index =
  | I of int (* single index *)
  | L of int list (* list of indices *)
  | R of int list

(* index range *)

type slice = index list

(* type of slice definition for internal use in owl_slicing module *)

type index_ =
  | I_ of int
  | L_ of int array
  | R_ of int array

type slice_ = index_ array

(* type of padding in conv?d and maxpool operations *)

type padding =
  | SAME
  | VALID

(* type of various computation devices *)

type device_type =
  | CPU
  | OpenCL
  | CUDA
