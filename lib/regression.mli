(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Regression module ]  *)

type dsmat = Dense.dsmat
type vector = Gsl.Vector.vector

val linear : ?i:bool -> dsmat -> dsmat -> dsmat

val polynomial : dsmat -> dsmat -> int -> dsmat

val exponential : dsmat -> dsmat -> dsmat

val nonlinear : (vector -> float -> float) -> float array -> dsmat -> dsmat -> dsmat
