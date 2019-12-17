(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  include Owl_types_ndarray_eltcmp.Sig


  module Scalar : sig

    val add : elt -> elt -> elt

    val sub : elt -> elt -> elt

    val mul : elt -> elt -> elt

    val div : elt -> elt -> elt

    val pow : elt -> elt -> elt

    val atan2 : elt -> elt -> elt

    val abs : elt -> elt

    val neg : elt -> elt

    val sqr : elt -> elt

    val sqrt : elt -> elt

    val exp : elt -> elt

    val log : elt -> elt

    val log2 : elt -> elt

    val log10 : elt -> elt

    val signum : elt -> elt

    val floor : elt -> elt

    val ceil : elt -> elt

    val round : elt -> elt

    val sin : elt -> elt

    val cos : elt -> elt

    val tan : elt -> elt

    val sinh : elt -> elt

    val cosh : elt -> elt

    val tanh : elt -> elt

    val asin : elt -> elt

    val acos : elt -> elt

    val atan : elt -> elt

    val asinh : elt -> elt

    val acosh : elt -> elt

    val atanh : elt -> elt

    val relu : elt -> elt

    val sigmoid : elt -> elt

  end

  module Mat : sig
    val diagm : ?k:int -> arr -> arr

    val triu: ?k:int -> arr -> arr

    val tril: ?k:int -> arr -> arr

    val eye : int -> arr
  end

  module Linalg : sig
    val inv : arr -> arr

    val logdet: arr -> elt

    val chol : ?upper:bool -> arr -> arr

    val svd : ?thin:bool -> arr -> arr * arr * arr

    val qr : arr -> arr * arr

    val lq : arr -> arr * arr

    val sylvester: arr -> arr -> arr -> arr

    val lyapunov: arr -> arr -> arr

    val discrete_lyapunov: ?solver:[`default | `bilinear | `direct] -> arr -> arr -> arr

    val linsolve: ?trans:bool -> ?typ:[`n | `u | `l] -> arr -> arr -> arr

    val care : ?diag_r:bool -> arr -> arr -> arr -> arr -> arr
  end


end
