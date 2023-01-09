(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Sig = sig
  module A : Owl_types_ndarray_mutable.Sig

  (** {5 Type definition} *)

  type device
  (** TODO *)

  type value
  (** TODO *)

  (** {5 Core functions} *)

  val make_device : unit -> device
  (** TODO *)

  val arr_to_value : A.arr -> value
  (** TODO *)

  val value_to_arr : value -> A.arr
  (** TODO *)

  val elt_to_value : A.elt -> value
  (** TODO *)

  val value_to_elt : value -> A.elt
  (** TODO *)

  val value_to_float : value -> float
  (** TODO *)

  val is_arr : value -> bool
  (** TODO *)

  val is_elt : value -> bool
  (** TODO *)
end
