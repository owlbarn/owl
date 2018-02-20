(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Root finding algorithms *)

val bisec : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(**
``bisec f a b`` tries to find the root of univariate function ``f`` in the
bracket defined by ``[a, b]``.

Parameters:
  * ``max_iter``: maximum number of iterations.
  * ``xtol``: the tolerance of ``x`` on abscissa.
  * ``f``: the univariate scalar function to find root.
  * ``a``: boundary of bracket.
  * ``b``: boundary of bracket.
 *)

val false_pos : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(**
``false_pos f a b`` tries to find the root of univariate function ``f`` in the
bracket defined by ``[a, b]``.

Parameters:
  * ``max_iter``: maximum number of iterations.
  * ``xtol``: the tolerance of ``x`` on abscissa.
  * ``f``: the univariate scalar function to find root.
  * ``a``: boundary of bracket.
  * ``b``: boundary of bracket.
 *)

val ridder : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(**
``ridder f a b`` tries to find the root of univariate function ``f`` in the
bracket defined by ``[a, b]``.

Parameters:
  * ``max_iter``: maximum number of iterations.
  * ``xtol``: the tolerance of ``x`` on abscissa.
  * ``f``: the univariate scalar function to find root.
  * ``a``: boundary of bracket.
  * ``b``: boundary of bracket.
 *)

val brent : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(**
``brent f a b`` tries to find the root of univariate function ``f`` in the
bracket defined by ``[a, b]``.

Parameters:
  * ``max_iter``: maximum number of iterations.
  * ``xtol``: the tolerance of ``x`` on abscissa.
  * ``f``: the univariate scalar function to find root.
  * ``a``: boundary of bracket.
  * ``b``: boundary of bracket.

Refer to Brent, R. P., Algorithms for Minimization Without Derivatives. Englewood Cliffs, NJ: Prentice-Hall, 1973. Ch. 3-4.

 *)
