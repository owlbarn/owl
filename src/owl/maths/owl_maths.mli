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


(** {6 Basic functions} *)

val add : float -> float -> float
(** ``add x y`` *)

val sub : float -> float -> float
(** ``sub x y`` *)

val mul : float -> float -> float
(** ``mul x y`` *)

val div : float -> float -> float
(** ``div x y`` *)

val atan2 : float -> float -> float
(** ``atan2 x y`` *)

val abs : float -> float
(** ``abs x`` *)

val neg : float -> float
(** ``neg x`` *)

val reci : float -> float
(** ``reci x`` *)

val floor : float -> float
(** ``floor x`` *)

val ceil : float -> float
(** ``ceil x`` *)

val round : float -> float
(** ``round x`` *)

val trunc : float -> float
(** ``trunc x`` *)

val sqr : float -> float
(** ``sqr x`` *)

val sqrt : float -> float
(** ``sqrt x`` *)

val pow : float -> float -> float
(** ``pow x`` *)

val exp : float -> float
(** ``exp x`` *)

val expm1 : float -> float
(** ``expm1`` *)

val log : float -> float
(** ``log x`` *)

val log1p : float -> float
(** ``log1p x`` *)

val logabs : float -> float
(** ``logabs x`` *)

val log2 : float -> float
(** ``log2 x`` *)

val log10 : float -> float
(** ``log10 x`` *)

val logn : float -> float -> float
(** ``logn x`` *)

val sigmoid : float -> float
(** ``sigmod x`` *)

val signum : float -> float
(** ``signum x`` *)

val softsign : float -> float
(** ``softsign x`` *)

val softplus : float -> float
(** ``softplus x`` *)

val relu : float -> float
(** ``relu x`` *)

val sin : float -> float
(** ``sin x`` *)

val cos : float -> float
(** ``cos x`` *)

val tan : float -> float
(** ``tan x`` *)

val cot : float -> float
(** ``cot x`` *)

val sec : float -> float
(** ``sec x`` *)

val csc : float -> float
(** ``csc x`` *)

val asin : float -> float
(** ``asin x`` *)

val acos : float -> float
(** ``acos x`` *)

val atan : float -> float
(** ``atan x`` *)

val acot : float -> float
(** ``acot x`` *)

val asec : float -> float
(** ``asec x`` *)

val acsc : float -> float
(** ``acsc x`` *)

val sinh : float -> float
(** ``sinh x`` *)

val cosh : float -> float
(** ``cosh x`` *)

val tanh : float -> float
(** ``tanh x`` *)

val coth : float -> float
(** ``coth x`` *)

val sech : float -> float
(** ``sech x`` *)

val csch : float -> float
(** ``csch x`` *)

val asinh : float -> float
(** ``asinh x`` *)

val acosh : float -> float
(** ``acosh x`` *)

val atanh : float -> float
(** ``atanh x`` *)

val acoth : float -> float
(** ``acoth x`` *)

val asech : float -> float
(** ``asech x`` *)

val acsch : float -> float
(** ``acsch x`` *)

val sinc : float -> float
(** ``sinc x`` *)

val logsinh : float -> float
(** ``logsinh x`` *)

val logcosh : float -> float
(** ``logcosh x`` *)

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
(** ``xlogy(x, y) = x*log(y)`` *)

val xlog1py : float -> float -> float
(** ``xlog1py(x, y) = x*log1p(y)`` *)

val logit : float -> float
(** ``logit(x) = log(p/(1-p))`` *)

val expit : float -> float
(** ``expit(x) = 1/(1+exp(-x))`` *)


(** {6 Airy functions} *)

val airy : float -> float * float * float * float
(**
Airy function ``airy x`` returns ``(Ai, Aip, Bi, Bip)``. ``Aip`` is the
derivative of ``Ai`` whilst ``Bip`` is the derivative of ``Bi``.
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
(** Jacobian Elliptic function ``ellipj u m`` returns ``(sn, cn, dn, phi)``. *)

val ellipk : float -> float
(** Complete elliptic integral of the first kind ``ellipk m``. *)

val ellipkm1 : float -> float
(** Complete elliptic integral of the first kind around ``m = 1``. *)

val ellipkinc : float -> float -> float
(** Incomplete elliptic integral of the first kind ``ellipkinc phi m``. *)

val ellipe : float -> float
(** Complete elliptic integral of the second kind ``ellipe m``. *)

val ellipeinc : float -> float -> float
(** Incomplete elliptic integral of the second kind ``ellipeinc phi m``. *)


(** {6 Gamma Functions} *)

val gamma : float -> float
(**
Gamma function.

.. math::
  \Gamma(z) = \int_0^\infty x^{z-1} e^{-x} dx = (z - 1)!

The gamma function is often referred to as the generalized factorial since
``z*gamma(z) = gamma(z+1)`` and ``gamma(n+1) = n!`` for natural number ``n``.

Parameters:
  * ``z``

Returns:
  * The value of gamma(z).
 *)

val rgamma : float -> float
(** Reciprocal Gamma function. *)

val loggamma : float -> float
(** Logarithm of the gamma function. *)

val gammainc : float -> float -> float
(** Incomplete gamma function. *)

val gammaincinv : float -> float -> float
(** Inverse function of ``gammainc`` *)

val gammaincc : float -> float -> float
(** Complemented incomplete gamma integral *)

val gammainccinv : float -> float -> float
(** Inverse function of ``gammaincc`` *)

val psi : float -> float
(** The digamma function. *)


(** {6 Beta functions} *)

val beta : float -> float -> float
(**
Beta function.

.. math::
  \mathrm{B}(a, b) =  \frac{\Gamma(a) \Gamma(b)}{\Gamma(a+b)}
 *)

val betainc : float -> float -> float -> float
(** Incomplete beta integral. *)

val betaincinv : float -> float -> float -> float
(** Inverse funciton of beta integral. *)


(** {6 Factorials} *)

val fact : int -> float
(** Factorial function ``fact n`` calculates ``n!``. *)

val log_fact : int -> float
(** Logarithm of factorial function ``log_fact n`` calculates ``log n!``. *)

val permutation : int -> int -> int
(** ``permutation n k`` return the number of permutations of n things taken k at a time. *)

val permutation_float : int -> int -> float
(**
``permutation_float n k`` return the number of permutations of n things taken
k at a time. This function can deal with larger range than ``permutation``.
 *)

val combination : int -> int -> int
(** ``combination n k`` return the combination number of taking k out of n. *)

val combination_float : int -> int -> float
(**
``combination_float n k`` return the combination number of taking k out of n.
This function can deal with larger range than ``combination``.
 *)


(** {6 Error functions} *)

val erf : float -> float
(** Error function. *)

val erfc : float -> float
(** Complementary error function, ``1 - erf(x)`` *)

val erfcx : float -> float
(** Scaled complementary error function, ``exp(x**2) * erfc(x)``. *)

val erfinv : float -> float
(** Inverse of ``erf x``. *)

val erfcinv : float -> float
(** Inverse of ``erfc x`` *)


(** {6 Dawson & Fresnel integrals} *)

val dawsn : float -> float
(** Dawson’s integral. *)

val fresnel : float -> float * float
(**
Fresnel sin and cos integrals, ``fresnel x`` returns a tuple consisting of
``(Fresnel sin integral, Fresnel cos integral)``.
 *)


(** {6 Struve functions} *)

val struve : float -> float -> float
(**
Struve function ``struve v x`` returns the value of the Struve function of
order ``v`` at ``x``. The Struve function is defined as,

.. math::
  H_v(x) = (z/2)^{v + 1} \sum_{n=0}^\infty \frac{(-1)^n (z/2)^{2n}}{\Gamma(n + \frac{3}{2}) \Gamma(n + v + \frac{3}{2})},

where :math:`\Gamma` is the gamma function.

Parameters:
  * ``v``: order of the Struve function (float).
  * ``x``: Argument of the Struve function (float; must be positive unless v is an integer).

Returns:
  * Value of the Struve function of order ``v`` at ``x``.
 *)


(** {6 Other special functions} *)

val expn : int -> float -> float
(** Exponential integral E_n. *)

val shichi : float -> float * float
(** Hyperbolic sine and cosine integrals, ``shichi x`` returns ``(shi, chi)``. *)

val shi : float -> float
(** Hyperbolic sine integrals. *)

val chi : float -> float
(** Hyperbolic cosine integrals. *)

val sici : float -> float * float
(** Sine and cosine integrals, ``sici x`` returns ``(si, ci)``. *)

val si : float -> float
(** Sine integral. *)

val ci : float -> float
(** Cosine integral. *)

val zeta : float -> float -> float
(** Riemann or Hurwitz zeta function ``zeta x q``. *)

val zetac : float -> float
(** Riemann zeta function minus 1. *)


(** {6 Raw statistical functions} *)

val bdtr : int -> int -> float -> float
(**
Binomial distribution cumulative distribution function.

``bdtr k n p`` calculates the sum of the terms 0 through k of the Binomial
probability density.

.. math::
  \mathrm{bdtr}(k, n, p) = \sum_{j=0}^k {{n}\choose{j}} p^j (1-p)^{n-j}

Parameters:
  * ``k``: Number of successes.
  * ``n``: Number of events.
  * ``p``: Probability of success in a single event.

Returns:
  * Probability of k or fewer successes in n independent events with success probabilities of p.
 *)

val bdtrc : int -> int -> float -> float
(**
Binomial distribution survival function.

``bdtrc k n p`` calculates the sum of the terms k + 1 through n of the binomial
probability density,

.. math::
  \mathrm{bdtrc}(k, n, p) = \sum_{j=k+1}^n {{n}\choose{j}} p^j (1-p)^{n-j}

 *)

val bdtri : int -> int -> float -> float
(**
Inverse function to ``bdtr`` with respect to ``p``.

Finds the event probability ``p`` such that the sum of the terms 0 through k of
the binomial probability density is equal to the given cumulative probability y.
 *)


val btdtr : float -> float -> float -> float
(**
Cumulative density function of the beta distribution.

``btdtr a b x`` returns the integral from zero to x of the beta probability
density function,

.. math::
  I = \int_0^x \frac{\Gamma(a + b)}{\Gamma(a)\Gamma(b)} t^{a-1} (1-t)^{b-1}\,dt

where :math:`\Gamma` is the gamma function.

Parameters:
  * ``a``: Shape parameter (a > 0).
  * ``b``: Shape parameter (a > 0).
  * ``x``: Upper limit of integration, in [0, 1].

Returns:
  * Cumulative density function of the beta distribution with ``a`` and ``b`` at ``x``.
 *)

val btdtri : float -> float -> float -> float
(**
The p-th quantile of the Beta distribution.

This function is the inverse of the beta cumulative distribution function,
``btdtr``, returning the value of ``x`` for which ``btdtr(a, b, x) = p``,

.. math::
  p = \int_0^x \frac{\Gamma(a + b)}{\Gamma(a)\Gamma(b)} t^{a-1} (1-t)^{b-1}\,dt

where :math:`\Gamma` is the gamma function.

Parameters:
  * ``a``: Shape parameter (a > 0).
  * ``b``: Shape parameter (a > 0).
  * ``x``: Cumulative probability, in [0, 1].

Returns:
  * The quantile corresponding to ``p``.
 *)


(** {6 Helper functions} *)

val is_odd : int -> bool
(** ``is_odd x`` returns ``true`` if ``x`` is odd. *)

val is_even : int -> bool
(** ``is_even x`` returns ``true`` if ``x`` is even. *)

val is_pow2 : int -> bool
(** ``is_pow2 x`` return ``true`` if ``x`` is integer power of 2, e.g. 32, 64, etc. *)

val nextafter : float -> float -> float
(**
``nextafter from to`` returns the next representable double precision value
of ``from`` in the direction of ``to``. If from equals to ``to``, ``to`` is returned.
 *)

val nextafterf : float -> float -> float
(**
``nextafter from to`` returns the next representable single precision value
of ``from`` in the direction of ``to``. If from equals to ``to``, ``to`` is returned.
 *)


(* ends here *)
