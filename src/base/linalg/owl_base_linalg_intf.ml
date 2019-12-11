(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Linalg = sig
  type elt
  type arr

  val inv : arr -> arr

  val logdet : arr -> elt

  val svd: ?thin:bool -> arr -> arr * arr * arr

  val chol : ?upper:bool -> arr -> arr

  val qr : arr -> arr * arr

  val lq : arr -> arr * arr

  val sylvester : arr -> arr -> arr -> arr

  val lyapunov : arr -> arr -> arr

  val discrete_lyapunov : ?solver:[`default | `direct | `bilinear] -> arr -> arr -> arr

  val linsolve : ?trans:bool -> ?typ:[`n | `u | `l] -> arr -> arr -> arr

  val care : ?diag_r:bool -> arr -> arr -> arr -> arr -> arr
end
