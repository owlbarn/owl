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

  Currently, Linalg module supports dense matrix of four different number types,
  including [float32], [float64], [complex32], and [complex64]. The support for
  sparse matrices will be provided in future.
 *)

open Bigarray

type mat_d = Owl_dense.Matrix.D.mat
type mat_z = Owl_dense.Matrix.Z.mat
type ('a, 'b) t = ('a, 'b) Owl_dense.Matrix.Generic.t


val inv : ('a, 'b) t -> ('a, 'b) t
(** [inv x] calculates the inverse of a square matrix [x] such that
  [x *@ x = I] wherein [I] is an identity matrix.
 *)

val det : ('a, 'b) t -> 'a
(** [det x] computes the determinant of a square matrix [x]. *)

val logdet : ('a, 'b) t -> 'a
(** [logdet x] computes the log of the determinant of a square matrix [x]. It is
  equivalent to [log (det x)] but may provide more accuracy and efficiency.
 *)

val rank : ?tol:float -> ('a, 'b) t -> int
(** [rank x] calculates the rank of a rectangular matrix [x] of shape [m x n].
  The function does so by counting the number of singular values of [x] which
  are beyond a pre-defined threshold [tol]. By default, [tol = max(m,n) * eps]
  where [eps = 1e-10].
 *)

val lu : ?pivot:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(** [lu x -> (l, u, ipiv)] calculates LU decomposition of a general [m x n]
  matrix. The function uses partial pivoting, with row interchanges.

  [ipiv] is a row vector shows row [i] was interchanged with row [ipiv(i)]. The
  indices are not adjusted to 0-based C layout.
 *)

val lq : ?thin:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(** [lq x -> (l, q)] calculates the LQ decomposition of [x]. By default, the
  reduced LQ decomposition is performed. But you can get full [Q] by setting
  parameter [thin = false].
 *)

val qr : ?thin:bool -> ?pivot:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(** [qr x] calculates QR decomposition for an [m] by [n] matrix [x] as
  [x = Q R]. [Q] is an [m] by [n] matrix (where [Q^T Q = I]) and [R] is
  an [n] by [n] upper-triangular matrix.

  The function returns a 3-tuple, the first two are [q] and [r], and the thrid
  is the permutation vector of columns. The default value of [pivot] is [false],
  setting [pivot = true] lets [qr] performs pivoted factorisation. Note that
  the returned indices are not adjusted to 0-based C layout.

  By default, [qr] performs a reduced QR factorisation, full factorisation can
  be enabled by setting [thin] parameter to [false].
 *)

val chol : ?upper:bool -> ('a, 'b) t -> ('a, 'b) t
(** [chol x -> u] calculates the Cholesky factorisation of a positive definite
  matrix [x] such that [x = u' *@ u]. By default, the upper triangular matrix
  is returned. The lower triangular part can be obtained by setting the
  parameter [upper = false].
 *)

val svd : ?thin:bool -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(** [svd x -> (u, s, vt)] calculates the singular value decomposition of [x],
  and returns a 3-tuple [(u,s,vt)]. By default, a reduced svd is performed: [u]
  is an [m] by [n] orthogonal matrix, [s] an [1] by [n] row vector of singular
  values, and [vt] is the transpose of an [n] by [n] orthogonal square matrix.

  The full svd can be performed by setting [thin = false]. Note that for complex
  numbers, the type of returned singular values are also complex, the imaginary
  part is zero.
 *)

val svdvals : ('a, 'b) t -> ('a, 'b) t
(** [svdvals x -> s] performs the singular value decomposition of [x] like
  [svd x], but the function only returns the singular values without [u] and
  [vt]. Note that for complex numbers, the return is also complex type.
 *)

val gsvd : ('a, 'b) t -> ('a, 'b) t ->
  ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(** [gsvd x y -> (u, v, q, d1, d2, r)] computes the generalised singular value
  decomposition of a pair of general rectangular matrices [x] and [y]. [d1] and
  [d2] contain the generalised singular value pairs of [x] and [y]. The shape
  of [x] is [m x n] and the shape of [y] is [p x n].

  [let x = Mat.uniform 5 5;;]

  [let y = Mat.uniform 2 5;;]

  [let u, v, q, d1, d2, r = Linalg.gsvd x y;;]

  [Mat.(u *@ d1 *@ r *@ transpose q =~ x);;]

  [Mat.(v *@ d2 *@ r *@ transpose q =~ y);;]

  Please refer to:
  https://software.intel.com/en-us/mkl-developer-reference-c-ggsvd3
 *)

val gsvdvals : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [gsvdvals x y] is similar to [gsvd x y] but only returns the singular
  values of the generalised singular value decomposition of [x] and [y].
 *)

val schur : ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(** [schur x -> (t, z, wr, wi)] calculates Schur factorisation of [x]. [t] is
  (quasi) triangular Schur factor, [z] is orthogonal/unitary Schur vectors. The
  eigen values are not sorted, they have the same order as that they appear on
  the diagonal of the output real-Schur form t.

  Both [wr] and [wi] eigen values: for real numbers, the eigen values are
  splitted into real and imaginary parts, therefore you need to assemble them
  together to get complex eigen values. For complex numbers, [wr] and [wi] are
  the same.
 *)


(** {6 Soon will be obsoleted } *)

val qr_sqsolve : mat_d -> mat_d -> mat_d

val qr_lssolve : mat_d -> mat_d -> mat_d * mat_d

val is_posdef : mat_d -> bool
(** [is_posdef x] checks whether [x] is a positive semi-definite matrix. *)

val symmtd : mat_d -> mat_d * mat_d * mat_d

val bidiag : mat_d -> mat_d * mat_d * mat_d * mat_d

val tridiag_solve : mat_d -> mat_d -> mat_d

val symm_tridiag_solve : mat_d -> mat_d -> mat_d


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


(** {6 Some helper functions} *)

val peakflops : ?n:int -> unit -> float
