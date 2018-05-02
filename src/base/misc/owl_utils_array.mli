(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Basic functions} *)

val length : 'a array -> int
(** Refer to OCaml native array. *)

val get : 'a array -> int -> 'a
(** Refer to OCaml native array. *)

val set : 'a array -> int -> 'a -> unit
(** Refer to OCaml native array. *)

val make : int -> 'a -> 'a array
(** Refer to OCaml native array. *)

val create_float : int -> float array
(** Refer to OCaml native array. *)

val init : int -> (int -> 'a) -> 'a array
(** Refer to OCaml native array. *)

val make_matrix : int -> int -> 'a -> 'a array array
(** Refer to OCaml native array. *)

val append : 'a array -> 'a array -> 'a array
(** Refer to OCaml native array. *)

val concat : 'a array list -> 'a array
(** Refer to OCaml native array. *)

val sub : 'a array -> int -> int -> 'a array
(** Refer to OCaml native array. *)

val copy : 'a array -> 'a array
(** Refer to OCaml native array. *)

val fill : 'a array -> int -> int -> 'a -> unit
(** Refer to OCaml native array. *)

val blit : 'a array -> int -> 'a array -> int -> int -> unit
(** Refer to OCaml native array. *)

val to_list : 'a array -> 'a list
(** Refer to OCaml native array. *)

val of_list : 'a list -> 'a array
(** Refer to OCaml native array. *)

val iter : ('a -> unit) -> 'a array -> unit
(** Refer to OCaml native array. *)

val iteri : (int -> 'a -> unit) -> 'a array -> unit
(** Refer to OCaml native array. *)

val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b array -> 'a
(** Refer to OCaml native array. *)

val fold_right : ('b -> 'a -> 'a) -> 'b array -> 'a -> 'a
(** Refer to OCaml native array. *)

val map2 : ('a -> 'b -> 'c) -> 'a array -> 'b array -> 'c array
(** Refer to OCaml native array. *)

val for_all : ('a -> bool) -> 'a array -> bool
(** Refer to OCaml native array. *)

val exists : ('a -> bool) -> 'a array -> bool
(** Refer to OCaml native array. *)

val mem : 'a -> 'a array -> bool
(** Refer to OCaml native array. *)

val memq : 'a -> 'a array -> bool
(** Refer to OCaml native array. *)

val sort : ('a -> 'a -> int) -> 'a array -> unit
(** Refer to OCaml native array. *)

val stable_sort : ('a -> 'a -> int) -> 'a array -> unit
(** Refer to OCaml native array. *)

val fast_sort : ('a -> 'a -> int) -> 'a array -> unit
(** Refer to OCaml native array. *)

val unsafe_get : 'a array -> int -> 'a
(** Refer to OCaml native array. *)

val unsafe_set : 'a array -> int -> 'a -> unit
(** Refer to OCaml native array. *)


(** {6 Extended functions} *)

val ( @ ) : 'a array -> 'a array -> 'a array
(** TODO *)

val set_n : 'a array -> int array -> 'a -> unit
(** TODO *)

val range : int -> int -> int array
(** TODO *)

val count : 'a array -> 'a -> int
(** TODO *)

val insert : 'a array -> 'a array -> int -> 'a array
(** TODO *)

val remove : 'a array -> int -> 'a array
(** TODO *)

val replace : int -> int -> 'a array -> 'a array -> 'a array
(** TODO *)

val mapi : (int -> 'a -> 'b) -> 'a array -> 'b array
(** TODO *)

val map : ('a -> 'b) -> 'a array -> 'b array
(** TODO *)

val iter2i : (int -> 'a -> 'b -> 'c) -> 'a array -> 'b array -> unit
(** TODO *)

val iter2 : ('a -> 'b -> 'c) -> 'a array -> 'b array -> unit
(** TODO *)

val iter3i : (int -> 'a -> 'b -> 'c -> 'd) -> 'a array -> 'b array -> 'c array -> unit
(** TODO *)

val iter3 : ('a -> 'b -> 'c -> 'd) -> 'a array -> 'b array -> 'c array -> unit
(** TODO *)

val map2i : (int -> 'a -> 'b -> 'c) -> 'a array -> 'b array -> 'c array
(** TODO *)

val map2i_split2 : (int -> 'a -> 'b -> 'c * 'd) -> 'a array -> 'b array -> 'c array * 'd array
(** TODO *)

val filteri_v : (int -> 'a -> bool * 'b) -> 'a array -> 'b array
(** TODO *)

val filter_v : ('a -> bool * 'b) -> 'a array -> 'b array
(** TODO *)

val filteri : (int -> 'a -> bool) -> 'a array -> 'a array
(** TODO *)

val filter : ('a -> bool) -> 'a array -> 'a array
(** TODO *)

val filter2i : (int -> 'a -> 'b -> bool) -> 'a array -> 'b array -> ('a * 'b) array
(**
``filter2i f x y`` filters the elements in ``x`` and ``y`` using passed in
function ``f``. Both arrays must have same length.
 *)

val filter2 : ('a -> 'b -> bool) -> 'a array -> 'b array -> ('a * 'b) array
(**
``filter2 f x y`` is similar to ``filter2i`` but without passing index of
the elements to function ``f``.
 *)

val filter2i_i : (int -> 'a -> 'b -> bool) -> 'a array -> 'b array -> int array
(**
``filter2i_i f x y`` filters the elements in ``x`` and ``y`` using passed in
function ``f``. Both arrays must have same length. Note that the indices of
those satisfying the predicate ``f`` are returned in an array.
 *)

val filter2_i : ('a -> 'b -> bool) -> 'a array -> 'b array -> int array
(**
``filter2_i f x y`` is similar to ``filter2i_i`` but without passing index of
the elements to function ``f``.
 *)


val resize : ?head:bool -> 'a -> int -> 'a array -> 'a array
(**
``resize ~head v n x`` resizes ``x`` of length ``m`` to length ``n``. If
``m <= n``, a copy of ``x`` subarray is returned. If ``m > n``, then ``x`` is
extended, the extra space is filled with value ``v``.
 *)

val pad : [ `Left | `Right ] -> 'a -> int -> 'a array -> 'a array
(** TODO *)

val align : [ `Left | `Right ] -> 'a -> 'a array -> 'a array -> 'a array * 'a array
(**
``align side v x y`` aligns two arrays ``x`` and ``y`` along the specified side
with value ``v``. The copies of two arrays are returned.
 *)

val greater_eqaul : 'a array -> 'a array -> bool
(** TODO *)

val swap : 'a array -> int -> int -> unit
(** TODO *)

val permute : int array -> 'a array -> 'a array
(** TODO *)

val of_tuples : ('a * 'a) array -> 'a array
(** TODO *)

val complement : 'a array -> 'a array -> 'a array
(** TODO *)

val to_string : ?prefix:string -> ?suffix:string -> ?sep:string -> ('a -> string) -> 'a array -> string
(** TODO *)
