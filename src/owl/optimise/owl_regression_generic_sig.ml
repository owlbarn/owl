(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module type Sig = sig

  module Optimise : Owl_optimise_generic_sig.Sig

  open Optimise.Algodiff


  (** {6 Type definition} *)

  type arr = A.arr
  (** Type of ndarray values. *)

  type elt = A.elt
  (** Type of scalar values. *)


  (** {6 Regression models} *)

  val ols : ?i:bool -> arr -> arr -> arr array
  (** TODO *)

  val ridge : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (** TODO *)

  val lasso : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (** TODO *)

  val elastic_net : ?i:bool -> ?alpha:float -> ?l1_ratio:float -> arr -> arr -> arr array
  (** TODO *)

  val svm : ?i:bool -> ?a:float -> arr -> arr -> arr array
  (** TODO *)

  val logistic : ?i:bool -> arr -> arr -> arr array
  (** TODO *)

  val exponential : ?i:bool -> arr -> arr -> elt * elt * elt
  (** TODO *)

  val poly : arr -> arr -> int -> arr
  (** TODO *)


end
