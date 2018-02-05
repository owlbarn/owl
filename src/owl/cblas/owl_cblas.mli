(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** CBLAS interface: high-level interface  beween Owl and level-1, level-2,
  level-3 BLAS functions.
 *)

(** Please refer to: Intel Math Kernel Library in the CBLAS interface
  url: https://software.intel.com/en-us/mkl-developer-reference-c *)

open Bigarray


(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t
(** The default type is Bigarray's ``Array1.t``. *)

type cblas_layout = CblasRowMajor | CblasColMajor
(** Layout type, Row-major or Column-major. *)

type cblas_transpose = CblasNoTrans | CblasTrans | CblasConjTrans
(** Transpose type, no transpose, transpose, or conjugate transpose. *)

type cblas_uplo = CblasUpper | CblasLower
(** Upper or lower triangular matrix. *)

type cblas_diag = CblasNonUnit | CblasUnit
(** Diag type *)

type cblas_side = CblasLeft | CblasRight
(** Side type *)


(** {6 Level-1 BLAS: vector-vector operations} *)

val rotg : float -> float -> float * float * float * float
(** Computes the parameters for a Givens rotation. *)

val rotmg : ('a, 'b) kind -> float -> float -> float -> float -> float * float * float * ('a, 'b) t
(** Computes the parameters for a modified Givens rotation. *)

val rot : int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> float -> float -> unit
(** Performs rotation of points in the plane. *)

val rotm : int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> unit
(** Performs modified Givens rotation of points in the plane *)

val swap : int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Swaps a vector with another vector. *)

val scal : int -> 'a -> ('a, 'b) t -> int -> unit
(** Computes the product of a vector and a scalar. *)

val cszd_scal : int -> float -> (Complex.t, 'a) t -> int -> unit
(** Computes the product of a complex vector and a float number. *)

val copy : int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Copies vector to another vector. *)

val axpy : int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Computes a vector-scalar product and adds the result to a vector. *)

val dot : ?conj:bool -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> 'a
(** Computes a vector-vector dot product. [conj] is for complex numbers, [true]
  indicates conjugated, [false] indicates unconjugated.
 *)

val sdsdot : int -> float -> (float, float32_elt) t -> int -> (float, float32_elt) t -> int -> float
(** Computes a vector-vector dot product extended precision accumulation. *)

val dsdot : int -> (float, float32_elt) t -> int -> (float, float32_elt) t -> int -> float
(** Computes a vector-vector dot product extended precision accumulation. *)

val nrm2 : int -> ('a, 'b) t -> int -> float
(** Computes the Euclidean norm of a vector. *)

val asum : int -> ('a, 'b) t -> int -> float
(** Computes the sum of magnitudes of the vector elements. *)

val amax : int -> ('a, 'b) t -> int -> int
(** Finds the index of the element with maximum absolute value. *)


(** {6 Level-2 BLAS: matrix-vector operations} *)

val gemv : cblas_layout -> cblas_transpose -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> 'a -> ('a, 'b) t -> int -> unit
(** Computes a matrix-vector product using a general matrix *)

val gbmv : cblas_layout -> cblas_transpose -> int -> int -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> 'a -> ('a, 'b) t -> int -> unit
(** Computes a matrix-vector product using a general band matrix *)

val trmv : cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Computes a matrix-vector product using a triangular matrix. *)

val tbmv : cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Computes a matrix-vector product using a triangular band matrix. *)

val tpmv : cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Computes a matrix-vector product using a triangular packed matrix. *)

val trsv : cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Solves a system of linear equations whose coefficients are in a triangular matrix. *)

val tbsv : cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Solves a system of linear equations whose coefficients are in a triangular band matrix. *)

val tpsv : cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Solves a system of linear equations whose coefficients are in a triangular packed matrix. *)

val symv : cblas_layout -> cblas_uplo -> int -> float -> (float, 'a) t -> int -> (float, 'a) t -> int -> float -> (float, 'a) t -> int -> unit
(** Computes a matrix-vector product for a symmetric matrix. *)

val sbmv : cblas_layout -> cblas_uplo -> int -> int -> float -> (float, 'a) t -> int -> (float, 'a) t -> int -> float -> (float, 'a) t -> int -> unit
(** Computes a matrix-vector product using a symmetric band matrix. *)

val spmv : cblas_layout -> cblas_uplo -> int -> int -> float -> (float, 'a) t -> (float, 'a) t -> int -> float -> (float, 'a) t -> int -> unit
(** Computes a matrix-vector product using a symmetric packed matrix. *)

val ger : ?conj:bool -> cblas_layout -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(**
Performs a rank-1 update of a general matrix. [conj] is for complex numbers,
[true] indicates conjugated, [false] indicates unconjugated.
 *)

val syr : cblas_layout -> cblas_uplo -> int -> float -> (float, 'a) t -> int -> (float, 'a) t -> int -> unit
(** Performs a rank-1 update of a symmetric matrix. *)

val spr : cblas_layout -> cblas_uplo -> int -> float -> (float, 'a) t -> int -> (float, 'a) t -> unit
(** Performs a rank-1 update of a symmetric packed matrix. *)

val syr2 : cblas_layout -> cblas_uplo -> int -> float -> (float, 'a) t -> int -> (float, 'a) t -> int -> (float, 'a) t -> int -> unit
(** Performs a rank-2 update of symmetric matrix. *)

val spr2 : cblas_layout -> cblas_uplo -> int -> float -> (float, 'a) t -> int -> (float, 'a) t -> int -> (float, 'a) t -> unit
(** Performs a rank-2 update of a symmetric packed matrix. *)

val hemv : cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> Complex.t -> (Complex.t, 'a) t -> int -> unit
(** Computes a matrix-vector product using a Hermitian matrix. *)

val hbmv : cblas_layout -> cblas_uplo -> int -> int -> Complex.t -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> Complex.t -> (Complex.t, 'a) t -> int -> unit
(** Computes a matrix-vector product using a Hermitian band matrix. *)

val hpmv : cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, 'a) t -> (Complex.t, 'a) t -> int -> Complex.t -> (Complex.t, 'a) t -> int -> unit
(** Computes a matrix-vector product using a Hermitian packed matrix. *)

val her : cblas_layout -> cblas_uplo -> int -> float -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> unit
(** Performs a rank-1 update of a Hermitian matrix. *)

val hpr : cblas_layout -> cblas_uplo -> int -> float -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> unit
(** Performs a rank-1 update of a Hermitian packed matrix. *)

val her2 : cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> unit
(** Performs a rank-2 update of a Hermitian matrix. *)

val hpr2 : cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> unit
(** Performs a rank-2 update of a Hermitian packed matrix. *)


(** {6 Level-3 BLAS: matrix-matrix operations} *)

val gemm : cblas_layout -> cblas_transpose -> cblas_transpose -> int -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> 'a -> ('a, 'b) t -> int -> unit
(** Computes a matrix-matrix product with general matrices. *)

val symm : cblas_layout -> cblas_side -> cblas_uplo -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> 'a -> ('a, 'b) t -> int -> unit
(** Computes a matrix-matrix product where one input matrix is symmetric. *)

val syrk : cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> 'a -> ('a, 'b) t -> int -> 'a -> ('a, 'b) t -> int -> unit
(** Performs a symmetric rank-k update. *)

val syr2k : cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> 'a -> ('a, 'b) t -> int -> unit
(** Performs a symmetric rank-2k update. *)

val trmm : cblas_layout -> cblas_side -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Computes a matrix-matrix product where one input matrix is triangular. *)

val trsm : cblas_layout -> cblas_side -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> 'a -> ('a, 'b) t -> int -> ('a, 'b) t -> int -> unit
(** Solves a triangular matrix equation. *)

val hemm : cblas_layout -> cblas_side -> cblas_uplo -> int -> int -> Complex.t -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> Complex.t -> (Complex.t, 'a) t -> int -> unit
(** Computes a matrix-matrix product where one input matrix is Hermitian. *)

val herk : cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> float -> (Complex.t, 'a) t -> int -> float -> (Complex.t, 'a) t -> int -> unit
(** Performs a Hermitian rank-k update. *)

val her2k : cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> Complex.t -> (Complex.t, 'a) t -> int -> (Complex.t, 'a) t -> int -> float -> (Complex.t, 'a) t -> int -> unit
(** Performs a Hermitian rank-2k update. *)
