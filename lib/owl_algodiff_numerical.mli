(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numerical differentiation module
  This module provides APIs for performing numerical differentiation of any
  user defined functions. The module is part of Algodiff module, and only
  supports float numbers at the moment.

  Numerical differentiation is subject to truncation error and round-off error.
  If you need more precise results, please consider to use Algodiff.AD module
  for algorithmic differentiation.
 *)

type mat = Owl_dense_real.mat
type vec = Owl_dense_vector_d.vec

(** {6 Core APIs of differentiation} *)

val diff : (float -> float) -> (float -> float)
(** [diff f x] returns the numrical derivative of a function [f : float -> float]
  at point [x]. Simply calling [diff f] will return its derivative function [g]
  of the same type, i.e. [g : float -> float].

  Keep calling this function will give you higher-order derivatives of [f], i.e.
  [f |> diff |> diff |> diff |> ...]. However, the error grows quickly due to
  the numerical method of differentiation.
 *)

val diff2 : (float -> float) -> (float -> float)
(** [diff2 f x] returns second-order derivative of [f : float -> float] at [x]. *)

val grad : (vec -> float) -> (vec -> vec)
(** [grad f x] returns the gradient of [f] at point [x]. Note the type of the
  function is [f : mat -> float], i.e. [f] takes an one-row matrix as input and
  outputs a float scalar. An exception will be raised if the passed in paramter
  is not an one-row matrix.
 *)

val jacobian : (vec -> vec) -> (vec -> mat)
(** [jacobian f x] returns the jacobian of [f] at point [x]. Again, the [mat]
  type here refers to one-row matrix. I am still thinking maybe it is necessary
  to introduce vector as a separate type in Owl? Currently, the returned result
  uses numerator-layout. I.e., if [x] is n-dimensional and [f x] is y-dimensional,
  then the returned jacobian is an [m x n] matrix.
 *)

val jacobianT : (vec -> vec) -> (vec -> mat)
(** [jacobianT f] returns the transposed jacobian of [f] at point [x]. *)


(** {6 Enhanced APIs with more returned information} *)

val diff' : (float -> float) -> float -> float * float
(** [diff' f x] is similar to [diff] but also returns the function value [f x]. *)

val diff2' : (float -> float) -> float -> float * float
(** [diff2' f x] is similar to [diff2] but also returns the function value [f x]. *)

val grad' : (vec -> float) -> vec -> vec * vec
(** [grad' f x] is similar to [grad] but also returns the function value [f x]. *)

val jacobian' : (vec -> vec) -> vec -> vec * mat
(** [jacobian' f x] is similar to [jacobian] but also returns the function value [f x]. *)

val jacobianT' : (vec -> vec) -> vec -> vec * mat
(** [jacobianT' f x] is similar to [jacobianT] but also returns the function value [f x]. *)
