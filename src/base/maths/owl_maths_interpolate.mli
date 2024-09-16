(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Interpolation and Extrapolation *)

val polint : float array -> float array -> float -> float * float
(**
[polint xs ys x] performs polynomial interpolation of the given arrays [xs]
and [ys]. Given arrays [xs[0..(n-1)]] and [ys[0..(n-1)]], and a value
[x], the function returns a value [y], and an error estimate [dy]. If
[P(x)] is the polynomial of degree [N − 1] such that [P(xs[i]) = ys[i]]
for [i = 0,...,n-1],

Parameters:
  * [xs]: an array of input [x] values of [P(x)].
  * [ys]: an array of corresponding [y] values of [P(x)].
  * [x]: value to interpolate.

Returns:
  * [(y, dy)] wherein [y] is the returned value [y = P(x)], and [dy] is the estimated error.
 *)

val ratint : float array -> float array -> float -> float * float
(** [ratint xs ys x] performs rational function interpolation on the data points 
    given by [xs] and [ys], and returns the interpolated value at the point [x], 
    along with an estimate of the error.

    This function fits a rational function (a ratio of two polynomials) to the 
    provided data points. It is particularly useful when the data exhibits behavior 
    that might be better captured by such a function, especially in cases where 
    the data might have singularities or steep gradients.

    The function raises an exception if the lengths of [xs] and [ys] do not match, 
    or if a pole is encountered during the interpolation process.
    
    Parameters:
    @param xs An array of x-values (the independent variable).
    @param ys An array of y-values (the dependent variable) corresponding to [xs].
    @param x The point at which the interpolated value is to be calculated.

    Returns:
    @return A tuple [(y, dy)], where [y] is the interpolated value at [x], 
            and [dy] is an estimate of the error in the interpolation. 
*)

