(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_vector_generic

type vec = (float, float64_elt) Owl_dense_matrix.t
type elt = float
type vec_typ = Row | Col


(** {6 Creation functions } *)

val empty : ?typ:vec_typ -> int -> vec

val create : ?typ:vec_typ -> int -> elt -> vec

val zeros : ?typ:vec_typ -> int -> vec

val ones : ?typ:vec_typ -> int -> vec

val uniform : ?typ:vec_typ -> ?scale:float -> int -> vec

val sequential : ?typ:vec_typ -> int -> vec

val unit_basis : ?typ:vec_typ -> int -> int -> vec

val linspace : ?typ:vec_typ -> elt -> elt -> int -> vec

val logspace : ?typ:vec_typ -> ?base:float -> elt -> elt -> int -> vec


(** {6 Vector properties } *)

val shape : vec -> int * int

val numel : vec -> int


(** {6 Vector manipulations } *)

val set : vec -> int -> elt -> unit

val get : vec -> int -> elt

val clone : vec -> vec

val transpose : vec -> vec


(** {6 Iteration functions } *)

val iteri : (int -> elt -> unit) -> vec -> unit

val iter : (elt -> unit) -> vec -> unit

val mapi : (int -> elt -> elt) -> vec -> vec

val map : (elt -> elt) -> vec -> vec


(** {6 Binary mathematical operations } *)

val add : vec -> vec -> vec

val sub : vec -> vec -> vec

val mul : vec -> vec -> vec

val div : vec -> vec -> vec

val dot : vec -> vec -> vec


(** {6 Uniary mathematical operations } *)

val sum : vec -> elt

val abs : vec -> vec

val neg : vec -> vec

val reci : vec -> vec

val signum : vec -> vec

val sqr : vec -> vec

val sqrt : vec -> vec

val cbrt : vec -> vec

val exp : vec -> vec

val exp2 : vec -> vec

val expm1 : vec -> vec

val log : vec -> vec

val log10 : vec -> vec

val log2 : vec -> vec

val log1p : vec -> vec

val sin : vec -> vec

val cos : vec -> vec

val tan : vec -> vec

val asin : vec -> vec

val acos : vec -> vec

val atan : vec -> vec

val sinh : vec -> vec

val cosh : vec -> vec

val tanh : vec -> vec

val asinh : vec -> vec

val acosh : vec -> vec

val atanh : vec -> vec

val floor : vec -> vec

val ceil : vec -> vec

val round : vec -> vec

val trunc : vec -> vec

val erf : vec -> vec

val erfc : vec -> vec

val logistic : vec -> vec

val relu : vec -> vec

val softplus : vec -> vec

val softsign : vec -> vec

val softmax : vec -> vec

val sigmoid : vec -> vec

val log_sum_exp : vec -> elt

val l1norm : vec -> elt

val l2norm : vec -> elt

val l2norm_sqr : vec -> elt

val cross_entropy : vec -> vec -> elt


(* ends here *)
