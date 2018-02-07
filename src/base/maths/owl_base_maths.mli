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

(* ends here *)
