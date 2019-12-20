(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Common = sig
  include Owl_base_linalg_intf.Common
  (* NOTE: functions below have not been implemented in Base Linalg *)

  (** {6 Basic functions} *)

  val pinv : ?tol:float -> mat -> mat
  val rank : ?tol:float -> mat -> int
  val norm : ?p:float -> mat -> float
  val vecnorm : ?p:float -> mat -> float
  val cond : ?p:float -> mat -> float
  val rcond : mat -> float
  val is_posdef : mat -> bool

  (** {6 Factorisation} *)

  val lu : mat -> mat * mat * int32_mat
  val svdvals : mat -> mat
  val gsvd : mat -> mat -> mat * mat * mat * mat * mat * mat
  val gsvdvals : mat -> mat -> mat
  val schur : mat -> mat * mat * complex_mat
  val schur_tz : mat -> mat * mat
  val ordschur : select:int32_mat -> mat -> mat -> mat * mat * complex_mat
  val qz : mat -> mat -> mat * mat * mat * mat * complex_mat

  val ordqz
    :  select:int32_mat
    -> mat
    -> mat
    -> mat
    -> mat
    -> mat * mat * mat * mat * complex_mat

  val qzvals : mat -> mat -> complex_mat
  val hess : mat -> mat * mat

  (** {6 Eigenvalues & eigenvectors} *)

  val eig : ?permute:bool -> ?scale:bool -> mat -> complex_mat * complex_mat
  val eigvals : ?permute:bool -> ?scale:bool -> mat -> complex_mat

  (** {6 Linear system of equations} *)

  val null : mat -> mat
  val triangular_solve : upper:bool -> ?trans:bool -> mat -> mat -> mat
  val linreg : mat -> mat -> elt * elt

  (** {6 Low-level factorisation functions} *)

  val lufact : mat -> mat * int32_mat
  val qrfact : ?pivot:bool -> mat -> mat * mat * int32_mat
  val bkfact : ?upper:bool -> ?symmetric:bool -> ?rook:bool -> mat -> mat * int32_mat

  (** {6 Matrix functions} *)

  val mpow : mat -> float -> mat
  val expm : mat -> mat [@@warning "-32"]
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
end

module type Real = sig
  include Owl_base_linalg_intf.Real
  (* NOTE: functions below have not been implemented in Base Linalg *)

  val dare : mat -> mat -> mat -> mat -> mat
end
