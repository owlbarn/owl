(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Please refer to: Intel Math Kernel Library implements the BLAS
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)

open Ctypes

type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t

type s_t = (float, Bigarray.float32_elt) t
type d_t = (float, Bigarray.float64_elt) t
type c_t = (Complex.t, Bigarray.complex32_elt) t
type z_t = (Complex.t, Bigarray.complex64_elt) t

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
  C.drotg a b c s;
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
      let p  = Bigarray.(Array1.create Float32 C_layout 5) in
      let _p = bigarray_start Ctypes_static.Array1 p in
      C.srotmg d1 d2 b1 b2 _p;
      !@d1, !@d2, !@b1, p
    )
  | Bigarray.Float64 -> (
      let d1 = allocate double d1 in
      let d2 = allocate double d2 in
      let b1 = allocate double b1 in
      let p  = Bigarray.(Array1.create Float64 C_layout 5) in
      let _p = bigarray_start Ctypes_static.Array1 p in
      C.drotmg d1 d2 b1 b2 _p;
      !@d1, !@d2, !@b1, p
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
    | Bigarray.Float32 -> C.srotm n _x incx _y incy _p
    | Bigarray.Float64 -> C.drotm n _x incx _y incy _p
    | _                -> failwith "owl_cblas:rotm"
  in ()


(* Performs rotation of points in the plane. *)

let rot
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> float -> float -> unit
  = fun n x incx y incy c s ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32 -> C.srot n _x incx _y incy c s
    | Bigarray.Float64 -> C.drot n _x incx _y incy c s
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

let sgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.sgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  |> ignore

let dgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  |> ignore

let cgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cgemv _layout _trans m n _alpha _a lda _x incx _beta _y incy
  |> ignore

let zgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zgemv _layout _trans m n _alpha _a lda _x incx _beta _y incy
  |> ignore


(* Computes a matrix-vector product using a general band matrix *)

let sgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.sgbmv _layout _trans m n kl ku alpha _a lda _x incx beta _y incy
  |> ignore

let dgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dgbmv _layout _trans m n kl ku alpha _a lda _x incx beta _y incy
  |> ignore

let cgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cgbmv _layout _trans m n kl ku _alpha _a lda _x incx _beta _y incy
  |> ignore

let zgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zgbmv _layout _trans m n kl ku _alpha _a lda _x incx _beta _y incy
  |> ignore


(* Computes a matrix-vector product using a triangular matrix. *)

let strmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.strmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let dtrmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dtrmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ctrmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ctrmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ztrmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ztrmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore


(* Computes a matrix-vector product using a triangular band matrix. *)

let stbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.stbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let dtbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dtbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ctbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ctbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ztbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ztbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore


(* Computes a matrix-vector product using a triangular packed matrix. *)

let stpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.stpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let dtpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.dtpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ctpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.ctpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ztpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.ztpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore


(* Solves a system of linear equations whose coefficients are in a triangular matrix. *)

let strsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.strsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let dtrsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dtrsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ctrsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ctrsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ztrsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ztrsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore


(* Solves a system of linear equations whose coefficients are in a triangular band matrix. *)

let stbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.stbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let dtbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dtbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ctbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ctbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ztbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ztbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore


(* Solves a system of linear equations whose coefficients are in a triangular packed matrix. *)

let stpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.stpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let dtpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.dtpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ctpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.ctpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ztpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.ztpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore


(* Computes a matrix-vector product for a symmetric matrix. *)

let ssymv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ssymv _layout _uplo n alpha _a lda _x incx beta _y incy
  |> ignore

let dsymv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dsymv _layout _uplo n alpha _a lda _x incx beta _y incy
  |> ignore


(* Computes a matrix-vector product using a symmetric band matrix. *)

let ssbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ssbmv _layout _uplo n k alpha _a lda _x incx beta _y incy
  |> ignore

let dsbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dsbmv _layout _uplo n k alpha _a lda _x incx beta _y incy
  |> ignore


(* Computes a matrix-vector product using a symmetric packed matrix. *)

let sspmv layout uplo n k alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.sspmv _layout _uplo n alpha _ap _x incx beta _y incy
  |> ignore

let dspmv layout uplo n k alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.dspmv _layout _uplo n alpha _ap _x incx beta _y incy
  |> ignore


(* Performs a rank-1 update of a general matrix. *)

let sger layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.sger _layout m n alpha _x incx _y incy _a lda
  |> ignore

let dger layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dger _layout m n alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-1 update of a symmetric matrix. *)

let ssyr layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ssyr _layout _uplo n alpha _x incx _a lda
  |> ignore

let dsyr layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dsyr _layout _uplo n alpha _x incx _a lda
  |> ignore


(* Performs a rank-1 update of a symmetric packed matrix. *)

let sspr layout uplo n alpha x incx ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.sspr _layout _uplo n alpha _x incx _ap
  |> ignore

let dspr layout uplo n alpha x incx ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.dspr _layout _uplo n alpha _x incx _ap
  |> ignore


(* Performs a rank-2 update of symmetric matrix. *)

let ssyr2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.ssyr2 _layout _uplo n alpha _x incx _y incy _a lda
  |> ignore

let dsyr2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dsyr2 _layout _uplo n alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-2 update of a symmetric packed matrix. *)

let sspr2 layout uplo n alpha x incx y incy a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.sspr2 _layout _uplo n alpha _x incx _y incy _a
  |> ignore

let dspr2 layout uplo n alpha x incx y incy a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.dspr2 _layout _uplo n alpha _x incx _y incy _a
  |> ignore


(* Computes a matrix-vector product using a Hermitian matrix. *)

let chemv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.chemv _layout _uplo n _alpha _a lda _x incx _beta _y incy
  |> ignore

let zhemv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zhemv _layout _uplo n _alpha _a lda _x incx _beta _y incy
  |> ignore


(* Computes a matrix-vector product using a Hermitian band matrix. *)

let chbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.chbmv _layout _uplo n k _alpha _a lda _x incx _beta _y incy
  |> ignore

let zhbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zhbmv _layout _uplo n k _alpha _a lda _x incx _beta _y incy
  |> ignore


(* Computes a matrix-vector product using a Hermitian packed matrix. *)

let chpmv layout uplo n alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.chpmv _layout _uplo n _alpha _ap _x incx _beta _y incy
  |> ignore

let zhpmv layout uplo n alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.zhpmv _layout _uplo n _alpha _ap _x incx _beta _y incy
  |> ignore


(* Performs a rank-1 update (unconjugated) of a general matrix. *)

let cgeru layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cgeru _layout m n _alpha _x incx _y incy _a lda
  |> ignore

let zgeru layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zgeru _layout m n _alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-1 update (conjugated) of a general matrix. *)

let cgerc layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cgerc _layout m n _alpha _x incx _y incy _a lda
  |> ignore

let zgerc layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zgerc _layout m n _alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-1 update of a Hermitian matrix. *)

let cher layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cher _layout _uplo n alpha _x incx _a lda
  |> ignore

let zher layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zher _layout _uplo n alpha _x incx _a lda
  |> ignore


(* Performs a rank-1 update of a Hermitian packed matrix. *)

let chpr layout uplo n alpha x incx a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.chpr _layout _uplo n alpha _x incx _a
  |> ignore

let zhpr layout uplo n alpha x incx a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.chpr _layout _uplo n alpha _x incx _a
  |> ignore


(* Performs a rank-2 update of a Hermitian matrix. *)

let cher2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cher2 _layout _uplo n _alpha _x incx _y incy _a lda
  |> ignore

let zher2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.zher2 _layout _uplo n _alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-2 update of a Hermitian packed matrix. *)

let chpr2 layout uplo n alpha x incx y incy ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.chpr2 _layout _uplo n _alpha _x incx _y incy _ap
  |> ignore

let zhpr2 layout uplo n alpha x incx y incy ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.zhpr2 _layout _uplo n _alpha _x incx _y incy _ap
  |> ignore


(* Level 3 BLAS *)


(* Computes a matrix-matrix product with general matrices. *)

let sgemm layout transa transb m n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.sgemm _layout _transa _transb m n k alpha _a lda _b ldb beta _c ldc
  |> ignore

let dgemm layout transa transb m n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.dgemm _layout _transa _transb m n k alpha _a lda _b ldb beta _c ldc
  |> ignore

let cgemm layout transa transb m n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cgemm _layout _transa _transb m n k _alpha _a lda _b ldb _beta _c ldc
  |> ignore

let zgemm layout transa transb m n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zgemm _layout _transa _transb m n k _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Computes a matrix-matrix product where one input matrix is symmetric. *)

let ssymm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.ssymm _layout _side _uplo m n alpha _a lda _b ldb beta _c ldc
  |> ignore

let dsymm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.dsymm _layout _side _uplo m n alpha _a lda _b ldb beta _c ldc
  |> ignore

let csymm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.csymm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
  |> ignore

let zsymm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zsymm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Performs a symmetric rank-k update. *)

let ssyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.ssyrk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore

let dsyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.dsyrk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore

let csyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.csyrk _layout _uplo _trans n k _alpha _a lda _beta _c ldc
  |> ignore

let zsyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zsyrk _layout _uplo _trans n k _alpha _a lda _beta _c ldc
  |> ignore


(* Performs a symmetric rank-2k update. *)

let ssyr2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.ssyr2k _layout _uplo _trans n k alpha _a lda _b ldb beta _c ldc
  |> ignore

let dsyr2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.dsyr2k _layout _uplo _trans n k alpha _a lda _b ldb beta _c ldc
  |> ignore

let csyr2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.csyr2k _layout _uplo _trans n k _alpha _a lda _b ldb _beta _c ldc
  |> ignore

let zsyr2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zsyr2k _layout _uplo _trans n k _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Computes a matrix-matrix product where one input matrix is triangular. *)

let strmm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.strmm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  |> ignore

let dtrmm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.dtrmm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  |> ignore

let ctrmm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _alpha = allocate complex32 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.ctrmm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
  |> ignore

let ztrmm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _alpha = allocate complex64 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.ztrmm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
  |> ignore


(* Solves a triangular matrix equation. *)

let strsm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.strsm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  |> ignore

let dtrsm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.dtrsm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  |> ignore

let ctrsm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _alpha = allocate complex32 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.ctrsm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
  |> ignore

let ztrsm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _alpha = allocate complex64 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.ztrsm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
  |> ignore


(* Computes a matrix-matrix product where one input matrix is Hermitian. *)

let chemm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.chemm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
  |> ignore

let zhemm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zhemm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Performs a Hermitian rank-k update. *)

let cherk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cherk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore

let zherk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zherk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore


(* Performs a Hermitian rank-2k update. *)

let cher2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cher2k _layout _uplo _trans n k _alpha _a lda _b ldb beta _c ldc
  |> ignore

let zher2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.zher2k _layout _uplo _trans n k _alpha _a lda _b ldb beta _c ldc
  |> ignore
