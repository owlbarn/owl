(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Interpolation and Extrapolation *)


val polint : float array -> float array -> float -> float * float
(**
``polint xs ys x`` performs polynomial interpolation of the given arrays ``xs``
and ``ys``. Given arrays ``xs[0..(n-1)]`` and ``ys[0..(n-1)]``, and a value
``x``, the function returns a value ``y``, and an error estimate ``dy``. If
``P(x)`` is the polynomial of degree ``N − 1`` such that ``P(xs[i]) = ys[i]``
for ``i = 0,...,n-1``,

Parameters:
  * ``xs``: an array of input ``x`` values of ``P(x)``.
  * ``ys``: an array of corresponding ``y`` values of ``P(x)``.
  * ``x``: value to interpolate.

Returns:
  * ``(y, dy)`` wherein ``y`` is the returned value ``y = P(x)``, and ``dy`` is the estimated error.
 *)


val ratint : float array -> float array -> float -> float * float
(**
  TODO
 *)
