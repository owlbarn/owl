(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t
(** The default type is Bigarray's Genarray. *)

type side = Owl_cblas_basic.cblas_side
(** Upper or lower triangular matrix. *)

type uplo = Owl_cblas_basic.cblas_uplo
(** Side type *)


(** {6 Level-1 BLAS: vector-vector operations} *)


(** {6 Level-2 BLAS: matrix-vector operations} *)

val gemv : ?trans:bool -> ?incx:int -> ?incy:int -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> x:('a, 'b) t -> y:('a, 'b) t -> unit
(** Computes a matrix-vector product using a general matrix *)

val gbmv : ?trans:bool -> ?incx:int -> ?incy:int -> ?alpha:'a -> ?beta:'a -> kl:int -> ku:int -> a:('a, 'b) t -> x:('a, 'b) t -> y:('a, 'b) t -> unit
(** Computes a matrix-vector product using a general band matrix *)


(** {6 Level-3 BLAS: matrix-matrix operations} *)

val gemm : ?transa:bool -> ?transb:bool -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> unit
(** Computes a matrix-matrix product with general matrices. *)

val symm : ?side:side -> ?uplo:uplo -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> unit
(** Computes a matrix-matrix product where one input matrix is symmetric. *)

val syrk : ?uplo:uplo -> ?trans:bool -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> c:('a, 'b) t -> unit
(** Performs a symmetric rank-k update. *)

val syr2k : ?uplo:uplo -> ?trans:bool -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> unit
(** Performs a symmetric rank-2k update. *)

val trmm : ?side:side -> ?uplo:uplo -> ?transa:bool -> ?diag:bool -> ?alpha:'a -> a:('a, 'b) t -> b:('a, 'b) t -> unit
(** Computes a matrix-matrix product where one input matrix is triangular. *)

val trsm : ?side:side -> ?uplo:uplo -> ?transa:bool -> ?diag:bool -> ?alpha:'a -> a:('a, 'b) t -> b:('a, 'b) t -> unit
(** Solves a triangular matrix equation. *)

val hemm : ?side:side -> ?uplo:uplo -> ?alpha:Complex.t -> ?beta:Complex.t -> a:(Complex.t, 'a) t -> b:(Complex.t, 'a) t -> c:(Complex.t, 'a) t -> unit
(** Computes a matrix-matrix product where one input matrix is Hermitian. *)

val herk : ?uplo:uplo -> ?trans:bool -> ?alpha:float -> ?beta:float -> a:(Complex.t, 'a) t -> c:(Complex.t, 'a) t -> unit
(** Performs a Hermitian rank-k update. *)

val her2k : ?uplo:uplo -> ?trans:bool -> ?alpha:Complex.t -> ?beta:float -> a:(Complex.t, 'a) t -> b:(Complex.t, 'a) t -> c:(Complex.t, 'a) t -> unit
(** Performs a Hermitian rank-2k update. *)
