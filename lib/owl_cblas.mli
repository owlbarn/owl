
(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Please refer to: Intel Math Kernel Library implements the BLAS
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)


(** {6 Definition of basic types} *)

type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t

type s_t = (float, Bigarray.float32_elt) t
type d_t = (float, Bigarray.float64_elt) t
type c_t = (Complex.t, Bigarray.complex32_elt) t
type z_t = (Complex.t, Bigarray.complex64_elt) t

type cblas_layout = CblasRowMajor | CblasColMajor

type cblas_transpose = CblasNoTrans | CblasTrans | CblasConjTrans

type cblas_uplo = CblasUpper | CblasLower

type cblas_diag = CblasNonUnit | CblasUnit

type cblas_side = CblasLeft | CblasRight


(** {6 Level 1 BLAS: vector-vector operations} *)


(* Computes the parameters for a Givens rotation. *)

val srotg : float -> float -> float * float * float * float

val drotg : float -> float -> float * float * float * float


(* Computes the parameters for a modified Givens rotation. *)

val srotmg : float -> float -> float -> float -> float * float * float * s_t

val drotmg : float -> float -> float -> float -> float * float * float * d_t


(* Performs rotation of points in the plane. *)

val srot : int -> s_t -> int -> s_t -> int -> float -> float -> unit

val drot : int -> d_t -> int -> d_t -> int -> float -> float -> unit


(* Swaps a vector with another vector. *)

val sswap : int -> s_t -> int -> s_t -> int -> unit

val dswap : int -> d_t -> int -> d_t -> int -> unit

val cswap : int -> c_t -> int -> c_t -> int -> unit

val zswap : int -> z_t -> int -> z_t -> int -> unit


(* Computes the product of a vector by a scalar. *)

val sscal : int -> float -> s_t -> int -> unit

val dscal : int -> float -> d_t -> int -> unit

val cscal : int -> Complex.t -> c_t -> int -> unit

val zscal : int -> Complex.t -> z_t -> int -> unit

val csscal : int -> float -> c_t -> int -> unit

val zdscal : int -> float -> z_t -> int -> unit


(* Copies vector to another vector. *)

val scopy : int -> s_t -> int -> s_t -> int -> unit

val dcopy : int -> d_t -> int -> d_t -> int -> unit

val ccopy : int -> c_t -> int -> c_t -> int -> unit

val zcopy : int -> z_t -> int -> z_t -> int -> unit


(* Computes a vector-scalar product and adds the result to a vector. *)

val saxpy : int -> float -> s_t -> int -> s_t -> int -> unit

val daxpy : int -> float -> d_t -> int -> d_t -> int -> unit

val caxpy : int -> Complex.t -> c_t -> int -> c_t -> int -> unit

val zaxpy : int -> Complex.t -> z_t -> int -> z_t -> int -> unit


(* Computes a vector-vector dot product. *)

val sdot : int -> s_t -> int -> s_t -> int -> float

val ddot : int -> d_t -> int -> d_t -> int -> float


(* Computes a vector-vector dot product. *)

val cdotu : int -> c_t -> int -> c_t -> int -> Complex.t

val zdotu : int -> z_t -> int -> z_t -> int -> Complex.t


(* Computes a vector-vector dot product, unconjugated. *)

val cdotc : int -> c_t -> int -> c_t -> int -> Complex.t

val zdotc : int -> z_t -> int -> z_t -> int -> Complex.t


(* Computes a dot product of a conjugated vector with another vector. *)

val sdsdot : int -> float -> s_t -> int -> s_t -> int -> float

val dsdot : int -> s_t -> int -> s_t -> int -> float


(* Computes the Euclidean norm of a vector. *)

val snrm2 : int -> s_t -> int -> float

val dnrm2 : int -> d_t -> int -> float

val scnrm2 : int -> c_t -> int -> float

val dznrm2 : int -> z_t -> int -> float


(* Computes the sum of magnitudes of the vector elements. *)

val sasum : int -> s_t -> int -> float

val dasum : int -> d_t -> int -> float

val scasum : int -> c_t -> int -> float

val dzasum : int -> z_t -> int -> float


(* Finds the index of the element with maximum absolute value. *)

val isamax : int -> s_t -> int -> int

val idamax : int -> d_t -> int -> int

val icamax : int -> c_t -> int -> int

val izamax : int -> z_t -> int -> int


(** {6 Level 2 BLAS: matrix-vector operations} *)


(* Computes a matrix-vector product using a general matrix *)

val sgemv : cblas_layout -> cblas_transpose -> int -> int -> float -> s_t -> int -> s_t -> int -> float -> s_t -> int -> unit

val dgemv : cblas_layout -> cblas_transpose -> int -> int -> float -> d_t -> int -> d_t -> int -> float -> d_t -> int -> unit

val cgemv : cblas_layout -> cblas_transpose -> int -> int -> Complex.t -> c_t -> int -> c_t -> int -> Complex.t -> c_t -> int -> unit

val zgemv : cblas_layout -> cblas_transpose -> int -> int -> Complex.t -> z_t -> int -> z_t -> int -> Complex.t -> z_t -> int -> unit





(* ends here *)
