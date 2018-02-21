(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Root finding algorithms for nonlinear functions *)


(** {6 Type definition} *)

type solver =
  | Bisec
  | FalsePos
  | Ridder
  | Brent
(** Type of root functions of univariate functions. *)


(** {6 Core functions} *)

val fzero : ?solver:solver -> ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(**
``fzero ~solver f a b`` tries to find the root of univariate function ``f`` in
the bracket ``[a, b]`` using method ``solver``. This is the hub function of the
individual root finding algorithms in the following sections. You can certainly
call each individual ones.

Parameters:
  * ``solver``: solver, default one is Brent method.
  * ``max_iter``: maximum number of iterations, default value is ``1000``.
  * ``xtol``: the tolerance of ``x`` on abscissa, default value is ``1e-6``.
  * ``f``: the univariate scalar function to find root.
  * ``a``: boundary of bracket.
  * ``b``: boundary of bracket.
 *)


(** {6 Root of univariate functions} *)

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

Refer to :cite:`brent2013algorithms`
 *)
