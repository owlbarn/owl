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
  let _y = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_sgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  |> ignore

let dgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_dgemv _layout _trans m n alpha _a lda _x incx beta _y incy
  |> ignore

let cgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _beta = allocate complex32 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_cgemv _layout _trans m n _alpha _a lda _x incx _beta _y incy
  |> ignore

let zgemv layout trans m n alpha a lda x incx beta y incy =
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  C.cblas_zgemv _layout _trans m n _alpha _a lda _x incx _beta _y incy
  |> ignore


(* ends here *)
