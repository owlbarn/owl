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
  : type a b. kl:int -> ku:int -> m:int -> ab:(a, b) mat -> (a, b) mat * (int32, int32_elt) t
  = fun ~kl ~ku ~m ~ab ->
  let n = Array2.dim2 ab in
  let minmn = Pervasives.min m n in
  let _kind = Array2.kind ab in
  let _layout = Array2.layout ab in
  let layout = lapacke_layout _layout in

  assert (kl >= 0 && ku >=0 && m >= 0 && n >= 0);

  let ipiv = Array1.create int32 _layout minmn in
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
  -> ab:(a, b) mat -> ipiv:(int32, int32_elt) t -> b:(a, b) mat -> unit
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

  let _ilo = Ctypes.(allocate int32_t 0l) in
  let _ihi = Ctypes.(allocate int32_t 0l) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in

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
  let ilo = Int32.to_int !@_ilo in
  let ihi = Int32.to_int !@_ihi in
  ilo, ihi, !scale


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


let gelqf
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let tau = Array2.create _kind _layout 1 k in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> L.sgelqf layout m n _a lda _tau
    | Float64   -> L.dgelqf layout m n _a lda _tau
    | Complex32 -> L.cgelqf layout m n _a lda _tau
    | Complex64 -> L.zgelqf layout m n _a lda _tau
    | _         -> failwith "lapacke:gelqf"
  in
  check_lapack_error ret;
  a, tau


let geqlf
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let tau = Array2.create _kind _layout 1 k in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> L.sgeqlf layout m n _a lda _tau
    | Float64   -> L.dgeqlf layout m n _a lda _tau
    | Complex32 -> L.cgeqlf layout m n _a lda _tau
    | Complex64 -> L.zgeqlf layout m n _a lda _tau
    | _         -> failwith "lapacke:geqlf"
  in
  check_lapack_error ret;
  a, tau


let geqrf
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let tau = Array2.create _kind _layout 1 k in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> L.sgeqrf layout m n _a lda _tau
    | Float64   -> L.dgeqrf layout m n _a lda _tau
    | Complex32 -> L.cgeqrf layout m n _a lda _tau
    | Complex64 -> L.zgeqrf layout m n _a lda _tau
    | _         -> failwith "lapacke:geqrf"
  in
  check_lapack_error ret;
  a, tau


let gerqf
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let tau = Array2.create _kind _layout 1 k in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> L.sgerqf layout m n _a lda _tau
    | Float64   -> L.dgerqf layout m n _a lda _tau
    | Complex32 -> L.cgerqf layout m n _a lda _tau
    | Complex64 -> L.zgerqf layout m n _a lda _tau
    | _         -> failwith "lapacke:gerqf"
  in
  check_lapack_error ret;
  a, tau


let geqp3
  : type a b. ?jpvt:(int32, int32_elt) mat -> a:(a, b) mat
  -> (a, b) mat * (int32, int32_elt) mat * (a, b) mat
  = fun ?jpvt ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let jpvt = match jpvt with
    | Some jpvt -> jpvt
    | None      -> (
        let jpvt = Array2.create int32 _layout 1 n in
        Array2.fill jpvt 0l;
        jpvt
      )
  in
  assert (n = Array2.dim2 jpvt);

  let tau = Array2.create _kind _layout 1 k in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let _jpvt = bigarray_start Ctypes_static.Array2 jpvt in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> L.sgeqp3 layout m n _a lda _jpvt _tau
    | Float64   -> L.dgeqp3 layout m n _a lda _jpvt _tau
    | Complex32 -> L.cgeqp3 layout m n _a lda _jpvt _tau
    | Complex64 -> L.zgeqp3 layout m n _a lda _jpvt _tau
    | _         -> failwith "lapacke:geqp3"
  in
  check_lapack_error ret;
  a, jpvt, tau


let geqrt
  : type a b. nb:int -> a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~nb ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  assert (nb <= minmn);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Array2 a in
  (* FIXME: there might be something wrong with the lapacke interface. The
    behaviour of this function is not consistent with what has been documented
    on Intel's MKL website. I.e., if we allocate [nb x minmn] space for t, it
    is likely there will be memory fault. The lapacke code turns out to use
    [minmn x minmn] space actually.
  *)
  let t = Array2.create _kind _layout minmn minmn in
  let _t = bigarray_start Ctypes_static.Array2 t in
  let lda = Pervasives.max 1 (_stride a) in
  let ldt = Pervasives.max 1 (_stride t) in

  let ret = match _kind with
    | Float32   -> L.sgeqrt layout m n nb _a lda _t ldt
    | Float64   -> (
        Array2.fill t 0.7;
        L.dgeqrt layout m n nb _a lda _t ldt)
    | Complex32 -> L.cgeqrt layout m n nb _a lda _t ldt
    | Complex64 -> L.zgeqrt layout m n nb _a lda _t ldt
    | _         -> failwith "lapacke:geqrt"
  in
  check_lapack_error ret;
  (* resize to the shape of [t] to that is supposed to be *)
  let t = Owl_dense_matrix_generic.resize nb minmn t in
  a, t


let geqrt3
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  assert (m >= n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Array2 a in
  let t = Array2.create _kind _layout n n in
  let _t = bigarray_start Ctypes_static.Array2 t in
  let lda = Pervasives.max 1 (_stride a) in
  let ldt = Pervasives.max 1 (_stride t) in

  let ret = match _kind with
    | Float32   -> L.sgeqrt3 layout m n _a lda _t ldt
    | Float64   -> L.dgeqrt3 layout m n _a lda _t ldt
    | Complex32 -> L.cgeqrt3 layout m n _a lda _t ldt
    | Complex64 -> L.zgeqrt3 layout m n _a lda _t ldt
    | _         -> failwith "lapacke:geqrt3"
  in
  check_lapack_error ret;
  a, t


let getrf
  : type a b. a:(a, b) mat -> (a, b) mat * (int32, int32_elt) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Array2.create int32 _layout 1 minmn in
  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.sgetrf layout m n _a lda _ipiv
    | Float64   -> L.dgetrf layout m n _a lda _ipiv
    | Complex32 -> L.cgetrf layout m n _a lda _ipiv
    | Complex64 -> L.zgetrf layout m n _a lda _ipiv
    | _         -> failwith "lapacke:getrf"
  in
  check_lapack_error ret;
  a, ipiv


let tzrzf
  : type a b. a:(a, b) mat -> (a, b) mat * (a, b) mat
  = fun ~a ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  assert (m <= n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let tau = Array2.create _kind _layout 1 m in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.stzrzf layout m n _a lda _tau
    | Float64   -> L.dtzrzf layout m n _a lda _tau
    | Complex32 -> L.ctzrzf layout m n _a lda _tau
    | Complex64 -> L.ztzrzf layout m n _a lda _tau
    | _         -> failwith "lapacke:tzrzf"
  in
  check_lapack_error ret;
  a, tau


let ormrz
  : type a. side:char -> trans:char -> a:(float, a) mat -> tau:(float, a) mat
  -> c:(float, a) mat -> (float, a) mat
  = fun ~side ~trans ~a ~tau ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T');

  let m = Array2.dim1 c in
  let n = Array2.dim2 c in
  let k = Array2.((dim1 tau) * (dim2 tau)) in
  let l = Array2.((dim2 a) - (dim1 a)) in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Array2 a in
  let _c = bigarray_start Ctypes_static.Array2 c in
  let _tau = bigarray_start Ctypes_static.Array2 tau in
  let lda = Pervasives.max 1 (_stride a) in
  let ldc = Pervasives.max 1 (_stride c) in

  let ret = match _kind with
    | Float32   -> L.sormrz layout side trans m n k l _a lda _tau _c ldc
    | Float64   -> L.dormrz layout side trans m n k l _a lda _tau _c ldc
  in
  check_lapack_error ret;
  c


let gels
  : type a b. trans:char -> a:(a, b) mat -> b:(a, b) mat
  -> (a, b) mat * (a, b) mat * (a, b) mat
  = fun ~trans ~a ~b ->
  assert (trans = 'N' || trans = 'T' || trans = 'C');
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let mb = Array2.dim1 b in
  let nb = Array2.dim2 b in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  if trans = 'N' then assert (mb = m)
  else assert (mb = n);

  let l = Pervasives.max m n in
  let b = match mb < l with
    | true  -> Owl_dense_matrix_generic.resize l nb b
    | false -> b
  in

  let nrhs = nb in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> L.sgels layout trans m n nrhs _a lda _b ldb
    | Float64   -> L.dgels layout trans m n nrhs _a lda _b ldb
    | Complex32 -> L.cgels layout trans m n nrhs _a lda _b ldb
    | Complex64 -> L.zgels layout trans m n nrhs _a lda _b ldb
    | _         -> failwith "lapacke:gels"
  in
  check_lapack_error ret;

  let k = Pervasives.min m n in
  let a' = Owl_dense_matrix_generic.slice [[0;k-1]; [0;k-1]] a in
  let f = match m < n with
    | true  -> Owl_dense_matrix_generic.tril a'
    | false -> Owl_dense_matrix_generic.triu a'
  in
  let sol = match trans = 'N' with
    | true  -> Owl_dense_matrix_generic.resize n nb b
    | false -> Owl_dense_matrix_generic.resize m nb b
  in
  let ssr = match trans = 'N' with
    | true  ->
        if mb > n then
          Owl_dense_matrix_generic.resize ~head:false (mb - n) nb b
        else Array2.create _kind _layout 0 0
    | false ->
        if mb > m then
          Owl_dense_matrix_generic.resize ~head:false (mb - m) nb b
        else Array2.create _kind _layout 0 0
  in
  f, sol, ssr


let gesv
  : type a b. a:(a, b) mat -> b:(a, b) mat -> (a, b) mat * (a, b) mat * (int32, int32_elt) mat
  = fun ~a ~b ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let mb = Array2.dim1 b in
  let nb = Array2.dim2 b in
  assert (m = n && mb = n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let nrhs = nb in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ipiv = Array2.create int32 _layout 1 n in
  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in

  let ret = match _kind with
    | Float32   -> L.sgesv layout n nrhs _a lda _ipiv _b ldb
    | Float64   -> L.dgesv layout n nrhs _a lda _ipiv _b ldb
    | Complex32 -> L.cgesv layout n nrhs _a lda _ipiv _b ldb
    | Complex64 -> L.zgesv layout n nrhs _a lda _ipiv _b ldb
    | _         -> failwith "lapacke:gesv"
  in
  check_lapack_error ret;
  a, b, ipiv


let getrs
  : type a b. trans:char -> a:(a, b) mat -> ipiv:(int32, int32_elt) mat -> b:(a, b) mat -> (a, b) mat
  = fun ~trans ~a ~ipiv ~b ->
  assert (trans = 'N' || trans = 'T' || trans = 'C');
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let mb = Array2.dim1 b in
  let nb = Array2.dim2 b in
  assert (m = n && mb = n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let nrhs = nb in
  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> L.sgetrs layout trans n nrhs _a lda _ipiv _b ldb
    | Float64   -> L.dgetrs layout trans n nrhs _a lda _ipiv _b ldb
    | Complex32 -> L.cgetrs layout trans n nrhs _a lda _ipiv _b ldb
    | Complex64 -> L.zgetrs layout trans n nrhs _a lda _ipiv _b ldb
    | _         -> failwith "lapacke:getrs"
  in
  check_lapack_error ret;
  b


let getri
  : type a b. a:(a, b) mat -> ipiv:(int32, int32_elt) mat -> (a, b) mat
  = fun ~a ~ipiv ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let k = Array2.((dim1 ipiv) * (dim2 ipiv)) in
  assert (m = n && n = k);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.sgetri layout n _a lda _ipiv
    | Float64   -> L.dgetri layout n _a lda _ipiv
    | Complex32 -> L.cgetri layout n _a lda _ipiv
    | Complex64 -> L.zgetri layout n _a lda _ipiv
    | _         -> failwith "lapacke:getri"
  in
  check_lapack_error ret;
  a


let gesvx
  : type a b. fact:char -> trans:char -> a:(a, b) mat -> af:(a, b) mat
  -> ipiv:(int32, int32_elt) mat -> equed:char -> r:(a, b) mat -> c:(a, b) mat -> b:(a, b) mat
  -> (a, b) mat * char * (a, b) mat * (a, b) mat * (a, b) mat * a * (a, b) mat * (a, b) mat * a
  = fun ~fact ~trans ~a ~af ~ipiv ~equed ~r ~c ~b ->
  assert (fact = 'E' || fact = 'N' || fact = 'T' || fact = 'C');
  assert (trans = 'N' || trans = 'T' || trans = 'C');
  assert (equed = 'N' || equed = 'R' || equed = 'C' || equed = 'B');
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  assert (m = n);
  assert (Array2.dim1 af = n && Array2.dim2 af = n);
  let nrhs = Array2.dim2 b in
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldaf = Pervasives.max 1 (_stride af) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _af = bigarray_start Ctypes_static.Array2 af in
  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in
  let _equed = Ctypes.(allocate char equed) in
  let x = Array2.create _kind _layout n nrhs in
  let _x = bigarray_start Ctypes_static.Array2 x in
  let ldx = Pervasives.max 1 (_stride x) in

  let r_ref = ref (Array2.create _kind _layout 0 0) in
  let c_ref = ref (Array2.create _kind _layout 0 0) in
  let rcond = ref (Array2.create _kind _layout 0 0) in
  let ferr = ref (Array2.create _kind _layout 0 0) in
  let berr = ref (Array2.create _kind _layout 0 0) in
  let rpivot = ref (Array2.create _kind _layout 0 0) in

  let ret = match _kind with
    | Float32   -> (
        let rcond' = Array2.create float32 _layout 1 1 in
        let ferr' = Array2.create float32 _layout 1 nrhs in
        let berr' = Array2.create float32 _layout 1 nrhs in
        let rpivot' = Array2.create float32 _layout 1 1 in
        let _rcond = bigarray_start Ctypes_static.Array2 rcond' in
        let _ferr = bigarray_start Ctypes_static.Array2 ferr' in
        let _berr = bigarray_start Ctypes_static.Array2 berr' in
        let _rpivot = bigarray_start Ctypes_static.Array2 rpivot' in

        let _r = bigarray_start Ctypes_static.Array2 r in
        let _c = bigarray_start Ctypes_static.Array2 c in

        let ret = L.sgesvx layout fact trans n nrhs _a lda _af ldaf _ipiv _equed _r _c _b ldb _x ldx _rcond _ferr _berr _rpivot in
        r_ref := r;
        c_ref := c;
        rcond := rcond';
        ferr := ferr';
        berr := berr';
        rpivot := rpivot';
        ret
      )
    | Float64   -> (
        let rcond' = Array2.create float64 _layout 1 1 in
        let ferr' = Array2.create float64 _layout 1 nrhs in
        let berr' = Array2.create float64 _layout 1 nrhs in
        let rpivot' = Array2.create float64 _layout 1 1 in
        let _rcond = bigarray_start Ctypes_static.Array2 rcond' in
        let _ferr = bigarray_start Ctypes_static.Array2 ferr' in
        let _berr = bigarray_start Ctypes_static.Array2 berr' in
        let _rpivot = bigarray_start Ctypes_static.Array2 rpivot' in

        let _r = bigarray_start Ctypes_static.Array2 r in
        let _c = bigarray_start Ctypes_static.Array2 c in

        let ret = L.dgesvx layout fact trans n nrhs _a lda _af ldaf _ipiv _equed _r _c _b ldb _x ldx _rcond _ferr _berr _rpivot in
        r_ref := r;
        c_ref := c;
        rcond := rcond';
        ferr := ferr';
        berr := berr';
        rpivot := rpivot';
        ret
      )
    | Complex32 -> (
        let rcond' = Array2.create float32 _layout 1 1 in
        let ferr' = Array2.create float32 _layout 1 nrhs in
        let berr' = Array2.create float32 _layout 1 nrhs in
        let rpivot' = Array2.create float32 _layout 1 1 in
        let _rcond = bigarray_start Ctypes_static.Array2 rcond' in
        let _ferr = bigarray_start Ctypes_static.Array2 ferr' in
        let _berr = bigarray_start Ctypes_static.Array2 berr' in
        let _rpivot = bigarray_start Ctypes_static.Array2 rpivot' in

        let r' = Owl_dense_matrix_c.re r in
        let c' = Owl_dense_matrix_c.re c in
        let _r = bigarray_start Ctypes_static.Array2 r' in
        let _c = bigarray_start Ctypes_static.Array2 c' in

        let ret = L.cgesvx layout fact trans n nrhs _a lda _af ldaf _ipiv _equed _r _c _b ldb _x ldx _rcond _ferr _berr _rpivot in
        r_ref := Owl_dense_matrix_generic.cast_s2c r';
        c_ref := Owl_dense_matrix_generic.cast_s2c c';
        rcond := Owl_dense_matrix_generic.cast_s2c rcond';
        ferr := Owl_dense_matrix_generic.cast_s2c ferr';
        berr := Owl_dense_matrix_generic.cast_s2c berr';
        rpivot := Owl_dense_matrix_generic.cast_s2c rpivot';
        ret
      )
    | Complex64 -> (
        let _rpivot = Ctypes.(allocate double 0.) in
        let rcond' = Array2.create float64 _layout 1 1 in
        let ferr' = Array2.create float64 _layout 1 nrhs in
        let berr' = Array2.create float64 _layout 1 nrhs in
        let rpivot' = Array2.create float64 _layout 1 1 in
        let _rcond = bigarray_start Ctypes_static.Array2 rcond' in
        let _ferr = bigarray_start Ctypes_static.Array2 ferr' in
        let _berr = bigarray_start Ctypes_static.Array2 berr' in
        let _rpivot = bigarray_start Ctypes_static.Array2 rpivot' in

        let r' = Owl_dense_matrix_z.re r in
        let c' = Owl_dense_matrix_z.re c in
        let _r = bigarray_start Ctypes_static.Array2 r' in
        let _c = bigarray_start Ctypes_static.Array2 c' in

        let ret = L.zgesvx layout fact trans n nrhs _a lda _af ldaf _ipiv _equed _r _c _b ldb _x ldx _rcond _ferr _berr _rpivot in
        r_ref := Owl_dense_matrix_generic.cast_d2z r';
        c_ref := Owl_dense_matrix_generic.cast_d2z c';
        rcond := Owl_dense_matrix_generic.cast_d2z rcond';
        ferr := Owl_dense_matrix_generic.cast_d2z ferr';
        berr := Owl_dense_matrix_generic.cast_d2z berr';
        rpivot := Owl_dense_matrix_generic.cast_d2z rpivot';
        ret
      )
    | _         -> failwith "lapacke:gesvx"
  in
  check_lapack_error ret;
  if ret = n + 1 then Log.warn "matrix is singular to working precision.";
  x, !@_equed, !r_ref, !c_ref, b, !rcond.{0,0}, !ferr, !berr, !rpivot.{0,0}


let gelsd
  : type a b. a:(a, b) mat -> b:(a, b) mat -> rcond:float -> (a, b) mat * int
  = fun ~a ~b ~rcond ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  let mb = Array2.dim1 b in
  let nrhs = Array2.dim2 b in
  assert (mb = m);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let b = match mb < n with
    | true  -> Owl_dense_matrix_generic.resize n nrhs b
    | false -> b
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _rank = Ctypes.(allocate int32_t 0l) in

  let ret = match _kind with
    | Float32   -> (
        let s = Array2.create float32 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s in
        L.sgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | Float64   -> (
        let s = Array2.create float64 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s in
        L.dgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | Complex32 -> (
        let s = Array2.create float32 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s in
        L.cgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | Complex64 -> (
        let s = Array2.create float64 _layout 1 minmn in
        let _s = bigarray_start Ctypes_static.Array2 s in
        L.zgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | _         -> failwith "lapacke:gelsd"
  in
  check_lapack_error ret;
  let b = Owl_dense_matrix_generic.resize n nrhs b in
  b, Int32.to_int !@_rank


let gelsy
  : type a b. a:(a, b) mat -> b:(a, b) mat -> rcond:float -> (a, b) mat * int
  = fun ~a ~b ~rcond ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let mb = Array2.dim1 b in
  let nrhs = Array2.dim2 b in
  assert (mb = m);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let b = match mb < n with
    | true  -> Owl_dense_matrix_generic.resize n nrhs b
    | false -> b
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _rank = Ctypes.(allocate int32_t 0l) in

  let jpvt = Array2.create int32 _layout 1 n in
  Array2.fill jpvt 0l;
  let _jpvt = bigarray_start Ctypes_static.Array2 jpvt in

  let ret = match _kind with
    | Float32   -> L.sgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | Float64   -> L.dgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | Complex32 -> L.cgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | Complex64 -> L.zgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | _         -> failwith "lapacke:gelsy"
  in
  check_lapack_error ret;
  let b = Owl_dense_matrix_generic.resize n nrhs b in
  b, Int32.to_int !@_rank


let gglse
  : type a b. a:(a, b) mat -> b:(a, b) mat -> c:(a, b) mat -> d:(a, b) mat
  -> (a, b) mat * a
  = fun ~a ~b ~c ~d ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let p = Array2.dim1 b in
  assert (n = Array2.dim2 b);
  assert (m = Array2.((dim1 c) * (dim2 c)));
  assert (p = Array2.((dim1 d) * (dim2 d)));
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let x = Array2.create _kind _layout 1 n in
  let _x = bigarray_start Ctypes_static.Array2 x in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _c = bigarray_start Ctypes_static.Array2 c in
  let _d = bigarray_start Ctypes_static.Array2 d in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> L.sgglse layout m n p _a lda _b ldb _c _d _x
    | Float64   -> L.dgglse layout m n p _a lda _b ldb _c _d _x
    | Complex32 -> L.cgglse layout m n p _a lda _b ldb _c _d _x
    | Complex64 -> L.zgglse layout m n p _a lda _b ldb _c _d _x
    | _         -> failwith "lapacke:gglse"
  in
  check_lapack_error ret;

  let c' = Owl_dense_matrix_generic.resize ~head:false 1 (m - n + p) c in
  let res = Owl_dense_matrix_generic.(mul c' c' |> sum) in
  x, res


let geev
  : type a b. jobvl:char -> jobvr:char -> a:(a, b) mat
  -> (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat
  = fun ~jobvl ~jobvr ~a ->
  assert (jobvl = 'N' || jobvl = 'V');
  assert (jobvr = 'N' || jobvr = 'V');
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  assert (m = n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let vl = match jobvl with
    | 'V' -> Array2.create _kind _layout n n
    | _   -> Array2.create _kind _layout 0 n
  in
  let vr = match jobvr with
    | 'V' -> Array2.create _kind _layout n n
    | _   -> Array2.create _kind _layout 0 n
  in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _vl = bigarray_start Ctypes_static.Array2 vl in
  let _vr = bigarray_start Ctypes_static.Array2 vr in
  let lda = Pervasives.max 1 (_stride a) in
  let ldvl = Pervasives.max 1 (_stride vl) in
  let ldvr = Pervasives.max 1 (_stride vr) in

  let wr = ref (Array2.create _kind _layout 0 0) in
  let wi = ref (Array2.create _kind _layout 0 0) in

  let ret = match _kind with
    | Float32   -> (
        let wr' = Array2.create _kind _layout 1 n in
        let wi' = Array2.create _kind _layout 1 n in
        let _wr = bigarray_start Ctypes_static.Array2 wr' in
        let _wi = bigarray_start Ctypes_static.Array2 wi' in
        let r = L.sgeev layout jobvl jobvr n _a lda _wr _wi _vl ldvl _vr ldvr in
        wr := wr';
        wi := wi';
        r
      )
    | Float64   -> (
        let wr' = Array2.create _kind _layout 1 n in
        let wi' = Array2.create _kind _layout 1 n in
        let _wr = bigarray_start Ctypes_static.Array2 wr' in
        let _wi = bigarray_start Ctypes_static.Array2 wi' in
        let r = L.dgeev layout jobvl jobvr n _a lda _wr _wi _vl ldvl _vr ldvr in
        wr := wr';
        wi := wi';
        r
      )
    | Complex32 -> (
        let w' = Array2.create _kind _layout 1 n in
        let _w = bigarray_start Ctypes_static.Array2 w' in
        let r = L.cgeev layout jobvl jobvr n _a lda _w _vl ldvl _vr ldvr in
        wr := w';
        wi := w';
        r
      )
    | Complex64 -> (
        let w' = Array2.create _kind _layout 1 n in
        let _w = bigarray_start Ctypes_static.Array2 w' in
        let r = L.cgeev layout jobvl jobvr n _a lda _w _vl ldvl _vr ldvr in
        wr := w';
        wi := w';
        r
      )
    | _         -> failwith "lapacke:geev"
  in
  check_lapack_error ret;
  !wr, !wi, vl, vr


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
  let iwork = Array1.create int32 _layout n in

  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _u = bigarray_start Ctypes_static.Array2 u in
  let _v = bigarray_start Ctypes_static.Array2 v in
  let _q = bigarray_start Ctypes_static.Array2 q in
  let _iwork = bigarray_start Ctypes_static.Array1 iwork in
  let _k = Ctypes.(allocate int32_t 0l) in
  let _l = Ctypes.(allocate int32_t 0l) in

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
  let k = Int32.to_int !@_k in
  let l = Int32.to_int !@_l in
  let r = match m - k -l >= 0 with
    | true  -> (
        let r = Owl_dense_matrix_generic.slice [[0; k + l - 1]; [n - k - l; n - 1]] a in
        Owl_dense_matrix_generic.triu r
      )
    | false -> (
        let ra = Owl_dense_matrix_generic.slice [[]; [n - k - l; n - 1]] a in
        let rb = Owl_dense_matrix_generic.slice [[m - k; l - 1]; [n - k - l; n - 1]] b in
        let r = Owl_dense_matrix_generic.concat_vertical ra rb in
        Owl_dense_matrix_generic.triu r
      )
  in
  u, v, q, !alpha, !beta, k, l, r


let geevx
  : type a b. balanc:char -> jobvl:char -> jobvr:char -> sense:char -> a:(a, b) mat
  -> (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * int * int * (a, b) mat * float * (a, b) mat * (a, b) mat
  = fun ~balanc ~jobvl ~jobvr ~sense ~a ->
  assert (balanc = 'N' || balanc = 'P' || balanc = 'S' || balanc = 'B');
  assert (sense = 'N' || sense = 'E' || sense = 'V' || sense = 'B');
  assert (jobvl = 'N' || jobvl = 'V');
  assert (jobvr = 'N' || jobvr = 'V');
  if sense = 'E' || sense = 'B' then assert (jobvl = 'V' && jobvr = 'V');

  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  assert (m = n);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let ldvl = match jobvl with
    | 'V' -> n
    | _   -> 1
  in
  let ldvr = match jobvr with
    | 'V' -> n
    | _   -> 1
  in
  let vl = Array2.create _kind _layout n ldvl in
  let vr = Array2.create _kind _layout n ldvr in
  let _ilo = Ctypes.(allocate int32_t 0l) in
  let _ihi = Ctypes.(allocate int32_t 0l) in
  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _vl = bigarray_start Ctypes_static.Array2 vl in
  let _vr = bigarray_start Ctypes_static.Array2 vr in

  let wr = ref (Array2.create _kind _layout 0 0) in
  let wi = ref (Array2.create _kind _layout 0 0) in
  let scale = ref (Array2.create _kind _layout 0 0) in
  let abnrm = ref 0. in
  let rconde = ref (Array2.create _kind _layout 0 0) in
  let rcondv = ref (Array2.create _kind _layout 0 0) in

  let ret = match _kind with
    | Float32   -> (
        let wr' = Array2.create _kind _layout 1 n in
        let _wr = bigarray_start Ctypes_static.Array2 wr' in
        let wi' = Array2.create _kind _layout 1 n in
        let _wi = bigarray_start Ctypes_static.Array2 wi' in
        let scale' = Array2.create _kind _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let rconde' = Array2.create _kind _layout 1 n in
        let _rconde = bigarray_start Ctypes_static.Array2 rconde' in
        let rcondv' = Array2.create _kind _layout 1 n in
        let _rcondv = bigarray_start Ctypes_static.Array2 rcondv' in
        let _abnrm = Ctypes.(allocate float 0.) in
        let r = L.sgeevx layout balanc jobvl jobvr sense n _a lda _wr _wi _vl ldvl _vr ldvr _ilo _ihi _scale _abnrm _rconde _rcondv in
        wr := wr';
        wi := wi';
        scale := scale';
        abnrm := !@_abnrm;
        rconde := rconde';
        rcondv := rcondv';
        r
      )
    | Float64   -> (
        let wr' = Array2.create _kind _layout 1 n in
        let _wr = bigarray_start Ctypes_static.Array2 wr' in
        let wi' = Array2.create _kind _layout 1 n in
        let _wi = bigarray_start Ctypes_static.Array2 wi' in
        let scale' = Array2.create _kind _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let rconde' = Array2.create _kind _layout 1 n in
        let _rconde = bigarray_start Ctypes_static.Array2 rconde' in
        let rcondv' = Array2.create _kind _layout 1 n in
        let _rcondv = bigarray_start Ctypes_static.Array2 rcondv' in
        let _abnrm = Ctypes.(allocate double 0.) in
        let r = L.dgeevx layout balanc jobvl jobvr sense n _a lda _wr _wi _vl ldvl _vr ldvr _ilo _ihi _scale _abnrm _rconde _rcondv in
        wr := wr';
        wi := wi';
        scale := scale';
        abnrm := !@_abnrm;
        rconde := rconde';
        rcondv := rcondv';
        r
      )
    | Complex32 -> (
        let w' = Array2.create _kind _layout 1 n in
        let _w = bigarray_start Ctypes_static.Array2 w' in
        let scale' = Array2.create float32 _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let rconde' = Array2.create float32 _layout 1 n in
        let _rconde = bigarray_start Ctypes_static.Array2 rconde' in
        let rcondv' = Array2.create float32 _layout 1 n in
        let _rcondv = bigarray_start Ctypes_static.Array2 rcondv' in
        let _abnrm = Ctypes.(allocate float 0.) in
        let r = L.cgeevx layout balanc jobvl jobvr sense n _a lda _w _vl ldvl _vr ldvr _ilo _ihi _scale _abnrm _rconde _rcondv in
        wr := w';
        wi := w';
        scale := Owl_dense_matrix_generic.cast_s2c scale';
        abnrm := !@_abnrm;
        rconde := Owl_dense_matrix_generic.cast_s2c rconde';
        rcondv := Owl_dense_matrix_generic.cast_s2c rcondv';
        r
      )
    | Complex64 -> (
        let w' = Array2.create _kind _layout 1 n in
        let _w = bigarray_start Ctypes_static.Array2 w' in
        let scale' = Array2.create float64 _layout 1 n in
        let _scale = bigarray_start Ctypes_static.Array2 scale' in
        let rconde' = Array2.create float64 _layout 1 n in
        let _rconde = bigarray_start Ctypes_static.Array2 rconde' in
        let rcondv' = Array2.create float64 _layout 1 n in
        let _rcondv = bigarray_start Ctypes_static.Array2 rcondv' in
        let _abnrm = Ctypes.(allocate double 0.) in
        let r = L.zgeevx layout balanc jobvl jobvr sense n _a lda _w _vl ldvl _vr ldvr _ilo _ihi _scale _abnrm _rconde _rcondv in
        wr := w';
        wi := w';
        scale := Owl_dense_matrix_generic.cast_d2z scale';
        abnrm := !@_abnrm;
        rconde := Owl_dense_matrix_generic.cast_d2z rconde';
        rcondv := Owl_dense_matrix_generic.cast_d2z rcondv';
        r
      )
    | _         -> failwith "lapacke:geevx"
  in
  check_lapack_error ret;
  (* return all the results modified in-place *)
  let ilo = Int32.to_int !@_ilo in
  let ihi = Int32.to_int !@_ihi in
  a, !wr, !wi, vl, vr, ilo, ihi, !scale, !abnrm, !rconde, !rcondv


let ggev
  : type a b. jobvl:char -> jobvr:char -> a:(a, b) mat -> b:(a, b) mat
  -> (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat
  = fun ~jobvl ~jobvr ~a ~b ->
  assert (jobvl = 'N' || jobvl = 'V');
  assert (jobvr = 'N' || jobvr = 'V');

  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let mb = Array2.dim1 b in
  let nb = Array2.dim2 b in
  assert (m = n && mb = n && mb = nb);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let ldvl = match jobvl with
    | 'V' -> n
    | _   -> 1
  in
  let ldvr = match jobvr with
    | 'V' -> n
    | _   -> 1
  in
  let vl = Array2.create _kind _layout n ldvl in
  let vr = Array2.create _kind _layout n ldvr in

  let alphar = ref (Array2.create _kind _layout 0 0) in
  let alphai = ref (Array2.create _kind _layout 0 0) in
  let beta = Array2.create _kind _layout 1 n in

  let _a = bigarray_start Ctypes_static.Array2 a in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _vl = bigarray_start Ctypes_static.Array2 vl in
  let _vr = bigarray_start Ctypes_static.Array2 vr in
  let _beta = bigarray_start Ctypes_static.Array2 beta in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> (
        let alphar' = Array2.create _kind _layout 1 n in
        let _alphar = bigarray_start Ctypes_static.Array2 alphar' in
        let alphai' = Array2.create _kind _layout 1 n in
        let _alphai = bigarray_start Ctypes_static.Array2 alphai' in
        let r = L.sggev layout jobvl jobvr n _a lda _b ldb _alphar _alphai _beta _vl ldvl _vr ldvr in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Float64   -> (
        let alphar' = Array2.create _kind _layout 1 n in
        let _alphar = bigarray_start Ctypes_static.Array2 alphar' in
        let alphai' = Array2.create _kind _layout 1 n in
        let _alphai = bigarray_start Ctypes_static.Array2 alphai' in
        let r = L.dggev layout jobvl jobvr n _a lda _b ldb _alphar _alphai _beta _vl ldvl _vr ldvr in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Complex32 -> (
        let alpha' = Array2.create _kind _layout 1 n in
        let _alpha = bigarray_start Ctypes_static.Array2 alpha' in
        let r = L.cggev layout jobvl jobvr n _a lda _b ldb _alpha _beta _vl ldvl _vr ldvr in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | Complex64 -> (
        let alpha' = Array2.create _kind _layout 1 n in
        let _alpha = bigarray_start Ctypes_static.Array2 alpha' in
        let r = L.cggev layout jobvl jobvr n _a lda _b ldb _alpha _beta _vl ldvl _vr ldvr in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | _         -> failwith "lapacke:ggev"
  in
  check_lapack_error ret;
  (* note alphar and alphai are the same for complex flavour *)
  !alphar, !alphai, beta, vl, vr


let gtsv
  : type a b. dl:(a, b) mat -> d:(a, b) mat -> du:(a, b) mat -> b:(a, b) mat -> (a, b) mat
  = fun ~dl ~d ~du ~b ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_dl = Owl_dense_matrix_generic.numel dl in
  let n_du = Owl_dense_matrix_generic.numel du in
  assert (n_dl = n || n_dl = n - 1);
  assert (n_du = n || n_du = n - 1);
  let mb = Array2.dim1 b in
  let nrhs = Array2.dim2 b in
  assert (mb = n);
  let _kind = Array2.kind b in
  let _layout = Array2.layout b in
  let layout = lapacke_layout _layout in

  let ldb = Pervasives.max 1 (_stride b) in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _d = bigarray_start Ctypes_static.Array2 d in
  let _dl = bigarray_start Ctypes_static.Array2 dl in
  let _du = bigarray_start Ctypes_static.Array2 du in

  let ret = match _kind with
    | Float32   -> L.sgtsv layout n nrhs _dl _d _du _b ldb
    | Float64   -> L.dgtsv layout n nrhs _dl _d _du _b ldb
    | Complex32 -> L.cgtsv layout n nrhs _dl _d _du _b ldb
    | Complex64 -> L.zgtsv layout n nrhs _dl _d _du _b ldb
    | _         -> failwith "lapacke:gtsv"
  in
  check_lapack_error ret;
  b


let gttrf
  : type a b. dl:(a, b) mat -> d:(a, b) mat -> du:(a, b) mat
  -> (a, b) mat * (a, b) mat * (a, b) mat * (a, b) mat * (int32, int32_elt) mat
  = fun ~dl ~d ~du ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_dl = Owl_dense_matrix_generic.numel dl in
  let n_du = Owl_dense_matrix_generic.numel du in
  assert (n_dl = n - 1 && n_du = n - 1);
  let _kind = Array2.kind d in
  let _layout = Array2.layout d in

  let du2 = Array2.create _kind _layout 1 (n - 2) in
  let ipiv = Array2.create int32 _layout 1 n in
  let _d = bigarray_start Ctypes_static.Array2 d in
  let _dl = bigarray_start Ctypes_static.Array2 dl in
  let _du = bigarray_start Ctypes_static.Array2 du in
  let _du2 = bigarray_start Ctypes_static.Array2 du2 in
  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in

  let ret = match _kind with
    | Float32   -> L.sgttrf n _dl _d _du _du2 _ipiv
    | Float64   -> L.dgttrf n _dl _d _du _du2 _ipiv
    | Complex32 -> L.cgttrf n _dl _d _du _du2 _ipiv
    | Complex64 -> L.zgttrf n _dl _d _du _du2 _ipiv
    | _         -> failwith "lapacke:gttrf"
  in
  check_lapack_error ret;
  dl, d, du, du2, ipiv


let gttrs
  : type a b. trans:char -> dl:(a, b) mat -> d:(a, b) mat -> du:(a, b) mat
  -> du2:(a, b) mat -> ipiv:(int32, int32_elt) mat -> b:(a, b) mat -> (a, b) mat
  = fun ~trans ~dl ~d ~du ~du2 ~ipiv ~b ->
  assert (trans = 'N' || trans = 'T' || trans = 'C');

  let n = Owl_dense_matrix_generic.numel d in
  let n_dl = Owl_dense_matrix_generic.numel dl in
  let n_du = Owl_dense_matrix_generic.numel du in
  assert (n_dl = n - 1 && n_du = n - 1);
  let mb = Array2.dim1 b in
  let nrhs = Array2.dim2 b in
  assert (mb = n);
  let _kind = Array2.kind d in
  let _layout = Array2.layout d in
  let layout = lapacke_layout _layout in

  let ipiv = Array2.create int32 _layout 1 n in
  let ldb = Pervasives.max 1 (_stride b) in
  let _b = bigarray_start Ctypes_static.Array2 b in
  let _d = bigarray_start Ctypes_static.Array2 d in
  let _dl = bigarray_start Ctypes_static.Array2 dl in
  let _du = bigarray_start Ctypes_static.Array2 du in
  let _du2 = bigarray_start Ctypes_static.Array2 du2 in
  let _ipiv = bigarray_start Ctypes_static.Array2 ipiv in

  let ret = match _kind with
    | Float32   -> L.sgttrs layout trans n nrhs _dl _d _du _du2 _ipiv _b ldb
    | Float64   -> L.dgttrs layout trans n nrhs _dl _d _du _du2 _ipiv _b ldb
    | Complex32 -> L.cgttrs layout trans n nrhs _dl _d _du _du2 _ipiv _b ldb
    | Complex64 -> L.zgttrs layout trans n nrhs _dl _d _du _du2 _ipiv _b ldb
    | _         -> failwith "lapacke:gttrs"
  in
  check_lapack_error ret;
  b


let orglq
  : type a. ?k:int -> a:(float, a) mat -> tau:(float, a) mat -> (float, a) mat
  = fun ?k ~a ~tau ->
  let n = Array2.dim2 a in
  let m = Pervasives.min n (Array2.dim1 a) in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= m);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _tau = bigarray_start Ctypes_static.Array2 tau in

  let ret = match _kind with
    | Float32   -> L.sorglq layout m n k _a lda _tau
    | Float64   -> L.dorglq layout m n k _a lda _tau
  in
  check_lapack_error ret;
  a


let orgqr
  : type a. ?k:int -> a:(float, a) mat -> tau:(float, a) mat -> (float, a) mat
  = fun ?k ~a ~tau ->
  let m = Array2.dim1 a in
  let n = Array2.dim2 a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= m);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Array2.kind a in
  let _layout = Array2.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Array2 a in
  let _tau = bigarray_start Ctypes_static.Array2 tau in

  let ret = match _kind with
    | Float32   -> L.sorgqr layout m n k _a lda _tau
    | Float64   -> L.dorgqr layout m n k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading columns *)
  Owl_dense_matrix_generic.slice [[]; [0;minmn-1]] a






























(* ends here *)
