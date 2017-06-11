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


module C = Owl_cblas_bindings.Bindings(Owl_cblas_generated)


(* Level 1 BLAS *)


(* Computes the parameters for a Givens rotation. *)

let srotg a b =
  let a = allocate float a in
  let b = allocate float b in
  let c = allocate float 0. in
  let s = allocate float 0. in
  C.cblas_srotg a b c s;
  !@a, !@b, !@c, !@s

let drotg a b =
  let a = allocate double a in
  let b = allocate double b in
  let c = allocate double 0. in
  let s = allocate double 0. in
  C.cblas_drotg a b c s;
  !@a, !@b, !@c, !@s


(* Computes the parameters for a modified Givens rotation. *)

let srotmg d1 d2 b1 b2 =
  let d1 = allocate float d1 in
  let d2 = allocate float d2 in
  let b1 = allocate float b1 in
  let p  = Bigarray.(Array1.create Float32 C_layout 5) in
  let _p = bigarray_start Ctypes_static.Array1 p in
  C.cblas_srotmg d1 d2 b1 b2 _p;
  !@d1, !@d2, !@b1, p


let drotmg d1 d2 b1 b2 =
  let d1 = allocate double d1 in
  let d2 = allocate double d2 in
  let b1 = allocate double b1 in
  let p  = Bigarray.(Array1.create Float64 C_layout 5) in
  let _p = bigarray_start Ctypes_static.Array1 p in
  C.cblas_drotmg d1 d2 b1 b2 _p;
  !@d1, !@d2, !@b1, p


(* Performs rotation of points in the plane. *)

let srot n x incx y incy c s =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_srot n _x incx _y incy c s
  |> ignore

let drot n x incx y incy c s =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_drot n _x incx _y incy c s
  |> ignore


(* Swaps a vector with another vector. *)

let sswap n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_sswap n _x incx _y incy
  |> ignore

let dswap n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_dswap n _x incx _y incy
  |> ignore

let cswap n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_cswap n _x incx _y incy
  |> ignore

let zswap n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_zswap n _x incx _y incy
  |> ignore


(* Computes the product of a vector by a scalar. *)

let sscal n a x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_sscal n a _x incx
  |> ignore

let dscal n a x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_dscal n a _x incx
  |> ignore

let cscal n a x incx =
  let _a = allocate complex32 a in
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_cscal n _a _x incx
  |> ignore

let zscal n a x incx =
  let _a = allocate complex64 a in
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_zscal n _a _x incx
  |> ignore

let csscal n a x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_csscal n a _x incx
  |> ignore

let zdscal n a x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_zdscal n a _x incx
  |> ignore


(* Copies vector to another vector. *)

let scopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_scopy n _x incx _y incy
  |> ignore

let dcopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_dcopy n _x incx _y incy
  |> ignore

let ccopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_ccopy n _x incx _y incy
  |> ignore

let zcopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_zcopy n _x incx _y incy
  |> ignore


(* Computes a vector-scalar product and adds the result to a vector. *)

let saxpy n a x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_saxpy n a _x incx _y incy
  |> ignore

let daxpy n a x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_daxpy n a _x incx _y incy
  |> ignore

let caxpy n a x incx y incy =
  let _a = allocate complex32 a in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_caxpy n _a _x incx _y incy
  |> ignore

let zaxpy n a x incx y incy =
  let _a = allocate complex64 a in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_zaxpy n _a _x incx _y incy
  |> ignore


(* Computes a vector-vector dot product. *)

let sdot n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_sdot n _x incx _y incy

let ddot n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_ddot n _x incx _y incy


(* Computes a vector-vector dot product with double precision. *)

let sdsdot n a x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_sdsdot n a _x incx _y incy

let dsdot n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.cblas_dsdot n _x incx _y incy


(* Computes a vector-vector dot product, unconjugated. *)

let cdotu n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _z = allocate complex32 Complex.zero in
  C.cblas_cdotu n _x incx _y incy _z;
  !@_z

let zdotu n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _z = allocate complex64 Complex.zero in
  C.cblas_zdotu n _x incx _y incy _z;
  !@_z


(* Computes a dot product of a conjugated vector with another vector. *)

let cdotc n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _z = allocate complex32 Complex.zero in
  C.cblas_cdotc n _x incx _y incy _z;
  !@_z

let zdotc n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _z = allocate complex64 Complex.zero in
  C.cblas_zdotc n _x incx _y incy _z;
  !@_z


(* Computes the Euclidean norm of a vector. *)

let snrm2 n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_snrm2 n _x incx

let dnrm2 n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_dnrm2 n _x incx

let scnrm2 n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_scnrm2 n _x incx

let dznrm2 n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_dznrm2 n _x incx


(* Computes the sum of magnitudes of the vector elements. *)

let sasum n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_sasum n _x incx

let dasum n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_dasum n _x incx

let scasum n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_scasum n _x incx

let dzasum n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_dzasum n _x incx


(* Finds the index of the element with maximum absolute value. *)

let isamax n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_isamax n _x incx
  |> Unsigned.Size_t.to_int

let idamax n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_idamax n _x incx
  |> Unsigned.Size_t.to_int

let icamax n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_icamax n _x incx
  |> Unsigned.Size_t.to_int

let izamax n x incx =
  let _x = bigarray_start Ctypes_static.Array1 x in
  C.cblas_izamax n _x incx
  |> Unsigned.Size_t.to_int


(* Level 2 BLAS *)


(* Computes a matrix-vector product using a general matrix *)

let sgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_sgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  |> ignore

let dgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  |> ignore

let cgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cgemv _layout _trans m n _alpha _a lda _x incx _beta _y incy
  |> ignore

let zgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zgemv _layout _trans m n _alpha _a lda _x incx _beta _y incy
  |> ignore


(* Computes a matrix-vector product using a general band matrix *)

let sgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_sgbmv _layout _trans m n kl ku alpha _a lda _x incx beta _y incy
  |> ignore

let dgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dgbmv _layout _trans m n kl ku alpha _a lda _x incx beta _y incy
  |> ignore

let cgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cgbmv _layout _trans m n kl ku _alpha _a lda _x incx _beta _y incy
  |> ignore

let zgbmv layout trans m n kl ku alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zgbmv _layout _trans m n kl ku _alpha _a lda _x incx _beta _y incy
  |> ignore


(* Computes a matrix-vector product using a triangular matrix. *)

let strmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_strmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let dtrmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dtrmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ctrmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ctrmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ztrmv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ztrmv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore


(* Computes a matrix-vector product using a triangular band matrix. *)

let stbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_stbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let dtbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dtbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ctbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ctbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ztbmv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ztbmv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore


(* Computes a matrix-vector product using a triangular packed matrix. *)

let stpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_stpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let dtpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_dtpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ctpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_ctpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ztpmv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_ztpmv _layout _uplo _trans _diag n _ap _x incx
  |> ignore


(* Solves a system of linear equations whose coefficients are in a triangular matrix. *)

let strsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_strsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let dtrsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dtrsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ctrsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ctrsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore

let ztrsv layout uplo trans diag n a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ztrsv _layout _uplo _trans _diag n _a lda _x incx
  |> ignore


(* Solves a system of linear equations whose coefficients are in a triangular band matrix. *)

let stbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_stbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let dtbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dtbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ctbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ctbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore

let ztbsv layout uplo trans diag n k a lda x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ztbsv _layout _uplo _trans _diag n k _a lda _x incx
  |> ignore


(* Solves a system of linear equations whose coefficients are in a triangular packed matrix. *)

let stpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_stpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let dtpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_dtpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ctpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_ctpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore

let ztpsv layout uplo trans diag n ap x incx =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_ztpsv _layout _uplo _trans _diag n _ap _x incx
  |> ignore


(* Computes a matrix-vector product for a symmetric matrix. *)

let ssymv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ssymv _layout _uplo n alpha _a lda _x incx beta _y incy
  |> ignore

let dsymv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dsymv _layout _uplo n alpha _a lda _x incx beta _y incy
  |> ignore


(* Computes a matrix-vector product using a symmetric band matrix. *)

let ssbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ssbmv _layout _uplo n k alpha _a lda _x incx beta _y incy
  |> ignore

let dsbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dsbmv _layout _uplo n k alpha _a lda _x incx beta _y incy
  |> ignore


(* Computes a matrix-vector product using a symmetric packed matrix. *)

let sspmv layout uplo n k alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_sspmv _layout _uplo n alpha _ap _x incx beta _y incy
  |> ignore

let dspmv layout uplo n k alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_dspmv _layout _uplo n alpha _ap _x incx beta _y incy
  |> ignore


(* Performs a rank-1 update of a general matrix. *)

let sger layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_sger _layout m n alpha _x incx _y incy _a lda
  |> ignore

let dger layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dger _layout m n alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-1 update of a symmetric matrix. *)

let ssyr layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ssyr _layout _uplo n alpha _x incx _a lda
  |> ignore

let dsyr layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dsyr _layout _uplo n alpha _x incx _a lda
  |> ignore


(* Performs a rank-1 update of a symmetric packed matrix. *)

let sspr layout uplo n alpha x incx ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_sspr _layout _uplo n alpha _x incx _ap
  |> ignore

let dspr layout uplo n alpha x incx ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_dspr _layout _uplo n alpha _x incx _ap
  |> ignore


(* Performs a rank-2 update of symmetric matrix. *)

let ssyr2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_ssyr2 _layout _uplo n alpha _x incx _y incy _a lda
  |> ignore

let dsyr2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dsyr2 _layout _uplo n alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-2 update of a symmetric packed matrix. *)

let sspr2 layout uplo n alpha x incx y incy a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_sspr2 _layout _uplo n alpha _x incx _y incy _a
  |> ignore

let dspr2 layout uplo n alpha x incx y incy a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dspr2 _layout _uplo n alpha _x incx _y incy _a
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
  C.cblas_chemv _layout _uplo n _alpha _a lda _x incx _beta _y incy
  |> ignore

let zhemv layout uplo n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zhemv _layout _uplo n _alpha _a lda _x incx _beta _y incy
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
  C.cblas_chbmv _layout _uplo n k _alpha _a lda _x incx _beta _y incy
  |> ignore

let zhbmv layout uplo n k alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zhbmv _layout _uplo n k _alpha _a lda _x incx _beta _y incy
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
  C.cblas_chpmv _layout _uplo n _alpha _ap _x incx _beta _y incy
  |> ignore

let zhpmv layout uplo n alpha ap x incx beta y incy =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_zhpmv _layout _uplo n _alpha _ap _x incx _beta _y incy
  |> ignore


(* Performs a rank-1 update (unconjugated) of a general matrix. *)

let cgeru layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cgeru _layout m n _alpha _x incx _y incy _a lda
  |> ignore

let zgeru layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zgeru _layout m n _alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-1 update (conjugated) of a general matrix. *)

let cgerc layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cgerc _layout m n _alpha _x incx _y incy _a lda
  |> ignore

let zgerc layout m n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zgerc _layout m n _alpha _x incx _y incy _a lda
  |> ignore


(* Performs a rank-1 update of a Hermitian matrix. *)

let cher layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cher _layout _uplo n alpha _x incx _a lda
  |> ignore

let zher layout uplo n alpha x incx a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zher _layout _uplo n alpha _x incx _a lda
  |> ignore


(* Performs a rank-1 update of a Hermitian packed matrix. *)

let chpr layout uplo n alpha x incx a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_chpr _layout _uplo n alpha _x incx _a
  |> ignore

let zhpr layout uplo n alpha x incx a =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_chpr _layout _uplo n alpha _x incx _a
  |> ignore


(* Performs a rank-2 update of a Hermitian matrix. *)

let cher2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cher2 _layout _uplo n _alpha _x incx _a lda
  |> ignore

let zher2 layout uplo n alpha x incx y incy a lda =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zher2 _layout _uplo n _alpha _x incx _a lda
  |> ignore


(* Performs a rank-2 update of a Hermitian packed matrix. *)

let chpr2 layout uplo n alpha x incx y incy ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex32 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_chpr2 _layout _uplo n _alpha _x incx _y incy _ap
  |> ignore

let zhpr2 layout uplo n alpha x incx y incy ap =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  C.cblas_zhpr2 _layout _uplo n _alpha _x incx _y incy _ap
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
  C.cblas_sgemm _layout _transa _transb m n k alpha _a lda _b ldb beta _c ldc
  |> ignore

let dgemm layout transa transb m n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_dgemm _layout _transa _transb m n k alpha _a lda _b ldb beta _c ldc
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
  C.cblas_cgemm _layout _transa _transb m n k _alpha _a lda _b ldb _beta _c ldc
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
  C.cblas_zgemm _layout _transa _transb m n k _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Computes a matrix-matrix product where one input matrix is symmetric. *)

let ssymm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_ssymm _layout _side _uplo m n alpha _a lda _b ldb beta _c ldc
  |> ignore

let dsymm layout side uplo m n alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_dsymm _layout _side _uplo m n alpha _a lda _b ldb beta _c ldc
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
  C.cblas_csymm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
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
  C.cblas_zsymm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Performs a symmetric rank-k update. *)

let ssyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_ssyrk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore

let dsyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_dsyrk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore

let csyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_csyrk _layout _uplo _trans n k _alpha _a lda _beta _c ldc
  |> ignore

let zsyrk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_zsyrk _layout _uplo _trans n k _alpha _a lda _beta _c ldc
  |> ignore


(* Performs a symmetric rank-2k update. *)

let ssyr2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_ssyr2k _layout _uplo _trans n k alpha _a lda _b ldb beta _c ldc
  |> ignore

let dsyr2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_dsyr2k _layout _uplo _trans n k alpha _a lda _b ldb beta _c ldc
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
  C.cblas_csyr2k _layout _uplo _trans n k _alpha _a lda _b ldb _beta _c ldc
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
  C.cblas_zsyr2k _layout _uplo _trans n k _alpha _a lda _b ldb _beta _c ldc
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
  C.cblas_strmm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  |> ignore

let dtrmm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.cblas_dtrmm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
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
  C.cblas_ctrmm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
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
  C.cblas_ztrmm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
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
  C.cblas_strsm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
  |> ignore

let dtrsm layout side uplo transa diag m n alpha a lda b ldb =
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  C.cblas_dtrsm _layout _side _uplo _transa _diag m n alpha _a lda _b ldb
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
  C.cblas_ctrsm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
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
  C.cblas_ztrsm _layout _side _uplo _transa _diag m n _alpha _a lda _b ldb
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
  C.cblas_chemm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
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
  C.cblas_zhemm _layout _side _uplo m n _alpha _a lda _b ldb _beta _c ldc
  |> ignore


(* Performs a Hermitian rank-k update. *)

let cherk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_cherk _layout _uplo _trans n k alpha _a lda beta _c ldc
  |> ignore

let zherk layout uplo trans n k alpha a lda beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_zherk _layout _uplo _trans n k alpha _a lda beta _c ldc
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
  C.cblas_cher2k _layout _uplo _trans n k _alpha _a lda _b ldb beta _c ldc
  |> ignore

let zher2k layout uplo trans n k alpha a lda b ldb beta c ldc =
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  C.cblas_zher2k _layout _uplo _trans n k _alpha _a lda _b ldb beta _c ldc
  |> ignore
