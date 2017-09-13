(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make
  (M : MatrixSig)
  (A : NdarraySig with type elt = M.elt and type arr = M.mat)
  : sig

  type arr = A.arr
  type mat = M.mat
  type elt = M.elt


  val ols : ?i:bool -> mat -> mat -> mat array
  (** [] *)

  val ridge : ?i:bool -> ?a:float -> mat -> mat -> mat array
  (** [] *)

  val lasso : ?i:bool -> ?a:float -> mat -> mat -> mat array
  (** [] *)

  val svm : ?i:bool -> ?a:float -> mat -> mat -> mat array
  (** [] *)

  val logistic : ?i:bool -> mat -> mat -> mat array
  (** [] *)

  val exponential : ?i:bool -> mat -> mat -> elt * elt * elt
  (** [] *)

  val poly : mat -> mat -> int -> mat
  (** [] *)


end
