(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type mat = Owl_dense.Matrix.Z.mat

type int32_mat = (int32, int32_elt) Owl_dense.Matrix.Generic.t


(** {6 Basic functions} *)


val inv : mat -> mat

val det : mat -> elt

val logdet : mat -> elt

val rank : ?tol:float -> mat -> int

val is_posdef : mat -> bool


(** {6 Factorisation} *)


val lq : ?thin:bool -> mat -> mat * mat

val qr : ?thin:bool -> ?pivot:bool -> mat -> mat * mat * int32_mat

val chol : ?upper:bool -> mat -> mat

val svd : ?thin:bool -> mat -> mat * mat * mat

val svdvals : mat -> mat

val gsvd : mat -> mat -> mat * mat * mat * mat * mat * mat

val gsvdvals : mat -> mat -> mat

val schur : mat -> mat * mat * mat

val hess : mat -> mat * mat


(** {6 Solve Eigen systems} *)


val eig : ?permute:bool -> ?scale:bool -> mat -> mat * mat

val eigvals : ?permute:bool -> ?scale:bool -> mat -> mat
