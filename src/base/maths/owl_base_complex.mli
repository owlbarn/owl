(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition and constants} *)

type t = Complex.t

val zero : t

val one : t

val i : t


(** {6 Unary functions} *)

val neg : t -> t

val abs : t -> float

val abs2 : t -> float

val logabs : t -> float

val conj : t -> t

val inv : t -> t

val sqrt : t -> t

val arg : t -> float

val exp : t -> t

val log : t -> t

val sin : t -> t

val cos : t -> t

val tan : t -> t

val cot : t -> t

val sec : t -> t

val csc : t -> t


(** {6 Binary functions} *)

val add : t -> t -> t

val sub : t -> t -> t

val mul : t -> t -> t

val div : t -> t -> t

val add_re : t -> float -> t

val add_im : t -> float -> t

val sub_re : t -> float -> t

val sub_im : t -> float -> t

val mul_re : t -> float -> t

val mul_im : t -> float -> t

val div_re : t -> float -> t

val div_im : t -> float -> t

val polar : float -> float -> t

val pow : t -> t -> t
