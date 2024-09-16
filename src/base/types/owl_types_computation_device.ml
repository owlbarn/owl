(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Sig = sig
  module A : Owl_types_ndarray_mutable.Sig

  (** {5 Type definition} *)

  type device

  type value

  (** {5 Core functions} *)

  val make_device : unit -> device

  val arr_to_value : A.arr -> value

  val value_to_arr : value -> A.arr

  val elt_to_value : A.elt -> value

  val value_to_elt : value -> A.elt

  val value_to_float : value -> float

  val is_arr : value -> bool

  val is_elt : value -> bool

end
