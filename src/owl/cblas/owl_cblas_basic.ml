(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

[@@@warning "-6"]

(** Please refer to: Intel Math Kernel Library implements the BLAS
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)

open Ctypes

type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t

type cblas_layout = CblasRowMajor | CblasColMajor
let cblas_layout = function CblasRowMajor -> 101 | CblasColMajor -> 102

type cblas_transpose = CblasNoTrans | CblasTrans | CblasConjTrans
let cblas_transpose = function CblasNoTrans -> 111 | CblasTrans -> 112 | CblasConjTrans -> 113

type cblas_uplo = CblasUpper | CblasLower
let cblas_uplo = function CblasUpper -> 121 | CblasLower -> 122

type cblas_diag = CblasNonUnit | CblasUnit
let cblas_diag = function CblasNonUnit -> 131 | CblasUnit -> 132

type cblas_side = CblasLeft | CblasRight
let cblas_side = function CblasLeft -> 141 | CblasRight -> 142


module C = Owl_cblas_generated


(* Level 1 BLAS *)


(* Computes the parameters for a Givens rotation. *)

let rotg a b =
  let a = allocate double a in
  let b = allocate double b in
  let c = allocate double 0. in
  let s = allocate double 0. in
  C.drotg ~a ~b ~c ~s;
  !@a, !@b, !@c, !@s


(* Computes the parameters for a modified Givens rotation. *)

let rotmg
  : type a b. (a, b) Bigarray.kind -> float -> float -> float -> float -> float * float * float * (a, b) t
  = fun k d1 d2 b1 b2 ->
  match k with
  | Bigarray.Float32 -> (
      let d1 = allocate float d1 in
      let d2 = allocate float d2 in
      let b1 = allocate float b1 in
      let p' = Bigarray.(Array1.create Float32 C_layout 5) in
      let p  = bigarray_start Ctypes_static.Array1 p' in
      C.srotmg ~d1 ~d2 ~b1 ~b2 ~p;
      !@d1, !@d2, !@b1, p'
    )
  | Bigarray.Float64 -> (
      let d1 = allocate double d1 in
      let d2 = allocate double d2 in
      let b1 = allocate double b1 in
      let p' = Bigarray.(Array1.create Float64 C_layout 5) in
      let p  = bigarray_start Ctypes_static.Array1 p' in
      C.drotmg ~d1 ~d2 ~b1 ~b2 ~p;
      !@d1, !@d2, !@b1, p'
    )
  | _                -> failwith "owl_cblas:rotmg"


(* Performs modified Givens rotation of points in the plane *)

let rotm
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> (a, b) t -> unit
  = fun n x incx y incy p ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _p = bigarray_start Ctypes_static.Array1 p in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32 -> C.srotm ~n ~x:_x ~incx ~y:_y ~incy ~p:_p
    | Bigarray.Float64 -> C.drotm ~n ~x:_x ~incx ~y:_y ~incy ~p:_p
    | _                -> failwith "owl_cblas:rotm"
  in ()


(* Performs rotation of points in the plane. *)

let rot
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> float -> float -> unit
  = fun n x incx y incy c s ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32 -> C.srot ~n ~x:_x ~incx ~y:_y ~incy ~c ~s
    | Bigarray.Float64 -> C.drot ~n ~x:_x ~incx ~y:_y ~incy ~c ~s
    | _                -> failwith "owl_cblas:rot"
  in ()


(* Swaps a vector with another vector. *)

let swap
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun n x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.sswap n _x incx _y incy
    | Bigarray.Float64   -> C.dswap n _x incx _y incy
    | Bigarray.Complex32 -> C.cswap n _x incx _y incy
    | Bigarray.Complex64 -> C.zswap n _x incx _y incy
    | _                  -> failwith "owl_cblas:swap"
  in ()


(* Computes the product of a vector by a scalar. *)

let scal
  : type a b. int -> a -> (a, b) t -> int -> unit
  = fun n a x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.sscal n a _x incx
    | Bigarray.Float64   -> C.dscal n a _x incx
    | Bigarray.Complex32 -> C.cscal n (allocate complex32 a) _x incx
    | Bigarray.Complex64 -> C.zscal n (allocate complex64 a) _x incx
    | _                  -> failwith "owl_cblas:scal"
  in ()

let cszd_scal
  : type a. int -> float -> (Complex.t, a) t -> int -> unit
  = fun n a x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Complex32 -> C.csscal n a _x incx
    | Bigarray.Complex64 -> C.zdscal n a _x incx
  in ()


(* Copies vector to another vector. *)

let copy
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun n x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.scopy n _x incx _y incy
    | Bigarray.Float64   -> C.dcopy n _x incx _y incy
    | Bigarray.Complex32 -> C.ccopy n _x incx _y incy
    | Bigarray.Complex64 -> C.zcopy n _x incx _y incy
    | _                  -> failwith "owl_cblas:copy"
  in ()


(* Computes a vector-scalar product and adds the result to a vector. *)

let axpy
  : type a b. int -> a -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun n a x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.saxpy n a _x incx _y incy
    | Bigarray.Float64   -> C.daxpy n a _x incx _y incy
    | Bigarray.Complex32 -> C.caxpy n (allocate complex32 a) _x incx _y incy
    | Bigarray.Complex64 -> C.zaxpy n (allocate complex64 a) _x incx _y incy
    | _                  -> failwith "owl_cblas:axpy"
  in ()


(* Computes a vector-vector dot product. *)

let dot
  : type a b. ?conj:bool -> int -> (a, b) t -> int -> (a, b) t -> int -> a
  = fun ?(conj=false) n x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sdot n _x incx _y incy
  | Bigarray.Float64   -> C.ddot n _x incx _y incy
  | Bigarray.Complex32 -> (
      let _z = allocate complex32 Complex.zero in
      if conj = true then C.cdotc n _x incx _y incy _z
      else C.cdotu n _x incx _y incy _z;
      !@_z
    )
  | Bigarray.Complex64 -> (
      let _z = allocate complex32 Complex.zero in
      if conj = true then C.zdotc n _x incx _y incy _z
      else C.zdotu n _x incx _y incy _z;
      !@_z
    )
  | _                  -> failwith "owl_cblas:dot"


(* Computes a vector-vector dot product with double precision. *)

let sdsdot n a x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.sdsdot n a _x incx _y incy

let dsdot n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.dsdot n _x incx _y incy


(* Computes the Euclidean norm of a vector. *)

let nrm2
  : type a b. int -> (a, b) t -> int -> float
  = fun n x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.snrm2 n _x incx
  | Bigarray.Float64   -> C.dnrm2 n _x incx
  | Bigarray.Complex32 -> C.scnrm2 n _x incx
  | Bigarray.Complex64 -> C.dznrm2 n _x incx
  | _                  -> failwith "owl_cblas:nrm2"


(* Computes the sum of magnitudes of the vector elements. *)

let asum
  : type a b. int -> (a, b) t -> int -> float
  = fun n x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sasum n _x incx
  | Bigarray.Float64   -> C.sasum n _x incx
  | Bigarray.Complex32 -> C.scasum n _x incx
  | Bigarray.Complex64 -> C.dzasum n _x incx
  | _                  -> failwith "owl_cblas:asum"


(* Finds the index of the element with maximum absolute value. *)

let amax
  : type a b. int -> (a, b) t -> int -> int
  = fun n x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let i = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.isamax n _x incx
    | Bigarray.Float64   -> C.idamax n _x incx
    | Bigarray.Complex32 -> C.icamax n _x incx
    | Bigarray.Complex64 -> C.izamax n _x incx
    | _                  -> failwith "owl_cblas:amax"
  in
  Unsigned.Size_t.to_int i


(* Level 2 BLAS *)


(* Computes a matrix-vector product using a general matrix *)

let gemv
  : type a b. cblas_layout -> cblas_transpose -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout trans m n alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  | Bigarray.Float64   -> C.dgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  | Bigarray.Complex32 -> C.cgemv _layout _trans m n (allocate complex32 alpha) _a lda _x incx (allocate complex32 beta) _y incy
  | Bigarray.Complex64 -> C.zgemv _layout _trans m n (allocate complex64 alpha) _a lda _x incx (allocate complex64 beta) _y incy
  | _                  -> failwith "owl_cblas:gemv"


(* Computes a matrix-vector product using a general band matrix *)

let gbmv
  : type a b. cblas_layout -> cblas_transpose -> int -> int -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout trans m n kl ku alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sgbmv _layout _trans m n kl ku alpha _a lda _x incx beta _y incy
  | Bigarray.Float64   -> C.dgbmv _layout _trans m n kl ku alpha _a lda _x incx beta _y incy
  | Bigarray.Complex32 -> C.cgbmv _layout _trans m n kl ku (allocate complex32 alpha) _a lda _x incx (allocate complex32 beta) _y incy
  | Bigarray.Complex64 -> C.cgbmv _layout _trans m n kl ku (allocate complex64 alpha) _a lda _x incx (allocate complex64 beta) _y incy
  | _                  -> failwith "owl_cblas:gbmv"


(* Computes a matrix-vector product using a triangular matrix. *)

let trmv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.strmv _layout _uplo _trans _diag n _a lda _x incx
  | Bigarray.Float64   -> C.dtrmv _layout _uplo _trans _diag n _a lda _x incx
  | Bigarray.Complex32 -> C.ctrmv _layout _uplo _trans _diag n _a lda _x incx
  | Bigarray.Complex64 -> C.ztrmv _layout _uplo _trans _diag n _a lda _x incx
  | _                  -> failwith "owl_cblas:trmv"


(* Computes a matrix-vector product using a triangular band matrix. *)

let tbmv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n k a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stbmv _layout _uplo _trans _diag n k _a lda _x incx
  | Bigarray.Float64   -> C.dtbmv _layout _uplo _trans _diag n k _a lda _x incx
  | Bigarray.Complex32 -> C.ctbmv _layout _uplo _trans _diag n k _a lda _x incx
  | Bigarray.Complex64 -> C.ztbmv _layout _uplo _trans _diag n k _a lda _x incx
  | _                  -> failwith "owl_cblas:tbmv"


(* Computes a matrix-vector product using a triangular packed matrix. *)

let tpmv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n ap x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stpmv _layout _uplo _trans _diag n _ap _x incx
  | Bigarray.Float64   -> C.dtpmv _layout _uplo _trans _diag n _ap _x incx
  | Bigarray.Complex32 -> C.ctpmv _layout _uplo _trans _diag n _ap _x incx
  | Bigarray.Complex64 -> C.ztpmv _layout _uplo _trans _diag n _ap _x incx
  | _                  -> failwith "owl_cblas:tpmv"


(* Solves a system of linear equations whose coefficients are in a triangular matrix. *)

let trsv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.strsv _layout _uplo _trans _diag n _a lda _x incx
  | Bigarray.Float64   -> C.dtrsv _layout _uplo _trans _diag n _a lda _x incx
  | Bigarray.Complex32 -> C.ctrsv _layout _uplo _trans _diag n _a lda _x incx
  | Bigarray.Complex64 -> C.ztrsv _layout _uplo _trans _diag n _a lda _x incx
  | _                  -> failwith "owl_cblas:trsv"


(* Solves a system of linear equations whose coefficients are in a triangular band matrix. *)

let tbsv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n k a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stbsv _layout _uplo _trans _diag n k _a lda _x incx
  | Bigarray.Float64   -> C.dtbsv _layout _uplo _trans _diag n k _a lda _x incx
  | Bigarray.Complex32 -> C.ctbsv _layout _uplo _trans _diag n k _a lda _x incx
  | Bigarray.Complex64 -> C.ztbsv _layout _uplo _trans _diag n k _a lda _x incx
  | _                  -> failwith "owl_cblas:tbsv"


(* Solves a system of linear equations whose coefficients are in a triangular packed matrix. *)

let tpsv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n ap x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stpsv _layout _uplo _trans _diag n _ap _x incx
  | Bigarray.Float64   -> C.dtpsv _layout _uplo _trans _diag n _ap _x incx
  | Bigarray.Complex32 -> C.ctpsv _layout _uplo _trans _diag n _ap _x incx
  | Bigarray.Complex64 -> C.ztpsv _layout _uplo _trans _diag n _ap _x incx
  | _                  -> failwith "owl_cblas:tpsv"


(* Computes a matrix-vector product for a symmetric matrix. *)

let symv
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> float -> (float, a) t -> int -> unit
  = fun layout uplo n alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssymv _layout _uplo n alpha _a lda _x incx beta _y incy
  | Bigarray.Float64 -> C.dsymv _layout _uplo n alpha _a lda _x incx beta _y incy


(* Computes a matrix-vector product using a symmetric band matrix. *)

let sbmv
  : type a. cblas_layout -> cblas_uplo -> int -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> float -> (float, a) t -> int -> unit
  = fun layout uplo n k alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssbmv _layout _uplo n k alpha _a lda _x incx beta _y incy
  | Bigarray.Float64 -> C.dsbmv _layout _uplo n k alpha _a lda _x incx beta _y incy


(* Computes a matrix-vector product using a symmetric packed matrix. *)

let spmv
  : type a. cblas_layout -> cblas_uplo -> int -> int -> float -> (float, a) t -> (float, a) t -> int -> float -> (float, a) t -> int -> unit
  = fun layout uplo n _k alpha ap x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.sspmv _layout _uplo n alpha _ap _x incx beta _y incy
  | Bigarray.Float64 -> C.dspmv _layout _uplo n alpha _ap _x incx beta _y incy


(* Performs a rank-1 update of a general matrix. *)

let ger
  : type a b. ?conj:bool -> cblas_layout -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun ?(conj=false) layout m n alpha x incx y incy a lda ->
  let _layout = cblas_layout layout in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sger _layout m n alpha _x incx _y incy _a lda
  | Bigarray.Float64   -> C.dger _layout m n alpha _x incx _y incy _a lda
  | Bigarray.Complex32 ->
      if conj = true then C.cgerc _layout m n (allocate complex32 alpha) _x incx _y incy _a lda
      else C.cgeru _layout m n (allocate complex32 alpha) _x incx _y incy _a lda
  | Bigarray.Complex64 ->
      if conj = true then C.zgerc _layout m n (allocate complex64 alpha) _x incx _y incy _a lda
      else C.zgeru _layout m n (allocate complex64 alpha) _x incx _y incy _a lda
  | _                  -> failwith "owl_cblas:ger"


(* Performs a rank-1 update of a symmetric matrix. *)

let syr
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> unit
  = fun layout uplo n alpha x incx a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssyr _layout _uplo n alpha _x incx _a lda
  | Bigarray.Float64 -> C.dsyr _layout _uplo n alpha _x incx _a lda


(* Performs a rank-1 update of a symmetric packed matrix. *)

let spr
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> unit
  = fun layout uplo n alpha x incx ap ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.sspr _layout _uplo n alpha _x incx _ap
  | Bigarray.Float64 -> C.dspr _layout _uplo n alpha _x incx _ap


(* Performs a rank-2 update of symmetric matrix. *)

let syr2
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> (float, a) t -> int -> unit
  = fun layout uplo n alpha x incx y incy a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssyr2 _layout _uplo n alpha _x incx _y incy _a lda
  | Bigarray.Float64 -> C.dsyr2 _layout _uplo n alpha _x incx _y incy _a lda


(* Performs a rank-2 update of a symmetric packed matrix. *)

let spr2
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> (float, a) t -> unit
  = fun layout uplo n alpha x incx y incy a ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.sspr2 _layout _uplo n alpha _x incx _y incy _a
  | Bigarray.Float64 -> C.dspr2 _layout _uplo n alpha _x incx _y incy _a


(* Computes a matrix-vector product using a Hermitian matrix. *)

let hemv
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chemv _layout _uplo n _alpha _a lda _x incx _beta _y incy
  | Bigarray.Complex64 -> C.zhemv _layout _uplo n _alpha _a lda _x incx _beta _y incy


(* Computes a matrix-vector product using a Hermitian band matrix. *)

let hbmv
  : type a. cblas_layout -> cblas_uplo -> int -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n k alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chbmv _layout _uplo n k _alpha _a lda _x incx _beta _y incy
  | Bigarray.Complex64 -> C.zhbmv _layout _uplo n k _alpha _a lda _x incx _beta _y incy


(* Computes a matrix-vector product using a Hermitian packed matrix. *)

let hpmv
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha ap x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chpmv _layout _uplo n _alpha _ap _x incx _beta _y incy
  | Bigarray.Complex64 -> C.zhpmv _layout _uplo n _alpha _ap _x incx _beta _y incy


(* Performs a rank-1 update of a Hermitian matrix. *)

let her
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha x incx a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.cher _layout _uplo n alpha _x incx _a lda
  | Bigarray.Complex64 -> C.zher _layout _uplo n alpha _x incx _a lda


(* Performs a rank-1 update of a Hermitian packed matrix. *)

let hpr
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (Complex.t, a) t -> int -> (Complex.t, a) t -> unit
  = fun layout uplo n alpha x incx a ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chpr _layout _uplo n alpha _x incx _a
  | Bigarray.Complex64 -> C.zhpr _layout _uplo n alpha _x incx _a


(* Performs a rank-2 update of a Hermitian matrix. *)

let her2
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha x incx y incy a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.cher2 _layout _uplo n _alpha _x incx _y incy _a lda
  | Bigarray.Complex64 -> C.zher2 _layout _uplo n _alpha _x incx _y incy _a lda


(* Performs a rank-2 update of a Hermitian packed matrix. *)

let hpr2
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> (Complex.t, a) t -> unit
  = fun layout uplo n alpha x incx y incy ap ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chpr2 _layout _uplo n _alpha _x incx _y incy _ap
  | Bigarray.Complex64 -> C.zhpr2 _layout _uplo n _alpha _x incx _y incy _ap


(* Level 3 BLAS *)


(* Computes a matrix-matrix product with general matrices. *)

let gemm
  : type a b. cblas_layout -> cblas_transpose -> cblas_transpose -> int -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout transa transb m n k alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.sgemm _layout _transa _transb m n k alpha _a lda _b ldb beta _c ldc
  | Bigarray.Float64   -> C.dgemm _layout _transa _transb m n k alpha _a lda _b ldb beta _c ldc
  | Bigarray.Complex32 -> C.cgemm _layout _transa _transb m n k (allocate complex32 alpha) _a lda _b ldb (allocate complex32 beta) _c ldc
  | Bigarray.Complex64 -> C.zgemm _layout _transa _transb m n k (allocate complex64 alpha) _a lda _b ldb (allocate complex64 beta) _c ldc
  | _                  -> failwith "owl_cblas:gemm"


(* Computes a matrix-matrix product where one input matrix is symmetric. *)

let symm
  : type a b. cblas_layout -> cblas_side -> cblas_uplo -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout side uplo m n alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.ssymm _layout _side _uplo m n alpha _a lda _b ldb beta _c ldc
  | Bigarray.Float64   -> C.dsymm _layout _side _uplo m n alpha _a lda _b ldb beta _c ldc
  | Bigarray.Complex32 -> C.csymm _layout _side _uplo m n (allocate complex32 alpha) _a lda _b ldb (allocate complex32 beta) _c ldc
  | Bigarray.Complex64 -> C.zsymm _layout _side _uplo m n (allocate complex64 alpha) _a lda _b ldb (allocate complex64 beta) _c ldc
  | _                  -> failwith "owl_cblas:symm"


(* Performs a symmetric rank-k update. *)

let syrk
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> a -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout uplo trans n k alpha a lda beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.ssyrk _layout _uplo _trans n k alpha _a lda beta _c ldc
  | Bigarray.Float64   -> C.dsyrk _layout _uplo _trans n k alpha _a lda beta _c ldc
  | Bigarray.Complex32 -> C.csyrk _layout _uplo _trans n k (allocate complex32 alpha) _a lda (allocate complex32 beta) _c ldc
  | Bigarray.Complex64 -> C.zsyrk _layout _uplo _trans n k (allocate complex64 alpha) _a lda (allocate complex64 beta) _c ldc
  | _                  -> failwith "owl_cblas:syrk"


(* Performs a symmetric rank-2k update. *)

let syr2k
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout uplo trans n k alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.ssyr2k _layout _uplo _trans n k alpha _a lda _b ldb beta _c ldc
  | Bigarray.Float64   -> C.dsyr2k _layout _uplo _trans n k alpha _a lda _b ldb beta _c ldc
  | Bigarray.Complex32 -> C.csyr2k _layout _uplo _trans n k (allocate complex32 alpha) _a lda _b ldb (allocate complex32 beta) _c ldc
  | Bigarray.Complex64 -> C.zsyr2k _layout _uplo _trans n k (allocate complex64 alpha) _a lda _b ldb (allocate complex64 beta) _c ldc
  | _                  -> failwith "owl_cblas:syr2k"


(* Computes a matrix-matrix product where one input matrix is triangular. *)

let trmm
  : type a b. cblas_layout -> cblas_side -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout side uplo transa diag m n alpha a lda b ldb ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.strmm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  | Bigarray.Float64   -> C.dtrmm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  | Bigarray.Complex32 -> C.ctrmm _layout _side _uplo _transa _diag m n (allocate complex32 alpha) _a lda _b ldb
  | Bigarray.Complex64 -> C.ztrmm _layout _side _uplo _transa _diag m n (allocate complex64 alpha) _a lda _b ldb
  | _                  -> failwith "owl_cblas:trmm"


(* Solves a triangular matrix equation. *)

let trsm
  : type a b. cblas_layout -> cblas_side -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout side uplo transa diag m n alpha a lda b ldb ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.strsm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  | Bigarray.Float64   -> C.dtrsm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  | Bigarray.Complex32 -> C.ctrsm _layout _side _uplo _transa _diag m n (allocate complex32 alpha) _a lda _b ldb
  | Bigarray.Complex64 -> C.ztrsm _layout _side _uplo _transa _diag m n (allocate complex64 alpha) _a lda _b ldb
  | _                  -> failwith "owl_cblas:trsm"


(* Computes a matrix-matrix product where one input matrix is Hermitian. *)

let hemm
  : type a. cblas_layout -> cblas_side -> cblas_uplo -> int -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout side uplo m n alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Complex32 -> C.chemm _layout _side _uplo m n (allocate complex32 alpha) _a lda _b ldb (allocate complex32 beta) _c ldc
  | Bigarray.Complex64 -> C.zhemm _layout _side _uplo m n (allocate complex64 alpha) _a lda _b ldb (allocate complex64 beta) _c ldc


(* Performs a Hermitian rank-k update. *)

let herk
  : type a. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> float -> (Complex.t, a) t -> int -> float -> (Complex.t, a) t -> int -> unit
  = fun layout uplo trans n k alpha a lda beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Complex32 -> C.cherk _layout _uplo _trans n k alpha _a lda beta _c ldc
  | Bigarray.Complex64 -> C.zherk _layout _uplo _trans n k alpha _a lda beta _c ldc


(* Performs a Hermitian rank-2k update. *)

let her2k
  : type a. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> float -> (Complex.t, a) t -> int -> unit
  = fun layout uplo trans n k alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Complex32 -> C.cher2k _layout _uplo _trans n k (allocate complex32 alpha) _a lda _b ldb beta _c ldc
  | Bigarray.Complex64 -> C.zher2k _layout _uplo _trans n k (allocate complex64 alpha) _a lda _b ldb beta _c ldc
