(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(** {6 Types and constants}  *)

type ('a, 'b) t = ('a, 'b) Owl_base_dense_ndarray_generic.t

(** {6 Core functions}  *)

val is_tril : ('a, 'b) t -> bool

val is_triu : ('a, 'b) t -> bool

val is_diag : ('a, 'b) t -> bool

val is_symmetric : ('a, 'b) t -> bool

val is_hermitian : (Complex.t, 'b) t -> bool

val lu : (float, 'a) t -> (float, 'a) t * (float, 'a) t * int array

val det : (float, 'a) t -> float

val linsolve_lu : (float, 'a) t -> (float, 'b) t -> (float, 'b) t

val linsolve_gauss : (float, 'a) t -> (float, 'b) t -> (float, 'a) t * (float, 'b) t

val tridiag_solve_vec
  :  float array
  -> float array
  -> float array
  -> float array
  -> float array

(* TODO: change float to 'a *)
val inv : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val logdet : ('a, 'b) t -> 'a
(** Refer to :doc:`owl_dense_matrix_generic` *)

val chol : ?upper:bool -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

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

val linsolve
  :  ?trans:bool
  -> ?typ:[ `n | `u | `l ]
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
