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
(** ``add x y`` gives x + y. *)

val sub : float -> float -> float
(** ``sub x y`` gives x - y. *)

val mul : float -> float -> float
(** ``mul x y`` gives x * y. *)

val div : float -> float -> float
(** ``div x y`` gives x / y. *)

val atan2 : float -> float -> float
(** ``atan2 y x`` gives arctan(y/x), accounting for the sign of the arguments;
    this is the angle to the vector (x, y) counting from the x-axis. *)

val abs : float -> float
(** ``abs x`` gives ``|x|``. *)

val neg : float -> float
(** ``neg x`` gives -x. *)

val reci : float -> float
(** ``reci x`` gives 1/x. *)

val floor : float -> float
(** ``floor x`` gives the largest integer <= x. *)

val ceil : float -> float
(** ``ceil x`` gives the smallest integer >= x. *)

val round : float -> float
(** ``round x`` rounds, towards the bigger integer when on the fence. *)

val trunc : float -> float
(** ``trunc x`` integer part. *)

val sqr : float -> float
(** ``sqr x`` square. *)

val sqrt : float -> float
(** ``sqrt x`` square root. *)

val pow : float -> float -> float
(** ``pow x y`` gives x^y. *)

val exp : float -> float
(** ``exp x`` exponential. *)

val expm1 : float -> float
(** ``expm1 x`` gives exp(x) - 1 but more accurate for x ~ 0. *)

val log : float -> float
(** ``log x`` natural logarithm *)

val log1p : float -> float
(** ``log1p x`` gives log (x + 1) but more accurate for x ~ 0. Inverse of
    ``expm1``. *)

val logabs : float -> float
(** ``logabs x`` gives log(abs(x)). *)

val log2 : float -> float
(** ``log2 x`` gives the base-2 logarithm of x. *)

val log10 : float -> float
(** ``log10 x`` gives the base-10 logarithm of x. *)

val logn : float -> float -> float
(** ``logn x`` gives the base-n logarithm of x. *)

val sigmoid : float -> float
(** ``sigmoid x`` gives the logistic sigmoid function 1 / (1 + exp(-x)). *)

val signum : float -> float
(** ``signum x`` gives the sign of x: -1, 0 or 1. *)

val softsign : float -> float
(** ``softsign x`` smoothed sign function. *)

val softplus : float -> float
(** ``softplus x`` gives log(1+exp(x)). *)

val relu : float -> float
(** ``relu x`` gives max(0, x). *)

val sin : float -> float
(** ``sin x`` gives sin(x). *)

val cos : float -> float
(** ``cos x`` gives cos(x). *)

val tan : float -> float
(** ``tan x`` gives tan(x). *)

val cot : float -> float
(** ``cot x`` gives 1/tan(x). *)

val sec : float -> float
(** ``sec x`` gives 1/cos(x). *)

val csc : float -> float
(** ``csc x`` gives 1/sin(x). *)

val asin : float -> float
(** ``asin x`` gives arcsin(x). *)

val acos : float -> float
(** ``acos x`` gives arccos(x). *)

val atan : float -> float
(** ``atan x`` gives arctan(x). *)

val acot : float -> float
(** ``acot x`` gives arccotan(x). *)

val asec : float -> float
(** ``asec x`` gives arcsec(x). *)

val acsc : float -> float
(** ``acsc x`` gives arccosec(x). *)

val sinh : float -> float
(** ``sinh x`` gives sinh(x). *)

val cosh : float -> float
(** ``cosh x`` gives cosh(x). *)

val tanh : float -> float
(** ``tanh x`` gives tanh(x). *)

val coth : float -> float
(** ``coth x`` gives coth(x). *)

val sech : float -> float
(** ``sech x`` gives sech(x). *)

val csch : float -> float
(** ``csch x`` gives cosech(x). *)

val asinh : float -> float
(** ``asinh x`` gives arcsinh(x). *)

val acosh : float -> float
(** ``acosh x`` gives arccosh(x). *)

val atanh : float -> float
(** ``atanh x`` gives arctanh(x). *)

val acoth : float -> float
(** ``acoth x`` gives arccoth(x). *)

val asech : float -> float
(** ``asech x`` gives arcsech(x). *)

val acsch : float -> float
(** ``acsch x`` gives arccosech(x). *)

val sinc : float -> float
(** ``sinc x`` gives sin(x)/x and 1 for x=0. *)

val logsinh : float -> float
(** ``logsinh x`` gives log(sinh(x)) but handles large ``|x|``. *)

val logcosh : float -> float
(** ``logcosh x`` gives log(cosh(x)) but handles large ``|x|``. *)

val sindg : float -> float
(** Sine of angle given in degrees. *)

val cosdg : float -> float
(** Cosine of the angle x given in degrees. *)

val tandg : float -> float
(** Tangent of angle x given in degrees. *)

val cotdg : float -> float
(** Cotangent of the angle x given in degrees. *)

val hypot : float -> float -> float
(** Calculate the length of the hypotenuse. *)

val xlogy : float -> float -> float
(** ``xlogy(x, y)`` gives x*log(y). *)

val xlog1py : float -> float -> float
(** ``xlog1py(x, y)`` gives x*log(y+1). *)

val logit : float -> float
(** ``logit(x)`` gives log(p/(1-p)). *)

val expit : float -> float
(** ``expit(x)`` gives 1/(1+exp(-x)). *)


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
(** Inverse function of ``gammainc``. *)

val gammaincc : float -> float -> float
(** Complemented incomplete gamma integral. *)

val gammainccinv : float -> float -> float
(** Inverse function of ``gammaincc``. *)

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

val doublefact : int -> float
(** Double factorial function ``doublefact n`` calculates n!! = n(n-2)(n-4)... *)

val log_doublefact : int -> float
(** Logarithm of double factorial function. ``log_doublefact n`` calculates
    log(n!!) *)

val permutation : int -> int -> int
(** ``permutation n k`` gives the number n!/(n-k)! of ordered subsets of length k, taken
    from a set of n elements. *)

val permutation_float : int -> int -> float
(**
``permutation_float`` is like ``permutation`` but deal with larger range.
 *)

val combination : int -> int -> int
(** ``combination n k`` gives the number n!/(k!(n-k)!) of subsets of k elements
    of a set of n elements. This is the binomial coefficient 'n choose k' *)

val combination_float : int -> int -> float
(** ``combination_float`` is like ``combination`` but can deal with a larger range. *)

val log_combination : int -> int -> float
(** ``log_combination n k`` gives the logarithm of 'n choose k'. *)


(** {6 Error functions} *)

val erf : float -> float
(** Error function. :math:`\int_{-\infty}^x \frac{1}{\sqrt(2\pi)} exp(-1/2 y^2) dy` *)

val erfc : float -> float
(** Complementary error function, 1 - erf(x). *)

val erfcx : float -> float
(** Scaled complementary error function, exp(x^2) * erfc(x). *)

val erfinv : float -> float
(** Inverse of erf. *)

val erfcinv : float -> float
(** Inverse of erfc. *)


(** {6 Dawson & Fresnel integrals} *)

val dawsn : float -> float
(** Dawson’s integral. *)

val fresnel : float -> float * float
(** Fresnel sin and cos integrals. ``fresnel x`` returns a tuple consisting of
``(Fresnel sin integral, Fresnel cos integral)``. *)


(** {6 Struve functions} *)

val struve : float -> float -> float
(** ``struve v x`` returns the value of the Struve function of
order ``v`` at ``x``. The Struve function is defined as,

.. math::
  H_v(x) = (z/2)^{v + 1} \sum_{n=0}^\infty \frac{(-1)^n (z/2)^{2n}}{\Gamma(n + \frac{3}{2}) \Gamma(n + v + \frac{3}{2})},

where :math:`\Gamma` is the gamma function.

Parameters:
  * ``v``: order of the Struve function (float).
  * ``x``: Argument of the Struve function (float; must be positive unless v is an integer).

 *)


(** {6 Other special functions} *)

val expn : int -> float -> float
(** Exponential integral E_n. *)

val shichi : float -> float * float
(** Hyperbolic sine and cosine integrals, ``shichi x`` returns ``(shi, chi)``. *)

val shi : float -> float
(** Hyperbolic sine integral. *)

val chi : float -> float
(** Hyperbolic cosine integral. *)

val sici : float -> float * float
(** Sine and cosine integrals, ``sici x`` returns ``(si, ci)``. *)

val si : float -> float
(** Sine integral. *)

val ci : float -> float
(** Cosine integral. *)

val zeta : float -> float -> float
(** ``zeta x q`` gives the Hurwitz zeta function :math:`\zeta(x, q)`, which
    reduces to the Riemann zeta function :math:`\zeta(x)` when q=1. *)

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

val is_nan : float -> bool
(** ``is_nan x`` returns ``true`` if ``x`` is ``nan``. *)

val is_inf : float -> bool
(** ``is_inf x`` returns ``true`` if ``x`` is ``infinity`` or ``neg_infinity``. *)

val is_odd : int -> bool
(** ``is_odd x`` returns ``true`` if ``x`` is odd. *)

val is_even : int -> bool
(** ``is_even x`` returns ``true`` if ``x`` is even. *)

val is_pow2 : int -> bool
(** ``is_pow2 x`` return ``true`` if ``x`` is integer power of 2, e.g. 32, 64, etc. *)

val same_sign : float -> float -> bool
(** ``same_sign x y`` returns ``true`` if ``x`` and ``y`` have the same sign,
otherwise it returns ``false``. Positive and negative zeros are special cases
and always returns ``true``. *)

val is_simplex : float array -> bool
(**
``is_simplex x`` checks whether ``x`` is simplex. In other words,
:math:`\sum_i^K x_i = 1` and :math:`x_i \ge 0, \forall x_i \in [1,K]`.
 *)
 
val nextafter : float -> float -> float
(** ``nextafter from to`` returns the next representable double precision value
of ``from`` in the direction of ``to``. If ``from`` equals ``to``, this value
is returned.
 *)

val nextafterf : float -> float -> float
(** ``nextafter from to`` returns the next representable single precision value
of ``from`` in the direction of ``to``. If ``from`` equals ``to``, this value
is returned.
 *)


(* ends here *)
