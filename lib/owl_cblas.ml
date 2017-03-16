(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

module C = Owl_cblas_bindings.Bindings(Owl_cblas_generated)

let scopy n x incx y incy =
  let x_ptr = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let y_ptr = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_scopy n x_ptr incx y_ptr incy

let dcopy n x incx y incy =
  let x_ptr = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let y_ptr = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_dcopy n x_ptr incx y_ptr incy

let ccopy n x incx y incy =
  let x_ptr = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let y_ptr = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_ccopy n x_ptr incx y_ptr incy

let zcopy n x incx y incy =
  let x_ptr = Ctypes.bigarray_start Ctypes_static.Array1 x in
  let y_ptr = Ctypes.bigarray_start Ctypes_static.Array1 y in
  C.cblas_zcopy n x_ptr incx y_ptr incy
