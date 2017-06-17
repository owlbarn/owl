(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Please refer to: Intel Math Kernel Library on the LAPACKE Interface
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)

open Ctypes
open Bigarray

module L = Owl_lapacke_generated


type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Array1.t

type s_t = (float, Bigarray.float32_elt) t
type d_t = (float, Bigarray.float64_elt) t
type c_t = (Complex.t, Bigarray.complex32_elt) t
type z_t = (Complex.t, Bigarray.complex64_elt) t

type lapacke_layout = RowMajor | ColMajor
let lapacke_layout
  : type a. a layout -> int
  = function
  | C_layout       -> 101
  | Fortran_layout -> 102

type lapacke_transpose = NoTrans | Trans | ConjTrans
let lapacke_transpose = function NoTrans -> 111 | Trans -> 112 | ConjTrans -> 113

type lapacke_uplo = Upper | Lower
let lapacke_uplo = function Upper -> 121 | Lower -> 122

type lapacke_diag = NonUnit | Unit
let lapacke_diag = function NonUnit -> 131 | Unit -> 132

type lapacke_side = Left | Right
let lapacke_side = function Left -> 141 | Right -> 142

let check_lapack_error ret =
  if ret = 0 then ()
  else if ret < 0 then
    raise (Invalid_argument (string_of_int ret))
  else
    failwith (Printf.sprintf "LAPACKE: %i" ret)


let gesvd ~jobu ~jobvt ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb =
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in
  let kind = Array2.kind a in
  let minmn = Pervasives.min m n in

  let s = Array1.create kind _layout minmn in
  let u = match jobu with
    | 'A' -> Array2.create kind _layout m m
    | 'S' -> Array2.create kind _layout m minmn
    | _   -> Array2.create kind _layout 0 0
  in
  let vt = match jobvt with
    | 'A' -> Array2.create kind _layout n n
    | 'S' -> Array2.create kind _layout minmn n
    | _   -> Array2.create kind _layout 0 0
  in
  let a = bigarray_start Ctypes_static.Array2 a in
  let s = bigarray_start Ctypes_static.Array1 s in
  let u = bigarray_start Ctypes_static.Array2 u in
  let vt = bigarray_start Ctypes_static.Array2 vt in
  let superb = bigarray_start Ctypes_static.Array1 superb in

  let lapacke_fun = L.dgesvd
  in
  lapacke_fun ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb
  |> check_lapack_error
