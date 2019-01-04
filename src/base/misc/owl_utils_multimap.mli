(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module Make (Ord : Map.OrderedType) : sig

  (** {6 Type definition} *)

  type key = Ord.t
  (** Type of the multimap keys. *)

  type 'a t
  (** Type of a multimap. *)


  (** {6 Basic functions} *)

  val empty : 'a t
  (** The empty multimap. *)

  val is_empty : 'a t -> bool
  (** Check whether the multimap is empty. *)

  val mem : key -> 'a t -> bool
  (**
  ``mem k m`` returns true is the multimap ``m`` contains at least one binding
  for ``k``, false otherwise.
   *)

  val add : key -> 'a -> 'a t -> 'a t
  (**
  ``add k v m`` returns a multimap containing the same bindings as ``m``, plus a
  binding from ``k`` to ``v``. Previous bindings for ``k`` are hidden by the new
  binding (they can be restored by calling ``remove k m``).
   *)

  val remove : key -> 'a t -> 'a t
  (**
  ``remove k v m`` returns a multimap with the same bindings as ``m``, except
  for the binding of ``k``: the last value that was bound to it is removed. If
  there is no binding for ``k`` in ``m``, raises `Not_found`.
   *)

  val find : key -> 'a t -> 'a
  (**
  ``find k m`` returns the last added binding of ``k`` in ``m``, or raises
  ``Not_found`` if there is no such binding.
   *)

  val max_binding : 'a t -> key * 'a
  (**
  ``max_binding m`` returns the greatest binding in ``m``. Raises ``Not_found``
  if ``m`` is empty.
   *)

  val find_first_opt : (key -> bool) -> 'a t -> (key * 'a) option
  (**
  ``find_first_opt f m`` returns the first binding ``(k, v)`` such that ``f k``,
  or ``None`` if no such binding exists. The function ``f`` has to be
  nondecreasing. Time complexity is O(log n).
   *)

end
