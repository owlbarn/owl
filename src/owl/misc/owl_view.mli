(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** View module
  This module is used to create views atop of an ndarray. The view creation is
  very light-weighted and avoids copying actual data. You can further create
  views atop of existing views using slicing functions.

  All the views share the same underlying ndarray and any modification will be
  reflected on the original ndarray.
 *)

open Owl_types


module Make
  (A : Ndarray_Basic)
  : sig

  type t
  (** [t] is the abstract type to represent a view atop of an ndarray. *)


  (** {6 Core functions} *)

  val of_arr : A.arr -> t
  (** [of_arr x] creates a view from ndarray [x]. *)

  val to_arr : t -> A.arr
  (** [to_arr x] creates an new ndarray based on the view [x]. *)


  (** {6 Manipulation functions} *)

  val get : t -> int array -> A.elt

  val set : t -> int array -> A.elt -> unit

  val get_slice : int list list -> t -> t

  val set_slice : int list list -> t -> t -> unit

  val shape : t -> int array

  val num_dims : t -> int

  val nth_dim : t -> int -> int

  val numel : t -> int


  (** {6 Iteration functions} *)

  val iteri : (int array -> A.elt -> unit) -> t -> unit
  (** [iteri f x] iterates and applies [f] to every element in [x]. [f] has type
    [f : int array -> elt -> unit], the first paramater is index. The function
    is much slower than [iter]
   *)

  val iter : (A.elt -> unit) -> t -> unit

  val mapi : (int array -> A.elt -> A.elt) -> t -> unit
  (** [mapi f x] applies [f : int array -> elt -> elt] to every element in [x],
    then save the result in place. This function is much slower than [map].
   *)

  val map : (A.elt -> A.elt) -> t -> unit
  (** [map f x] applies [f : elt -> elt] to every element in [x], then save the
    the result in place in [x].
   *)

  val iter2 : (A.elt -> A.elt -> unit) -> t -> t -> unit

  val map2 : (A.elt -> A.elt -> A.elt) -> t -> t -> unit
  (** [map2 f x y] applies [f : elt -> elt -> elt] every pair of elements in [x]
    and [y], then saves the result in [y]. So be careful with the order, it
    matters, the data reflected by view [y] will be modified.
   *)


end
