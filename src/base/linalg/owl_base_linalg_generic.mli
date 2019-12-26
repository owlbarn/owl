(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(** {6 Types and constants}  *)

type ('a, 'b) t = ('a, 'b) Owl_base_dense_ndarray_generic.t

(** {6 Basic functions} *)

val inv : ('a, 'b) t -> ('a, 'b) t
(**
``inv x`` calculates the inverse of an invertible square matrix ``x``
such that ``x *@ x = I`` wherein ``I`` is an identity matrix.  (If ``x``
is singular, ``inv`` will return a useless result.)
 *)

val det : ('a, 'b) t -> 'a
(** ``det x`` computes the determinant of a square matrix ``x``. *)

val logdet : ('a, 'b) t -> 'a
(** Refer to :doc:`owl_dense_matrix_generic` *)

(** {6 Check matrix types} *)

val is_tril : ('a, 'b) t -> bool
(** ``is_tril x`` returns ``true`` if ``x`` is lower triangular otherwise ``false``. *)

val is_triu : ('a, 'b) t -> bool
(** ``is_triu x`` returns ``true`` if ``x`` is upper triangular otherwise ``false``. *)

val is_diag : ('a, 'b) t -> bool
(** ``is_diag x`` returns ``true`` if ``x`` is diagonal otherwise ``false``. *)

val is_symmetric : ('a, 'b) t -> bool
(** ``is_symmetric x`` returns ``true`` if ``x`` is symmetric otherwise ``false``. *)

val is_hermitian : (Complex.t, 'b) t -> bool
(** ``is_hermitian x`` returns ``true`` if ``x`` is hermitian otherwise ``false``. *)

(** {6 Factorisation} *)

val lu : ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * int array
(**
``lu x -> (l, u, ipiv)`` calculates LU decomposition of ``x``. The pivoting is
used by default.
 *)

val qr
  :  ?thin:bool
  -> ?pivot:bool
  -> ('a, 'b) t
  -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val lq : ?thin:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val svd : ?thin:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val chol : ?upper:bool -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

(** {6 Linear system of equations} *)

val linsolve
  :  ?trans:bool
  -> ?typ:[ `n | `u | `l ]
  -> ('a, 'b) t
  -> ('a, 'b) t
  -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val sylvester : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val lyapunov : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val discrete_lyapunov
  :  ?solver:[ `default | `bilinear | `direct ]
  -> ('a, 'b) t
  -> ('a, 'b) t
  -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val care
  :  ?diag_r:bool
  -> (float, 'b) t
  -> (float, 'b) t
  -> (float, 'b) t
  -> (float, 'b) t
  -> (float, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

(** {6 Non-standard functions} *)

val linsolve_lu : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val linsolve_gauss : (float, 'a) t -> (float, 'b) t -> (float, 'a) t * (float, 'b) t

val tridiag_solve_vec
  :  float array
  -> float array
  -> float array
  -> float array
  -> float array
