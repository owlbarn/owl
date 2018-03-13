(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Core function} *)

val check : bool -> exn -> unit
(** ``check p e`` raises the exception ``e`` if the predicate ``p`` is
``false``, otherwise returns ``unit``.

Parameters:
  * ``p``: predicate to check.
  * ``e``: exception to raise.

Returns:
  * ``unit``
 *)


(** {13 Exception definition} *)

exception NOT_IMPLEMENTED
(** Exception of not implemented yet. *)

exception FOUND
(** Exception of found an element. *)

exception NOT_FOUND
(** Exception of not found an element. *)

exception EMPTY_ARRAY
(** Exception of an empty array *)

exception TEST_FAIL
(** Unit Test fails. *)

exception NOT_SQUARE
(** Fails if a matrix is not square. *)

exception DIFFERENT_SHAPE
(** Fail if two ndarrays have different shape. *)

exception NOT_BROADCASTABLE
(** Fail if the shapes of multiple ndarrays are not broadcastable. *)

exception NOT_CONVERGE
(** Fail to converge. *)

exception MAX_ITERATION
(** Number of iteration exceeds the threshold. *)

exception SINGULAR
(** Exception of singular matrix. *)

exception INDEX_OUT_OF_BOUND
(** Exception of index out of boundary. *)

exception ZOO_ILLEGAL_GIST_NAME
(** Incorrrect input gist name *)
