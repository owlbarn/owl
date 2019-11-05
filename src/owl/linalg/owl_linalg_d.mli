(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = float

type mat = Owl_dense_matrix_d.mat

type complex_mat = Owl_dense_matrix_z.mat

type int32_mat = (int32, int32_elt) Owl_dense_matrix_generic.t


(** {6 Basic functions} *)

val inv : mat -> mat

val pinv : ?tol:float -> mat -> mat

val det : mat -> elt

val logdet : mat -> elt

val rank : ?tol:float -> mat -> int

val norm : ?p:float -> mat -> float

val vecnorm : ?p:float -> mat -> float

val cond : ?p:float -> mat -> float

val rcond : mat -> float

val is_triu : mat -> bool

val is_tril : mat -> bool

val is_symmetric : mat -> bool

val is_diag : mat -> bool

val is_posdef : mat -> bool


(** {6 Factorisation} *)

val lu : mat -> mat * mat * int32_mat

val lq : ?thin:bool -> mat -> mat * mat

val qr : ?thin:bool -> ?pivot:bool -> mat -> mat * mat * int32_mat

val chol : ?upper:bool -> mat -> mat

val svd : ?thin:bool -> mat -> mat * mat * mat

val svdvals : mat -> mat

val gsvd : mat -> mat -> mat * mat * mat * mat * mat * mat

val gsvdvals : mat -> mat -> mat

val schur : mat -> mat * mat * complex_mat

val schur_tz : mat -> mat * mat

val ordschur : select:int32_mat -> mat -> mat -> mat * mat * complex_mat

val qz : mat -> mat -> mat * mat * mat * mat * complex_mat

val ordqz: select:int32_mat -> mat -> mat -> mat -> mat -> mat * mat * mat * mat * complex_mat

val qzvals : mat -> mat -> complex_mat

val hess : mat -> mat * mat


(** {6 Eigenvalues & eigenvectors} *)

val eig : ?permute:bool -> ?scale:bool -> mat -> complex_mat * complex_mat

val eigvals : ?permute:bool -> ?scale:bool -> mat -> complex_mat


(** {6 Linear system of equations} *)

val null : mat -> mat

val triangular_solve: upper:bool -> ?trans:bool -> mat -> mat -> mat

val linsolve : ?trans:bool -> ?typ:[`n | `u | `l] -> mat -> mat -> mat

val linreg : mat -> mat -> elt * elt

val sylvester : mat -> mat -> mat -> mat

val lyapunov : mat -> mat -> mat

val discrete_lyapunov : ?solver:[`default | `direct | `bilinear] -> mat -> mat -> mat

val care : ?diag_r:bool -> mat -> mat -> mat -> mat -> mat

val dare : mat -> mat -> mat -> mat -> mat

(** {6 Low-level factorisation functions} *)

val lufact : mat -> mat * int32_mat

val qrfact : ?pivot:bool -> mat -> mat * mat * int32_mat

val bkfact : ?upper:bool -> ?symmetric:bool -> ?rook:bool -> mat -> mat * int32_mat


(** {6 Matrix functions} *)

val mpow : mat -> float -> mat

val expm : mat -> mat

val sinm : mat -> mat

val cosm : mat -> mat

val tanm : mat -> mat

val sincosm : mat -> mat * mat

val sinhm : mat -> mat

val coshm : mat -> mat

val tanhm : mat -> mat

val sinhcoshm : mat -> mat * mat


(** {6 Helper functions} *)

val select_ev : [ `LHP | `RHP | `UDI | `UDO ] -> mat -> int32_mat

val peakflops : ?n:int -> unit -> float
