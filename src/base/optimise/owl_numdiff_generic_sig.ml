(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numdiff: numerical differentiation module *)

open Owl_types


(** The functor used to generate Numdiff module of various precisions. *)

(* TODO: unit test *)

module type Sig = sig

  (** {6 Type definition} *)

  type arr
  (** General ndarray type *)

  type elt
  (** Scalar type *)


  (** {6 Basic functions} *)

  val diff : (elt -> elt) -> elt -> elt
  (** derivative of ``f : scalar -> scalar``. *)

  val diff' : (elt -> elt) -> elt -> elt * elt
  (** derivative of ``f : scalar -> scalar``, return both ``f x`` and ``f' x``. *)

  val diff2 : (elt -> elt) -> elt -> elt
  (** second order derivative of ``f : float -> float``. *)

  val diff2' : (elt -> elt) -> elt -> elt * elt
  (** second order derivative of ``f : float -> float``, return ``f x`` and ``f' x``. *)

  val grad : (arr -> elt) -> arr -> arr
  (** gradient of ``f : vector -> scalar``. *)

  val grad' : (arr -> elt) -> arr -> arr * arr
  (** gradient of ``f : vector -> scalar``, return ``f x`` and ``g x``. *)

  val jacobian : (arr -> arr) -> arr -> arr
  (** jacobian of ``f : vector -> vector``. *)

  val jacobian' : (arr -> arr) -> arr -> arr * arr
  (** jacobian of ``f : vector -> vector``, return ``f x`` and ``j x``. *)

  val jacobianT : (arr -> arr) -> arr -> arr
  (** transposed jacobian of ``f : vector -> vector``. *)

  val jacobianT' : (arr -> arr) -> arr -> arr * arr
  (** transposed jacobian of ``f : vector -> vector``, return ``f x`` and ``j x``. *)

end


(* This is a dumb module for checking the module signature. *)

module Impl (A : Ndarray_Numdiff with type elt = float) : Sig = Owl_numdiff_generic.Make (A)
