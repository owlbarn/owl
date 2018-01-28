(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numdiff: numerical differentiation module *)

open Owl_types


(** The functor used to generate Numdiff module of various precisions. *)

(* TODO: unit test *)

module Make
  (A : Ndarray_Numdiff)
  : sig

  type arr = A.arr
  type elt = A.elt

  val diff : (elt -> elt) -> elt -> elt
  (** derivative of [f : scalar -> scalar]. *)

  val diff' : (elt -> elt) -> elt -> elt * elt
  (** derivative of [f : scalar -> scalar], return both [f x] and [f' x]. *)

  val diff2 : (elt -> elt) -> elt -> elt
  (** second order derivative of [f : float -> float]. *)

  val diff2' : (elt -> elt) -> elt -> elt * elt
  (** second order derivative of [f : float -> float], return [f x] and [f' x]. *)

  val grad : (arr -> elt) -> arr -> arr
  (** gradient of [f : vector -> scalar]. *)

  val grad' : (arr -> elt) -> arr -> arr * arr
  (** gradient of [f : vector -> scalar], return [f x] and [g x]. *)

  val jacobian : (arr -> arr) -> arr -> arr
  (** jacobian of [f : vector -> vector]. *)

  val jacobian' : (arr -> arr) -> arr -> arr * arr
  (** jacobian of [f : vector -> vector], return [f x] and [j x]. *)

  val jacobianT : (arr -> arr) -> arr -> arr
  (** transposed jacobian of [f : vector -> vector]. *)

  val jacobianT' : (arr -> arr) -> arr -> arr * arr
  (** transposed jacobian of [f : vector -> vector], return [f x] and [j x]. *)

end
