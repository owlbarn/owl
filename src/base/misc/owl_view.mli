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


  (** {6 Type definition} *)

  type t
  (** ``t`` is the abstract type to represent a view atop of an ndarray. *)


  (** {6 Conversion functions} *)

  val of_arr : A.arr -> t
  (** ``of_arr x`` creates a view from ndarray ``x``. *)

  val to_arr : t -> A.arr
  (** ``to_arr x`` creates an new ndarray based on the view ``x``. *)


  (** {6 Manipulation functions} *)

  val get : t -> int array -> A.elt
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val set : t -> int array -> A.elt -> unit
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val get_slice : int list list -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val set_slice : int list list -> t -> t -> unit
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val shape : t -> int array
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val num_dims : t -> int
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val nth_dim : t -> int -> int
  (** Refer to :doc:`owl_dense_ndarray_generic` *)

  val numel : t -> int
  (** Refer to :doc:`owl_dense_ndarray_generic` *)


  (** {6 Iteration functions} *)

  val iteri : (int -> A.elt -> unit) -> t -> unit
  (**
``iteri f x`` iterates and applies ``f`` to every element in ``x``. ``f`` has type
``f : int array -> elt -> unit``, the first paramater is index. 1d indices are
passed to the user function.
   *)

  val iter : (A.elt -> unit) -> t -> unit
  (** Similar to ``iteri``, the index is not passed in. *)

  val mapi : (int -> A.elt -> A.elt) -> t -> unit
  (**
``mapi f x`` applies ``f : int array -> elt -> elt`` to every element in ``x``,
then save the result in place. 1d indices are passed to the user function.
   *)

  val map : (A.elt -> A.elt) -> t -> unit
  (**
``map f x`` applies ``f : elt -> elt`` to every element in ``x``, then save the
the result in place in ``x``.
   *)

  val iter2 : (A.elt -> A.elt -> unit) -> t -> t -> unit
  (**
``iter2 f x y`` applies ``f : elt -> elt -> elt`` every pair of elements in
``x`` and ``y``. The indices are not passed in the user function.
   *)

  val map2 : (A.elt -> A.elt -> A.elt) -> t -> t -> unit
  (**
``map2 f x y`` applies ``f : elt -> elt -> elt`` every pair of elements in ``x``
and ``y``, then saves the result in ``y``. So be careful with the order, it
matters, the data reflected by view ``y`` will be modified.
   *)

  val iteri_nd : (int array -> A.elt -> unit) -> t -> unit
  (**
Similar to `iteri` but n-d indices are passed in. This function is much slower
than `iteri`.
   *)

  val mapi_nd : (int array -> A.elt -> A.elt) -> t -> unit
  (**
Similar to `mapi` but n-d indices are passed in. This function is much slower
than `mapi`.
   *)


  (** {6 Examination & Comparison}  *)

  val exists : (A.elt -> bool) -> t -> bool
  (**
``exists f x`` checks all the elements in ``x`` using ``f``. If at least one
element satisfies ``f`` then the function returns ``true`` otherwise ``false``.
   *)

  val not_exists : (A.elt -> bool) -> t -> bool
  (**
  ``not_exists f x`` checks all the elements in ``x``, the function returns
  ``true`` only if all the elements fail to satisfy ``f : float -> bool``.
   *)

  val for_all : (A.elt -> bool) -> t -> bool
  (**
  ``for_all f x`` checks all the elements in ``x``, the function returns ``true``
  if and only if all the elements pass the check of function ``f``.
   *)

  val equal : t -> t -> bool
  (** ``equal x y`` returns ``true`` if ``x`` and ``y`` are elementwise equal. *)

  val not_equal : t -> t -> bool
  (** ``not_equal x y`` returns ``true`` if ``x`` and ``y`` are not elementwise equal. *)


end
