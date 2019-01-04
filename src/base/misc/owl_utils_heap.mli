(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition} *)

type 'a t
(** Type of a min heap. *)


(** {6 Basic functions} *)

val make : ('a -> 'a -> int) -> 'a t
(**
``make cmp`` creates an empty min heap, using ``cmp`` as a comparison function.
*)

val make_int : ?initial_size:int -> (int -> int -> int) -> int t
(**
``make_int ?initial_size cmp`` creates an empty integer heap, using ``cmp`` as a
comparison function and pre-allocates a space of ``initial_size`` elements.
 *)

val make_float : ?initial_size:int -> (float -> float -> int) -> float t
(**
``make_float ?initial_size cmp`` creates an empty float heap, using ``cmp`` as a
comparison function and pre-allocates a space of ``initial_size`` elements.
 *)

val size : 'a t -> int
(** ``size heap`` returns the number of elements in the heap. *)

val push : 'a t -> 'a -> unit
(**
``push heap x`` pushes ``x`` into ``heap``. Time complexity is ``O(log(n))``,
where n is the size of ``heap``.
 *)

val pop : 'a t -> 'a
(**
``pop heap`` pops the minimal element from ``heap``. It raises an exception if
the heap is empty. Time complexity is ``O(log(n))``, where n is the size of
``heap``.
 *)

val peek : 'a t -> 'a
(**
``peek heap`` returns the value of the minimal element in ``heap`` but it does
not remove the element from the heap. Raises an exception if the heap is empty.
Time complexity is ``O(1)``.
 *)

val is_empty : 'a t -> bool
(**
``is_empty heap`` returns ``true`` if ``heap`` is empty, ``false`` otherwise.
 *)

val to_array : 'a t -> 'a array
(**
``to_array heap`` returns the elements in ``heap`` into an (unsorted) array.
 *)
