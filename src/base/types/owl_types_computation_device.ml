(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig


  module A : Owl_types_ndarray_mutable.Sig

  (** {6 Type definition} *)

  type device
  (** TODO *)

  type value = ArrVal of A.arr | EltVal of A.elt
  (** TODO *)


  (** {6 Core functions} *)

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


end
