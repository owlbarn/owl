(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Maths: fundamental and advanced mathematical functions. *)

(**
  This module contains some basic and advanced mathematical operations.
  If you cannot find some function in this module, try Stats module.

  Please refer to Scipy documentation.
*)

(** {5 Basic functions} *)

val add : float -> float -> float
(** [add x y] returns x + y. *)

val sub : float -> float -> float
(** [sub x y] returns x - y. *)

val mul : float -> float -> float
(** [mul x y] returns x * y. *)

val div : float -> float -> float
(** [div x y] returns x / y. *)

val fmod : float -> float -> float
(** [fmod x y] returns x % y. *)

val atan2 : float -> float -> float
(** [atan2 y x] returns {m \arctan(y/x)}, accounting for the sign of the arguments;
 this is the angle to the vector {m (x, y)} counting from the x-axis. *)

val abs : float -> float
(** [abs x] returns ={m |x|}. *)

val neg : float -> float
(** [neg x] returns -x. *)

val reci : float -> float
(** [reci x] returns 1/x. *)

val floor : float -> float
(** [floor x] returns the largest integer {m \leq x}. *)

val ceil : float -> float
(** [ceil x] returns the smallest integer {m  \geq x}. *)

val round : float -> float
(** [round x] rounds, towards the bigger integer when on the fence. *)

val trunc : float -> float
(** [trunc x] integer part. *)

val sqr : float -> float
(** [sqr x] square. *)

val sqrt : float -> float
(** [sqrt x] square root. *)

val pow : float -> float -> float
(** [pow x y] returns {m x^y}. *)

val exp : float -> float
(** [exp x] exponential. *)

val exp2 : float -> float
(** [exp2 x] exponential. *)

val exp10 : float -> float
(** [exp10 x] exponential. *)

val expm1 : float -> float
(** [expm1 x] returns {m \exp(x) - 1} but more accurate for {m x \sim 0}. *)

val log : float -> float
(** [log x] natural logarithm *)

val log2 : float -> float
(** [log2 x] base-2 logarithm. *)

val log10 : float -> float
(** [log10 x] base-10 logarithm. *)

val logn : float -> float -> float
(** [logn x] base-n logarithm. *)

val log1p : float -> float
(** [log1p x] returns {m \log (x + 1)} but more accurate for {m x \sim 0}.
 Inverse of [expm1]. *)

val logabs : float -> float
(** [logabs x] returns {m \log(|x|)}. *)

val sigmoid : float -> float
(** [sigmoid x] returns the logistic sigmoid function
{m 1 / (1 + \exp(-x))}. *)

val signum : float -> float
(** [signum x] returns the sign of x -1, 0 or 1. *)

val softsign : float -> float
(** Smoothed sign function. *)

val softplus : float -> float
(** [softplus x] returns {m \log(1 + \exp(x))}. *)

val relu : float -> float
(** [relu x] returns {m \max(0, x)}. *)

val sin : float -> float
(** [sin x] returns {m \sin(x)}. *)

val cos : float -> float
(** [cos x] returns {m \cos(x)}. *)

val tan : float -> float
(** [tan x] returns {m \tan(x)}. *)

val cot : float -> float
(** [cot x] returns {m 1/\tan(x)}. *)

val sec : float -> float
(** [sec x] returns {m 1/\cos(x)}. *)

val csc : float -> float
(** [csc x] returns {m 1/\sin(x)}. *)

val asin : float -> float
(** [asin x] returns {m \arcsin(x)}. *)

val acos : float -> float
(** [acos x] returns {m \arccos(x)}. *)

val atan : float -> float

val acot : float -> float
(** Inverse function of [cot]. *)

val asec : float -> float
(** Inverse function of [sec]. *)

val acsc : float -> float
(** Inverse function of [csc]. *)

val sinh : float -> float
(** Returns {m \sinh(x)}. *)

val cosh : float -> float
(** [cosh x] returns {m \cosh(x)}. *)

val tanh : float -> float
(** [tanh x] returns {m \tanh(x)}. *)

val coth : float -> float
(** [coth x] returns {m \coth(x)}. *)

val sech : float -> float
(** [sech x] returns {m 1/\cosh(x)}. *)

val csch : float -> float
(** [csch x] returns {m 1/\sinh(x)}. *)

val asinh : float -> float
(** Inverse function of [sinh]. *)

val acosh : float -> float
(** Inverse function of [cosh]. *)

val atanh : float -> float
(** Inverse function of [tanh]. *)

val acoth : float -> float
(** Inverse function of [coth]. *)

val asech : float -> float
(** Inverse function of [sech]. *)

val acsch : float -> float
(** Inverse function of [csch]. *)

val sinc : float -> float
(** [sinc x] returns {m \sin(x)/x} and {m 1} for {m x=0}. *)

val logsinh : float -> float
(** [logsinh x] returns {m \log(\sinh(x))} but handles large {m |x|}. *)

val logcosh : float -> float
(** [logcosh x] returns {m \log(\cosh(x))} but handles large {m |x|}. *)

val sindg : float -> float
(** Sine of angle given in degrees. *)

val cosdg : float -> float
(** Cosine of the angle given in degrees. *)

val tandg : float -> float
(** Tangent of angle given in degrees. *)

val cotdg : float -> float
(** Cotangent of the angle given in degrees. *)

val hypot : float -> float -> float
(** [hypot x y] returns {m \sqrt{x^2 + y^2}}. *)

val xlogy : float -> float -> float
(** [xlogy(x, y)] returns {m x \log(y)}. *)

val xlog1py : float -> float -> float
(** [xlog1py(x, y)] returns {m x \log(y+1)}. *)

val logit : float -> float
(** [logit(x)] returns {m \log\left(\frac{p}{1-p}\right)}. *)

val expit : float -> float
(** [expit(x)] returns {m \frac{1}{1+\exp(-x)}}. *)

val log1mexp : float -> float
(** [log1mexp(x)] returns {m \log(1-\exp(x))}. *)

val log1pexp : float -> float
(** [log1pexp(x)] returns {m \log(1+\exp(x))}. *)

(** {5 Airy functions} *)

val airy : float -> float * float * float * float
(**
Airy function [airy x] returns [(Ai, Ai', Bi, Bi')] evaluated at x.
[Ai'] is the derivative of [Ai] whilst [Bi'] is the derivative of [Bi].
*)

(** {5 Bessel functions} *)

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
(** Modified Bessel function of the second kind of order 0, {m K_0}. *)

val k0e : float -> float
(** Exponentially scaled modified Bessel function K of order 0. *)

val k1 : float -> float
(** Modified Bessel function of the second kind of order 1, {m K_1(x)}. *)

val k1e : float -> float
(** Exponentially scaled modified Bessel function K of order 1. *)

(** {5 Elliptic functions} *)

val ellipj : float -> float -> float * float * float * float
(** Jacobian Elliptic function [ellipj u m] returns [(sn, cn, dn, phi)]. *)

val ellipk : float -> float
(** [ellipk m] returns the complete elliptic integral of the first kind. *)

val ellipkm1 : float -> float
(** FIXME. Complete elliptic integral of the first kind around {m m = 1}. *)

val ellipkinc : float -> float -> float
(** [ellipkinc phi m] incomplete elliptic integral of the first kind. *)

val ellipe : float -> float
(** [ellipe m] complete elliptic integral of the second kind. *)

val ellipeinc : float -> float -> float
(** [ellipeinc phi m] incomplete elliptic integral of the second kind. *)

(** {5 Gamma Functions} *)

val gamma : float -> float
(**
[gamma z] returns the value of the Gamma function

  {math \Gamma(z) = \int_0^\infty x^{z-1} e^{-x} dx = (z - 1)!.}

The gamma function is often referred to as the generalized factorial since
{m z\gamma(z) = \gamma(z+1)} and {m \gamma(n+1) = n!}
for natural number n.
 *)

val rgamma : float -> float
(** Reciprocal Gamma function. *)

val loggamma : float -> float
(** Logarithm of the gamma function. *)

val gammainc : float -> float -> float
(** Incomplete gamma function. *)

val gammaincinv : float -> float -> float
(** Inverse function of [gammainc]. *)

val gammaincc : float -> float -> float
(** Complemented incomplete gamma integral. *)

val gammainccinv : float -> float -> float
(** Inverse function of [gammaincc]. *)

val psi : float -> float
(** The digamma function. *)

(** {5 Beta functions} *)

val beta : float -> float -> float
(**
Beta function.

{math
  \mathrm{B}(a, b) =  \frac{\Gamma(a) \Gamma(b)}{\Gamma(a+b)}}
  *)

val betainc : float -> float -> float -> float
(** Incomplete beta integral. *)

val betaincinv : float -> float -> float -> float
(** Inverse function of [betainc]. *)

(** {5 Factorials} *)

val fact : int -> float
(** Factorial function [fact n] calculates {m n!}. *)

val log_fact : int -> float
(** Logarithm of factorial function [log_fact n] calculates {m \log n!}. *)

val doublefact : int -> float
(** Double factorial function [doublefact n] calculates
    {m n!! = n(n-2)(n-4)\dots 2} or {m \dots 1}. *)

val log_doublefact : int -> float
(** Logarithm of double factorial function. *)

val permutation : int -> int -> int
(** [permutation n k] returns the number {m \frac{n!}{(n-k)!}} of ordered subsets
    of length {m k}, taken from a set of {m n} elements. *)


val permutation_float : int -> int -> float
(**
[permutation_float] is like [permutation] but deals with larger range.
 *)

val combination : int -> int -> int
(** [combination n k] returns the number {m n!/(k!(n-k)!)} of subsets of k elements
    of a set of n elements. This is the binomial coefficient
    {m \binom{n}{k}} *)

val combination_float : int -> int -> float
(** [combination_float] is like [combination] but can deal with a larger range. *)

val log_combination : int -> int -> float
(** [log_combination n k] returns the logarithm of {m \binom{n}{k}}. *)

(** {5 Error functions} *)

val erf : float -> float
(** Error function. {m \int_{-\infty}^x \frac{1}{\sqrt(2\pi)} \exp(-(1/2) y^2) dy} *)

val erfc : float -> float
(** Complementary error function, {m \int^{\infty}_x \frac{1}{\sqrt(2\pi)} \exp(-(1/2) y^2) dy} *)

val erfcx : float -> float
(** Scaled complementary error function, {m \exp(x^2) \mathrm{erfc}(x)}. *)

val erfinv : float -> float
(** Inverse function of [erf]. *)

val erfcinv : float -> float
(** Inverse function of [erfc]. *)

(** {5 Dawson & Fresnel integrals} *)

val dawsn : float -> float
(** Dawson’s integral. *)

val fresnel : float -> float * float
(** Fresnel trigonometric integrals. [fresnel x] returns a tuple consisting of
[(Fresnel sin integral, Fresnel cos integral)]. *)

(** {5 Struve functions} *)

val struve : float -> float -> float
(** [struve v x] returns the value of the Struve function of
order v at x. The Struve function is defined as,

{math  H_v(x) = (z/2)^{v + 1}\sum_{n=0}^\infty \frac{(-1)^n (z/2)^{2n}}{\Gamma(n + \frac{3}{2})\Gamma(n + v + \frac{3}{2})}}

where {m \Gamma} is the gamma function. {m x} must be positive unless {m v} is an integer

 *)

(** {5 Other special functions} *)

val expn : int -> float -> float
(** Exponential integral {m E_n}. *)

val shichi : float -> float * float
(** Hyperbolic sine and cosine integrals, [shichi x] returns
 * {m (\mathrm{shi}, \mathrm{chi})}. *)

val shi : float -> float
(** Hyperbolic sine integral. *)

val chi : float -> float
(** Hyperbolic cosine integral. *)

val sici : float -> float * float
(** Sine and cosine integrals, [sici x] returns {m (\mathrm{si}, \mathrm{ci})}. *)

val si : float -> float
(** Sine integral. *)

val ci : float -> float
(** Cosine integral. *)

val zeta : float -> float -> float
(** [zeta x q] returns the Hurwitz zeta function {m \zeta(x, q)}, which
    reduces to the Riemann zeta function {m \zeta(x)} when {m q=1}. *)

val zetac : float -> float
(** Riemann zeta function minus 1. *)

(** {5 Raw statistical functions} *)

val bdtr : int -> int -> float -> float
(**
Binomial distribution cumulative distribution function.

[bdtr k n p] calculates the sum of the terms {m 0} through {m k} of
the Binomial probability density.

{m \mathrm{bdtr}(k, n, p) = \sum_{j=0}^k \binom{n}{j} p^j (1-p)^{n-j}}

Parameters:
  * [k]: Number of successes.
  * [n]: Number of events.
  * [p]: Probability of success in a single event.

Returns:
  * Probability of {m k} or fewer successes in {m n} independent events with success
    probability {m p}.
 *)

val bdtrc : int -> int -> float -> float
(**
Binomial distribution survival function.

[bdtrc k n p] calculates the sum of the terms {m k + 1} through {m n}
of the binomial probability density,

{m \mathrm{bdtrc}(k, n, p) = \sum_{j=k+1}^n \binom{n}{j} p^j (1-p)^{n-j}}

 *)

val bdtri : int -> int -> float -> float
(**
Inverse function to [bdtr] with respect to {m p}.

Finds the event probability {m p} such that the sum of the terms 0 through
[k] of the binomial probability density is equal to the given cumulative
probability {m y}.
 *)

val btdtr : float -> float -> float -> float
(**
Cumulative density function of the beta distribution.

[btdtr a b x] returns the integral from 0 to {m x} of the beta probability
density function,

{m I = \int_0^x \frac{\Gamma(a + b)}{\Gamma(a)\Gamma(b)} t^{a-1} (1-t)^{b-1}\,dt}

where {m \Gamma} is the gamma function.

Parameters:
  * [a]: Shape parameter ({m a > 0}).
  * [b]: Shape parameter ({m b > 0}).
  * [x]: Upper limit of integration, in {m [0, 1]}.

Returns:
  * Cumulative density function of the beta distribution with {m a} and
    {m b} at {m x}.
 *)

val btdtri : float -> float -> float -> float
(**
The {m p}-th quantile of the Beta distribution.

This function is the inverse of the beta cumulative distribution function,
   [btdtr], returning the value of {m x} for which
   {m \mathrm{btdtr}(a, b, x) = p},

{math 
  p = \int_0^x \frac{\Gamma(a + b)}{\Gamma(a)\Gamma(b)} t^{a-1} (1-t)^{b-1}\,dt}

where {m \Gamma} is the gamma function.

Parameters:
  * [a]: Shape parameter ({m a > 0}).
  * [b]: Shape parameter ({m b > 0}).
  * [x]: Cumulative probability, in {m [0, 1]}.

Returns:
  * The quantile corresponding to {m p}.
 *)

(** {5 Helper functions} *)

val is_nan : float -> bool
(** [is_nan x] returns [true] exactly if [x] is [nan]. *)

val is_inf : float -> bool
(** [is_inf x] returns [true] exactly if [x] is [infinity] or [neg_infinity]. *)

val is_normal : float -> bool
(** [is_normal x] returns [true] if [x] is a normal float number. *)

val is_subnormal : float -> bool
(** [is_nan x] returns [true] if [x] is subnormal float number. *)

val is_odd : int -> bool
(** [is_odd x] returns [true] exactly if [x] is odd. *)

val is_even : int -> bool
(** [is_even x] returns [true] exactly if [x] is even. *)

val is_pow2 : int -> bool
(** [is_pow2 x] return [true] exactly if [x] is an integer power of 2, e.g. 32, 64, etc. *)

val same_sign : float -> float -> bool
(** [same_sign x y] returns [true] if [x] and [y] have the same sign,
otherwise it returns [false]. Positive and negative zeros are special cases
and always returns [true]. *)

val is_simplex : float array -> bool
(**
[is_simplex x] checks whether the vector {m x} lies on a simplex. In
other words, {m \sum_i^K x_i = 1} 
and {m x_i\ge~0,\forall~i\in~[1,K]}, where {m K} is the dimension of {m x}.
 *)

val is_int : float -> bool

(* [is_int x] checks if [x] is an integer, i.e. fractional part is zero. *)

val is_sqr : int -> bool
(** [is_sqr x] checks if [x] is the square of an integer. *)

val mulmod : int -> int -> int -> int
(** [mulmod a b m] computes (a*b) mod m. *)

val powmod : int -> int -> int -> int
(** [powmod a b m] computes (a^b) mod m. *)

val is_prime : int -> bool
(**
[is_prime x] returns [true] if [x] is a prime number. The function is
deterministic for all numbers representable by an int. The function uses the
Rabin–Miller primality test.
*)

val fermat_fact : int -> int * int
(**
[fermat_fact x] performs Fermat factorisation over [x], i.e. into two
roughly equal factors. [x] must be an odd number.
 *)

val nextafter : float -> float -> float
(** [nextafter from to] returns the next representable double precision value
of [from] in the direction of [to]. If [from] equals [to], this value
is returned.
 *)

val nextafterf : float -> float -> float
(** [nextafter from to] returns the next representable single precision value
of [from] in the direction of [to]. If [from] equals [to], this value
is returned.
 *)

(* ends here *)
