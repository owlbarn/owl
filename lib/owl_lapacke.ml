(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Please refer to the documentation of Intel Math Kernel Library on the
  LAPACKE Interface. The interface implemented here is compatible the those
  documented on their website.
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)

open Ctypes
open Bigarray

module L = Owl_lapacke_generated


type ('a, 'b) t = ('a, 'b, c_layout) Array1.t
type ('a, 'b) mat = ('a, 'b, c_layout) Array2.t

type s_t = (float, Bigarray.float32_elt) t
type d_t = (float, Bigarray.float64_elt) t
type c_t = (Complex.t, Bigarray.complex32_elt) t
type z_t = (Complex.t, Bigarray.complex64_elt) t

type lapacke_layout = RowMajor | ColMajor
let lapacke_layout : type a. a layout -> int = function
  | C_layout       -> 101
  | Fortran_layout -> 102

type lapacke_transpose = NoTrans | Trans | ConjTrans
let lapacke_transpose = function NoTrans -> 'N' | Trans -> 'T' | ConjTrans -> 'C'

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
let _stride : type a b c. (a, b, c) Array2.t -> int = fun x ->
  match (Array2.layout x) with
  | C_layout       -> Array2.dim2 x
  | Fortran_layout -> Array2.dim1 x


let gbtrf
  : type a b. kl:int -> ku:int -> m:int -> ab:(a, b) mat -> (a, b) mat * (int, int_elt) t
  = fun ~kl ~ku ~m ~ab ->
  let n = Array2.dim2 ab in
  let minmn = Pervasives.min m n in
  let _kind = Array2.kind ab in
  let _layout = Array2.layout ab in
  let layout = lapacke_layout _layout in

  assert (kl >= 0 && ku >=0 && m >= 0 && n >= 0);

  let ipiv = Array1.create Int _layout minmn in
  let _ipiv = bigarray_start Ctypes_static.Array1 ipiv in
  let _ab = bigarray_start Ctypes_static.Array2 ab in
  let ldab = _stride ab in

  let ret = match _kind with
    | Float32   -> L.sgbtrf layout m n kl ku _ab ldab _ipiv
    | Float64   -> L.dgbtrf layout m n kl ku _ab ldab _ipiv
    | Complex32 -> L.cgbtrf layout m n kl ku _ab ldab _ipiv
    | Complex64 -> L.zgbtrf layout m n kl ku _ab ldab _ipiv
    | _         -> failwith "lapacke:gbtrf"
  in
  check_lapack_error ret;
  ab, ipiv


let gbtrs
  : type a b. trans:lapacke_transpose -> kl:int -> ku:int -> n:int
  -> ab:(a, b) mat -> ipiv:(int, int_elt) t -> b:(a, b) mat -> unit
  = fun ~trans ~kl ~ku ~n ~ab ~ipiv ~b ->
    let m = Array2.dim2 ab in
    assert (n = m && n = Array2.dim1 b);
    let nrhs = Array2.dim2 b in
    let _kind = Array2.kind ab in
    let _layout = Array2.layout ab in
    let layout = lapacke_layout _layout in
    let trans = lapacke_transpose trans in

    let _ipiv = bigarray_start Ctypes_static.Array1 ipiv in
    let _ab = bigarray_start Ctypes_static.Array2 ab in
    let _b = bigarray_start Ctypes_static.Array2 b in
    let ldab = _stride ab in
    let ldb = _stride b in

    let ret = match _kind with
      | Float32   -> L.sgbtrs layout trans n kl ku nrhs _ab ldab _ipiv _b ldb
      | Float64   -> L.dgbtrs layout trans n kl ku nrhs _ab ldab _ipiv _b ldb
      | Complex32 -> L.cgbtrs layout trans n kl ku nrhs _ab ldab _ipiv _b ldb
      | Complex64 -> L.zgbtrs layout trans n kl ku nrhs _ab ldab _ipiv _b ldb
      | _         -> failwith "lapacke:gbtrs"
    in
    check_lapack_error ret


let gebal
  : type a b. ?job:char -> a:(a, b) mat -> int * int * (a, b) mat
  = fun ?(job='B') ~a ->
  assert (job = 'N' || job = 'P' || job = 'S' || job = 'B');
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  assert (m = n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in
  let _ilo = Ctypes.(allocate int 0) in
  let _ihi = Ctypes.(allocate int 0) in
  let scale = ref (Array2.create _kind _layout 0 0) in

  let ret = match _kind with
    | Float32   -> (
        let scale' = Array2.create float32 _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let r = L.sgebal layout job n _a lda _ilo _ihi _scale in
        scale := scale';
        r
      )
    | Float64   -> (
        let scale' = Array2.create float64 _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let r = L.dgebal layout job n _a lda _ilo _ihi _scale in
        scale := scale';
        r
      )
    | Complex32 -> (
        let scale' = Array2.create float32 _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let r = L.cgebal layout job n _a lda _ilo _ihi _scale in
        scale := Owl_dense_matrix_generic.cast_s2c scale';
        r
      )
    | Complex64 -> (
        let scale' = Array2.create float64 _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let r = L.zgebal layout job n _a lda _ilo _ihi _scale in
        scale := Owl_dense_matrix_generic.cast_d2z scale';
        r
      )
    | _         -> failwith "lapacke:gebal"
  in
  check_lapack_error ret;
  !@_ilo, !@_ihi, !scale


(* TODO: need a solution for scale parameter *)
let gebak
  : type a b. job:char -> side:char -> ilo:int -> ihi:int -> scale:(float ptr) -> v:(a, b) mat -> unit
  = fun ~job ~side ~ilo ~ihi ~scale ~v ->
  assert (side = 'L' || side = 'R');
  assert (job = 'N' || job = 'P' || job = 'S' || job = 'B');
  let m = Array2.dim1 v in
  let n = Array2.dim2 v in
  assert (m = n);
  let _kind = Array2.kind v in
  let _layout = Array2.layout v in
  let layout = lapacke_layout _layout in

  let _v = bigarray_start Ctypes_static.Array2 v in
  let ldv = _stride v in

  let ret = match _kind with
    | Float32   -> L.sgebak layout job side n ilo ihi scale m _v ldv
    | Float64   -> L.dgebak layout job side n ilo ihi scale m _v ldv
    | Complex32 -> L.cgebak layout job side n ilo ihi scale m _v ldv
    | Complex64 -> L.zgebak layout job side n ilo ihi scale m _v ldv
    | _         -> failwith "lapacke:gebak"
  in
  check_lapack_error ret


let gebrd
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let d = ref (Array2.create _kind _layout 0 k) in
  let e = ref (Array2.create _kind _layout 0 k) in
  let tauq = Array2.create _kind _layout 1 k in
  let taup = Array2.create _kind _layout 1 k in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _tauq = bigarray_start Ctypes_static.Array2 tauq in
  let _taup = bigarray_start Ctypes_static.Array2 taup in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> (
        let d' = Array2.create float32 _layout 1 k in
        let _d = bigarray_start Ctypes_static.Array2 d' in
        let e' = Array2.create float32 _layout 1 k in
        let _e = bigarray_start Ctypes_static.Array2 e' in
        let r = L.sgebrd layout m n _a lda _d _e _tauq _taup in
        d := d';
        e := e';
        r
      )
    | Float64   -> (
        let d' = Array2.create float64 _layout 1 k in
        let _d = bigarray_start Ctypes_static.Array2 d' in
        let e' = Array2.create float64 _layout 1 k in
        let _e = bigarray_start Ctypes_static.Array2 e' in
        let r = L.dgebrd layout m n _a lda _d _e _tauq _taup in
        d := d';
        e := e';
        r
      )
    | Complex32 -> (
        let d' = Array2.create float32 _layout 1 k in
        let _d = bigarray_start Ctypes_static.Array2 d' in
        let e' = Array2.create float32 _layout 1 k in
        let _e = bigarray_start Ctypes_static.Array2 e' in
        let r = L.cgebrd layout m n _a lda _d _e _tauq _taup in
        d := Owl_dense_matrix_generic.cast_s2c d';
        e := Owl_dense_matrix_generic.cast_s2c e';
        r
      )
    | Complex64 -> (
        let d' = Array2.create float64 _layout 1 k in
        let _d = bigarray_start Ctypes_static.Array2 d' in
        let e' = Array2.create float64 _layout 1 k in
        let _e = bigarray_start Ctypes_static.Array2 e' in
        let r = L.zgebrd layout m n _a lda _d _e _tauq _taup in
        d := Owl_dense_matrix_generic.cast_d2z d';
        e := Owl_dense_matrix_generic.cast_d2z e';
        r
      )
    | _         -> failwith "lapacke:gebrd"
  in
  check_lapack_error ret;
  a, !d, !e, tauq, taup


let gesvd
  : type a b. ?jobu:char -> ?jobvt:char -> a:(a, b) mat -> (a, b) mat * (a, b) mat *  (a, b) mat
  = fun ?(jobu='A') ?(jobvt='A') ~a ->
  assert (jobu = 'A' || jobu = 'S' || jobu = 'O' || jobu = 'N');
  assert (jobvt = 'A' || jobvt = 'S' || jobvt = 'O' || jobvt = 'N');

  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  assert (jobu <> 'O' || jobvt <> 'O');
  assert (m > 0 && n > 0);

  let s = ref (Array2.create _kind _layout 0 0) in
  let u = match jobu with
    | 'A' -> Array2.create _kind _layout m m
    | 'S' -> Array2.create _kind _layout m minmn
    | _   -> Array2.create _kind _layout m 0
  in
  let vt = match jobvt with
    | 'A' -> Array2.create _kind _layout n n
    | 'S' -> Array2.create _kind _layout minmn n
    | _   -> Array2.create _kind _layout 0 n
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldvt = Pervasives.max 1 (_stride vt) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _u = bigarray_start Ctypes_static.Array2 u in
  let _vt = bigarray_start Ctypes_static.Array2 vt in

  let ret = match _kind with
    | Float32   -> (
        let s' = Array2.create float32 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let superb = Array1.create float32 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        let r = L.sgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := s';
        r
      )
    | Float64   -> (
        let s' = Array2.create float64 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let superb = Array1.create float64 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        let r = L.dgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := s';
        r
      )
    | Complex32 -> (
        let s' = Array2.create float32 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let superb = Array1.create float32 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        let r = L.cgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := Owl_dense_matrix_generic.cast_s2c s';
        r
      )
    | Complex64 -> (
        let s' = Array2.create float64 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let superb = Array1.create float64 _layout (minmn - 1)
          |> bigarray_start Ctypes_static.Array1
        in
        let r = L.zgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := Owl_dense_matrix_generic.cast_d2z s';
        r
      )
    | _        -> failwith "lapacke:gesvd"
  in
  check_lapack_error ret;

  match jobu, jobvt with
  | 'O', _ -> a, !s, vt
  | _, 'O' -> u, !s, a
  | _, _   -> u, !s, vt


let gesdd
  : type a b. ?jobz:char -> a:(a, b) mat -> (a, b) mat * (a, b) mat *  (a, b) mat
  = fun ?(jobz='A') ~a ->
  assert (jobz = 'A' || jobz = 'S' || jobz = 'O' || jobz = 'N');

  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  assert (m > 0 && n > 0);

  let s = ref (Array2.create _kind _layout 0 0) in
  let u = match jobz with
    | 'A' -> Array2.create _kind _layout m m
    | 'S' -> Array2.create _kind _layout m minmn
    | 'O' -> Array2.create _kind _layout m (if m >=n then 0 else m)
    | _   -> Array2.create _kind _layout m 0
  in
  let vt = match jobz with
    | 'A' -> Array2.create _kind _layout n n
    | 'S' -> Array2.create _kind _layout minmn n
    | 'O' -> Array2.create _kind _layout n (if m >=n then n else 0)
    | _   -> Array2.create _kind _layout 0 n
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldvt = Pervasives.max 1 (_stride vt) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _u = bigarray_start Ctypes_static.Array2 u in
  let _vt = bigarray_start Ctypes_static.Array2 vt in

  let ret = match _kind with
    | Float32   -> (
        let s' = Array2.create float32 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let r = L.sgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := s';
        r
      )
    | Float64   -> (
        let s' = Array2.create float64 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let r = L.dgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := s';
        r
      )
    | Complex32 -> (
        let s' = Array2.create float32 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let r = L.cgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := Owl_dense_matrix_generic.cast_s2c s';
        r
      )
    | Complex64 -> (
        let s' = Array2.create float64 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s' in
        let r = L.zgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := Owl_dense_matrix_generic.cast_d2z s';
        r
      )
    | _        -> failwith "lapacke:gesdd"
  in
  check_lapack_error ret;

  match jobz, m >= n with
  | 'O', true  -> a, !s, vt
  | 'O', false -> u, !s, a
  | _, _       -> u, !s, vt


let ggsvd3
  : type a b. ?jobu:char -> ?jobv:char -> ?jobq:char -> a:(a, b) mat -> b:(a, b) mat
    -> (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * int * int * (a, b) mat
  = fun ?(jobu='U') ?(jobv='V') ?(jobq='Q') ~a ~b ->
  assert (jobu = 'U' || jobu = 'N');
  assert (jobv = 'V' || jobu = 'N');
  assert (jobq = 'Q' || jobu = 'N');

  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let p = Array2.dim1 b in
  assert (n = Array2.dim2 b);
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldu = Pervasives.max 1 m in
  let ldv = Pervasives.max 1 p in
  let ldq = Pervasives.max 1 n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let alpha = ref (Array2.create _kind _layout 0 0) in
  let beta = ref (Array2.create _kind _layout 0 0) in
  let u = match jobu with
    | 'U' -> Array2.create _kind _layout ldu m
    | _   -> Array2.create _kind _layout 0 m
  in
  let v = match jobv with
    | 'V' -> Array2.create _kind _layout ldv p
    | _   -> Array2.create _kind _layout 0 p
  in
  let q = match jobq with
    | 'Q' -> Array2.create _kind _layout ldq n
    | _   -> Array2.create _kind _layout 0 n
  in
  let iwork = Array1.create Int _layout n in

  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _u = bigarray_start Ctypes_static.Array2 u in
  let _v = bigarray_start Ctypes_static.Array2 v in
  let _q = bigarray_start Ctypes_static.Array2 q in
  let _iwork = bigarray_start Ctypes_static.Array1 iwork in
  let _k = Ctypes.(allocate int 0) in
  let _l = Ctypes.(allocate int 0) in

  let ret = match _kind with
    | Float32   -> (
        let alpha' = Array2.create float32 _layout 1 n in
        let beta' = Array2.create float32 _layout 1 n in
        let _alpha = bigarray_start Ctypes_static.Array2 alpha' in
        let _beta = bigarray_start Ctypes_static.Array2 beta' in
        let r = L.sggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := alpha';
        beta := beta';
        r
      )
    | Float64   -> (
        let alpha' = Array2.create float64 _layout 1 n in
        let beta' = Array2.create float64 _layout 1 n in
        let _alpha = bigarray_start Ctypes_static.Array2 alpha' in
        let _beta = bigarray_start Ctypes_static.Array2 beta' in
        let r = L.dggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := alpha';
        beta := beta';
        r
      )
    | Complex32 -> (
        let alpha' = Array2.create float32 _layout 1 n in
        let beta' = Array2.create float32 _layout 1 n in
        let _alpha = bigarray_start Ctypes_static.Array2 alpha' in
        let _beta = bigarray_start Ctypes_static.Array2 beta' in
        let r = L.cggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := Owl_dense_matrix_generic.cast_s2c alpha';
        beta := Owl_dense_matrix_generic.cast_s2c beta';
        r
      )
    | Complex64 -> (
        let alpha' = Array2.create float64 _layout 1 n in
        let beta' = Array2.create float64 _layout 1 n in
        let _alpha = bigarray_start Ctypes_static.Array2 alpha' in
        let _beta = bigarray_start Ctypes_static.Array2 beta' in
        let r = L.zggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := Owl_dense_matrix_generic.cast_d2z alpha';
        beta := Owl_dense_matrix_generic.cast_d2z beta';
        r
      )
    | _         -> failwith "lapacke:ggsvd3"
  in
  check_lapack_error ret;

  (* construct R from a and b *)
  let r = match m - !@_k - !@_l >= 0 with
    | true  -> (
        let r = Owl_dense_matrix_generic.slice [[0; !@_k + !@_l - 1]; [n - !@_k - !@_l; n - 1]] a in
        Owl_dense_matrix_generic.triu r
      )
    | false -> (
        let ra = Owl_dense_matrix_generic.slice [[]; [n - !@_k - !@_l; n - 1]] a in
        let rb = Owl_dense_matrix_generic.slice [[m - !@_k; !@_l - 1]; [n - !@_k - !@_l; n - 1]] b in
        let r = Owl_dense_matrix_generic.concat_vertical ra rb in
        Owl_dense_matrix_generic.triu r
      )
  in
  u, v, q, !alpha, !beta, !@_k, !@_l, r




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
