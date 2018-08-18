(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition} *)

type 'a t = {
  mutable used : int;
  mutable size : int;
  mutable data : 'a array;
}
(** Type of a stack. *)


(** {6 Basic functions} *)

val make : unit -> 'a t
(** ``make ()`` creates an empty stack. *)

val push : 'a t -> 'a -> unit
(** ``push stack x`` pushes ``x`` into ``stack``. *)

val pop : 'a t -> 'a option
(**
``pop stack`` pops the top element in ``stack``. It returns ``None`` if the
``stack`` is empty.
 *)

val peek : 'a t -> 'a option
(**
``peek stack`` returns the value of top element in ``stack`` but it does not
remove the element from the stack. ``None`` is returned if the stack is empty.
 *)

val is_empty : 'a t -> bool
(** Returns ``true`` if the stack is empty, otherwise ``false``. *)

val mem : 'a t -> 'a -> bool
(**
``mem stack x`` checks whether ``x`` exist in ``stack``. The complexity is
``O(n)`` where ``n`` is the size of the ``stack``.
 *)

val memq : 'a t -> 'a -> bool
(** Similar to ``mem`` but physical equality is used for comparing values. *)

val to_array : 'a t -> 'a array
(** ``to_array stack`` converts the elements in ``stack`` into an array. *)
