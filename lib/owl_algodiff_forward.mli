(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Algorithmic differentiation - Forward mode *)

type dual

type t = Float of float | Dual of dual


(** {6 Derivative, Gradient, Jacobian, and Hessian} *)

val derivative : ?argnum:int -> (t array -> t) -> (t array -> t)

val gradient : (t array -> t) -> (t array -> t array)

val jacobian : (t array -> t array) -> (t array -> t array array)

val hessian : (t array -> t) -> (t array -> t array array)

val laplacian : (t array -> t) -> (t array -> t)


(** {6 Overloaded Mathematical Operators} *)

module Maths : sig

  (** {7 Unary operators} *)

  val neg : t -> t

  val exp : t -> t

  val log : t -> t

  val sin : t -> t

  val cos : t -> t

  val sinh : t -> t

  val cosh : t -> t

  val tanh : t -> t

  val square : t -> t

  (** {7 Binary operators} *)

  val ( +. ) : t -> t -> t

  val ( -. ) : t -> t -> t

  val ( *. ) : t -> t -> t

  val ( /. ) : t -> t -> t

  val ( ** ) : t -> t -> t

end


(** {6 Dual number functions} *)

(* In general, you are not supposed to use these functions directly. *)

val degree : t -> int

val pp_dual : t -> unit

val make_dual : t -> t -> t

val zero : t -> t

val one : t -> t

val is_zero : t -> bool

val is_const : t -> bool
