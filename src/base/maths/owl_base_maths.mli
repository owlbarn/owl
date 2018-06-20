(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Maths: fundamental and advanced mathematical functions. *)


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

val log : float -> float
(** ``log x`` *)

val log2 : float -> float
(** ``log2 x`` *)

val log10 : float -> float
(** ``log10 x`` *)

val sigmoid : float -> float
(** ``sigmod x`` *)

val signum : float -> float
(** ``signum x`` *)

val relu : float -> float
(** ``relu x`` *)

val sin : float -> float
(** ``sin x`` *)

val cos : float -> float
(** ``cos x`` *)

val tan : float -> float
(** ``tan x`` *)

val asin : float -> float
(** ``asin x`` *)

val acos : float -> float
(** ``acos x`` *)

val atan : float -> float
(** ``atan x`` *)

val sinh : float -> float
(** ``sinh x`` *)

val cosh : float -> float
(** ``cosh x`` *)

val tanh : float -> float
(** ``tanh x`` *)

val asinh : float -> float
(** ``asinh x`` *)

val acosh : float -> float
(** ``acosh x`` *)

val atanh : float -> float
(** ``atanh x`` *)


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

val is_int : float -> bool
(* ``is_int x`` checks if ``x`` is an integer, i.e. fractional part is zero. *)

val is_sqr : int -> bool
(** ``is_sqr x`` checks if ``x`` is the square of an integer. *)

val fermat_fact : int -> int * int
(**
``fermat_fact x`` performs Fermat factorisation over ``x``, i.e. into two
roughly equal factors. ``x`` must be an odd number.
 *)


(* ends here *)
