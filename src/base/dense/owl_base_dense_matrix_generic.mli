(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
Matrix module: including creation, manipulation, and various vectorised
mathematical operations.
 *)

(**
About the comparison of two complex numbers ``x`` and ``y``, Owl uses the
following conventions: 1) ``x`` and ``y`` are equal iff both real and imaginary
parts are equal; 2) ``x`` is less than ``y`` if the magnitude of ``x`` is less than
the magnitude of ``x``; in case both ``x`` and ``y`` have the same magnitudes, ``x``
is less than ``x`` if the phase of ``x`` is less than the phase of ``y``; 3) less or
equal, greater, greater or equal relation can be further defined atop of the
aforementioned conventions.
 *)

open Bigarray

(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t
(**
N-dimensional array type, i.e. Bigarray Genarray type.
 *)

val eye : ('a, 'b) kind -> int -> ('a, 'b) t
(**
``eye m`` creates an ``m`` by ``m`` identity matrix.
 *)

val diagm : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val tril : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val triu : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)
