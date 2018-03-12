(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_primitive


(** {6 Core functions} *)

val of_ndarray : ('a, 'b) Owl_dense_ndarray_generic.t -> t
(** ``of_ndarray x`` *)

val to_ndarray : ('a, 'b) Bigarray.kind -> t -> ('a, 'b) Owl_dense_ndarray_generic.t
(** ``to_ndarray otyp x`` *)


(** {6 Unary math functions} *)

val erf : t -> t
(** ``erf x`` *)

val erfc : t -> t
(** ``erfc x`` *)

val abs : t -> t
(** ``abs x`` *)

val neg : t -> t
(** ``neg x`` *)

val sqr : t -> t
(** ``sqr x`` *)

val sqrt : t -> t
(** ``sqrt x`` *)

val cbrt : t -> t
(** ``cbrt x`` *)

val reci : t -> t
(** ``reci x`` *)

val sin : t -> t
(** ``sin x`` *)

val cos : t -> t
(** ``cos x`` *)

val tan : t -> t
(** ``tan x`` *)

val asin : t -> t
(** ``asin x`` *)

val acos : t -> t
(** ``acos x`` *)

val atan : t -> t
(** ``atan x`` *)

val sinh : t -> t
(** ``sinh x`` *)

val cosh : t -> t
(** ``cosh x`` *)

val tanh : t -> t
(** ``tanh x`` *)

val asinh : t -> t
(** ``asinh x`` *)

val acosh : t -> t
(** ``acosh x`` *)

val atanh : t -> t
(** ``atanh x`` *)

val atanpi : t -> t
(** ``atanpi x`` *)

val sinpi : t -> t
(** ``sinpi x`` *)

val cospi : t -> t
(** ``cospi x`` *)

val tanpi : t -> t
(** ``tanpi x`` *)

val floor : t -> t
(** ``floor x`` *)

val ceil : t -> t
(** ``ceil x`` *)

val round : t -> t
(** ``round x`` *)

val exp : t -> t
(** ``exp x`` *)

val exp2 : t -> t
(** ``exp2 x`` *)

val exp10 : t -> t
(** ``exp10 x`` *)

val expm1 : t -> t
(** ``expm1 x`` *)

val log : t -> t
(** ``log x`` *)

val log2 : t -> t
(** ``log2 x`` *)

val log10 : t -> t
(** ``log10 x`` *)

val log1p : t -> t
(** ``log1p x`` *)

val logb : t -> t
(** ``logb x`` *)

val relu : t -> t
(** ``relu x`` *)

val signum : t -> t
(** ``signum x`` *)

val sigmoid : t -> t
(** ``sigmoid x`` *)

val softplus : t -> t
(** ``softplus x`` *)

val softsign : t -> t
(** ``softsign x`` *)


(** {6 Binary math functions} *)

val add : t -> t -> t
(** ``add x y`` *)

val sub : t -> t -> t
(** ``sub x y`` *)

val mul : t -> t -> t
(** ``mul x y`` *)

val div : t -> t -> t
(** ``div x y`` *)

val pow : t -> t -> t
(** ``pow x y`` *)

val min2 : t -> t -> t
(** ``min2 x y`` *)

val max2 : t -> t -> t
(** ``max2 x y`` *)

val fmod : t -> t -> t
(** ``fmod x y`` *)

val hypot : t -> t -> t
(** ``hypot x y`` *)

val atan2 : t -> t -> t
(** ``atan2 x y`` *)

val atan2pi : t -> t -> t
(** ``atan2pi x y`` *)

val add_scalar : t -> t -> t
(** ``add_scalar x a`` *)

val sub_scalar : t -> t -> t
(** ``sub_scalar x a`` *)

val mul_scalar : t -> t -> t
(** ``mul_scalar x a`` *)

val div_scalar : t -> t -> t
(** ``div_scalar x a`` *)

val pow_scalar : t -> t -> t
(** ``pow_scalar x a`` *)

val fmod_scalar : t -> t -> t
(** ``fmod_scalar x a`` *)

val atan2_scalar : t -> t -> t
(** ``atan2_scalar x a`` *)

val atan2pi_scalar : t -> t -> t
(** ``atan2pi_scalar x a`` *)
