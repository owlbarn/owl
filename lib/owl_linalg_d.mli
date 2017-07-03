(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type elt = float

type mat = Owl_dense.Matrix.D.mat

type complex_mat = Owl_dense.Matrix.Z.mat

type int32_mat = (int32, int32_elt) Owl_dense.Matrix.Generic.t


(** {6 Basic functions} *)


val inv : mat -> mat

val det : mat -> elt

val logdet : mat -> elt

val rank : ?tol:float -> mat -> int

val is_triu : mat -> bool

val is_tril : mat -> bool

val is_symmetric : mat -> bool

val is_diag : mat -> bool

val is_posdef : mat -> bool


(** {6 Factorisation} *)


val lu : mat -> mat * mat * int32_mat

val lq : ?thin:bool -> mat -> mat * mat

val qr : ?thin:bool -> ?pivot:bool -> mat -> mat * mat * int32_mat

val chol : ?upper:bool -> mat -> mat

val svd : ?thin:bool -> mat -> mat * mat * mat

val svdvals : mat -> mat

val gsvd : mat -> mat -> mat * mat * mat * mat * mat * mat

val gsvdvals : mat -> mat -> mat

val schur : mat -> mat * mat * complex_mat

val hess : mat -> mat * mat


(** {6 Solve Eigen systems} *)


val eig : ?permute:bool -> ?scale:bool -> mat -> complex_mat * complex_mat

val eigvals : ?permute:bool -> ?scale:bool -> mat -> complex_mat
