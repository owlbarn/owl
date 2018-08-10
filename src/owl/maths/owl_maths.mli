(*
 * OWL - OCaml Scientific and Engineering Computing
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
(** ``add x y`` returns :math:`x + y`. *)

val sub : float -> float -> float
(** ``sub x y`` returns :math:`x - y`. *)

val mul : float -> float -> float
(** ``mul x y`` returns :math:`x * y`. *)

val div : float -> float -> float
(** ``div x y`` returns :math:`x / y`. *)

val atan2 : float -> float -> float
(** ``atan2 y x`` returns :math:`\arctan(y/x)`, accounting for the sign of the arguments;
 this is the angle to the vector :math:`(x, y)` counting from the x-axis. *)

val abs : float -> float
(** ``abs x`` returns :math:`|x|`. *)

val neg : float -> float
(** ``neg x`` returns :math:`-x`. *)

val reci : float -> float
(** ``reci x`` returns :math:`1/x`. *)

val floor : float -> float
(** ``floor x`` returns the largest integer :math:`\leq x`. *)

val ceil : float -> float
(** ``ceil x`` returns the smallest integer :math:`\geq x`. *)

val round : float -> float
(** ``round x`` rounds, towards the bigger integer when on the fence. *)

val trunc : float -> float
(** ``trunc x`` integer part. *)

val sqr : float -> float
(** ``sqr x`` square. *)

val sqrt : float -> float
(** ``sqrt x`` square root. *)

val pow : float -> float -> float
(** ``pow x y`` returns :math:`x^y`. *)

val exp : float -> float
(** ``exp x`` exponential. *)

val expm1 : float -> float
(** ``expm1 x`` returns :math:`\exp(x) - 1` but more accurate for :math:`x \sim 0`. *)

val log : float -> float
(** ``log x`` natural logarithm *)

val log1p : float -> float
(** ``log1p x`` returns :math:`\log (x + 1)` but more accurate for :math:`x \sim 0`.
 Inverse of ``expm1``. *)

val logabs : float -> float
(** ``logabs x`` returns :math:`\log(|x|)`. *)

val log2 : float -> float
(** ``log2 x`` base-2 logarithm. *)

val log10 : float -> float
(** ``log10 x`` base-10 logarithm. *)

val logn : float -> float -> float
(** ``logn x`` base-n logarithm. *)

val sigmoid : float -> float
(** ``sigmoid x`` returns the logistic sigmoid function
:math:`1 / (1 + \exp(-x))`. *)

val signum : float -> float
(** ``signum x`` returns the sign of :math:`x`: -1, 0 or 1. *)

val softsign : float -> float
(** Smoothed sign function. *)

val softplus : float -> float
(** ``softplus x`` returns :math:`\log(1 + \exp(x))`. *)

val relu : float -> float
(** ``relu x`` returns :math:`\max(0, x)`. *)

val sin : float -> float
(** ``sin x`` returns :math:`\sin(x)`. *)

val cos : float -> float
(** ``cos x`` returns :math:`\cos(x)`. *)

val tan : float -> float
(** ``tan x`` returns :math:`\tan(x)`. *)

val cot : float -> float
(** ``cot x`` returns :math:`1/\tan(x)`. *)

val sec : float -> float
(** ``sec x`` returns :math:`1/\cos(x)`. *)

val csc : float -> float
(** ``csc x`` returns :math:`1/\sin(x)`. *)

val asin : float -> float
(** ``asin x`` returns :math:`\arcsin(x)`. *)

val acos : float -> float
(** ``acos x`` returns :math:`\arccos(x)`. *)

val atan : float -> float
(** ``atan x`` returns :math:`\arctan(x)`. *)

val acot : float -> float
(** Inverse function of ``cot``. *)

val asec : float -> float
(** Inverse function of ``sec``. *)

val acsc : float -> float
(** Inverse function of ``csc``. *)

val sinh : float -> float
(** Returns :math:`\sinh(x)`. *)

val cosh : float -> float
(** ``cosh x`` returns :math:`\cosh(x)`. *)

val tanh : float -> float
(** ``tanh x`` returns :math:`\tanh(x)`. *)

val coth : float -> float
(** ``coth x`` returns :math:`\coth(x)`. *)

val sech : float -> float
(** ``sech x`` returns :math:`1/\cosh(x)`. *)

val csch : float -> float
(** ``csch x`` returns :math:`1/\sinh(x)`. *)

val asinh : float -> float
(** Inverse function of ``sinh``. *)

val acosh : float -> float
(** Inverse function of ``cosh``. *)

val atanh : float -> float
(** Inverse function of ``tanh``. *)

val acoth : float -> float
(** Inverse function of ``coth``. *)

val asech : float -> float
(** Inverse function of ``sech``. *)

val acsch : float -> float
(** Inverse function of ``csch``. *)

val sinc : float -> float
(** ``sinc x`` returns :math:`\sin(x)/x` and :math:`1` for :math:`x=0`. *)

val logsinh : float -> float
(** ``logsinh x`` returns :math:`\log(\sinh(x))` but handles large :math:`|x|`. *)

val logcosh : float -> float
(** ``logcosh x`` returns :math:`\log(\cosh(x))` but handles large :math:`|x|`. *)

val sindg : float -> float
(** Sine of angle given in degrees. *)

val cosdg : float -> float
(** Cosine of the angle given in degrees. *)

val tandg : float -> float
(** Tangent of angle given in degrees. *)

val cotdg : float -> float
(** Cotangent of the angle given in degrees. *)

val hypot : float -> float -> float
(** ``hypot x y`` returns :math:`\sqrt{x^2 + y^2}`. *)

val xlogy : float -> float -> float
(** ``xlogy(x, y)`` returns :math:`x \log(y)`. *)

val xlog1py : float -> float -> float
(** ``xlog1py(x, y)`` returns :math:`x \log(y+1)`. *)

val logit : float -> float
(** ``logit(x)`` returns :math:`\log[p/(1-p)]`. *)

val expit : float -> float
(** ``expit(x)`` returns :math:`1/(1+\exp(-x))`. *)


(** {6 Airy functions} *)

val airy : float -> float * float * float * float
(**
Airy function ``airy x`` returns ``(Ai, Ai', Bi, Bi')`` evaluated at :math:`x`.
``Ai'`` is the derivative of ``Ai`` whilst ``Bi'`` is the derivative of ``Bi``.
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
(** Modified Bessel function of the second kind of order 0, :math:`K_0`.*)

val k0e : float -> float
(** Exponentially scaled modified Bessel function K of order 0. *)

val k1 : float -> float
(** Modified Bessel function of the second kind of order 1, :math:`K_1(x)`. *)

val k1e : float -> float
(** Exponentially scaled modified Bessel function K of order 1. *)


(** {6 Elliptic functions} *)

val ellipj : float -> float -> float * float * float * float
(** Jacobian Elliptic function ``ellipj u m`` returns ``(sn, cn, dn, phi)``. *)

val ellipk : float -> float
(** ``ellipk m`` returns the complete elliptic integral of the first kind. *)

val ellipkm1 : float -> float
(** FIXME. Complete elliptic integral of the first kind around :math:`m = 1`. *)

val ellipkinc : float -> float -> float
(** ``ellipkinc phi m`` incomplete elliptic integral of the first kind. *)

val ellipe : float -> float
(** ``ellipe m`` complete elliptic integral of the second kind. *)

val ellipeinc : float -> float -> float
(** ``ellipeinc phi m`` incomplete elliptic integral of the second kind. *)


(** {6 Gamma Functions} *)

val gamma : float -> float
(**
``gamma z`` returns the value of the Gamma function

.. math::
  \Gamma(z) = \int_0^\infty x^{z-1} e^{-x} dx = (z - 1)! .

The gamma function is often referred to as the generalized factorial since
:math:`z\ gamma(z) = \gamma(z+1)` and :math:`gamma(n+1) = n!`
for natural number :math:`n`.
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
(** Inverse function of ``betainc``. *)


(** {6 Factorials} *)

val fact : int -> float
(** Factorial function ``fact n`` calculates :math:`n!`. *)

val log_fact : int -> float
(** Logarithm of factorial function ``log_fact n`` calculates :math:`\log n!`. *)

val doublefact : int -> float
(** Double factorial function ``doublefact n`` calculates
:math:`n!! = n(n-2)(n-4)\dots 2` or :math:`\dots 1` *)

val log_doublefact : int -> float
(** Logarithm of double factorial function. *)

val permutation : int -> int -> int
(** ``permutation n k`` returns the number :math:`n!/(n-k)!` of ordered subsets
 * of length :math:`k`, taken from a set of :math:`n` elements. *)

val permutation_float : int -> int -> float
(**
``permutation_float`` is like ``permutation`` but deals with larger range.
 *)

val combination : int -> int -> int
(** ``combination n k`` returns the number :math:`n!/(k!(n-k)!)` of subsets of k elements
    of a set of n elements. This is the binomial coefficient
    :math:`\binom{n}{k}` *)

val combination_float : int -> int -> float
(** ``combination_float`` is like ``combination`` but can deal with a larger range. *)

val log_combination : int -> int -> float
(** ``log_combination n k`` returns the logarithm of :math:`\binom{n}{k}`. *)


(** {6 Error functions} *)

val erf : float -> float
(** Error function. :math:`\int_{-\infty}^x \frac{1}{\sqrt(2\pi)} \exp(-(1/2) y^2) dy` *)

val erfc : float -> float
(** Complementary error function, :math:`\int^{\infty}_x \frac{1}{\sqrt(2\pi)} \exp(-(1/2) y^2) dy` *)

val erfcx : float -> float
(** Scaled complementary error function, :math:`\exp(x^2) \mathrm{erfc}(x)`. *)

val erfinv : float -> float
(** Inverse function of ``erf``. *)

val erfcinv : float -> float
(** Inverse function of ``erfc``. *)


(** {6 Dawson & Fresnel integrals} *)

val dawsn : float -> float
(** Dawson’s integral. *)

val fresnel : float -> float * float
(** Fresnel trigonometric integrals. ``fresnel x`` returns a tuple consisting of
``(Fresnel sin integral, Fresnel cos integral)``. *)


(** {6 Struve functions} *)

val struve : float -> float -> float
(** ``struve v x`` returns the value of the Struve function of
order :math:`v` at :math:`x`. The Struve function is defined as,

.. math::
  H_v(x) = (z/2)^{v + 1} \sum_{n=0}^\infty \frac{(-1)^n (z/2)^{2n}}{\Gamma(n + \frac{3}{2}) \Gamma(n + v + \frac{3}{2})},

where :math:`\Gamma` is the gamma function. :math:`x` must be positive unless :math:`v` is an integer

 *)


(** {6 Other special functions} *)

val expn : int -> float -> float
(** Exponential integral :math:`E_n`. *)

val shichi : float -> float * float
(** Hyperbolic sine and cosine integrals, ``shichi x`` returns
 * :math:`(\mathrm{shi}, \mathrm{chi})``. *)

val shi : float -> float
(** Hyperbolic sine integral. *)

val chi : float -> float
(** Hyperbolic cosine integral. *)

val sici : float -> float * float
(** Sine and cosine integrals, ``sici x`` returns :math:`(\mathrm{si}, \mathrm{ci})`. *)

val si : float -> float
(** Sine integral. *)

val ci : float -> float
(** Cosine integral. *)

val zeta : float -> float -> float
(** ``zeta x q`` returns the Hurwitz zeta function :math:`\zeta(x, q)`, which
    reduces to the Riemann zeta function :math:`\zeta(x)` when :math:`q=1`. *)

val zetac : float -> float
(** Riemann zeta function minus 1. *)

(** {6 Raw statistical functions} *)

val bdtr : int -> int -> float -> float
(**
Binomial distribution cumulative distribution function.

``bdtr k n p`` calculates the sum of the terms :math:`0` through :math:`k` of
the Binomial probability density.

.. math::
  \mathrm{bdtr}(k, n, p) = \sum_{j=0}^k {{n}\choose{j}} p^j (1-p)^{n-j}

Parameters:
  * ``k``: Number of successes.
  * ``n``: Number of events.
  * ``p``: Probability of success in a single event.

Returns:
  * Probability of :math:`k` or fewer successes in :math:`n` independent events with success
    probability :math:`p`.
 *)

val bdtrc : int -> int -> float -> float
(**
Binomial distribution survival function.

``bdtrc k n p`` calculates the sum of the terms :math:`k + 1` through :math:`n`
of the binomial probability density,

.. math::
  \mathrm{bdtrc}(k, n, p) = \sum_{j=k+1}^n {{n}\choose{j}} p^j (1-p)^{n-j}

 *)

val bdtri : int -> int -> float -> float
(**
Inverse function to ``bdtr`` with respect to :math:`p`.

Finds the event probability :math:`p` such that the sum of the terms 0 through
:math:`k` of the binomial probability density is equal to the given cumulative
probability :math:`y`.
 *)


val btdtr : float -> float -> float -> float
(**
Cumulative density function of the beta distribution.

``btdtr a b x`` returns the integral from 0 to :math:`x` of the beta probability
density function,

.. math::
  I = \int_0^x \frac{\Gamma(a + b)}{\Gamma(a)\Gamma(b)} t^{a-1} (1-t)^{b-1}\,dt

where :math:`\Gamma` is the gamma function.

Parameters:
  * ``a``: Shape parameter (:math:`a > 0`).
  * ``b``: Shape parameter (:math:`a > 0`).
  * ``x``: Upper limit of integration, in :math:`[0, 1]`.

Returns:
  * Cumulative density function of the beta distribution with :math:`a` and
    :math:`b` at :math:`x`.
 *)

val btdtri : float -> float -> float -> float
(**
The :math:`p`-th quantile of the Beta distribution.

This function is the inverse of the beta cumulative distribution function,
   ``btdtr``, returning the value of :math:`x` for which
   :math:`\mathrm{btdtr}(a, b, x) = p`,

.. math::
  p = \int_0^x \frac{\Gamma(a + b)}{\Gamma(a)\Gamma(b)} t^{a-1} (1-t)^{b-1}\,dt

where :math:`\Gamma` is the gamma function.

Parameters:
  * ``a``: Shape parameter (:math:`a > 0`).
  * ``b``: Shape parameter (:math:`a > 0`).
  * ``x``: Cumulative probability, in :math:`[0, 1]`.

Returns:
  * The quantile corresponding to :math:`p`.
 *)


(** {6 Helper functions} *)

val is_nan : float -> bool
(** ``is_nan x`` returns ``true`` exactly if ``x`` is ``nan``. *)

val is_inf : float -> bool
(** ``is_inf x`` returns ``true`` exactly if ``x`` is ``infinity`` or ``neg_infinity``. *)

val is_normal : float -> bool
(** ``is_normal x`` returns ``true`` if ``x`` is a normal float number. *)

val is_subnormal : float -> bool
(** ``is_nan x`` returns ``true`` if ``x`` is subnormal float number. *)

val is_odd : int -> bool
(** ``is_odd x`` returns ``true`` exactly if ``x`` is odd. *)

val is_even : int -> bool
(** ``is_even x`` returns ``true`` exactly if ``x`` is even. *)

val is_pow2 : int -> bool
(** ``is_pow2 x`` return ``true`` exactly if ``x`` is an integer power of 2, e.g. 32, 64, etc. *)

val same_sign : float -> float -> bool
(** ``same_sign x y`` returns ``true`` if ``x`` and ``y`` have the same sign,
otherwise it returns ``false``. Positive and negative zeros are special cases
and always returns ``true``. *)

val is_simplex : float array -> bool
(**
``is_simplex x`` checks whether the vector :math:`x` lies on a simplex. In
other words, :math:`\sum_i^K x_i = 1` and :math:`x_i \ge 0, \forall i \in
[1,K]`, where :math:`K` is the dimension of :math:`x`.
 *)

val is_int : float -> bool
(* ``is_int x`` checks if ``x`` is an integer, i.e. fractional part is zero. *)

val is_sqr : int -> bool
(** ``is_sqr x`` checks if ``x`` is the square of an integer. *)

val fermat_fact : int -> int * int
(**
``fermat_fact x`` performs Fermat factorisation over ``x``, i.e. into two
roughly equal factors. ``x`` must be an odd number.
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
