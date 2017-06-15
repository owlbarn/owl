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




(* Copies vector to another vector. *)

let scopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.scopy n _x incx _y incy
  |> ignore

let dcopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.dcopy n _x incx _y incy
  |> ignore

let ccopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.ccopy n _x incx _y incy
  |> ignore

let zcopy n x incx y incy =
  let _x = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let _y = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.zcopy n _x incx _y incy
  |> ignore
