(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
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

val exp_mult : float -> float -> float

val exprel : float -> float

val log : float -> float

val log1p : float -> float

val log_abs : float -> float

val log2 : float -> float

val log10 : float -> float

val logN : float -> float -> float

val sigmoid : float -> float

val signum : float -> float

val softsign : float -> float

val softplus : float -> float

val relu : float -> float


(** {6 Trigonometric and hyperbolic functions} *)

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

val lnsinh : float -> float

val lncosh : float -> float

val hypot : float -> float -> float

val rect_of_polar : r:float -> theta:float -> float * float

val polar_of_rect : x:float -> y:float -> float * float

val angle_restrict_symm : float -> float

val angle_restrict_pos : float -> float


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

val factorial : int -> float

val double_factorial : int -> float

val ln_factorial : int -> float

val ln_double_factorial : int -> float

val taylorcoeff : int -> float -> float

val permutation : int -> int -> int
(** [permutation n k] return the number of permutations of n things taken k at a time. *)

val combination : int -> int -> int
(** [combination n k] return the number of combination of n things taken k at a time. *)

val combination_float : int -> int -> float
(** [combination_float n k] return the number of combination of n things taken
  k at a time. This function can handle the result in a much larger range from
  [[-.max_float, max_float]] comparing to [combination n k].
*)

val ln_combination : int -> int -> float
(** [ln_combination n k] return the logarithm of the number of combination of n things taken k at a time. *)

val combination_iterator : int -> int -> (unit -> int array)
(** [combination_iterator n k] returns an iterator so that you can iterate all
  the possible combinations of taking k elements from a set of n of elements. *)

val permutation_iterator : int -> (unit -> int array)
(** [permutation_iterator n] returns an iterator so that you can iterate all the
  possible combinations of a set of n of elements. *)


(** {6 Pochhammer Symbol} *)

val poch : float -> float -> float

val lnpoch : float -> float -> float

val pochrel : float -> float -> float


(** {6 Lambert W Functions} *)

val lambert_w0 : float -> float

val lambert_w1 : float -> float


(** {6 Some constants} *)

val e : float

val euler : float

val log2e : float

val log10e : float

val sqrt1_2 : float

val sqrt2 : float

val sqrt3 : float

val sqrtpi : float

val pi : float

val pi_2 : float

val pi_4 : float

val i_1_pi : float

val i_1_pi : float

val ln10 : float

val ln2 : float

val lnpi : float


(** {6 Some utility functions} *)

val is_odd : int -> bool

val is_even : int -> bool

val is_pow2 : int -> bool



(* ends here *)
