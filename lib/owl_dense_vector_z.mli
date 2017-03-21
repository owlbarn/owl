(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_vector_generic

type vec = (Complex.t, complex64_elt) Owl_dense_matrix_generic.t
type elt = Complex.t
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

val neg : vec -> vec

val reci : vec -> vec

val l1norm : vec -> float

val l2norm : vec -> float

val l2norm_sqr : vec -> float


(* ends here *)
