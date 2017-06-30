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


(** {6 Soon will be obsoleted } *)

val qr_sqsolve : mat_d -> mat_d -> mat_d

val qr_lssolve : mat_d -> mat_d -> mat_d * mat_d

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
