(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
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


(** {6 Level-3 BLAS: matrix-matrix operations} *)

val gemm : ?transa:bool -> ?transb:bool -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> unit
(** Computes a matrix-matrix product with general matrices. *)

val symm : ?side:side -> ?uplo:uplo -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> unit
(** Computes a matrix-matrix product where one input matrix is symmetric. *)

val syrk : ?uplo:uplo -> ?trans:bool -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> c:('a, 'b) t -> unit
(** Performs a symmetric rank-k update. *)
