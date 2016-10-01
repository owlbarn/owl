(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Regression module provides basic functions to fit data into
  different models such as linear, polynomial, and exponential.
 *)

type dsmat = Dense.dsmat
type vector

val linear : ?i:bool -> dsmat -> dsmat -> dsmat
(** Linear regression:  *)

val polynomial : dsmat -> dsmat -> int -> dsmat
(** polynomial regression:  *)

val exponential : dsmat -> dsmat -> dsmat
(** Exponential regression:  *)

val nonlinear : (vector -> float -> float) -> float array -> dsmat -> dsmat -> dsmat
(** Nonlinear regression: *)


(* TODO: center the data, and unit variance *)
