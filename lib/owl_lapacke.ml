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


type ('a, 'b, 'c) t = ('a, 'b, 'c) Array1.t
type ('a, 'b, 'c) mat = ('a, 'b, 'c) Array2.t

type 'c s_t = (float, Bigarray.float32_elt, 'c) t
type 'c d_t = (float, Bigarray.float64_elt, 'c) t
type 'c c_t = (Complex.t, Bigarray.complex32_elt, 'c) t
type 'c z_t = (Complex.t, Bigarray.complex64_elt, 'c) t

type lapacke_layout = RowMajor | ColMajor
let lapacke_layout : type a. a layout -> int = function
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

(* calculate the leading dimension of a matrix *)
let _stride : type a b c. (a, b, c) mat -> int = fun x ->
  match (Array2.layout x) with
  | C_layout       -> Array2.dim2 x
  | Fortran_layout -> Array2.dim1 x



let gesvd
  : type a b c. jobu:char -> jobvt:char -> a:(a, b, c) mat -> unit
  = fun ~jobu ~jobvt ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  assert (jobu <> 'O' || jobvt <> 'O');
  assert (m > 0 && n > 0);

  let u = match jobu with
    | 'A' -> Array2.create _kind _layout m m
    | 'S' -> Array2.create _kind _layout m minmn
    | _   -> Array2.create _kind _layout 0 0
  in
  let vt = match jobvt with
    | 'A' -> Array2.create _kind _layout n n
    | 'S' -> Array2.create _kind _layout minmn n
    | _   -> Array2.create _kind _layout 0 0
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldvt = Pervasives.max 1 (_stride vt) in
  let a = bigarray_start Ctypes_static.Array2 a in
  let u = bigarray_start Ctypes_static.Array2 u in
  let vt = bigarray_start Ctypes_static.Array2 vt in

  let ret = match _kind with
    | Float32 -> (
        let s = Array1.create float32 _layout minmn
          |> bigarray_start Ctypes_static.Array1
        in
        let superb = Array1.create float32 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        L.sgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb
      )
    | Float64 -> (
        let s = Array1.create float64 _layout minmn
          |> bigarray_start Ctypes_static.Array1
        in
        let superb = Array1.create float64 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        L.dgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb
      )
    | Complex32 -> (
        let s = Array1.create float32 _layout minmn
          |> bigarray_start Ctypes_static.Array1
        in
        let superb = Array1.create float32 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        L.cgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb
      )
    | Complex64 -> (
        let s = Array1.create float64 _layout minmn
          |> bigarray_start Ctypes_static.Array1
        in
        let superb = Array1.create float64 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        L.zgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb
      )
    | _        -> failwith "lapacke:gesvd"
  in
  check_lapack_error ret


(*
let gesvd : type a b. (a, b) kind -> layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(a ptr) -> lda:int
-> s:(float ptr) -> u:(a ptr) -> ldu:int -> vt:(a ptr) -> ldvt:int -> superb:(float ptr) -> int
  = function
  | Float32 -> L.sgesvd
  | Float64 -> L.dgesvd
  | Complex32 -> L.cgesvd
  | Complex64 -> L.zgesvd
  | _         -> failwith "lapacke:gesvd"
*)
