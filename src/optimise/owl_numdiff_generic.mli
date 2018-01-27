(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numdiff: numerical differentiation module *)

open Owl_types


(** The functor used to generate Numdiff module of various precisions. *)

module Make
  (A : Ndarray_Algodiff)
  : sig

  type arr = A.arr
  type elt = A.elt


end
