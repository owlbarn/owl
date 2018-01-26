(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make
  (A : Ndarray_Basic)
  : sig

  type arr = A.arr
  type elt = A.elt


  val ols : ?i:bool -> arr -> arr -> arr array
  (** [] *)

  val ridge : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (** [] *)

  val lasso : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (** [] *)

  val elastic_net : ?i:bool -> ?alpha:float -> ?l1_ratio:float -> arr -> arr -> arr array
  (** [] *)

  val svm : ?i:bool -> ?a:float -> arr -> arr -> arr array
  (** [] *)

  val logistic : ?i:bool -> arr -> arr -> arr array
  (** [] *)

  val exponential : ?i:bool -> arr -> arr -> elt * elt * elt
  (** [] *)

  val poly : arr -> arr -> int -> arr
  (** [] *)


end
