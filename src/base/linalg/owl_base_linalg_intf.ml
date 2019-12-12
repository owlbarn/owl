(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Common = sig
  type elt

  type mat

  type complex_mat

  type int32_mat

  val logdet : mat -> elt

  val svd : ?thin:bool -> mat -> mat * mat * mat

  val chol : ?upper:bool -> mat -> mat

  val qr : ?thin:bool -> ?pivot:bool -> mat -> mat * mat * int32_mat

  val lq : ?thin:bool -> mat -> mat * mat

  val sylvester : mat -> mat -> mat -> mat

  val lyapunov : mat -> mat -> mat

  val discrete_lyapunov : ?solver:[ `default | `direct | `bilinear ] -> mat -> mat -> mat

  val linsolve : ?trans:bool -> ?typ:[ `n | `u | `l ] -> mat -> mat -> mat
end

module type Real = sig
  type elt

  type mat

  (* TODO: implement inv for both real and complex matrices *)
  val inv : mat -> mat

  val care : ?diag_r:bool -> mat -> mat -> mat -> mat -> mat
end
