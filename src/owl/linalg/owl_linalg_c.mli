(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type mat = Owl_dense_matrix_c.mat

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

val is_hermitian : mat -> bool

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

val schur : mat -> mat * mat * mat

val schur_tz : mat -> mat * mat

val ordschur : select:int32_mat -> mat -> mat -> mat * mat * mat

val qz : mat -> mat -> mat * mat * mat * mat * mat

val ordqz: select:int32_mat -> mat -> mat -> mat -> mat -> mat * mat * mat * mat * mat

val qzvals : mat -> mat -> mat

val hess : mat -> mat * mat


(** {6 Eigenvalues & eigenvectors} *)

val eig : ?permute:bool -> ?scale:bool -> mat -> mat * mat

val eigvals : ?permute:bool -> ?scale:bool -> mat -> mat


(** {6 Linear system of equations} *)

val null : mat -> mat

val linsolve : ?trans:bool -> mat -> mat -> mat

val linreg : mat -> mat -> elt * elt

val sylvester : mat -> mat -> mat -> mat

val lyapunov : mat -> mat -> mat


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
