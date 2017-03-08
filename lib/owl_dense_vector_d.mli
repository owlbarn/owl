(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_vector_generic

type vec = (float, float64_elt) Owl_dense_matrix.t

val empty : ?typ:vec_typ -> int -> vec

val zeros : ?typ:vec_typ -> int -> vec

val ones : ?typ:vec_typ -> int -> vec

val uniform : ?typ:vec_typ -> ?scale:float -> int -> vec


(** {6 Vector manipulations } *)

val transpose : vec -> vec


(** {6 Binary mathematical operations } *)

val add : vec -> vec -> vec

val sub : vec -> vec -> vec

val mul : vec -> vec -> vec

val div : vec -> vec -> vec

val dot : vec -> vec -> vec


(** {6 Uniary mathematical operations } *)
