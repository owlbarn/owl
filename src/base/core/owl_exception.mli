(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** {6 Core function} *)

val check : bool -> exn -> unit
(**
``check p e`` raises the exception ``e`` if the predicate ``p`` is
``false``, otherwise returns ``unit``.

Parameters:
  * ``p``: predicate to check.
  * ``e``: exception to raise.

Returns:
  * ``unit``
 *)

val verify : bool -> (unit -> exn) -> unit
(**
``verify p f`` calls the function ``f`` which further raises an exception
if the predicate ``p`` is ``false``, otherwise returns ``unit``.

Parameters:
  * ``p``: predicate to check.
  * ``f``: function to raise the exception.

Returns:
  * ``unit``
 *)

val to_string : exn -> string
(**
``to_string e`` converts an exception into a string containing more
detailed information for debugging the code.
 *)

val pp_exception : Format.formatter -> exn -> unit
  [@@ocaml.toplevel_printer]
(** ``pp_exception`` is the pretty printer for Owl exceptions. *)

(** {6 Exception definition} *)

exception CONV_INVALID_ARGUMENT
(** Input arguments of convolution operations are invalid. *)

exception NOT_IMPLEMENTED of string
(** Exception of not implemented yet. *)

exception NOT_SUPPORTED
(** Exception of not supported type. *)

exception FOUND
(** Exception of found an element. *)

exception NOT_FOUND
(** Exception of not found an element. *)

exception EMPTY_ARRAY
(** Exception of an empty array *)

exception TEST_FAIL
(** Unit Test fails. *)

exception INVALID_ARGUMENT of string
(** Input arguments are invalid. *)

exception INVALID_PROBABILITY of float
(** Invalid probability value, not within [0,1] range. *)

exception LINALG_MATRIX_DOT_SHAPE of (int * int * int * int)
(** Invalid matrix shapes for matrix dot product. *)

exception NON_NEGATIVE_INT of int
(** Fails if the input is negative. *)

exception NOT_SQUARE of int array
(** Fails if a matrix is not square. *)

exception NOT_MATRIX of int array
(** Fails if the input is not a matrix. *)

exception DIFFERENT_SHAPE of (int array * int array)
(** Fail if two ndarrays have different shape. *)

exception DIFFERENT_SIZE of (int * int)
(** Fail if two ndarrays have different size. *)

exception NOT_BROADCASTABLE
(** Fail if the shapes of multiple ndarrays are not broadcastable. *)

exception NOT_CONVERGE
(** Fail to converge. *)

exception MAX_ITERATION
(** Number of iteration exceeds the threshold. *)

exception SINGULAR
(** Exception of singular matrix. *)

exception NOT_SIMPLEX
(** Exception of not being simplex. *)

exception INDEX_OUT_OF_BOUND
(** Exception of index out of boundary. *)

exception ZOO_ILLEGAL_GIST_NAME
(** Exception of illegal gist name. *)
