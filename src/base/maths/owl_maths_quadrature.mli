(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numerical Integration *)


(** {6 Integration functions} *)

val trapz : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(**
``trapz f a b`` computes the integral of ``f`` on the interval ``[a,b]`` using
the trapezoidal rule, i.e. :math:`\int_a^b f(x) dx`.

Parameters:
  * ``f``: function to be integrated.
  * ``n``: the maximum allowed number of steps. The default value is ``20``.
  * ``eps``: the desired fractional accuracy. The default value is ``1e-6``.
  * ``a``: lower bound of the integrated interval.
  * ``b``: upper bound of the integrated interval.

Returns:
  * ``y``: the integral of ``f`` on ``[a, b]``.
 *)

val simpson : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(**
``simpson f a b`` computes the integral of ``f`` on the interval ``[a,b]`` using
the Simpson's rule, i.e. :math:`\int_a^b f(x) dx`.

Parameters:
  * ``f``: function to be integrated.
  * ``n``: the maximum allowed number of steps. The default value is ``20``.
  * ``eps``: the desired fractional accuracy. The default value is ``1e-6``.
  * ``a``: lower bound of the integrated interval.
  * ``b``: upper bound of the integrated interval.

Returns:
  * ``y``: the integral of ``f`` on ``[a, b]``.
 *)

val romberg : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(**
``romberg f a b`` computes the integral of ``f`` on the interval ``[a,b]`` using
the Romberg method, i.e. :math:`\int_a^b f(x) dx`. Note that this algorithm is
much faster than ``trapz`` and ``simpson``.

Parameters:
  * ``f``: function to be integrated.
  * ``n``: the maximum allowed number of steps. The default value is ``20``.
  * ``eps``: the desired fractional accuracy. The default value is ``1e-6``.
  * ``a``: lower bound of the integrated interval.
  * ``b``: upper bound of the integrated interval.

Returns:
  * ``y``: the integral of ``f`` on ``[a, b]``.
 *)


val gaussian_fixed : ?n:int -> (float -> float) -> float -> float -> float
(**
``gaussian_fixed f a b`` computes the integral of ``f`` on the interval
``[a,b]`` using the Gaussian quadrature of fixed order. Note that this
algorithm is much faster than others due to cached weights.

Parameters:
  * ``f``: function to be integrated.
  * ``n``: the order of polynomial. The default value is ``10``.
  * ``a``: lower bound of the integrated interval.
  * ``b``: upper bound of the integrated interval.

Returns:
  * ``y``: the integral of ``f`` on ``[a, b]``.
 *)

val gaussian : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(**
``gaussian f a b`` computes the integral of ``f`` on the interval  ``[a,b]``
using adaptive Gaussian quadrature of fixed tolerance.

Parameters:
  * ``f``: function to be integrated.
  * ``n``: the maximum order. The default value is ``50``.
  * ``eps``: the desired fractional accuracy. The default value is ``1e-6``.
  * ``a``: lower bound of the integrated interval.
  * ``b``: upper bound of the integrated interval.

Returns:
  * ``y``: the integral of ``f`` on ``[a, b]``.
 *)


(** {6 Helper functions} *)

val trapzd : (float -> float) -> float -> float -> int -> float
(**
The function computes the nth stage of refinement of an extended trapezoidal
rule. It is the workhorse of several integration functions including ``trapz``,
``simpson``, and ``romberg``.

Parameters:
  * ``f``: function to be integrated.
  * ``a``: lower bound of the integrated interval.
  * ``b``: upper bound of the integrated interval.
  * ``n``: the nth stage.

Returns:
  * ``y``: the integral of ``f`` on ``[a, b]``.
 *)

val gauss_legendre : ?eps:float -> ?a:float -> ?b:float -> int -> float array * float array
(**
Given the lower and upper limits of integration ``a`` and ``b``, and order
``n``, the function computes the abscissas and weights of the Gauss-Legendre
n-point quadrature formula.
*)
