(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Regression module

  The module provides basic functions to fit data into
  different models such as linear, polynomial, and exponential.
 *)

type dsmat = Owl_dense_real.mat
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
(** Exponential regression: [exponential x y] fits the measurements [x] and the
  observations [y] into a exponential model: [ y = a * exp^(-lambda * x) + b ].
  Both [x] and [y] are [m] by [1] matrices. The returned result is a matrix of
  three model parameters [\[a, lambda, b\]].
 *)

val nonlinear : (vector -> float -> float) -> float array -> dsmat -> dsmat -> dsmat
(** Nonlinear regression: [nonlinear f p x y] fits the measurements [x] and the
  observations [y] into a user-defined nonlinear model. Both [x] and [y] are
  [m] x [1] matrices; [p] is the initial guess of the parameters, [f] is the
  user-defined function, its first parameter is the parameter array, and the
  second is the variable.

  E.g., if we want to fit [x] and [y] using [ y = a *. (log x) +. b ] model, we
  first define the function [f] as

  [ let f p x = p.{0} *. (log x) + p.{1} ]

  where [p.{0}] represents [a] and [p.{1}] represents [b]. Then we also need to make
  an initial guess of the parameters (i.e., [a] and [b]) by defining

  [let p = \[0.1; 0.1\]].

  Finally, we can perform the nonlinear regression by calling [nonlinear f p x y].
 *)

val ols : ?i:bool -> dsmat -> dsmat -> dsmat
(** Ordinary Least Square regression: in [ols ~i x y], [i] : whether or not to
  include intercept bias in parameters, the default is [true]; ; [x] is the
  measurements, and [y] is the observations. THe return is the model.
 *)

val ridge : ?i:bool -> ?a:float -> dsmat -> dsmat -> dsmat
(** Ridge regression: in [ridge ~i ~a x y], [i] : whether or not to include
  intercept bias in parameters, the default is [true]; [a] : the weight on the
  regularisation term; [x] is the measurements, and [y] is the observations.
  The return is the model.
 *)

val lasso : ?i:bool -> ?a:float -> dsmat -> dsmat -> dsmat
(** LASSO regression: in [lasso ~i ~a x y], [i] : whether or not to include
  intercept bias in parameters, the default is [true]; [a] : the weight on the
  regularisation term; [x] is the measurements, and [y] is the observations.
  The return is the model.
 *)

val logistic : ?i:bool -> dsmat -> dsmat -> dsmat
(** Logistic regression: in [logistic ~i x y], [i] : whether or not to include
  intercept bias in parameters, the default is [true]; ; [x] is the
  measurements, and [y] is the observations.

  Note that the values in [y] are either [+1] or [0]. The return is the model.
 *)

val svm : ?i:bool -> dsmat -> dsmat -> dsmat -> dsmat
(** Support Vector Machine regression: in [svm ~i p x y], [i] : whether or not
  to include intercept bias in parameters, the default is [true]; [p] : the
  initial guess of the model; [x] is the measurements, and [y] is the observations.

  Note that the values in [y] are either [+1] or [-1].
 *)

val kmeans : dsmat -> int -> dsmat * int array
(** K-means clustering: [kmeans x c] divides [x] which is a row-based matrix
  into [c] clusters. The return is [(y,a)] where [y] is the model and [a] is
  the membership list of all nodes in [x].
 *)


(* TODO: center the data, and unit variance *)
