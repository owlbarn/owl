(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_cblas_basic


(** Type definition *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

type side = Owl_cblas_basic.cblas_side

type uplo = Owl_cblas_basic.cblas_uplo


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


let _cblas_diag = function true -> CblasUnit | false -> CblasNonUnit


(** Level-1 BLAS: vector-vector operations *)



(** Level-2 BLAS: matrix-vector operations *)

let gemv ?(trans=false) ?(incx=1) ?(incy=1) ?alpha ?beta ~a ~x ~y =
  let m, n = _matrix_shape a in

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
  let trans = _cblas_trans _kind trans in
  let lda = n in

  let a = _flatten a |> array1_of_genarray in
  let x = _flatten x |> array1_of_genarray in
  let y = _flatten y |> array1_of_genarray in

  Owl_cblas_basic.gemv layout trans m n alpha a lda x incx beta y incy


let gbmv ?(trans=false) ?(incx=1) ?(incy=1) ?alpha ?beta ~kl ~ku ~a ~x ~y =
  let m, n = _matrix_shape a in
  assert (kl >= 0 && ku >= 0);

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
  let trans = _cblas_trans _kind trans in
  let lda = n in

  let a = _flatten a |> array1_of_genarray in
  let x = _flatten x |> array1_of_genarray in
  let y = _flatten y |> array1_of_genarray in

  Owl_cblas_basic.gbmv layout trans m n kl ku alpha a lda x incx beta y incy


(** Level-3 BLAS: matrix-matrix operations *)

let gemm ?(transa=false) ?(transb=false) ?alpha ?beta ~a ~b ~c =
  let m, k = _matrix_shape a in
  let l, n = _matrix_shape b in
  let p, q = _matrix_shape c in

  let m, k = if transa then k, m else m, k in
  let l, n = if transb then n, l else l, n in
  assert (k = l && m > 0 && n > 0);
  assert (p = m && q = n);

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
  let lda = match transa with CblasNoTrans -> k | _  -> m in
  let ldb = match transb with CblasNoTrans -> n | _  -> k in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.gemm layout transa transb m n k alpha a lda b ldb beta c ldc


let symm ?(side=CblasRight) ?(uplo=CblasUpper) ?alpha ?beta ~a ~b ~c =
  let m, n, lda, ldb, ldc =
    let m, k = _matrix_shape a in
    let l, n = _matrix_shape b in
    let p, q = _matrix_shape c in
    let () = match side with
    | CblasLeft ->
      assert (k = l && m > 0 && n > 0);
      assert (p = m && q = n);
    | CblasRight ->
      assert (n = m && l > 0 && k > 0);
      assert (p = l && q = k);
    in
      p, q, k, n, q
  in
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

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.symm layout side uplo m n alpha a lda b ldb beta c ldc


let syrk ?(uplo=CblasUpper) ?(trans=false) ?alpha ?beta ~a ~c =
  let n, k = _matrix_shape a in
  let p, q = _matrix_shape c in

  let n, k = if trans then k, n else n, k in
  assert (n > 0 && k > 0);
  assert (p = n && q = n);

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
  let trans = _cblas_trans _kind trans in
  let lda = match trans with CblasNoTrans -> k | _  -> n in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.syrk layout uplo trans n k alpha a lda beta c ldc


let syr2k ?(uplo=CblasUpper) ?(trans=false) ?alpha ?beta ~a ~b ~c =
  let n, k = _matrix_shape a in
  let m, l = _matrix_shape b in
  let p, q = _matrix_shape c in

  let n, k = if trans then k, n else n, k in
  let m, l = if trans then l, m else n, l in
  assert (n > 0 && k > 0);
  assert (m = n && k = l);
  assert (p = n && q = n);

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
  let trans = _cblas_trans _kind trans in
  let lda = match trans with CblasNoTrans -> k | _  -> n in
  let ldb = match trans with CblasNoTrans -> k | _  -> n in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.syr2k layout uplo trans n k alpha a lda b ldb beta c ldc


let trmm ?(side=CblasRight) ?(uplo=CblasUpper) ?(transa=false) ?(diag=false) ?alpha ~a ~b =
  let p, q = _matrix_shape a in
  let m, n = _matrix_shape b in

  let p, q = if transa then q, p else p, q in
  assert (m > 0 && n > 0);
  assert (m = p && n = q);

  let _kind = Genarray.kind a in
  let alpha = match alpha with
    | Some alpha -> alpha
    | None       -> Owl_const.one _kind
  in
  let layout = Owl_cblas_basic.CblasRowMajor in
  let transa = _cblas_trans _kind transa in
  let diag = _cblas_diag diag in
  let lda = match side with CblasLeft -> m | _  -> n in
  let ldb = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in

  Owl_cblas_basic.trmm layout side uplo transa diag m n alpha a lda b ldb


let trsm ?(side=CblasRight) ?(uplo=CblasUpper) ?(transa=false) ?(diag=false) ?alpha ~a ~b =
  let p, q = _matrix_shape a in
  let m, n = _matrix_shape b in

  let p, q = if transa then q, p else p, q in
  assert (m > 0 && n > 0);
  assert (m = p && n = q);

  let _kind = Genarray.kind a in
  let alpha = match alpha with
    | Some alpha -> alpha
    | None       -> Owl_const.one _kind
  in
  let layout = Owl_cblas_basic.CblasRowMajor in
  let transa = _cblas_trans _kind transa in
  let diag = _cblas_diag diag in
  let lda = match side with CblasLeft -> m | _  -> n in
  let ldb = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in

  Owl_cblas_basic.trsm layout side uplo transa diag m n alpha a lda b ldb


let hemm ?(side=CblasRight) ?(uplo=CblasUpper) ?alpha ?beta ~a ~b ~c =
  (* TODO: check the shape of a *)
  let m, n = _matrix_shape b in
  let p, q = _matrix_shape c in
  assert (m > 0 && n > 0);
  assert (p = m && q = n);

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
  let lda = match side with CblasLeft -> m | CblasRight -> n in
  let ldb = n in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.hemm layout side uplo m n alpha a lda b ldb beta c ldc


let herk ?(uplo=CblasUpper) ?(trans=false) ?alpha ?beta ~a ~c =
  let n, k = _matrix_shape a in
  let p, q = _matrix_shape c in

  let n, k = if trans then k, n else n, k in
  assert (n > 0 && k > 0);
  assert (p = n && q = n);

  let _kind = Genarray.kind a in
  let alpha = match alpha with Some alpha -> alpha | None -> 1. in
  let beta = match beta with Some beta -> beta | None -> 0. in
  let layout = Owl_cblas_basic.CblasRowMajor in
  let trans = _cblas_trans _kind trans in
  let lda = match trans with CblasNoTrans -> k | _  -> n in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.herk layout uplo trans n k alpha a lda beta c ldc


let her2k ?(uplo=CblasUpper) ?(trans=false) ?alpha ?beta ~a ~b ~c =
  let n, k = _matrix_shape a in
  let l, m = _matrix_shape b in
  let p, q = _matrix_shape c in

  let n, k = if trans then k, n else n, k in
  let l, m = if trans then m, l else l, m in
  assert (n > 0 && k > 0);
  assert (n = l && k = m);
  assert (p = n && q = n);

  let _kind = Genarray.kind a in
  let alpha = match alpha with Some alpha -> alpha | None -> Complex.one in
  let beta = match beta with Some beta -> beta | None -> 0. in
  let layout = Owl_cblas_basic.CblasRowMajor in
  let trans = _cblas_trans _kind trans in
  let lda = match trans with CblasNoTrans -> k | _  -> n in
  let ldb = match trans with CblasNoTrans -> k | _  -> n in
  let ldc = n in

  let a = _flatten a |> array1_of_genarray in
  let b = _flatten b |> array1_of_genarray in
  let c = _flatten c |> array1_of_genarray in

  Owl_cblas_basic.her2k layout uplo trans n k alpha a lda b ldb beta c ldc
