(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

(** Lazy module implments lazy evaluation atop of owl's ndarray. *)

open Owl_types

module Make
  (A : InpureSig)
  : sig

  type t

  type arr = A.arr

  type elt = A.elt


  (** {6 Unary operators} *)

  val neg : t -> t

  val conj : t -> t

  val reci : t -> t

  val signum : t -> t

  val sqr : t -> t

  val sqrt : t -> t

  val cbrt : t -> t

  val exp : t -> t

  val exp2 : t -> t

  val exp10 : t -> t

  val expm1 : t -> t

  val log : t -> t

  val log2 : t -> t

  val log10 : t -> t

  val log1p : t -> t

  val sin : t -> t

  val cos : t -> t

  val tan : t -> t

  val asin : t -> t

  val acos : t -> t

  val atan : t -> t

  val sinh : t -> t

  val cosh : t -> t

  val tanh : t -> t

  val asinh : t -> t

  val acosh : t -> t

  val atanh : t -> t

  val floor : t -> t

  val ceil : t -> t

  val round : t -> t

  val trunc : t -> t

  val fix : t -> t

  val sum : ?axis:int -> t -> t

  val prod : ?axis:int -> t -> t

  val min : ?axis:int -> t -> t

  val max : ?axis:int -> t -> t

  val mean : ?axis:int -> t -> t

  val var : ?axis:int -> t -> t

  val std : ?axis:int -> t -> t

  val l1norm : ?axis:int -> t -> t

  val l2norm : ?axis:int -> t -> t

  val cumsum : ?axis:int -> t -> t

  val cumprod : ?axis:int -> t -> t

  val cummin : ?axis:int -> t -> t

  val cummax : ?axis:int -> t -> t


  (** {6 Binary operators} *)

  val add : t -> t -> t

  val sub : t -> t -> t

  val mul : t -> t -> t

  val div : t -> t -> t

  val pow : t -> t -> t

  val atan2 : t -> t -> t

  val hypot : t -> t -> t

  val fmod : t -> t -> t

  val min2 : t -> t -> t

  val max2 : t -> t -> t

  val add_scalar : t -> elt -> t

  val sub_scalar : t -> elt -> t

  val mul_scalar : t -> elt -> t

  val div_scalar : t -> elt -> t

  val pow_scalar : t -> elt -> t

  val atan2_scalar : t -> elt -> t

  val fmod_scalar : t -> elt -> t

  val scalar_add : elt -> t -> t

  val scalar_sub : elt -> t -> t

  val scalar_mul : elt -> t -> t

  val scalar_div : elt -> t -> t

  val scalar_pow : elt -> t -> t

  val scalar_atan2 : elt -> t -> t

  val scalar_fmod : elt -> t -> t


  (** {6 Helper functions} *)

  val of_ndarray : arr -> t

  val to_ndarray : t -> arr

  val eval : t -> unit


end
