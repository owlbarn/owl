(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_cblas_basic


type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t


(** Helper functions *)

let _matrix_shape x =
  let s = Genarray.dims x in
  assert (Array.length s = 2);
  s.(0), s.(1)


let _flatten x =
  let d = Genarray.dims x in
  let n = Array.fold_right ( * ) d 1 in
  reshape x [|n|]


let _cblas_trans : type a b . (a, b) kind -> bool -> cblas_transpose
  = fun _kind trans ->
  if trans = true then
    match _kind with
    | Float32   -> CblasTrans
    | Float64   -> CblasTrans
    | Complex32 -> CblasConjTrans
    | Complex64 -> CblasConjTrans
    | _         -> failwith "owl_cblas._trans_typ: unsupported type"
  else
    CblasNoTrans


(** Level-3 BLAS: matrix-matrix operations *)

let gemm ?(transa=false) ?(transb=false) ?alpha ?beta ~a ~b ~c =
  let m, k = _matrix_shape a in
  let l, n = _matrix_shape b in

  let _m, _k = if transa then k, m else m, k in
  let _l, _n = if transb then n, l else l, n in
  assert (_k = _l && _m > 0 && _n > 0);

  let _kind = Genarray.kind a in
  let alpha = match alpha with
    | Some alpha -> alpha
    | None       -> Owl_const.one _kind
  in
  let beta = match beta with
    | Some beta -> beta
    | None      -> Owl_const.zero _kind
  in
  let layout = Owl_cblas_basic.CblasRowMajor in
  let transa = _cblas_trans _kind transa in
  let transb = _cblas_trans _kind transb in
  let lda = match transa with | CblasNoTrans -> k | _  -> m in
  let ldb = match transb with | CblasNoTrans -> n | _  -> k in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.gemm layout transa transb m n k alpha a lda b ldb beta c ldc
