(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** LAPACKE interface: high-level interface between Owl and LAPACKE *)

(** Please refer to the documentation of Intel Math Kernel Library on the
  LAPACKE Interface. The interface implemented here is compatible the those
  documented on their website.
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)

open Ctypes

open Bigarray

open Owl_types


module L = Owl_lapacke_generated


type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

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
let _stride : type a b c. (a, b, c) Genarray.t -> int = fun x ->
  match (Genarray.layout x) with
  | C_layout       -> (Genarray.dims x).(1)
  | Fortran_layout -> (Genarray.dims x).(0)

let _row_num x = (Genarray.dims x).(0)

let _col_num x = (Genarray.dims x).(1)


let gbtrf
  : type a b. kl:int -> ku:int -> m:int -> ab:(a, b) t -> (a, b) t * (int32, int32_elt) t
  = fun ~kl ~ku ~m ~ab ->
  let n = Owl_dense_matrix_generic.col_num ab in
  let minmn = Pervasives.min m n in
  let _kind = Genarray.kind ab in
  let _layout = Genarray.layout ab in
  let layout = lapacke_layout _layout in

  assert (kl >= 0 && ku >=0 && m >= 0 && n >= 0);

  let ipiv = Genarray.create int32 _layout [|minmn|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _ab = bigarray_start Ctypes_static.Genarray ab in
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
  -> ab:(a, b) t -> ipiv:(int32, int32_elt) t -> b:(a, b) t -> unit
  = fun ~trans ~kl ~ku ~n ~ab ~ipiv ~b ->
    let m = Owl_dense_matrix_generic.col_num ab in
    assert (n = m && n = Owl_dense_matrix_generic.row_num b);
    let nrhs = Owl_dense_matrix_generic.col_num b in
    let _kind = Genarray.kind ab in
    let _layout = Genarray.layout ab in
    let layout = lapacke_layout _layout in
    let trans = lapacke_transpose trans in

    let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
    let _ab = bigarray_start Ctypes_static.Genarray ab in
    let _b = bigarray_start Ctypes_static.Genarray b in
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
  : type a b. ?job:char -> a:(a, b) t -> int * int * (a, b) t
  = fun ?(job='B') ~a ->
  assert (job = 'N' || job = 'P' || job = 'S' || job = 'B');
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _ilo = Ctypes.(allocate int32_t 0l) in
  let _ihi = Ctypes.(allocate int32_t 0l) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = _stride a in

  let scale = ref (Genarray.create _kind _layout [|0;0|]) in

  let ret = match _kind with
    | Float32   -> (
        let scale' = Genarray.create float32 _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let r = L.sgebal layout job n _a lda _ilo _ihi _scale in
        scale := scale';
        r
      )
    | Float64   -> (
        let scale' = Genarray.create float64 _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let r = L.dgebal layout job n _a lda _ilo _ihi _scale in
        scale := scale';
        r
      )
    | Complex32 -> (
        let scale' = Genarray.create float32 _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let r = L.cgebal layout job n _a lda _ilo _ihi _scale in
        scale := Owl_dense_matrix_generic.cast_s2c scale';
        r
      )
    | Complex64 -> (
        let scale' = Genarray.create float64 _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
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
  : type a b. job:char -> side:char -> ilo:int -> ihi:int -> scale:(float ptr) -> v:(a, b) t -> unit
  = fun ~job ~side ~ilo ~ihi ~scale ~v ->
  assert (side = 'L' || side = 'R');
  assert (job = 'N' || job = 'P' || job = 'S' || job = 'B');
  let m = Owl_dense_matrix_generic.row_num v in
  let n = Owl_dense_matrix_generic.col_num v in
  assert (m = n);
  let _kind = Genarray.kind v in
  let _layout = Genarray.layout v in
  let layout = lapacke_layout _layout in

  let _v = bigarray_start Ctypes_static.Genarray v in
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
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let d = ref (Genarray.create _kind _layout [|0;k|]) in
  let e = ref (Genarray.create _kind _layout [|0;k|]) in
  let tauq = Genarray.create _kind _layout [|1;k|] in
  let taup = Genarray.create _kind _layout [|1;k|] in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tauq = bigarray_start Ctypes_static.Genarray tauq in
  let _taup = bigarray_start Ctypes_static.Genarray taup in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> (
        let d' = Genarray.create float32 _layout [|1;k|] in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        let e' = Genarray.create float32 _layout [|1;k|] in
        let _e = bigarray_start Ctypes_static.Genarray e' in
        let r = L.sgebrd layout m n _a lda _d _e _tauq _taup in
        d := d';
        e := e';
        r
      )
    | Float64   -> (
        let d' = Genarray.create float64 _layout [|1;k|] in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        let e' = Genarray.create float64 _layout [|1;k|] in
        let _e = bigarray_start Ctypes_static.Genarray e' in
        let r = L.dgebrd layout m n _a lda _d _e _tauq _taup in
        d := d';
        e := e';
        r
      )
    | Complex32 -> (
        let d' = Genarray.create float32 _layout [|1;k|] in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        let e' = Genarray.create float32 _layout [|1;k|] in
        let _e = bigarray_start Ctypes_static.Genarray e' in
        let r = L.cgebrd layout m n _a lda _d _e _tauq _taup in
        d := Owl_dense_matrix_generic.cast_s2c d';
        e := Owl_dense_matrix_generic.cast_s2c e';
        r
      )
    | Complex64 -> (
        let d' = Genarray.create float64 _layout [|1;k|] in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        let e' = Genarray.create float64 _layout [|1;k|] in
        let _e = bigarray_start Ctypes_static.Genarray e' in
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
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let tau = Genarray.create _kind _layout [|1;k|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let tau = Genarray.create _kind _layout [|1;k|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let tau = Genarray.create _kind _layout [|1;k|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let tau = Genarray.create _kind _layout [|1;k|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a b. ?jpvt:(int32, int32_elt) t -> a:(a, b) t
  -> (a, b) t * (a, b) t * (int32, int32_elt) t
  = fun ?jpvt ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let jpvt = match jpvt with
    | Some jpvt -> jpvt
    | None      -> (
        let jpvt = Genarray.create int32 _layout [|1;n|] in
        Genarray.fill jpvt 0l;
        jpvt
      )
  in
  assert (n = Owl_dense_matrix_generic.col_num jpvt);

  let tau = Genarray.create _kind _layout [|1;k|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _jpvt = bigarray_start Ctypes_static.Genarray jpvt in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = _stride a in

  let ret = match _kind with
    | Float32   -> L.sgeqp3 layout m n _a lda _jpvt _tau
    | Float64   -> L.dgeqp3 layout m n _a lda _jpvt _tau
    | Complex32 -> L.cgeqp3 layout m n _a lda _jpvt _tau
    | Complex64 -> L.zgeqp3 layout m n _a lda _jpvt _tau
    | _         -> failwith "lapacke:geqp3"
  in
  check_lapack_error ret;
  a, tau, jpvt


let geqrt
  : type a b. nb:int -> a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~nb ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  assert (nb <= minmn);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Genarray a in
  (* FIXME: there might be something wrong with the lapacke interface. The
    behaviour of this function is not consistent with what has been documented
    on Intel's MKL website. I.e., if we allocate [nb x minmn] space for t, it
    is likely there will be memory fault. The lapacke code turns out to use
    [minmn x minmn] space actually.
  *)
  let t = Genarray.create _kind _layout [|minmn; minmn|] in
  let _t = bigarray_start Ctypes_static.Genarray t in
  let lda = Pervasives.max 1 (_stride a) in
  let ldt = Pervasives.max 1 (_stride t) in

  let ret = match _kind with
    | Float32   -> L.sgeqrt layout m n nb _a lda _t ldt
    | Float64   -> (
        Genarray.fill t 0.7;
        L.dgeqrt layout m n nb _a lda _t ldt)
    | Complex32 -> L.cgeqrt layout m n nb _a lda _t ldt
    | Complex64 -> L.zgeqrt layout m n nb _a lda _t ldt
    | _         -> failwith "lapacke:geqrt"
  in
  check_lapack_error ret;
  (* resize to the shape of [t] to that is supposed to be *)
  let t = Owl_dense_matrix_generic.resize t [|nb; minmn|] in
  a, t


let geqrt3
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m >= n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Genarray a in
  let t = Genarray.create _kind _layout [|n;n|] in
  let _t = bigarray_start Ctypes_static.Genarray t in
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
  : type a b. a:(a, b) t -> (a, b) t * (int32, int32_elt) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1; minmn|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a b. a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m <= n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let tau = Genarray.create _kind _layout [|1; m|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a. side:char -> trans:char -> a:(float, a) t -> tau:(float, a) t
  -> c:(float, a) t -> (float, a) t
  = fun ~side ~trans ~a ~tau ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T');

  let m = Owl_dense_matrix_generic.row_num c in
  let n = Owl_dense_matrix_generic.col_num c in
  let k = Owl_dense_matrix_generic.((row_num tau) * (col_num tau)) in
  let l = Owl_dense_matrix_generic.((col_num a) - (row_num a)) in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _a = bigarray_start Ctypes_static.Genarray a in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let lda = Pervasives.max 1 (_stride a) in
  let ldc = Pervasives.max 1 (_stride c) in

  let ret = match _kind with
    | Float32   -> L.sormrz layout side trans m n k l _a lda _tau _c ldc
    | Float64   -> L.dormrz layout side trans m n k l _a lda _tau _c ldc
  in
  check_lapack_error ret;
  c


let gels
  : type a b. trans:char -> a:(a, b) t -> b:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t
  = fun ~trans ~a ~b ->
  assert (trans = 'N' || trans = 'T' || trans = 'C');
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  if trans = 'N' then
    assert (mb = m)
  else
    assert (mb = n);

  let l = Pervasives.max m n in
  let b = match mb < l with
    | true  -> Owl_dense_matrix_generic.resize b [|l; nb|]
    | false -> b
  in

  let nrhs = nb in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
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
  let a' = Owl_dense_matrix_generic.get_fancy [R[0;k-1]; R[0;k-1]] a in
  let f = match m < n with
    | true  -> Owl_dense_matrix_generic.tril a'
    | false -> Owl_dense_matrix_generic.triu a'
  in
  let sol = match trans = 'N' with
    | true  -> Owl_dense_matrix_generic.resize b [|n; nb|]
    | false -> Owl_dense_matrix_generic.resize b [|m; nb|]
  in
  let ssr = match trans = 'N' with
    | true  ->
        if mb > n then
          Owl_dense_matrix_generic.resize ~head:false b [|mb - n; nb|]
        else
          Genarray.create _kind _layout [|0;0|]
    | false ->
        if mb > m then
          Owl_dense_matrix_generic.resize ~head:false b [|mb - m; nb|]
        else
          Genarray.create _kind _layout [|0;0|]
  in
  f, sol, ssr


let gesv
  : type a b. a:(a, b) t -> b:(a, b) t -> (a, b) t * (a, b) t * (int32, int32_elt) t
  = fun ~a ~b ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  assert (m = n && mb = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let nrhs = nb in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in

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
  : type a b. trans:char -> a:(a, b) t -> ipiv:(int32, int32_elt) t -> b:(a, b) t -> (a, b) t
  = fun ~trans ~a ~ipiv ~b ->
  assert (trans = 'N' || trans = 'T' || trans = 'C');
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  assert (m = n && mb = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let nrhs = nb in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
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
  : type a b. a:(a, b) t -> ipiv:(int32, int32_elt) t -> (a, b) t
  = fun ~a ~ipiv ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let k = Owl_dense_matrix_generic.((row_num ipiv) * (col_num ipiv)) in
  assert (m = n && n = k);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
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
  : type a b. fact:char -> trans:char -> a:(a, b) t -> af:(a, b) t
  -> ipiv:(int32, int32_elt) t -> equed:char -> r:(a, b) t -> c:(a, b) t -> b:(a, b) t
  -> (a, b) t * char * (a, b) t * (a, b) t * (a, b) t * a * (a, b) t * (a, b) t * a
  = fun ~fact ~trans ~a ~af ~ipiv ~equed ~r ~c ~b ->
  assert (fact = 'E' || fact = 'N' || fact = 'T' || fact = 'C');
  assert (trans = 'N' || trans = 'T' || trans = 'C');
  assert (equed = 'N' || equed = 'R' || equed = 'C' || equed = 'B');
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  assert (Owl_dense_matrix_generic.row_num af = n && Owl_dense_matrix_generic.col_num af = n);
  let nrhs = Owl_dense_matrix_generic.col_num b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldaf = Pervasives.max 1 (_stride af) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _af = bigarray_start Ctypes_static.Genarray af in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _equed = Ctypes.(allocate char equed) in
  let x = Genarray.create _kind _layout [|n;nrhs|] in
  let _x = bigarray_start Ctypes_static.Genarray x in
  let ldx = Pervasives.max 1 (_stride x) in

  let r_ref = ref (Genarray.create _kind _layout [|0;0|]) in
  let c_ref = ref (Genarray.create _kind _layout [|0;0|]) in
  let rcond = ref (Genarray.create _kind _layout [|0;0|]) in
  let ferr = ref (Genarray.create _kind _layout [|0;0|]) in
  let berr = ref (Genarray.create _kind _layout [|0;0|]) in
  let rpivot = ref (Genarray.create _kind _layout [|0;0|]) in

  let ret = match _kind with
    | Float32   -> (
        let rcond' = Genarray.create float32 _layout [|1;1|] in
        let ferr' = Genarray.create float32 _layout [|1;nrhs|] in
        let berr' = Genarray.create float32 _layout [|1;nrhs|] in
        let rpivot' = Genarray.create float32 _layout [|1;1|] in
        let _rcond = bigarray_start Ctypes_static.Genarray rcond' in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let _rpivot = bigarray_start Ctypes_static.Genarray rpivot' in

        let _r = bigarray_start Ctypes_static.Genarray r in
        let _c = bigarray_start Ctypes_static.Genarray c in

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
        let rcond' = Genarray.create float64 _layout [|1;1|] in
        let ferr' = Genarray.create float64 _layout [|1;nrhs|] in
        let berr' = Genarray.create float64 _layout [|1;nrhs|] in
        let rpivot' = Genarray.create float64 _layout [|1;1|] in
        let _rcond = bigarray_start Ctypes_static.Genarray rcond' in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let _rpivot = bigarray_start Ctypes_static.Genarray rpivot' in

        let _r = bigarray_start Ctypes_static.Genarray r in
        let _c = bigarray_start Ctypes_static.Genarray c in

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
        let rcond' = Genarray.create float32 _layout [|1;1|] in
        let ferr' = Genarray.create float32 _layout [|1;nrhs|] in
        let berr' = Genarray.create float32 _layout [|1;nrhs|] in
        let rpivot' = Genarray.create float32 _layout [|1;1|] in
        let _rcond = bigarray_start Ctypes_static.Genarray rcond' in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let _rpivot = bigarray_start Ctypes_static.Genarray rpivot' in

        let r' = Owl_dense_matrix_c.re r in
        let c' = Owl_dense_matrix_c.re c in
        let _r = bigarray_start Ctypes_static.Genarray r' in
        let _c = bigarray_start Ctypes_static.Genarray c' in

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
        let rcond' = Genarray.create float64 _layout [|1;1|] in
        let ferr' = Genarray.create float64 _layout [|1;nrhs|] in
        let berr' = Genarray.create float64 _layout [|1;nrhs|] in
        let rpivot' = Genarray.create float64 _layout [|1;1|] in
        let _rcond = bigarray_start Ctypes_static.Genarray rcond' in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let _rpivot = bigarray_start Ctypes_static.Genarray rpivot' in

        let r' = Owl_dense_matrix_z.re r in
        let c' = Owl_dense_matrix_z.re c in
        let _r = bigarray_start Ctypes_static.Genarray r' in
        let _c = bigarray_start Ctypes_static.Genarray c' in

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
  if ret = n + 1 then Owl_log.warn "matrix is singular to working precision.";
  let rcond = Owl_dense_matrix_generic.get !rcond 0 0 in
  let rpivot = Owl_dense_matrix_generic.get !rpivot 0 0 in
  x, !@_equed, !r_ref, !c_ref, b, rcond, !ferr, !berr, rpivot


let gelsd
  : type a b. a:(a, b) t -> b:(a, b) t -> rcond:float -> (a, b) t * int
  = fun ~a ~b ~rcond ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (mb = m);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let b = match mb < n with
    | true  -> Owl_dense_matrix_generic.resize b [|n; nrhs|]
    | false -> b
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _rank = Ctypes.(allocate int32_t 0l) in

  let ret = match _kind with
    | Float32   -> (
        let s = Genarray.create float32 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s in
        L.sgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | Float64   -> (
        let s = Genarray.create float64 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s in
        L.dgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | Complex32 -> (
        let s = Genarray.create float32 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s in
        L.cgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | Complex64 -> (
        let s = Genarray.create float64 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s in
        L.zgelsd layout m n nrhs _a lda _b ldb _s rcond _rank
      )
    | _         -> failwith "lapacke:gelsd"
  in
  check_lapack_error ret;
  let b = Owl_dense_matrix_generic.resize b [|n; nrhs|] in
  b, Int32.to_int !@_rank


let gelsy
  : type a b. a:(a, b) t -> b:(a, b) t -> rcond:float -> (a, b) t * int
  = fun ~a ~b ~rcond ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (mb = m);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let b = match mb < n with
    | true  -> Owl_dense_matrix_generic.resize b [|n; nrhs|]
    | false -> b
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _rank = Ctypes.(allocate int32_t 0l) in

  let jpvt = Genarray.create int32 _layout [|1;n|] in
  Genarray.fill jpvt 0l;
  let _jpvt = bigarray_start Ctypes_static.Genarray jpvt in

  let ret = match _kind with
    | Float32   -> L.sgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | Float64   -> L.dgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | Complex32 -> L.cgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | Complex64 -> L.zgelsy layout m n nrhs _a lda _b ldb _jpvt rcond _rank
    | _         -> failwith "lapacke:gelsy"
  in
  check_lapack_error ret;
  let b = Owl_dense_matrix_generic.resize b [|n; nrhs|] in
  b, Int32.to_int !@_rank


let gglse
  : type a b. a:(a, b) t -> b:(a, b) t -> c:(a, b) t -> d:(a, b) t
  -> (a, b) t * a
  = fun ~a ~b ~c ~d ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let p = Owl_dense_matrix_generic.row_num b in
  assert (n = Owl_dense_matrix_generic.col_num b);
  assert (m = Owl_dense_matrix_generic.((row_num c) * (col_num c)));
  assert (p = Owl_dense_matrix_generic.((row_num d) * (col_num d)));
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let x = Genarray.create _kind _layout [|1;n|] in
  let _x = bigarray_start Ctypes_static.Genarray x in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let _d = bigarray_start Ctypes_static.Genarray d in
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

  let c' = Owl_dense_matrix_generic.resize ~head:false c [|1; m - n + p|] in
  let res = Owl_dense_matrix_generic.(mul c' c' |> sum') in
  x, res


let geev
  : type a b. jobvl:char -> jobvr:char -> a:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~jobvl ~jobvr ~a ->
  assert (jobvl = 'N' || jobvl = 'V');
  assert (jobvr = 'N' || jobvr = 'V');
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let vl = match jobvl with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let vr = match jobvr with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _vl = bigarray_start Ctypes_static.Genarray vl in
  let _vr = bigarray_start Ctypes_static.Genarray vr in
  let lda = Pervasives.max 1 (_stride a) in
  let ldvl = Pervasives.max 1 (_stride vl) in
  let ldvr = Pervasives.max 1 (_stride vr) in

  let wr = ref (Genarray.create _kind _layout [|0;0|]) in
  let wi = ref (Genarray.create _kind _layout [|0;0|]) in

  let ret = match _kind with
    | Float32   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let r = L.sgeev layout jobvl jobvr n _a lda _wr _wi _vl ldvl _vr ldvr in
        wr := wr';
        wi := wi';
        r
      )
    | Float64   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let r = L.dgeev layout jobvl jobvr n _a lda _wr _wi _vl ldvl _vr ldvr in
        wr := wr';
        wi := wi';
        r
      )
    | Complex32 -> (
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.cgeev layout jobvl jobvr n _a lda _w _vl ldvl _vr ldvr in
        wr := w';
        wi := w';
        r
      )
    | Complex64 -> (
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
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
  : type a b. ?jobz:char -> a:(a, b) t -> (a, b) t * (a, b) t *  (a, b) t
  = fun ?(jobz='A') ~a ->
  assert (jobz = 'A' || jobz = 'S' || jobz = 'O' || jobz = 'N');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  assert (m > 0 && n > 0);

  let s = ref (Genarray.create _kind _layout [|0;0|]) in
  let u = match jobz with
    | 'A' -> Genarray.create _kind _layout [|m;m|]
    | 'S' -> Genarray.create _kind _layout [|m;minmn|]
    | 'O' -> Genarray.create _kind _layout [|m; if m >=n then 0 else m|]
    | _   -> Genarray.create _kind _layout [|m;0|]
  in
  let vt = match jobz with
    | 'A' -> Genarray.create _kind _layout [|n;n|]
    | 'S' -> Genarray.create _kind _layout [|minmn;n|]
    | 'O' -> Genarray.create _kind _layout [|n; if m >=n then n else 0|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldvt = Pervasives.max 1 (_stride vt) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _u = bigarray_start Ctypes_static.Genarray u in
  let _vt = bigarray_start Ctypes_static.Genarray vt in

  let ret = match _kind with
    | Float32   -> (
        let s' = Genarray.create float32 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let r = L.sgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := s';
        r
      )
    | Float64   -> (
        let s' = Genarray.create float64 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let r = L.dgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := s';
        r
      )
    | Complex32 -> (
        let s' = Genarray.create float32 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let r = L.cgesdd layout jobz m n _a lda _s _u ldu _vt ldvt in
        s := Owl_dense_matrix_generic.cast_s2c s';
        r
      )
    | Complex64 -> (
        let s' = Genarray.create float64 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
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
  : type a b. ?jobu:char -> ?jobvt:char -> a:(a, b) t -> (a, b) t * (a, b) t *  (a, b) t
  = fun ?(jobu='A') ?(jobvt='A') ~a ->
  assert (jobu = 'A' || jobu = 'S' || jobu = 'O' || jobu = 'N');
  assert (jobvt = 'A' || jobvt = 'S' || jobvt = 'O' || jobvt = 'N');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  assert (jobu <> 'O' || jobvt <> 'O');
  assert (m > 0 && n > 0);

  let s = ref (Genarray.create _kind _layout [|0;0|]) in
  let u = match jobu with
    | 'A' -> Genarray.create _kind _layout [|m;m|]
    | 'S' -> Genarray.create _kind _layout [|m;minmn|]
    | _   -> Genarray.create _kind _layout [|m;0|]
  in
  let vt = match jobvt with
    | 'A' -> Genarray.create _kind _layout [|n;n|]
    | 'S' -> Genarray.create _kind _layout [|minmn;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let lda = Pervasives.max 1 (_stride a) in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldvt = Pervasives.max 1 (_stride vt) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _u = bigarray_start Ctypes_static.Genarray u in
  let _vt = bigarray_start Ctypes_static.Genarray vt in

  let ret = match _kind with
    | Float32   -> (
        let s' = Genarray.create float32 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let superb = Genarray.create float32 _layout [|minmn - 1|]
          |> bigarray_start Ctypes_static.Genarray
        in
        let r = L.sgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := s';
        r
      )
    | Float64   -> (
        let s' = Genarray.create float64 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let superb = Genarray.create float64 _layout [|minmn - 1|]
          |> bigarray_start Ctypes_static.Genarray
        in
        let r = L.dgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := s';
        r
      )
    | Complex32 -> (
        let s' = Genarray.create float32 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let superb = Genarray.create float32 _layout [|minmn - 1|]
          |> bigarray_start Ctypes_static.Genarray
        in
        let r = L.cgesvd layout jobu jobvt m n _a lda _s _u ldu _vt ldvt superb in
        s := Owl_dense_matrix_generic.cast_s2c s';
        r
      )
    | Complex64 -> (
        let s' = Genarray.create float64 _layout [|1; minmn|] in
        let _s = bigarray_start Ctypes_static.Genarray s' in
        let superb = Genarray.create float64 _layout [|minmn - 1|]
          |> bigarray_start Ctypes_static.Genarray
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
  : type a b. ?jobu:char -> ?jobv:char -> ?jobq:char -> a:(a, b) t -> b:(a, b) t
    -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t * int * int * (a, b) t
  = fun ?(jobu='U') ?(jobv='V') ?(jobq='Q') ~a ~b ->
  assert (jobu = 'U' || jobu = 'N');
  assert (jobv = 'V' || jobu = 'N');
  assert (jobq = 'Q' || jobu = 'N');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let p = Owl_dense_matrix_generic.row_num b in
  assert (n = Owl_dense_matrix_generic.col_num b);
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldu = Pervasives.max 1 m in
  let ldv = Pervasives.max 1 p in
  let ldq = Pervasives.max 1 n in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let alpha = ref (Genarray.create _kind _layout [|0;0|]) in
  let beta = ref (Genarray.create _kind _layout [|0;0|]) in
  let u = match jobu with
    | 'U' -> Genarray.create _kind _layout [|ldu; m|]
    | _   -> Genarray.create _kind _layout [|0; m|]
  in
  let v = match jobv with
    | 'V' -> Genarray.create _kind _layout [|ldv; p|]
    | _   -> Genarray.create _kind _layout [|0; p|]
  in
  let q = match jobq with
    | 'Q' -> Genarray.create _kind _layout [|ldq; n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let iwork = Genarray.create int32 _layout [|n|] in

  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _u = bigarray_start Ctypes_static.Genarray u in
  let _v = bigarray_start Ctypes_static.Genarray v in
  let _q = bigarray_start Ctypes_static.Genarray q in
  let _iwork = bigarray_start Ctypes_static.Genarray iwork in
  let _k = Ctypes.(allocate int32_t 0l) in
  let _l = Ctypes.(allocate int32_t 0l) in

  let ret = match _kind with
    | Float32   -> (
        let alpha' = Genarray.create float32 _layout [|1;n|] in
        let beta' = Genarray.create float32 _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let _beta = bigarray_start Ctypes_static.Genarray beta' in
        let r = L.sggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := alpha';
        beta := beta';
        r
      )
    | Float64   -> (
        let alpha' = Genarray.create float64 _layout [|1;n|] in
        let beta' = Genarray.create float64 _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let _beta = bigarray_start Ctypes_static.Genarray beta' in
        let r = L.dggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := alpha';
        beta := beta';
        r
      )
    | Complex32 -> (
        let alpha' = Genarray.create float32 _layout [|1;n|] in
        let beta' = Genarray.create float32 _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let _beta = bigarray_start Ctypes_static.Genarray beta' in
        let r = L.cggsvd3 layout jobu jobv jobq m n p _k _l _a lda _b ldb _alpha _beta _u ldu _v ldv _q ldq _iwork in
        alpha := Owl_dense_matrix_generic.cast_s2c alpha';
        beta := Owl_dense_matrix_generic.cast_s2c beta';
        r
      )
    | Complex64 -> (
        let alpha' = Genarray.create float64 _layout [|1;n|] in
        let beta' = Genarray.create float64 _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let _beta = bigarray_start Ctypes_static.Genarray beta' in
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
        let r = Owl_dense_matrix_generic.get_fancy [R[0; k + l - 1]; R[n - k - l; n - 1]] a in
        Owl_dense_matrix_generic.triu r
      )
    | false -> (
        let ra = Owl_dense_matrix_generic.get_fancy [R[]; R[n - k - l; n - 1]] a in
        let rb = Owl_dense_matrix_generic.get_fancy [R[m - k; l - 1]; R[n - k - l; n - 1]] b in
        let r = Owl_dense_matrix_generic.concat_vertical ra rb in
        Owl_dense_matrix_generic.triu r
      )
  in
  u, v, q, !alpha, !beta, k, l, r


let geevx
  : type a b. balanc:char -> jobvl:char -> jobvr:char -> sense:char -> a:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t * int * int * (a, b) t * float * (a, b) t * (a, b) t
  = fun ~balanc ~jobvl ~jobvr ~sense ~a ->
  assert (balanc = 'N' || balanc = 'P' || balanc = 'S' || balanc = 'B');
  assert (sense = 'N' || sense = 'E' || sense = 'V' || sense = 'B');
  assert (jobvl = 'N' || jobvl = 'V');
  assert (jobvr = 'N' || jobvr = 'V');
  if sense = 'E' || sense = 'B' then assert (jobvl = 'V' && jobvr = 'V');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let vl = match jobvl with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let vr = match jobvr with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let ldvl = Pervasives.max 1 (_stride vl) in
  let ldvr = Pervasives.max 1 (_stride vr) in

  let _ilo = Ctypes.(allocate int32_t 0l) in
  let _ihi = Ctypes.(allocate int32_t 0l) in
  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _vl = bigarray_start Ctypes_static.Genarray vl in
  let _vr = bigarray_start Ctypes_static.Genarray vr in

  let wr = ref (Genarray.create _kind _layout [|0;0|]) in
  let wi = ref (Genarray.create _kind _layout [|0;0|]) in
  let scale = ref (Genarray.create _kind _layout [|0;0|]) in
  let abnrm = ref 0. in
  let rconde = ref (Genarray.create _kind _layout [|0;0|]) in
  let rcondv = ref (Genarray.create _kind _layout [|0;0|]) in

  let ret = match _kind with
    | Float32   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let scale' = Genarray.create _kind _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let rconde' = Genarray.create _kind _layout [|1;n|] in
        let _rconde = bigarray_start Ctypes_static.Genarray rconde' in
        let rcondv' = Genarray.create _kind _layout [|1;n|] in
        let _rcondv = bigarray_start Ctypes_static.Genarray rcondv' in
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
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let scale' = Genarray.create _kind _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let rconde' = Genarray.create _kind _layout [|1;n|] in
        let _rconde = bigarray_start Ctypes_static.Genarray rconde' in
        let rcondv' = Genarray.create _kind _layout [|1;n|] in
        let _rcondv = bigarray_start Ctypes_static.Genarray rcondv' in
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
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let scale' = Genarray.create float32 _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let rconde' = Genarray.create float32 _layout [|1;n|] in
        let _rconde = bigarray_start Ctypes_static.Genarray rconde' in
        let rcondv' = Genarray.create float32 _layout [|1;n|] in
        let _rcondv = bigarray_start Ctypes_static.Genarray rcondv' in
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
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let scale' = Genarray.create float64 _layout [|1;n|] in
        let _scale = bigarray_start Ctypes_static.Genarray scale' in
        let rconde' = Genarray.create float64 _layout [|1;n|] in
        let _rconde = bigarray_start Ctypes_static.Genarray rconde' in
        let rcondv' = Genarray.create float64 _layout [|1;n|] in
        let _rcondv = bigarray_start Ctypes_static.Genarray rcondv' in
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
  : type a b. jobvl:char -> jobvr:char -> a:(a, b) t -> b:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~jobvl ~jobvr ~a ~b ->
  assert (jobvl = 'N' || jobvl = 'V');
  assert (jobvr = 'N' || jobvr = 'V');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  assert (m = n && mb = n && mb = nb);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ldvl = match jobvl with
    | 'V' -> n
    | _   -> 1
  in
  let ldvr = match jobvr with
    | 'V' -> n
    | _   -> 1
  in
  let vl = Genarray.create _kind _layout [|n;ldvl|] in
  let vr = Genarray.create _kind _layout [|n;ldvr|] in

  let alphar = ref (Genarray.create _kind _layout [|0;0|]) in
  let alphai = ref (Genarray.create _kind _layout [|0;0|]) in
  let beta = Genarray.create _kind _layout [|1;n|] in

  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _vl = bigarray_start Ctypes_static.Genarray vl in
  let _vr = bigarray_start Ctypes_static.Genarray vr in
  let _beta = bigarray_start Ctypes_static.Genarray beta in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> (
        let alphar' = Genarray.create _kind _layout [|1;n|] in
        let _alphar = bigarray_start Ctypes_static.Genarray alphar' in
        let alphai' = Genarray.create _kind _layout [|1;n|] in
        let _alphai = bigarray_start Ctypes_static.Genarray alphai' in
        let r = L.sggev layout jobvl jobvr n _a lda _b ldb _alphar _alphai _beta _vl ldvl _vr ldvr in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Float64   -> (
        let alphar' = Genarray.create _kind _layout [|1;n|] in
        let _alphar = bigarray_start Ctypes_static.Genarray alphar' in
        let alphai' = Genarray.create _kind _layout [|1;n|] in
        let _alphai = bigarray_start Ctypes_static.Genarray alphai' in
        let r = L.dggev layout jobvl jobvr n _a lda _b ldb _alphar _alphai _beta _vl ldvl _vr ldvr in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Complex32 -> (
        let alpha' = Genarray.create _kind _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let r = L.cggev layout jobvl jobvr n _a lda _b ldb _alpha _beta _vl ldvl _vr ldvr in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | Complex64 -> (
        let alpha' = Genarray.create _kind _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
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
  : type a b. dl:(a, b) t -> d:(a, b) t -> du:(a, b) t -> b:(a, b) t -> (a, b) t
  = fun ~dl ~d ~du ~b ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_dl = Owl_dense_matrix_generic.numel dl in
  let n_du = Owl_dense_matrix_generic.numel du in
  assert (n_dl = n || n_dl = n - 1);
  assert (n_du = n || n_du = n - 1);
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (mb = n);
  let _kind = Genarray.kind b in
  let _layout = Genarray.layout b in
  let layout = lapacke_layout _layout in

  let ldb = Pervasives.max 1 (_stride b) in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _dl = bigarray_start Ctypes_static.Genarray dl in
  let _du = bigarray_start Ctypes_static.Genarray du in

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
  : type a b. dl:(a, b) t -> d:(a, b) t -> du:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (int32, int32_elt) t
  = fun ~dl ~d ~du ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_dl = Owl_dense_matrix_generic.numel dl in
  let n_du = Owl_dense_matrix_generic.numel du in
  assert (n_dl = n - 1 && n_du = n - 1);
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in

  let du2 = Genarray.create _kind _layout [|1; n - 2|] in
  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _dl = bigarray_start Ctypes_static.Genarray dl in
  let _du = bigarray_start Ctypes_static.Genarray du in
  let _du2 = bigarray_start Ctypes_static.Genarray du2 in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in

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
  : type a b. trans:char -> dl:(a, b) t -> d:(a, b) t -> du:(a, b) t
  -> du2:(a, b) t -> ipiv:(int32, int32_elt) t -> b:(a, b) t -> (a, b) t
  = fun ~trans ~dl ~d ~du ~du2 ~ipiv ~b ->
  assert (trans = 'N' || trans = 'T' || trans = 'C');

  let n = Owl_dense_matrix_generic.numel d in
  let n_dl = Owl_dense_matrix_generic.numel dl in
  let n_du = Owl_dense_matrix_generic.numel du in
  assert (n_dl = n - 1 && n_du = n - 1);
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (mb = n);
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let ldb = Pervasives.max 1 (_stride b) in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _dl = bigarray_start Ctypes_static.Genarray dl in
  let _du = bigarray_start Ctypes_static.Genarray du in
  let _du2 = bigarray_start Ctypes_static.Genarray du2 in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in

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
  : type a. ?k:int -> a:(float, a) t -> tau:(float, a) t -> (float, a) t
  = fun ?k ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= minmn);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sorglq layout minmn n k _a lda _tau
    | Float64   -> L.dorglq layout minmn n k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading rows if necessary *)
  match minmn < m with
  | true  -> Owl_dense_matrix_generic.get_fancy [R[0;minmn-1]; R[]] a
  | false -> a


let unglq
  : type a. ?k:int -> a:(Complex.t, a) t -> tau:(Complex.t, a) t -> (Complex.t, a) t
  = fun ?k ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= minmn);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Complex32 -> L.cunglq layout minmn n k _a lda _tau
    | Complex64 -> L.zunglq layout minmn n k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading rows if necessary *)
  match minmn < m with
  | true  -> Owl_dense_matrix_generic.get_fancy [R[0;minmn-1]; R[]] a
  | false -> a


let orgqr
  : type a. ?k:int -> a:(float, a) t -> tau:(float, a) t -> (float, a) t
  = fun ?k ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= minmn);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sorgqr layout m minmn k _a lda _tau
    | Float64   -> L.dorgqr layout m minmn k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading columns if necessary *)
  match minmn < n with
  | true  -> Owl_dense_matrix_generic.get_fancy [R[]; R[0;minmn-1]] a
  | false -> a


let ungqr
  : type a. ?k:int -> a:(Complex.t, a) t -> tau:(Complex.t, a) t -> (Complex.t, a) t
  = fun ?k ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= minmn);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Complex32   -> L.cungqr layout m minmn k _a lda _tau
    | Complex64   -> L.zungqr layout m minmn k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading columns if necessary *)
  match minmn < n with
  | true  -> Owl_dense_matrix_generic.get_fancy [R[]; R[0;minmn-1]] a
  | false -> a


let orgql
  : type a. ?k:int -> a:(float, a) t -> tau:(float, a) t -> (float, a) t
  = fun ?k ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= minmn);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sorgql layout m minmn k _a lda _tau
    | Float64   -> L.dorgql layout m minmn k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading columns if necessary *)
  match minmn < n with
  | true  -> Owl_dense_matrix_generic.get_fancy [R[]; R[0;minmn-1]] a
  | false -> a


let orgrq
  : type a. ?k:int -> a:(float, a) t -> tau:(float, a) t -> (float, a) t
  = fun ?k ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let minmn = Pervasives.min m n in
  let k = match k with
    | Some k -> k
    | None   -> Owl_dense_matrix_generic.numel tau
  in
  assert (k <= minmn);
  assert (k <= Owl_dense_matrix_generic.numel tau);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sorgrq layout m minmn k _a lda _tau
    | Float64   -> L.dorgrq layout m minmn k _a lda _tau
  in
  check_lapack_error ret;
  (* extract the first leading columns if necessary *)
  match minmn < n with
  | true  -> Owl_dense_matrix_generic.get_fancy [R[]; R[0;minmn-1]] a
  | false -> a


let ormlq
  : type a. side:char -> trans:char -> a:(float, a) t -> tau:(float, a) t
  -> c:(float, a) t -> (float, a) t
  = fun ~side ~trans ~a ~tau ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T');

  let m = Owl_dense_matrix_generic.row_num c in
  let n = Owl_dense_matrix_generic.col_num c in
  let ma = Owl_dense_matrix_generic.row_num a in
  let na = Owl_dense_matrix_generic.col_num a in
  let k = Owl_dense_matrix_generic.numel tau in
  if side = 'L' then
    assert (ma = k && na = m && k <= m)
  else (* if side = 'R' *)
    assert (ma = k && na = n && k <= n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldc = Pervasives.max 1 (_stride c) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sormlq layout side trans m n k _a lda _tau _c ldc
    | Float64   -> L.dormlq layout side trans m n k _a lda _tau _c ldc
  in
  check_lapack_error ret;
  c


let ormqr
  : type a. side:char -> trans:char -> a:(float, a) t -> tau:(float, a) t
  -> c:(float, a) t -> (float, a) t
  = fun ~side ~trans ~a ~tau ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T');

  let m = Owl_dense_matrix_generic.row_num c in
  let n = Owl_dense_matrix_generic.col_num c in
  let ma = Owl_dense_matrix_generic.row_num a in
  let na = Owl_dense_matrix_generic.col_num a in
  let k = Owl_dense_matrix_generic.numel tau in
  if side = 'L' then
    assert (ma = m && na = k && k <= m)
  else (* if side = 'R' *)
    assert (ma = n && na = k && k <= n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldc = Pervasives.max 1 (_stride c) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sormqr layout side trans m n k _a lda _tau _c ldc
    | Float64   -> L.dormqr layout side trans m n k _a lda _tau _c ldc
  in
  check_lapack_error ret;
  c


let ormql
  : type a. side:char -> trans:char -> a:(float, a) t -> tau:(float, a) t
  -> c:(float, a) t -> (float, a) t
  = fun ~side ~trans ~a ~tau ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T');

  let m = Owl_dense_matrix_generic.row_num c in
  let n = Owl_dense_matrix_generic.col_num c in
  let ma = Owl_dense_matrix_generic.row_num a in
  let na = Owl_dense_matrix_generic.col_num a in
  let k = Owl_dense_matrix_generic.numel tau in
  if side = 'L' then
    assert (ma = m && na = k && k <= m)
  else (* if side = 'R' *)
    assert (ma = n && na = k && k <= n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldc = Pervasives.max 1 (_stride c) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sormql layout side trans m n k _a lda _tau _c ldc
    | Float64   -> L.dormql layout side trans m n k _a lda _tau _c ldc
  in
  check_lapack_error ret;
  c


let ormrq
  : type a. side:char -> trans:char -> a:(float, a) t -> tau:(float, a) t
  -> c:(float, a) t -> (float, a) t
  = fun ~side ~trans ~a ~tau ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T');

  let m = Owl_dense_matrix_generic.row_num c in
  let n = Owl_dense_matrix_generic.col_num c in
  let ma = Owl_dense_matrix_generic.row_num a in
  let na = Owl_dense_matrix_generic.col_num a in
  let k = Owl_dense_matrix_generic.numel tau in
  if side = 'L' then
    assert (ma = k && na = m && k <= m)
  else (* if side = 'R' *)
    assert (ma = k && na = n && k <= n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldc = Pervasives.max 1 (_stride c) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let _tau = bigarray_start Ctypes_static.Genarray tau in

  let ret = match _kind with
    | Float32   -> L.sormrq layout side trans m n k _a lda _tau _c ldc
    | Float64   -> L.dormrq layout side trans m n k _a lda _tau _c ldc
  in
  check_lapack_error ret;
  c


let gemqrt
  : type a b. side:char -> trans:char -> v:(a, b) t -> t:(a, b) t -> c:(a, b) t -> (a, b) t
  = fun ~side ~trans ~v ~t ~c ->
  assert (side = 'L' || side = 'R');
  assert (trans = 'N' || trans = 'T' || trans = 'C');

  let m = Owl_dense_matrix_generic.row_num c in
  let n = Owl_dense_matrix_generic.col_num c in
  let nb = Owl_dense_matrix_generic.row_num t in
  let k = Owl_dense_matrix_generic.col_num t in
  let mv = Owl_dense_matrix_generic.row_num v in
  let ldv = Pervasives.max 1 (_stride v) in
  assert (k >= nb);
  if side = 'L' then
    assert (mv = m && ldv = k && k <= m)
  else (* if side = 'R' *)
    assert (mv = n && ldv = k && k <= n);
  let _kind = Genarray.kind c in
  let _layout = Genarray.layout c in
  let layout = lapacke_layout _layout in

  let ldt = Pervasives.max 1 (_stride t) in
  let ldc = Pervasives.max 1 (_stride c) in
  let _v = bigarray_start Ctypes_static.Genarray v in
  let _t = bigarray_start Ctypes_static.Genarray t in
  let _c = bigarray_start Ctypes_static.Genarray c in

  let ret = match _kind with
    | Float32   -> L.sgemqrt layout side trans m n k nb _v ldv _t ldt _c ldc
    | Float64   -> L.dgemqrt layout side trans m n k nb _v ldv _t ldt _c ldc
    | Complex32 -> L.cgemqrt layout side trans m n k nb _v ldv _t ldt _c ldc
    | Complex64 -> L.zgemqrt layout side trans m n k nb _v ldv _t ldt _c ldc
    | _         -> failwith "lapacke:gemqrt"
  in
  check_lapack_error ret;
  c


let posv
  : type a b. uplo:char -> a:(a, b) t -> b:(a, b) t -> (a, b) t * (a, b) t
  = fun ~uplo ~a ~b ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let nrhs = _stride b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in

  let ret = match _kind with
    | Float32   -> L.sposv layout uplo n nrhs _a lda _b ldb
    | Float64   -> L.dposv layout uplo n nrhs _a lda _b ldb
    | Complex32 -> L.cposv layout uplo n nrhs _a lda _b ldb
    | Complex64 -> L.zposv layout uplo n nrhs _a lda _b ldb
    | _         -> failwith "lapacke:posv"
  in
  check_lapack_error ret;
  a, b


let potrf
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in

  let ret = match _kind with
    | Float32   -> L.spotrf layout uplo n _a lda
    | Float64   -> L.dpotrf layout uplo n _a lda
    | Complex32 -> L.cpotrf layout uplo n _a lda
    | Complex64 -> L.zpotrf layout uplo n _a lda
    | _         -> failwith "lapacke:potrf"
  in
  check_lapack_error ret;
  a


let potri
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in

  let ret = match _kind with
    | Float32   -> L.spotri layout uplo n _a lda
    | Float64   -> L.dpotri layout uplo n _a lda
    | Complex32 -> L.cpotri layout uplo n _a lda
    | Complex64 -> L.zpotri layout uplo n _a lda
    | _         -> failwith "lapacke:potri"
  in
  check_lapack_error ret;
  a


let potrs
  : type a b. uplo:char -> a:(a, b) t -> b:(a, b) t -> (a, b) t
  = fun ~uplo ~a ~b ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let nrhs = _stride b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in

  let ret = match _kind with
    | Float32   -> L.spotrs layout uplo n nrhs _a lda _b ldb
    | Float64   -> L.dpotrs layout uplo n nrhs _a lda _b ldb
    | Complex32 -> L.cpotrs layout uplo n nrhs _a lda _b ldb
    | Complex64 -> L.zpotrs layout uplo n nrhs _a lda _b ldb
    | _         -> failwith "lapacke:potrs"
  in
  check_lapack_error ret;
  b


let pstrf
  : type a b. uplo:char -> a:(a, b) t -> tol:a -> (a, b) t * (int32, int32_elt) t * int * int
  = fun ~uplo ~a ~tol ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let piv = Genarray.create int32 _layout [|1;n|] in
  let _piv = bigarray_start Ctypes_static.Genarray piv in
  let _rank = Ctypes.(allocate int32_t 0l) in

  let ret = match _kind with
    | Float32   -> L.spstrf layout uplo n _a lda _piv _rank tol
    | Float64   -> L.dpstrf layout uplo n _a lda _piv _rank tol
    | Complex32 -> L.cpstrf layout uplo n _a lda _piv _rank Complex.(tol.re)
    | Complex64 -> L.zpstrf layout uplo n _a lda _piv _rank Complex.(tol.re)
    | _         -> failwith "lapacke:pstrf"
  in
  check_lapack_error ret;
  let rank = Int32.to_int !@_rank in
  a, piv, rank, ret


let ptsv
  : type a b. d:(a, b) t -> e:(a, b) t -> b:(a, b) t -> (a, b) t
  = fun ~d ~e ~b ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (n_e = n - 1);
  assert (mb = n);
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let ldb = Pervasives.max 1 (_stride b) in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _b = bigarray_start Ctypes_static.Genarray b in

  (* NOTE: only use the real part of d *)
  let ret = match _kind with
    | Float32   -> (
        let _d = bigarray_start Ctypes_static.Genarray d in
        L.sptsv layout n nrhs _d _e _b ldb
      )
    | Float64   -> (
        let _d = bigarray_start Ctypes_static.Genarray d in
        L.dptsv layout n nrhs _d _e _b ldb
      )
    | Complex32 -> (
        let d' = Owl_dense_matrix_c.re d in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        L.cptsv layout n nrhs _d _e _b ldb
      )
    | Complex64 -> (
        let d' = Owl_dense_matrix_z.re d in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        L.zptsv layout n nrhs _d _e _b ldb
      )
    | _         -> failwith "lapacke:ptsv"
  in
  check_lapack_error ret;
  b


let pttrf
  : type a b. d:(a, b) t -> e:(a, b) t -> (a, b) t * (a, b) t
  = fun ~d ~e ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  assert (n_e = n - 1);
  let _kind = Genarray.kind d in
  let _e = bigarray_start Ctypes_static.Genarray e in

  (* NOTE: only use the real part of d *)
  let ret = match _kind with
    | Float32   -> (
        let _d = bigarray_start Ctypes_static.Genarray d in
        L.spttrf n _d _e
      )
    | Float64   -> (
        let _d = bigarray_start Ctypes_static.Genarray d in
        L.dpttrf n _d _e
      )
    | Complex32 -> (
        let d' = Owl_dense_matrix_c.re d in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        L.cpttrf n _d _e
      )
    | Complex64 -> (
        let d' = Owl_dense_matrix_z.re d in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        L.zpttrf n _d _e
      )
    | _         -> failwith "lapacke:pttrf"
  in
  check_lapack_error ret;
  d, e


let pttrs
: type a b. ?uplo:char -> d:(a, b) t -> e:(a, b) t -> b:(a, b) t -> (a, b) t
= fun ?uplo ~d ~e ~b ->
  (* NOTE: uplo is only for complex flavour *)
  let uplo = match uplo with
    | Some uplo -> uplo
    | None      -> 'U'
  in
  assert (uplo = 'U' || uplo = 'L');

  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (n_e = n - 1);
  assert (mb = n);
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let ldb = Pervasives.max 1 (_stride b) in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _b = bigarray_start Ctypes_static.Genarray b in

  (* NOTE: only use the real part of d *)
  let ret = match _kind with
    | Float32   -> (
        let _d = bigarray_start Ctypes_static.Genarray d in
        L.spttrs layout n nrhs _d _e _b ldb
      )
    | Float64   -> (
        let _d = bigarray_start Ctypes_static.Genarray d in
        L.dpttrs layout n nrhs _d _e _b ldb
      )
    | Complex32 -> (
        let d' = Owl_dense_matrix_c.re d in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        L.cpttrs layout uplo n nrhs _d _e _b ldb
      )
    | Complex64 -> (
        let d' = Owl_dense_matrix_z.re d in
        let _d = bigarray_start Ctypes_static.Genarray d' in
        L.zpttrs layout uplo n nrhs _d _e _b ldb
      )
    | _         -> failwith "lapacke:pttrs"
  in
  check_lapack_error ret;
  b


let trtri
  : type a b. uplo:char -> diag:char -> a:(a, b) t -> (a, b) t
  = fun ~uplo ~diag ~a ->
  assert (uplo = 'U' || uplo = 'L');
  assert (diag = 'N' || diag = 'U');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in

  let ret = match _kind with
    | Float32   -> L.strtri layout uplo diag n _a lda
    | Float64   -> L.dtrtri layout uplo diag n _a lda
    | Complex32 -> L.ctrtri layout uplo diag n _a lda
    | Complex64 -> L.ztrtri layout uplo diag n _a lda
    | _         -> failwith "lapacke:trtri"
  in
  check_lapack_error ret;
  a


let trtrs
  : type a b. uplo:char -> trans:char -> diag:char -> a:(a, b) t -> b:(a, b) t -> (a, b) t
  = fun ~uplo ~trans ~diag ~a ~b ->
  assert (uplo = 'U' || uplo = 'L');
  assert (diag = 'N' || diag = 'U');
  assert (trans = 'N' || trans = 'T' || trans = 'C');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let mb = Owl_dense_matrix_generic.row_num b in
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (mb = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in

  let ret = match _kind with
    | Float32   -> L.strtrs layout uplo trans diag n nrhs _a lda _b ldb
    | Float64   -> L.dtrtrs layout uplo trans diag n nrhs _a lda _b ldb
    | Complex32 -> L.ctrtrs layout uplo trans diag n nrhs _a lda _b ldb
    | Complex64 -> L.ztrtrs layout uplo trans diag n nrhs _a lda _b ldb
    | _         -> failwith "lapacke:trtrs"
  in
  check_lapack_error ret;
  b


let trcon
  : type a b. norm:char -> uplo:char -> diag:char -> a:(a, b) t -> float
  = fun ~norm ~uplo ~diag ~a ->
  assert (uplo = 'U' || uplo = 'L');
  assert (diag = 'N' || diag = 'U');
  assert (norm = '1' || norm = 'O' || norm = 'I');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let rcond = ref 0. in

  let ret = match _kind with
    | Float32   -> (
        let _rcond = Ctypes.(allocate float 0.) in
        let r = L.strcon layout norm uplo diag n _a lda _rcond in
        rcond := !@_rcond;
        r
      )
    | Float64   -> (
        let _rcond = Ctypes.(allocate double 0.) in
        let r = L.dtrcon layout norm uplo diag n _a lda _rcond in
        rcond := !@_rcond;
        r
      )
    | Complex32 -> (
        let _rcond = Ctypes.(allocate float 0.) in
        let r = L.ctrcon layout norm uplo diag n _a lda _rcond in
        rcond := !@_rcond;
        r
      )
    | Complex64 -> (
        let _rcond = Ctypes.(allocate double 0.) in
        let r = L.ztrcon layout norm uplo diag n _a lda _rcond in
        rcond := !@_rcond;
        r
      )
    | _         -> failwith "lapacke:trcon"
  in
  check_lapack_error ret;
  !rcond


let trevc
  : type a b. side:char -> howmny:char -> select:(int32, int32_elt) t -> t:(a, b) t
  -> (int32, int32_elt) t * (a, b) t * (a, b) t
  = fun ~side ~howmny ~select ~t ->
  assert (side = 'L' || side = 'R' || side = 'B');
  assert (howmny = 'A' || howmny = 'B' || howmny = 'S');

  let mt = Owl_dense_matrix_generic.row_num t in
  let n = Owl_dense_matrix_generic.col_num t in
  assert (mt = n);
  let _kind = Genarray.kind t in
  let _layout = Genarray.layout t in
  let layout = lapacke_layout _layout in

  (* NOTE: I might allocate too much memory for vl and vr, please refer to Intel
    MKL documentation for more detailed memory allocation strategy. Fix later.
    url: https://software.intel.com/en-us/mkl-developer-reference-c-trevc
  *)
  let vl = Genarray.create _kind _layout [|n;n|] in
  let vr = Genarray.create _kind _layout [|n;n|] in
  let mm = Owl_dense_matrix_generic.col_num vl in
  let ldt = _stride t in
  let ldvl = _stride vl in
  let ldvr = _stride vr in
  let _m = Ctypes.(allocate int32_t 0l) in
  let _t = bigarray_start Ctypes_static.Genarray t in
  let _vl = bigarray_start Ctypes_static.Genarray vl in
  let _vr = bigarray_start Ctypes_static.Genarray vr in
  let _select = bigarray_start Ctypes_static.Genarray select in

  let ret = match _kind with
    | Float32   -> L.strevc layout side howmny _select n _t ldt _vl ldvl _vr ldvr mm _m
    | Float64   -> L.dtrevc layout side howmny _select n _t ldt _vl ldvl _vr ldvr mm _m
    | Complex32 -> L.ctrevc layout side howmny _select n _t ldt _vl ldvl _vr ldvr mm _m
    | Complex64 -> L.ztrevc layout side howmny _select n _t ldt _vl ldvl _vr ldvr mm _m
    | _         -> failwith "lapacke:trevc"
  in
  check_lapack_error ret;

  let m = Int32.to_int !@_m in
  let _empty = Genarray.create _kind _layout [|0;0|] in
  if howmny = 'S' then (      (* return selected eigenvectors *)
    if side = 'L' then        (* left eigenvectors only *)
      select, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vl, _empty
    else if side = 'R' then   (* right eigenvectors only *)
      select, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vr, _empty
    else                      (* both eigenvectors *)
      select, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vl, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vr
  )
  else (                      (* return all eigenvectors *)
    if side = 'L' then        (* left eigenvectors only *)
      select, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vl, _empty
    else if side = 'R' then   (* right eigenvectors only *)
      select, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vr, _empty
    else                      (* both eigenvectors *)
      select, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vl, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] vr
  )


let trrfs
  : type a b. uplo:char -> trans:char -> diag:char -> a:(a, b) t -> b:(a, b) t
  -> x:(a, b) t -> (a, b) t * (a, b) t
  = fun ~uplo ~trans ~diag ~a ~b ~x ->
  assert (uplo = 'U' || uplo = 'L');
  assert (diag = 'N' || diag = 'U');
  assert (trans = 'N' || trans = 'T' || trans = 'C');

  let n = Owl_dense_matrix_generic.col_num a in
  assert (Owl_dense_matrix_generic.row_num b = n);
  let nrhs = Owl_dense_matrix_generic.col_num b in
  assert (Owl_dense_matrix_generic.col_num x = nrhs);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldx = Pervasives.max 1 (_stride x) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _x = bigarray_start Ctypes_static.Genarray x in

  let ferr = ref (Genarray.create _kind _layout [|0;0|]) in
  let berr = ref (Genarray.create _kind _layout [|0;0|]) in

  let ret = match _kind with
    | Float32   -> (
        let ferr' = Genarray.create _kind _layout [|1;nrhs|] in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let berr' = Genarray.create _kind _layout [|1;nrhs|] in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let r = L.strrfs layout uplo trans diag n nrhs _a lda _b ldb _x ldx _ferr _berr in
        ferr := ferr';
        berr := berr';
        r
      )
    | Float64   -> (
        let ferr' = Genarray.create _kind _layout [|1;nrhs|] in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let berr' = Genarray.create _kind _layout [|1;nrhs|] in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let r = L.dtrrfs layout uplo trans diag n nrhs _a lda _b ldb _x ldx _ferr _berr in
        ferr := ferr';
        berr := berr';
        r
      )
    | Complex32 -> (
        let ferr' = Genarray.create float32 _layout [|1;nrhs|] in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let berr' = Genarray.create float32 _layout [|1;nrhs|] in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let r = L.ctrrfs layout uplo trans diag n nrhs _a lda _b ldb _x ldx _ferr _berr in
        ferr := Owl_dense_matrix_generic.cast_s2c ferr';
        berr := Owl_dense_matrix_generic.cast_s2c berr';
        r
      )
    | Complex64 -> (
        let ferr' = Genarray.create float64 _layout [|1;nrhs|] in
        let _ferr = bigarray_start Ctypes_static.Genarray ferr' in
        let berr' = Genarray.create float64 _layout [|1;nrhs|] in
        let _berr = bigarray_start Ctypes_static.Genarray berr' in
        let r = L.ctrrfs layout uplo trans diag n nrhs _a lda _b ldb _x ldx _ferr _berr in
        ferr := Owl_dense_matrix_generic.cast_d2z ferr';
        berr := Owl_dense_matrix_generic.cast_d2z berr';
        r
      )
    | _         -> failwith "lapacke:trrfs"
  in
  check_lapack_error ret;
  !ferr, !berr


let stev
  : type a. jobz:char -> d:(float, a) t -> e:(float, a) t
  -> (float, a) t * (float, a) t
  = fun ~jobz ~d ~e ->
  assert (jobz = 'N' && jobz = 'V');

  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  assert (n_e = n - 1);
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let z = match jobz with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let ldz = Pervasives.max 1 (_stride z) in
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _z = bigarray_start Ctypes_static.Genarray z in

  let ret = match _kind with
    | Float32   -> L.sstev layout jobz n _d _e _z ldz
    | Float64   -> L.dstev layout jobz n _d _e _z ldz
  in
  check_lapack_error ret;
  d, z


let stebz
  : type a. range:char -> order:char -> vl:float -> vu:float -> il:int -> iu:int
  -> abstol:float -> d:(float, a) t -> e:(float, a) t
  -> (float, a) t * (int32, int32_elt) t * (int32, int32_elt) t
  = fun ~range ~order ~vl ~vu ~il ~iu ~abstol ~d ~e ->
  assert (range = 'A' || range = 'V' && range = 'I');
  assert (order = 'B' || order = 'E');

  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  assert (n_e = n - 1);
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in

  let _m = Ctypes.(allocate int32_t 0l) in
  let _nsplit = Ctypes.(allocate int32_t 0l) in
  let w = Genarray.create _kind _layout [|1;n|] in
  let iblock = Genarray.create int32 _layout [|1;n|] in
  let isplit = Genarray.create int32 _layout [|1;n|] in

  let _d = bigarray_start Ctypes_static.Genarray d in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _w = bigarray_start Ctypes_static.Genarray w in
  let _iblock = bigarray_start Ctypes_static.Genarray iblock in
  let _isplit = bigarray_start Ctypes_static.Genarray isplit in

  let ret = match _kind with
    | Float32   -> L.sstebz range order n vl vu il iu abstol _d _e _m _nsplit _w _iblock _isplit
    | Float64   -> L.dstebz range order n vl vu il iu abstol _d _e _m _nsplit _w _iblock _isplit
  in
  check_lapack_error ret;
  let m = Int32.to_int !@_m in
  let w = Owl_dense_matrix_generic.resize w [|1; m|] in
  let iblock = Owl_dense_matrix_generic.resize iblock [|1; m|] in
  let isplit = Owl_dense_matrix_generic.resize isplit [|1; m|] in
  w, iblock, isplit


let stegr
  : type a b. kind:(a, b) kind -> jobz:char -> range:char -> d:(float, b) t
  -> e:(float, b) t -> vl:float -> vu:float -> il:int -> iu:int -> (a, b) t *(a, b) t
  = fun ~kind ~jobz ~range ~d ~e ~vl ~vu ~il ~iu ->
  assert (jobz = 'N' && jobz = 'V');
  assert (range = 'A' || range = 'V' && range = 'I');

  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  assert (n_e = n - 1);
  let _kind = kind in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let abstol = 1. in  (* note that abstol is unused. *)
  let e = Owl_dense_matrix_generic.resize e [|1; n|] in
  let ldz = match jobz with 'N' -> 1 | _ -> n in
  let z = match range with
    | 'I' -> Genarray.create _kind _layout [|(iu - il + 1); ldz|]
    | _   -> Genarray.create _kind _layout [|n; ldz|]
  in
  let isuppz = Genarray.create int32 _layout [|1; (Owl_dense_matrix_generic.row_num z)|] in

  let w = ref (Genarray.create _kind _layout [|0;0|]) in
  let _m = Ctypes.(allocate int32_t 0l) in
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _z = bigarray_start Ctypes_static.Genarray z in
  let _isuppz = bigarray_start Ctypes_static.Genarray isuppz in

  let ret = match _kind with
    | Float32   -> (
        let w' = Genarray.create float32 _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.sstegr layout jobz range n _d _e vl vu il iu abstol _m _w _z ldz _isuppz in
        w := w';
        r
      )
    | Float64   -> (
        let w' = Genarray.create float64 _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.dstegr layout jobz range n _d _e vl vu il iu abstol _m _w _z ldz _isuppz in
        w := w';
        r
      )
    | Complex32 -> (
        let w' = Genarray.create float32 _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.cstegr layout jobz range n _d _e vl vu il iu abstol _m _w _z ldz _isuppz in
        w := Owl_dense_matrix_generic.cast_s2c w';
        r
      )
    | Complex64 -> (
        let w' = Genarray.create float64 _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.zstegr layout jobz range n _d _e vl vu il iu abstol _m _w _z ldz _isuppz in
        w := Owl_dense_matrix_generic.cast_d2z w';
        r
      )
    | _         -> failwith "lapacke:stegr"
  in
  check_lapack_error ret;

  let m = Int32.to_int !@_m in
  let w = match m < Owl_dense_matrix_generic.col_num !w with
    | true  -> Owl_dense_matrix_generic.resize !w [|1; m|]
    | false -> !w
  in
  let z = match m < Owl_dense_matrix_generic.col_num z with
    | true  -> Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] z
    | false -> z
  in
  w, z


let stein
  : type a b. kind:(a, b) kind -> d:(float, b) t -> e:(float, b) t
  -> w:(float, b) t -> iblock:(int32, int32_elt) t -> isplit:(int32, int32_elt) t
  -> (a, b) t * (int32, int32_elt) t
  = fun ~kind ~d ~e ~w ~iblock ~isplit ->
  let n = Owl_dense_matrix_generic.numel d in
  let n_e = Owl_dense_matrix_generic.numel e in
  assert (n_e = n - 1);
  let m = Owl_dense_matrix_generic.numel w in
  assert (n <= m);
  let _kind = kind in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let e = Owl_dense_matrix_generic.resize e [|1; n|] in
  let ldz = Pervasives.max 1 m in
  let z = Genarray.create _kind _layout [|n; m|] in
  let ifailv = Genarray.create int32 _layout [|1; m|] in
  (* TODO: cases where inputs are invalid, refer to julia implementation *)
  let iblock = Genarray.create int32 _layout [|1;n|] in
  let isplit = Genarray.create int32 _layout [|1;n|] in

  let _w = bigarray_start Ctypes_static.Genarray w in
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _z = bigarray_start Ctypes_static.Genarray z in
  let _iblock = bigarray_start Ctypes_static.Genarray iblock in
  let _isplit = bigarray_start Ctypes_static.Genarray isplit in
  let _ifailv = bigarray_start Ctypes_static.Genarray ifailv in

  let ret = match _kind with
    | Float32   -> L.sstein layout n _d _e m _w _iblock _isplit _z ldz _ifailv
    | Float64   -> L.dstein layout n _d _e m _w _iblock _isplit _z ldz _ifailv
    | Complex32 -> L.cstein layout n _d _e m _w _iblock _isplit _z ldz _ifailv
    | Complex64 -> L.zstein layout n _d _e m _w _iblock _isplit _z ldz _ifailv
    | _         -> failwith "lapacke:stein"
  in
  check_lapack_error ret;
  z, ifailv


let syconv
  : type a b. uplo:char -> way:char -> a:(a, b) t -> ipiv:(int32, int32_elt) t
  -> (a, b) t
  = fun ~uplo ~way ~a ~ipiv ->
  assert (uplo = 'U' || uplo = 'L');
  assert (way = 'C' || way = 'R');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let e = Genarray.create _kind _layout [|1;n|] in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.ssyconv layout uplo way n _a lda _ipiv _e
    | Float64   -> L.dsyconv layout uplo way n _a lda _ipiv _e
    | Complex32 -> L.csyconv layout uplo way n _a lda _ipiv _e
    | Complex64 -> L.zsyconv layout uplo way n _a lda _ipiv _e
    | _         -> failwith "lapacke:syconv"
  in
  check_lapack_error ret;
  e


let sysv
  : type a b. uplo:char -> a:(a, b) t -> b:(a, b) t
  -> (a, b) t * (a, b) t * (int32, int32_elt) t
  = fun ~uplo ~a ~b ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  assert (n = Owl_dense_matrix_generic.row_num b);
  let nrhs = Owl_dense_matrix_generic.col_num b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> L.ssysv layout uplo n nrhs _a lda _ipiv _b ldb
    | Float64   -> L.dsysv layout uplo n nrhs _a lda _ipiv _b ldb
    | Complex32 -> L.csysv layout uplo n nrhs _a lda _ipiv _b ldb
    | Complex64 -> L.zsysv layout uplo n nrhs _a lda _ipiv _b ldb
    | _         -> failwith "lapacke:sysv"
  in
  check_lapack_error ret;
  b, a, ipiv


let sytrf
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t * (int32, int32_elt) t * int
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.ssytrf layout uplo n _a lda _ipiv
    | Float64   -> L.dsytrf layout uplo n _a lda _ipiv
    | Complex32 -> L.csytrf layout uplo n _a lda _ipiv
    | Complex64 -> L.zsytrf layout uplo n _a lda _ipiv
    | _         -> failwith "lapacke:sytrf"
  in
  check_lapack_error ret;
  a, ipiv, ret


let sytrf_rook
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t * (int32, int32_elt) t * int
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.ssytrf_rook layout uplo n _a lda _ipiv
    | Float64   -> L.dsytrf_rook layout uplo n _a lda _ipiv
    | Complex32 -> L.csytrf_rook layout uplo n _a lda _ipiv
    | Complex64 -> L.zsytrf_rook layout uplo n _a lda _ipiv
    | _         -> failwith "lapacke:sytrf_rook"
  in
  check_lapack_error ret;
  a, ipiv, ret


let sytri
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.ssytri layout uplo n _a lda _ipiv
    | Float64   -> L.dsytri layout uplo n _a lda _ipiv
    | Complex32 -> L.csytri layout uplo n _a lda _ipiv
    | Complex64 -> L.zsytri layout uplo n _a lda _ipiv
    | _         -> failwith "lapacke:sytri"
  in
  check_lapack_error ret;
  a


let sytrs
  : type a b. uplo:char -> a:(a, b) t -> ipiv:(int32, int32_elt) t -> b:(a, b) t
  -> (a, b) t
  = fun ~uplo ~a ~ipiv ~b ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  assert (n = Owl_dense_matrix_generic.row_num b);
  let nrhs = Owl_dense_matrix_generic.col_num b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Float32   -> L.ssytrs layout uplo n nrhs _a lda _ipiv _b ldb
    | Float64   -> L.dsytrs layout uplo n nrhs _a lda _ipiv _b ldb
    | Complex32 -> L.csytrs layout uplo n nrhs _a lda _ipiv _b ldb
    | Complex64 -> L.zsytrs layout uplo n nrhs _a lda _ipiv _b ldb
    | _         -> failwith "lapacke:sytrs"
  in
  check_lapack_error ret;
  b


let hesv
  : type a. uplo:char -> a:(Complex.t, a) t -> b:(Complex.t, a) t
  -> (Complex.t, a) t * (Complex.t, a) t * (int32, int32_elt) t
  = fun ~uplo ~a ~b ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  assert (n = Owl_dense_matrix_generic.row_num b);
  let nrhs = Owl_dense_matrix_generic.col_num b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Complex32 -> L.chesv layout uplo n nrhs _a lda _ipiv _b ldb
    | Complex64 -> L.zhesv layout uplo n nrhs _a lda _ipiv _b ldb
  in
  check_lapack_error ret;
  b, a, ipiv


let hetrf
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t * (int32, int32_elt) t * int
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Complex32 -> L.chetrf layout uplo n _a lda _ipiv
    | Complex64 -> L.zhetrf layout uplo n _a lda _ipiv
    | _         -> failwith "lapacke:hetrf"
  in
  check_lapack_error ret;
  a, ipiv, ret


let hetrf_rook
  : type a b. uplo:char -> a:(a, b) t -> (a, b) t * (int32, int32_elt) t * int
  = fun ~uplo ~a ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let ipiv = Genarray.create int32 _layout [|1;n|] in
  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Complex32 -> L.chetrf_rook layout uplo n _a lda _ipiv
    | Complex64 -> L.zhetrf_rook layout uplo n _a lda _ipiv
    | _         -> failwith "lapacke:hetrf_rook"
  in
  check_lapack_error ret;
  a, ipiv, ret


let hetri
  : type a. uplo:char -> a:(Complex.t, a) t -> ipiv:(int32, int32_elt) t
  -> (Complex.t, a) t
  = fun ~uplo ~a ~ipiv ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Complex32 -> L.chetri layout uplo n _a lda _ipiv
    | Complex64 -> L.zhetri layout uplo n _a lda _ipiv
  in
  check_lapack_error ret;
  a


let hetrs
  : type a. uplo:char -> a:(Complex.t, a) t -> ipiv:(int32, int32_elt) t
  -> b:(Complex.t, a) t -> (Complex.t, a) t
  = fun ~uplo ~a ~ipiv ~b ->
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  assert (n = Owl_dense_matrix_generic.row_num b);
  let nrhs = Owl_dense_matrix_generic.col_num b in
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _ipiv = bigarray_start Ctypes_static.Genarray ipiv in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in

  let ret = match _kind with
    | Complex32 -> L.chetrs layout uplo n nrhs _a lda _ipiv _b ldb
    | Complex64 -> L.zhetrs layout uplo n nrhs _a lda _ipiv _b ldb
  in
  check_lapack_error ret;
  b


let syev
  : type a. jobz:char -> uplo:char -> a:(float, a) t -> (float, a) t * (float, a) t
  = fun ~jobz ~uplo ~a ->
  assert (jobz = 'N' || jobz = 'V');
  assert (uplo = 'U' || uplo = 'L');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let w = Genarray.create _kind _layout [|1;n|] in
  let _w = bigarray_start Ctypes_static.Genarray w in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.ssyev layout jobz uplo n _a lda _w
    | Float64   -> L.dsyev layout jobz uplo n _a lda _w
  in
  check_lapack_error ret;

  match jobz with
  | 'V' -> w, a
  | _   -> w, Genarray.create _kind _layout [|0;0|]


let syevr
  : type a. jobz:char -> range:char -> uplo:char -> a:(float, a) t -> vl:float
  -> vu:float -> il:int -> iu:int -> abstol:float -> (float, a) t * (float, a) t
  = fun ~jobz ~range ~uplo ~a ~vl ~vu ~il ~iu ~abstol ->
  assert (jobz = 'N' || jobz = 'V');
  assert (range = 'A' || range = 'V' && range = 'I');
  assert (uplo = 'U' || uplo = 'L' );

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _ = match range with
    | 'I' -> assert (1 <= il && il <= iu && iu <= n)
    | 'V' -> assert (vu <= vl)
    | _   -> ()
  in
  let lda = Pervasives.max 1 n in
  let ldz = match jobz with
    | 'V' -> Pervasives.max 1 m
    | _   -> 1
  in
  let z = Genarray.create _kind _layout [|n;ldz|] in
  let w = Genarray.create _kind _layout [|1;n|] in
  let isuppz = Genarray.create int32 _layout [|1;(2 * m)|] in

  let _m = Ctypes.(allocate int32_t 0l) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _z = bigarray_start Ctypes_static.Genarray z in
  let _w = bigarray_start Ctypes_static.Genarray w in
  let _isuppz = bigarray_start Ctypes_static.Genarray isuppz in

  let ret = match _kind with
    | Float32   -> L.ssyevr layout jobz range uplo n _a lda vl vu il iu abstol _m _w _z ldz _isuppz
    | Float64   -> L.dsyevr layout jobz range uplo n _a lda vl vu il iu abstol _m _w _z ldz _isuppz
  in
  check_lapack_error ret;

  let m = Int32.to_int !@_m in
  let w = Owl_dense_matrix_generic.resize w [|1; m|] in
  match jobz with
  | 'V' -> w, Owl_dense_matrix_generic.get_fancy [R[]; R[0;m-1]] z
  | _   -> w, Genarray.create _kind _layout [|0;0|]


let sygvd
  : type a. ityp:int -> jobz:char -> uplo:char -> a:(float, a) t -> b:(float, a) t
  -> (float, a) t * (float, a) t * (float, a) t
  = fun ~ityp ~jobz ~uplo ~a ~b ->
  assert (ityp > 0 && ityp < 4);
  assert (jobz = 'N' || jobz = 'V');
  assert (uplo = 'U' || uplo = 'L' );

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  assert (m = n && n = mb && n = nb);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let w = Genarray.create _kind _layout [|1;n|] in
  let _w = bigarray_start Ctypes_static.Genarray w in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in

  let ret = match _kind with
    | Float32   -> L.ssygvd layout ityp jobz uplo n _a lda _b ldb _w
    | Float64   -> L.dsygvd layout ityp jobz uplo n _a lda _b ldb _w
  in
  check_lapack_error ret;
  w, a, b


let bdsqr
  : type a b. uplo:char -> d:(float, b) t -> e:(float, b) t -> vt:(a, b) t
  -> u:(a, b) t -> c:(a, b) t -> (float, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun  ~uplo ~d ~e ~vt ~u ~c ->
  assert (uplo = 'U' || uplo = 'L' );

  let n = Owl_dense_matrix_generic.numel d in
  let ncvt = Owl_dense_matrix_generic.col_num vt in
  let nru = Owl_dense_matrix_generic.row_num u in
  let ncc = Owl_dense_matrix_generic.col_num c in
  assert (Owl_dense_matrix_generic.row_num vt = n);
  assert (Owl_dense_matrix_generic.row_num c = n);
  let n_e = Owl_dense_matrix_generic.numel e in
  assert (n_e = n - 1);
  let _kind = Genarray.kind vt in
  let _layout = Genarray.layout vt in
  let layout = lapacke_layout _layout in

  let ldvt = Pervasives.max 1 (_stride vt) in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldc = Pervasives.max 1 ncc in
  assert (ldvt >= ncvt);
  assert (ldu >= n);
  assert (ldc >= ncc);
  let _d = bigarray_start Ctypes_static.Genarray d in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _vt = bigarray_start Ctypes_static.Genarray vt in
  let _u = bigarray_start Ctypes_static.Genarray u in
  let _c = bigarray_start Ctypes_static.Genarray c in

  let ret = match _kind with
    | Float32   -> L.sbdsqr layout uplo n ncvt nru ncc _d _e _vt ldvt _u ldu _c ldc
    | Float64   -> L.dbdsqr layout uplo n ncvt nru ncc _d _e _vt ldvt _u ldu _c ldc
    | Complex32 -> L.cbdsqr layout uplo n ncvt nru ncc _d _e _vt ldvt _u ldu _c ldc
    | Complex64 -> L.zbdsqr layout uplo n ncvt nru ncc _d _e _vt ldvt _u ldu _c ldc
    | _         -> failwith "lapacke:bdsqr"
  in
  check_lapack_error ret;
  d, vt, u, c


let bdsdc
  : type a. uplo:char -> compq:char -> d:(float, a) t -> e:(float, a) t
  -> (float, a) t * (float, a) t * (float, a) t * (float, a) t * (float, a) t * (int32, int32_elt) t
  = fun ~uplo ~compq ~d ~e ->
  assert (uplo = 'U' || uplo = 'L');
  assert (compq = 'N' || compq = 'P' || compq = 'I');

  let n = Owl_dense_matrix_generic.numel d in
  let _kind = Genarray.kind d in
  let _layout = Genarray.layout d in
  let layout = lapacke_layout _layout in

  let u = match compq with
    | 'I' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let vt = match compq with
    | 'I' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let q = match compq with
    | 'P' -> (
      let smlsiz = 100. in
      let n = float_of_int n in
      let ldq = Owl_maths.(n *. (11. +. 2. *. smlsiz +. 8. *. round (log ((n /. (smlsiz +. 1.))) /. (log 2.)))) in
      Genarray.create _kind _layout [|1; (Pervasives.max 0 (int_of_float ldq))|]
      )
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let iq = match compq with
    | 'P' -> (
      let smlsiz = 100. in
      let n = float_of_int n in
      let ldiq = Owl_maths.(n *. (3. +. 3. *. round (log (n /. (smlsiz +. 1.)) /. (log 2.)))) in
      Genarray.create int32 _layout [|1; (Pervasives.max 0 (int_of_float ldiq))|]
      )
    | _   -> Genarray.create int32 _layout [|0; n|]
  in
  let ldu = Pervasives.max 1 (_stride u) in
  let ldvt = Pervasives.max 1 (_stride vt) in

  let _d = bigarray_start Ctypes_static.Genarray d in
  let _e = bigarray_start Ctypes_static.Genarray e in
  let _u = bigarray_start Ctypes_static.Genarray u in
  let _vt = bigarray_start Ctypes_static.Genarray vt in
  let _q = bigarray_start Ctypes_static.Genarray q in
  let _iq = bigarray_start Ctypes_static.Genarray iq in

  let ret = match _kind with
    | Float32   -> L.sbdsdc layout uplo compq n _d _e _u ldu _vt ldvt _q _iq
    | Float64   -> L.dbdsdc layout uplo compq n _d _e _u ldu _vt ldvt _q _iq
  in
  check_lapack_error ret;
  d, e, u, vt, q, iq


let gecon
  : type a b. norm:char -> a:(a, b) t -> anorm:float -> float
  = fun ~norm ~a ~anorm ->
  assert (norm = '1' || norm = 'O' || norm = 'I');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let rcond = ref 0. in

  let ret = match _kind with
    | Float32   -> (
        let _rcond = Ctypes.(allocate float 0.) in
        let r = L.sgecon layout norm n _a lda anorm _rcond in
        rcond := !@_rcond;
        r
      )
    | Float64   -> (
        let _rcond = Ctypes.(allocate double 0.) in
        let r = L.dgecon layout norm n _a lda anorm _rcond in
        rcond := !@_rcond;
        r
      )
    | Complex32 -> (
        let _rcond = Ctypes.(allocate float 0.) in
        let r = L.cgecon layout norm n _a lda anorm _rcond in
        rcond := !@_rcond;
        r
      )
    | Complex64 -> (
        let _rcond = Ctypes.(allocate double 0.) in
        let r = L.zgecon layout norm n _a lda anorm _rcond in
        rcond := !@_rcond;
        r
      )
    | _         -> failwith "lapacke:gecon"
  in
  check_lapack_error ret;
  !rcond


let gehrd
  : type a b. ilo:int -> ihi:int -> a:(a, b) t -> (a, b) t * (a, b) t
  = fun ~ilo ~ihi ~a ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let tau = Genarray.create _kind _layout [|1; (Pervasives.max 1 (n - 1))|] in
  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.sgehrd layout n ilo ihi _a lda _tau
    | Float64   -> L.dgehrd layout n ilo ihi _a lda _tau
    | Complex32 -> L.cgehrd layout n ilo ihi _a lda _tau
    | Complex64 -> L.zgehrd layout n ilo ihi _a lda _tau
    | _         -> failwith "lapacke:gehrd"
  in
  check_lapack_error ret;
  a, tau


let orghr
  : type a. ilo:int -> ihi:int -> a:(float, a) t -> tau:(float, a) t -> (float, a) t
  = fun ~ilo ~ihi ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let n_tau = Owl_dense_matrix_generic.numel tau in
  assert (n_tau = n - 1);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> L.sorghr layout n ilo ihi _a lda _tau
    | Float64   -> L.dorghr layout n ilo ihi _a lda _tau
  in
  check_lapack_error ret;
  a


let unghr
  : type a. ilo:int -> ihi:int -> a:(Complex.t, a) t -> tau:(Complex.t, a) t -> (Complex.t, a) t
  = fun ~ilo ~ihi ~a ~tau ->
  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let n_tau = Owl_dense_matrix_generic.numel tau in
  assert (n_tau = n - 1);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let _tau = bigarray_start Ctypes_static.Genarray tau in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Complex32 -> L.cunghr layout n ilo ihi _a lda _tau
    | Complex64 -> L.zunghr layout n ilo ihi _a lda _tau
  in
  check_lapack_error ret;
  a


let gees
  : type a b. jobvs:char -> a:(a, b) t -> (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~jobvs ~a ->
  let sort = 'N' in
  assert (jobvs = 'N' || jobvs = 'V');
  assert (sort = 'N' || sort = 'S');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (m = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let vs = match jobvs with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let ldvs = Pervasives.max 1 (_stride vs) in
  let wr = ref (Genarray.create _kind _layout [|0;0|]) in
  let wi = ref (Genarray.create _kind _layout [|0;0|]) in

  let _select = Ctypes.null in
  let _sdim = Ctypes.(allocate int32_t 0l) in
  let _vs = bigarray_start Ctypes_static.Genarray vs in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let lda = Pervasives.max 1 (_stride a) in

  let ret = match _kind with
    | Float32   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let r = L.sgees layout jobvs sort _select n _a lda _sdim _wr _wi _vs ldvs in
        wr := wr';
        wi := wi';
        r
      )
    | Float64   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let r = L.dgees layout jobvs sort _select n _a lda _sdim _wr _wi _vs ldvs in
        wr := wr';
        wi := wi';
        r
      )
    | Complex32 -> (
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.cgees layout jobvs sort _select n _a lda _sdim _w _vs ldvs in
        wr := w';
        wi := w';
        r
      )
    | Complex64 -> (
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let r = L.zgees layout jobvs sort _select n _a lda _sdim _w _vs ldvs in
        wr := w';
        wi := w';
        r
      )
    | _         -> failwith "lapacke:gees"
  in
  check_lapack_error ret;
  (* NOTE: wr and wi are the same for complex flavour *)
  a, vs, !wr, !wi


let gges
  : type a b. jobvsl:char -> jobvsr:char -> a:(a, b) t -> b:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~jobvsl ~jobvsr ~a ~b ->
  let sort = 'N' in
  assert (jobvsl = 'N' || jobvsl = 'V');
  assert (jobvsr = 'N' || jobvsr = 'V');
  assert (sort = 'N' || sort = 'S');

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  assert (m = n && n = mb && mb = nb);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let vsl = match jobvsl with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let vsr = match jobvsr with
    | 'V' -> Genarray.create _kind _layout [|n;n|]
    | _   -> Genarray.create _kind _layout [|0;n|]
  in
  let ldvsl = Pervasives.max 1 (_stride vsl) in
  let ldvsr = Pervasives.max 1 (_stride vsr) in
  let alphar = ref (Genarray.create _kind _layout [|0;0|]) in
  let alphai = ref (Genarray.create _kind _layout [|0;0|]) in
  let beta = Genarray.create _kind _layout [|1;n|] in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _vsl = bigarray_start Ctypes_static.Genarray vsl in
  let _vsr = bigarray_start Ctypes_static.Genarray vsr in
  let _beta = bigarray_start Ctypes_static.Genarray beta in
  let _selctg = Ctypes.null in
  let _sdim = Ctypes.(allocate int32_t 0l) in

  let ret = match _kind with
    | Float32   -> (
        let alphar' = Genarray.create _kind _layout [|1;n|] in
        let _alphar = bigarray_start Ctypes_static.Genarray alphar' in
        let alphai' = Genarray.create _kind _layout [|1;n|] in
        let _alphai = bigarray_start Ctypes_static.Genarray alphai' in
        let r = L.sgges layout jobvsl jobvsr sort _selctg n _a lda _b ldb _sdim _alphar _alphai _beta _vsl ldvsl _vsr ldvsr in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Float64   -> (
        let alphar' = Genarray.create _kind _layout [|1;n|] in
        let _alphar = bigarray_start Ctypes_static.Genarray alphar' in
        let alphai' = Genarray.create _kind _layout [|1;n|] in
        let _alphai = bigarray_start Ctypes_static.Genarray alphai' in
        let r = L.dgges layout jobvsl jobvsr sort _selctg n _a lda _b ldb _sdim _alphar _alphai _beta _vsl ldvsl _vsr ldvsr in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Complex32 -> (
        let alpha' = Genarray.create _kind _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let r = L.cgges layout jobvsl jobvsr sort _selctg n _a lda _b ldb _sdim _alpha _beta _vsl ldvsl _vsr ldvsr in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | Complex64 -> (
        let alpha' = Genarray.create _kind _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let r = L.zgges layout jobvsl jobvsr sort _selctg n _a lda _b ldb _sdim _alpha _beta _vsl ldvsl _vsr ldvsr in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | _         -> failwith "lapacke:gges"
  in
  check_lapack_error ret;
  (* NOTE: alphar and alphai are the same for complex flavour *)
  a, b, !alphar, !alphai, beta, vsl, vsr


let trexc
  : type a b. compq:char -> t:(a, b) t -> q:(a, b) t -> ifst:int -> ilst:int
  -> (a, b) t * (a, b) t
  = fun ~compq ~t ~q ~ifst ~ilst ->
  assert (compq = 'N' || compq = 'V');

  let m = Owl_dense_matrix_generic.row_num t in
  let n = Owl_dense_matrix_generic.col_num t in
  assert (m = n);
  assert (1 <= ifst && ifst <= n);
  assert (1 <= ilst && ilst <= n);
  let _kind = Genarray.kind t in
  let _layout = Genarray.layout t in
  let layout = lapacke_layout _layout in

  let ldt = Pervasives.max 1 (_stride t) in
  let ldq = Pervasives.max 1 (_stride q) in
  let _t = bigarray_start Ctypes_static.Genarray t in
  let _q = bigarray_start Ctypes_static.Genarray q in
  let _ifst = Ctypes.(allocate int32_t (Int32.of_int ifst)) in
  let _ilst = Ctypes.(allocate int32_t (Int32.of_int ilst)) in

  let ret = match _kind with
    | Float32   -> L.strexc layout compq n _t ldt _q ldq _ifst _ilst
    | Float64   -> L.dtrexc layout compq n _t ldt _q ldq _ifst _ilst
    | Complex32 -> L.ctrexc layout compq n _t ldt _q ldq ifst ilst
    | Complex64 -> L.ztrexc layout compq n _t ldt _q ldq ifst ilst
    | _         -> failwith "lapacke:trexc"
  in
  check_lapack_error ret;
  t, q


let trsen
  : type a b. job:char -> compq:char -> select:(int32, int32_elt) t -> t:(a, b) t
  -> q:(a, b) t -> (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~job ~compq ~select ~t ~q ->
  assert (job = 'N' || job = 'E' || job = 'V' || job = 'B');
  assert (compq = 'N' || compq = 'V');

  let mt = Owl_dense_matrix_generic.row_num t in
  let n = Owl_dense_matrix_generic.col_num t in
  assert (mt = n);
  let _kind = Genarray.kind t in
  let _layout = Genarray.layout t in
  let layout = lapacke_layout _layout in

  let ldt = Pervasives.max 1 (_stride t) in
  let ldq = Pervasives.max 1 (_stride q) in
  let _t = bigarray_start Ctypes_static.Genarray t in
  let _q = bigarray_start Ctypes_static.Genarray q in
  let wr = ref (Genarray.create _kind _layout [|0;0|]) in
  let wi = ref (Genarray.create _kind _layout [|0;0|]) in
  let _select = bigarray_start Ctypes_static.Genarray select in

  (* FIXME: not sure summation is really needed *)
  let m = ref 0l in
  for i = 0 to Owl_dense_matrix_generic.col_num select - 1 do
    m := Int32.add !m (Owl_dense_matrix_generic.get select 0 i)
  done;
  let _m = Ctypes.(allocate int32_t !m) in

  let ret = match _kind with
    | Float32   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let _s = Ctypes.(allocate float 0.) in
        let _sep = Ctypes.(allocate float 0.) in
        let r = L.strsen layout job compq _select n _t ldt _q ldq _wr _wi _m _s _sep in
        wr := wr';
        wi := wi';
        r
      )
    | Float64   -> (
        let wr' = Genarray.create _kind _layout [|1;n|] in
        let _wr = bigarray_start Ctypes_static.Genarray wr' in
        let wi' = Genarray.create _kind _layout [|1;n|] in
        let _wi = bigarray_start Ctypes_static.Genarray wi' in
        let _s = Ctypes.(allocate double 0.) in
        let _sep = Ctypes.(allocate double 0.) in
        let r = L.dtrsen layout job compq _select n _t ldt _q ldq _wr _wi _m _s _sep in
        wr := wr';
        wi := wi';
        r
      )
    | Complex32 -> (
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let _s = Ctypes.(allocate float 0.) in
        let _sep = Ctypes.(allocate float 0.) in
        let r = L.ctrsen layout job compq _select n _t ldt _q ldq _w _m _s _sep in
        wr := w';
        wi := w';
        r
      )
    | Complex64 -> (
        let w' = Genarray.create _kind _layout [|1;n|] in
        let _w = bigarray_start Ctypes_static.Genarray w' in
        let _s = Ctypes.(allocate float 0.) in
        let _sep = Ctypes.(allocate float 0.) in
        let r = L.ztrsen layout job compq _select n _t ldt _q ldq _w _m _s _sep in
        wr := w';
        wi := w';
        r
      )
    | _         -> failwith "lapacke:trsen"
  in
  check_lapack_error ret;
  (* NOTE: wr and wi are the same for complex flavour *)
  t, q, !wr, !wi


let tgsen
  : type a b. select:(int32, int32_elt) t -> a:(a, b) t -> b:(a, b) t -> q:(a, b) t -> z:(a, b) t
  -> (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t * (a, b) t
  = fun ~select ~a ~b ~q ~z ->
  (* set these values by default *)
  let ijob = 0 in
  let wantq = 1 in
  let wantz = 1 in
  assert (0 <= ijob && ijob <= 5);
  assert (wantq = 0 || wantq = 1);
  assert (wantz = 0 || wantz = 1);

  let ma = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  assert (ma = n);
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  assert (mb = nb);
  let mq = Owl_dense_matrix_generic.row_num q in
  let nq = Owl_dense_matrix_generic.col_num q in
  assert (mq = nq);
  let mz = Owl_dense_matrix_generic.row_num z in
  let nz = Owl_dense_matrix_generic.col_num z in
  assert (mz = nz);
  assert (n = nb);
  assert (n = nq);
  assert (n = nz);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldq = Pervasives.max 1 (_stride q) in
  let ldz = Pervasives.max 1 (_stride z) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _q = bigarray_start Ctypes_static.Genarray q in
  let _z = bigarray_start Ctypes_static.Genarray z in
  let alphar = ref (Genarray.create _kind _layout [|0;0|]) in
  let alphai = ref (Genarray.create _kind _layout [|0;0|]) in
  let beta = Genarray.create _kind _layout [|1;n|] in
  let _beta = bigarray_start Ctypes_static.Genarray beta in
  let _select = bigarray_start Ctypes_static.Genarray select in

  (* FIXME: not sure summation is really needed *)
  let m = ref 0l in
  for i = 0 to Owl_dense_matrix_generic.col_num select - 1 do
    m := Int32.add !m (Owl_dense_matrix_generic.get select 0 i)
  done;
  let _m = Ctypes.(allocate int32_t !m) in

  let ret = match _kind with
    | Float32   -> (
        let alphar' = Genarray.create _kind _layout [|1;n|] in
        let _alphar = bigarray_start Ctypes_static.Genarray alphar' in
        let alphai' = Genarray.create _kind _layout [|1;n|] in
        let _alphai = bigarray_start Ctypes_static.Genarray alphai' in
        let _pl = Ctypes.(allocate float 0.) in
        let _pr = Ctypes.(allocate float 0.) in
        let dif = Genarray.create float32 _layout [|1;2|] in
        let _dif = bigarray_start Ctypes_static.Genarray dif in
        let r = L.stgsen layout ijob wantq wantz _select n _a lda _b ldb _alphar _alphai _beta _q ldq _z ldz _m _pl _pr _dif in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Float64   -> (
        let alphar' = Genarray.create _kind _layout [|1;n|] in
        let _alphar = bigarray_start Ctypes_static.Genarray alphar' in
        let alphai' = Genarray.create _kind _layout [|1;n|] in
        let _alphai = bigarray_start Ctypes_static.Genarray alphai' in
        let _pl = Ctypes.(allocate double 0.) in
        let _pr = Ctypes.(allocate double 0.) in
        let dif = Genarray.create float64 _layout [|1;2|] in
        let _dif = bigarray_start Ctypes_static.Genarray dif in
        let r = L.dtgsen layout ijob wantq wantz _select n _a lda _b ldb _alphar _alphai _beta _q ldq _z ldz _m _pl _pr _dif in
        alphar := alphar';
        alphai := alphai';
        r
      )
    | Complex32 -> (
        let alpha' = Genarray.create _kind _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let _pl = Ctypes.(allocate float 0.) in
        let _pr = Ctypes.(allocate float 0.) in
        let dif = Genarray.create float32 _layout [|1;2|] in
        let _dif = bigarray_start Ctypes_static.Genarray dif in
        let r = L.ctgsen layout ijob wantq wantz _select n _a lda _b ldb _alpha _beta _q ldq _z ldz _m _pl _pr _dif in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | Complex64 -> (
        let alpha' = Genarray.create _kind _layout [|1;n|] in
        let _alpha = bigarray_start Ctypes_static.Genarray alpha' in
        let _pl = Ctypes.(allocate double 0.) in
        let _pr = Ctypes.(allocate double 0.) in
        let dif = Genarray.create float64 _layout [|1;2|] in
        let _dif = bigarray_start Ctypes_static.Genarray dif in
        let r = L.ztgsen layout ijob wantq wantz _select n _a lda _b ldb _alpha _beta _q ldq _z ldz _m _pl _pr _dif in
        alphar := alpha';
        alphai := alpha';
        r
      )
    | _         -> failwith "lapacke:tgsen"
  in
  check_lapack_error ret;
  (* NOTE: alphar and alphai are the same for complex flavour *)
  a, b, !alphar, !alphai, beta, q, z


let trsyl
  : type a b. trana:char -> tranb:char -> isgn:int -> a:(a, b) t
  -> b:(a, b) t -> c:(a, b) t -> (a, b) t * float
  = fun ~trana ~tranb ~isgn ~a ~b ~c ->
  assert (trana = 'N' || trana = 'T' || trana = 'C');
  assert (tranb = 'N' || tranb = 'T' || tranb = 'C');
  assert (isgn = -1 || isgn = +1);

  let m = Owl_dense_matrix_generic.row_num a in
  let n = Owl_dense_matrix_generic.col_num a in
  let mb = Owl_dense_matrix_generic.row_num b in
  let nb = Owl_dense_matrix_generic.col_num b in
  let mc = Owl_dense_matrix_generic.row_num c in
  let nc = Owl_dense_matrix_generic.col_num c in
  assert (m = n);
  assert (mb = nb);
  assert (mc = m && nc = n);
  let _kind = Genarray.kind a in
  let _layout = Genarray.layout a in
  let layout = lapacke_layout _layout in

  let lda = Pervasives.max 1 (_stride a) in
  let ldb = Pervasives.max 1 (_stride b) in
  let ldc = Pervasives.max 1 (_stride c) in
  let _a = bigarray_start Ctypes_static.Genarray a in
  let _b = bigarray_start Ctypes_static.Genarray b in
  let _c = bigarray_start Ctypes_static.Genarray c in
  let scale = ref 0. in

  let ret = match _kind with
    | Float32   -> (
        let _scale = Ctypes.(allocate float 0.) in
        let r = L.strsyl layout trana tranb isgn m n _a lda _b ldb _c ldc _scale in
        scale := !@_scale;
        r
      )
    | Float64   -> (
        let _scale = Ctypes.(allocate double 0.) in
        let r = L.dtrsyl layout trana tranb isgn m n _a lda _b ldb _c ldc _scale in
        scale := !@_scale;
        r
      )
    | Complex32 -> (
        let _scale = Ctypes.(allocate float 0.) in
        let r = L.ctrsyl layout trana tranb isgn m n _a lda _b ldb _c ldc _scale in
        scale := !@_scale;
        r
      )
    | Complex64 -> (
        let _scale = Ctypes.(allocate double 0.) in
        let r = L.ztrsyl layout trana tranb isgn m n _a lda _b ldb _c ldc _scale in
        scale := !@_scale;
        r
      )
    | _         -> failwith "lapacke:trsyl"
  in
  check_lapack_error ret;
  c, !scale











(* ends here *)
