(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Linear algebra module including high-level functions to solve linear
  systems, factorisation, and etc.
 *)

(**
  The module includes a set of advanced linear algebra operations such as
  singular value decomposition, and etc.

  Currently, Linalg module only supports dense matrix. The support for sparse
  matrices will be provided very soon.
 *)

open Bigarray

type mat_d = Owl_dense.Matrix.D.mat
type mat_z = Owl_dense.Matrix.Z.mat
type ('a, 'b) t = ('a, 'b) Owl_dense.Matrix.Generic.t


val inv : mat_d -> mat_d
(** A general square matrix A has an LU decomposition into upper and lower
  triangular matrices, [P A = L U] where P is a permutation matrix, L is unit
  lower triangular matrix and U is upper triangular matrix. For square matrices
  this decomposition can be used to convert the linear system A x = b into a
  pair of triangular systems (L y = P b, U x = y), which can be solved by
  forward and back-substitution. Note that the LU decomposition is valid for
  singular matrices.
 *)

val det : mat_d -> float
(** [det x] computes the determinant of a matrix [x] from its LU decomposition. *)

val qr : ?thin:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(** [qr x] calculates QR decomposition for an [m] by [n] matrix [x] as
  [x = Q R]. [Q] is an [m] by [n] matrix (where [Q^T Q = I]) and [R] is
  an [n] by [n] upper-triangular matrix.
 *)

val qr_pivot : ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t


val qr_sqsolve : mat_d -> mat_d -> mat_d

val qr_lssolve : mat_d -> mat_d -> mat_d * mat_d

val svd : mat_d -> mat_d * mat_d * mat_d
(** [svd x] calculates the singular value decomposition of [x], and returns a
  tuple [(u,s,v)]. [u] is an [m] by [n] orthogonal matrix, [s] an [n] by [1]
  matrix of singular values, and [v] is the transpose of an [n] by [n]
  orthogonal square matrix.
 *)

val cholesky : mat_d -> mat_d

val is_posdef : mat_d -> bool
(** [is_posdef x] checks whether [x] is a positive semi-definite matrix. *)

val symmtd : mat_d -> mat_d * mat_d * mat_d

val bidiag : mat_d -> mat_d * mat_d * mat_d * mat_d

val tridiag_solve : mat_d -> mat_d -> mat_d

val symm_tridiag_solve : mat_d -> mat_d -> mat_d

(* TODO: lu decomposition *)


(** {6 Solve Eigen systems} *)

val eigen_symm : mat_d -> mat_d
(* [eigen_symm x] return the eigen values of real symmetric matrix [x]. *)

val eigen_symmv : mat_d -> mat_d * mat_d
(* [eigen_symmv x] return the eigen values and vactors of real symmetric matrix [x]. *)

val eigen_nonsymm : mat_d -> mat_z
(* [eigen_nonsymm x] return the eigen values of real asymmetric matrix [x]. *)

val eigen_nonsymmv : mat_d -> mat_z * mat_z
(* [eigen_nonsymmv x] return the eigen values and vectors of real asymmetric matrix [x]. *)

val eigen_herm : mat_z -> mat_d
(* [eigen_herm x] return the eigen values of complex Hermitian matrix [x]. *)

val eigen_hermv : mat_z -> mat_d * mat_z
(* [eigen_hermv x] return the eigen values and vectors of complex Hermitian matrix [x]. *)
