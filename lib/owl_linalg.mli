(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Linalg module

  The module includes a set of advanced linear algebra operations such as
  singular value decomposition, and etc.

  Currently, Linalg module only supports dense matrix. The support for sparse
  matrices will be provided very soon.
 *)

type dsmat = Owl_dense_real.mat


val inv : dsmat -> dsmat
(** A general square matrix A has an LU decomposition into upper and lower triangular matrices,
 [P A = L U] where P is a permutation matrix, L is unit lower triangular matrix and U is upper triangular matrix. For square matrices this decomposition can be used to convert the linear system A x = b into a pair of triangular systems (L y = P b, U x = y), which can be solved by forward and back-substitution. Note that the LU decomposition is valid for singular matrices.

 *)

val det : dsmat -> float
(** [det x] computes the determinant of a matrix [x] from its LU decomposition. *)

val qr : dsmat -> dsmat * dsmat
(** [qr x] calculates QR decomposition for an [m] by [n] matrix [x] as
  [x = Q R]. [Q] is an [m] by [m] square matrix (where [Q^T Q = I]) and [R] is
  an [m] by [n] right-triangular matrix.
 *)

val qr_sqsolve : dsmat -> dsmat -> dsmat

val qr_lssolve : dsmat -> dsmat -> dsmat * dsmat

val svd : dsmat -> dsmat * dsmat * dsmat
(** [svd x] calculates the singular value decomposition of [x], and returns a
  tuple [(u,s,v)]. [u] is an [m] by [n] orthogonal matrix, [s] an [n] by [1]
  matrix of singular values, and [v] is the transpose of an [n] by [n]
  orthogonal square matrix.
 *)

val cholesky : dsmat -> dsmat

val is_posdef : dsmat -> bool
(** [is_posdef x] checks whether [x] is a positive semi-definite matrix. *)

val symmtd : dsmat -> dsmat * dsmat * dsmat

val bidiag : dsmat -> dsmat * dsmat * dsmat * dsmat

val tridiag_solve : dsmat -> dsmat -> dsmat

val symm_tridiag_solve : dsmat -> dsmat -> dsmat

(* TODO: lu decomposition *)
