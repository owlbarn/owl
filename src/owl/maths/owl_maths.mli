(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Maths: fundamental and advanced mathematical functions. *)

(**
  This module contains some basic and advanced mathematical operations.
  If you cannot find some function in this module, try Stats module.

  Please refer to Scipy documentation.
*)


(** {6 Basic math functions} *)

val abs : float -> float

val neg : float -> float

val reci : float -> float

val floor : float -> float

val ceil : float -> float

val round : float -> float

val trunc : float -> float

val sqrt : float -> float

val pow : float -> float -> float

val exp : float -> float

val expm1 : float -> float

val log : float -> float

val log1p : float -> float

val logabs : float -> float

val log2 : float -> float

val log10 : float -> float

val logn : float -> float -> float

val sigmoid : float -> float

val signum : float -> float

val softsign : float -> float

val softplus : float -> float

val relu : float -> float

val sin : float -> float

val cos : float -> float

val tan : float -> float

val cot : float -> float

val sec : float -> float

val csc : float -> float

val asin : float -> float

val acos : float -> float

val atan : float -> float

val acot : float -> float

val asec : float -> float

val acsc : float -> float

val sinh : float -> float

val cosh : float -> float

val tanh : float -> float

val coth : float -> float

val sech : float -> float

val csch : float -> float

val asinh : float -> float

val acosh : float -> float

val atanh : float -> float

val acoth : float -> float

val asech : float -> float

val acsch : float -> float

val sinc : float -> float

val logsinh : float -> float

val logcosh : float -> float

val sindg : float -> float
(** Sine of angle given in degrees *)

val cosdg : float -> float
(** Cosine of the angle x given in degrees. *)

val tandg : float -> float
(** Tangent of angle x given in degrees. *)

val cotdg : float -> float
(** Cotangent of the angle x given in degrees. *)

val hypot : float -> float -> float
(** Calculate the length of the hypotenuse. *)

val xlogy : float -> float -> float
(** [xlogy(x, y) = x*log(y)] *)

val xlog1py : float -> float -> float
(** [xlog1py(x, y) = x*log1p(y)] *)

val logit : float -> float
(** [logit(x) = log(p/(1-p))] *)

val expit : float -> float
(** [expit(x) = 1/(1+exp(-x))] *)


(** {6 Airy functions} *)

val airy : float -> float * float * float * float
(** Airy function [airy x] returns [(Ai, Aip, Bi, Bip)]. [Aip] is the
  derivative of [Ai] whilst [Bip] is the derivative of [Bi].
 *)


(** {6 Bessel functions} *)

val j0 : float -> float
(** Bessel function of the first kind of order 0. *)

val j1 : float -> float
(** Bessel function of the first kind of order 1. *)

val jv : float -> float -> float
(** Bessel function of real order. *)

val y0 : float -> float
(** Bessel function of the second kind of order 0. *)

val y1 : float -> float
(** Bessel function of the second kind of order 1. *)

val yv : float -> float -> float
(** Bessel function of the second kind of real order. *)

val yn : int -> float -> float
(** Bessel function of the second kind of integer order. *)

val i0 : float -> float
(** Modified Bessel function of order 0. *)

val i0e : float -> float
(** Exponentially scaled modified Bessel function of order 0. *)

val i1 : float -> float
(** Modified Bessel function of order 1. *)

val i1e : float -> float
(** Exponentially scaled modified Bessel function of order 1. *)

val iv : float -> float -> float
(** Modified Bessel function of the first kind of real order. *)

val k0 : float -> float
(** Modified Bessel function of the second kind of order 0, K_0.*)

val k0e : float -> float
(** Exponentially scaled modified Bessel function K of order 0. *)

val k1 : float -> float
(** Modified Bessel function of the second kind of order 1, K_1(x). *)

val k1e : float -> float
(** Exponentially scaled modified Bessel function K of order 1. *)


(** {6 Elliptic functions} *)

val ellipj : float -> float -> float * float * float * float
(** Jacobian Elliptic function [ellipj u m] returns [(sn, cn, dn, phi)]. *)

val ellipk : float -> float
(** Complete elliptic integral of the first kind [ellipk m]. *)

val ellipkm1 : float -> float
(** Complete elliptic integral of the first kind around [m = 1]. *)

val ellipkinc : float -> float -> float
(** Incomplete elliptic integral of the first kind [ellipkinc phi m]. *)

val ellipe : float -> float
(** Complete elliptic integral of the second kind [ellipe m]. *)

val ellipeinc : float -> float -> float
(** Incomplete elliptic integral of the second kind [ellipeinc phi m]. *)


(** {6 Gamma Functions} *)

val gamma : float -> float
(** Gamma function. *)

val rgamma : float -> float
(** Reciprocal Gamma function. *)

val loggamma : float -> float
(** Logarithm of the gamma function. *)

val gammainc : float -> float -> float
(** Incomplete gamma function. *)

val gammaincinv : float -> float -> float
(** Inverse function of [gammainc] *)

val gammaincc : float -> float -> float
(** Complemented incomplete gamma integral *)

val gammainccinv : float -> float -> float
(** Inverse function of [gammaincc] *)

val psi : float -> float
(** The digamma function. *)


(** {6 Beta functions} *)

val beta : float -> float -> float
(** Beta function. *)

val betainc : float -> float -> float -> float
(** Incomplete beta integral. *)

val betaincinv : float -> float -> float -> float
(** Inverse funciton of beta integral. *)


(** {6 Factorials} *)

val fact : int -> float
(** Factorial function [fact n] calculates [n!]. *)

val log_fact : int -> float
(** Logarithm of factorial function [log_fact n] calculates [log n!]. *)

val permutation : int -> int -> int
(** [permutation n k] return the number of permutations of n things taken k at a time. *)

val combination : int -> int -> int
(** [combination n k] return the combination number of taking k out of n. *)


(** {6 Error Function and Fresnel Integrals} *)

val erf : float -> float
(** Error function. *)

val erfc : float -> float
(** Complementary error function, [1 - erf(x)] *)

val erfcx : float -> float
(** Scaled complementary error function, [exp(x**2) * erfc(x)]. *)

val erfinv : float -> float
(** Inverse of [erf x]. *)

val erfcinv : float -> float
(** Inverse of [erfc x] *)

val dawsn : float -> float
(** Dawson’s integral. *)

val fresnel : float -> float * float
(** Fresnel sin and cos integrals, [fresnel x] returns a tuple consisting of
  [(Fresnel sin integral, Fresnel cos integral)].
 *)


(** {6 Struve functions} *)

val struve : float -> float -> float
(** Struve function [struve v x]. *)


(** {6 Other special functions} *)

val expn : int -> float -> float
(** Exponential integral E_n. *)

val shichi : float -> float * float
(** Hyperbolic sine and cosine integrals, [shichi x] returns [(shi, chi)]. *)

val shi : float -> float
(** Hyperbolic sine integrals. *)

val chi : float -> float
(** Hyperbolic cosine integrals. *)

val sici : float -> float * float
(** Sine and cosine integrals, [sici x] returns [(si, ci)]. *)

val si : float -> float
(** Sine integral. *)

val ci : float -> float
(** Cosine integral. *)

val zeta : float -> float -> float
(** Riemann or Hurwitz zeta function [zeta x q]. *)

val zetac : float -> float
(** Riemann zeta function minus 1. *)


(** {6 Some utility functions} *)

val is_odd : int -> bool

val is_even : int -> bool

val is_pow2 : int -> bool



(* ends here *)
