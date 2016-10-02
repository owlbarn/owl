(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Regression module provides basic functions to fit data into
  different models such as linear, polynomial, and exponential.
 *)

type dsmat = Dense.dsmat
type vector = Gsl.Vector.vector

val linear : ?i:bool -> dsmat -> dsmat -> dsmat
(** Linear regression: [linear ~i x y] fits the measurements [x] and the
  observations [y] into a linear model. [x] is a [m] by [n] row-based matrix
  and each row represents one measurement. [y] is a [m] by [1] matrix and each
  number is an observation. The parameters will be returned as a column vector.
  [~i] indicates wether to include intercept, the default value is [false]. The
  intercept will be the first elelment in the returned parameters.
 *)

val polynomial : dsmat -> dsmat -> int -> dsmat
(** polynomial regression:  [polynomial x y d] fits the measurements [x] and the
  observations [y] into a polynomial model. Both [x] and [y] are [m] by [1]
  matrices. Parameter [d] specifies the highest degree of the polynomial model.
  The function returns a [(d+1)] by [1] matrix where the first element is the
  intercept and the rest are the corresponding coefficients of each degree from
  [1] to [d].
 *)

val exponential : dsmat -> dsmat -> dsmat
(** Exponential regression:  *)

val nonlinear : (vector -> float -> float) -> float array -> dsmat -> dsmat -> dsmat
(** Nonlinear regression: *)

(* TODO: center the data, and unit variance *)
