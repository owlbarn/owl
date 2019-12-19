(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Common = sig
  type elt

  type mat

  type complex_mat

  type int32_mat

  (** {6 Basic functions} *)

  val inv : mat -> mat

  val det : mat -> elt

  val logdet : mat -> elt

  val is_triu : mat -> bool

  val is_tril : mat -> bool

  val is_symmetric : mat -> bool

  val is_diag : mat -> bool

  (** {6 Factorisation} *)

  val svd : ?thin:bool -> mat -> mat * mat * mat

  val chol : ?upper:bool -> mat -> mat

  val qr : ?thin:bool -> ?pivot:bool -> mat -> mat * mat * int32_mat

  val lq : ?thin:bool -> mat -> mat * mat

  (** {6 Linear system of equations} *)

  val linsolve : ?trans:bool -> ?typ:[ `n | `u | `l ] -> mat -> mat -> mat

  val sylvester : mat -> mat -> mat -> mat

  val lyapunov : mat -> mat -> mat

  val discrete_lyapunov : ?solver:[ `default | `direct | `bilinear ] -> mat -> mat -> mat
end

module type Real = sig
  type elt

  type mat

  val care : ?diag_r:bool -> mat -> mat -> mat -> mat -> mat
end
