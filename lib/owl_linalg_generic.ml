(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b) Owl_dense.Matrix.Generic.t

module M = Owl_dense.Matrix.Generic


(* LU decomposition *)


let lu x =
  let x = M.clone x in
  let m, n = M.shape x in
  let minmn = Pervasives.min m n in

  let a, ipiv = Owl_lapacke.getrf x in
  let l = M.tril a in
  let u = M.resize n n (M.triu a) in

  let _a1 = Owl_dense_common._one (M.kind x) in
  for i = 0 to minmn - 1 do
    l.{i,i} <- _a1
  done;

  l, u, ipiv


let lufact x =
  let a, ipiv = Owl_lapacke.getrf x in
  a, ipiv


let inv x =
  let x = M.clone x in
  let a, ipiv = Owl_lapacke.getrf x in
  Owl_lapacke.getri a ipiv


let det x =
  let x = M.clone x in
  let m, n = M.shape x in
  assert (m = n);

  let a, ipiv = Owl_lapacke.getrf x in
  let d = ref (Owl_dense_common._one (M.kind x)) in
  let c = ref 0 in

  let _mul_op = Owl_dense_common._mul_elt (M.kind x) in
  for i = 0 to m - 1 do
    d := _mul_op !d a.{i,i};
    (* NOTE: +1 to adjust to Fortran index *)
    if ipiv.{0,i} <> Int32.of_int (i + 1) then
      c := !c + 1
  done;

  match Owl_maths.is_odd !c with
  | true  -> Owl_dense_common._neg_elt (M.kind x) !d
  | false -> !d


(* FIXME: need to check ... *)
let logdet x =
  let x = M.clone x in
  let m, n = M.shape x in
  assert (m = n);

  let _kind = M.kind x in
  let a, ipiv = Owl_lapacke.getrf x in
  let d = ref (Owl_dense_common._zero _kind) in
  let c = ref 0 in

  let _add_op = Owl_dense_common._add_elt _kind in
  let _log_op = Owl_dense_common._log_elt _kind in
  let _neg_op = Owl_dense_common._neg_elt _kind in

  for i = 0 to m - 1 do
    d := _add_op !d (_log_op a.{i,i});
    (* NOTE: +1 to adjust to Fortran index *)
    if ipiv.{0,i} <> Int32.of_int (i + 1) then
      c := !c + 1
  done;

  match Owl_maths.is_odd !c with
  | true  -> Owl_dense_common._neg_elt _kind !d
  | false -> !d


(* QR decomposition *)


let _get_qr_q
  : type a b. (a, b) kind -> (a, b) t -> (a, b) t -> (a, b) t
  = fun k a tau ->
  match k with
  | Float32   -> Owl_lapacke.orgqr a tau
  | Float64   -> Owl_lapacke.orgqr a tau
  | Complex32 -> Owl_lapacke.ungqr a tau
  | Complex64 -> Owl_lapacke.ungqr a tau
  | _         -> failwith "owl_linalg:_get_qr_q"


let qr ?(thin=true) ?(pivot=false) x =
  let x = M.clone x in
  let m, n = M.shape x in
  let minmn = Pervasives.min m n in
  let a, tau, jpvt = match pivot with
    | true  -> Owl_lapacke.geqp3 x
    | false -> (
        let jpvt = M.empty int32 0 0 in
        let a, tau = Owl_lapacke.geqrf x in
        a, tau, jpvt
      )
  in
  let r = match thin with
    | true  -> M.resize ~head:true minmn n (M.triu a)
    | false -> M.resize ~head:true m n (M.triu a)
  in
  let a = match thin with
    | true  -> a
    | false ->
        if m <= n then a
        else (
          let a' = M.zeros (M.kind x) m (m - n) in
          M.concat_horizontal a a'
        )
  in
  let q = _get_qr_q (M.kind x) a tau in
  q, r, jpvt


let qrfact ?(pivot=false) x =
  let a, tau, jpvt = match pivot with
    | true  -> Owl_lapacke.geqp3 x
    | false -> (
        let jpvt = M.empty int32 0 0 in
        let a, tau = Owl_lapacke.geqrf x in
        a, tau, jpvt
      )
  in
  a, tau, jpvt


let _get_lq_q
  : type a b. (a, b) kind -> (a, b) t -> (a, b) t -> (a, b) t
  = fun k a tau ->
  match k with
  | Float32   -> Owl_lapacke.orglq a tau
  | Float64   -> Owl_lapacke.orglq a tau
  | Complex32 -> Owl_lapacke.unglq a tau
  | Complex64 -> Owl_lapacke.unglq a tau
  | _         -> failwith "owl_linalg:_get_lq_q"


let lq ?(thin=true) x =
  let x = M.clone x in
  let m, n = M.shape x in
  let minmn = Pervasives.min m n in
  let a, tau = Owl_lapacke.gelqf x in
  let l = match thin with
    | true  ->
        if m < n then
          M.slice [[]; [0; minmn-1]] (M.tril a)
        else M.tril a
    | false -> M.tril a
  in
  let a = match thin with
    | true  -> a
    | false ->
        if m >= n then a
        else M.resize ~head:true n n a
  in
  let q = _get_lq_q (M.kind x) a tau in
  l, q


(* Sigular Value decomposition *)


let svd ?(thin=true) x =
  let x = M.clone x in
  let jobz = match thin with
    | true  -> 'S'
    | false -> 'A'
  in
  let u, s, vt = Owl_lapacke.gesdd ~jobz ~a:x in
  u, s, vt


let svdvals x =
  let x = M.clone x in
  let _, s, _ = Owl_lapacke.gesdd ~jobz:'N' ~a:x in
  s


let gsvd x y =
  let x = M.clone x in
  let y = M.clone y in
  let m, n = M.shape x in
  let p, _ = M.shape y in
  let u, v, q, alpha, beta, k, l, r =
    Owl_lapacke.ggsvd3 ~jobu:'U' ~jobv:'V' ~jobq:'Q' ~a:x ~b:y
  in
  let alpha = M.resize ~head:true 1 (k + l) alpha in
  let d1 = M.resize ~head:true m (k + l) (M.diagm alpha) in
  let beta = M.resize ~head:true 1 (k + l) beta in
  let beta = M.resize ~head:false 1 l beta in
  let d2 = M.resize p (k + l) (M.diagm ~k beta) in
  u, v, q, d1, d2, r


let gsvdvals x y =
  let x = M.clone x in
  let y = M.clone y in
  let _, _, _, alpha, beta, k, l, _ =
    Owl_lapacke.ggsvd3 ~jobu:'N' ~jobv:'N' ~jobq:'N' ~a:x ~b:y
  in
  let alpha = M.resize ~head:true 1 (k + l) alpha in
  let beta = M.resize ~head:true 1 (k + l) beta in
  M.(div alpha beta)


let rank ?tol x =
  let sv = svdvals x in
  let m, n = M.shape x in
  let maxmn = Pervasives.max m n in
  (* by default using float32 eps *)
  let eps = Owl_utils.eps Float32 in
  let tol = match tol with
    | Some tol -> tol
    | None     -> (float_of_int maxmn) *. eps
  in
  let dtol = tol in
  let ztol = Complex.({re = tol; im = neg_infinity}) in
  let _count : type a b. (a, b) kind -> (a, b) t -> int =
    fun _kind sv -> match _kind with
    | Float32   -> M.elt_greater_scalar sv dtol |> M.sum |> int_of_float
    | Float64   -> M.elt_greater_scalar sv dtol |> M.sum |> int_of_float
    | Complex32 ->
        let a = M.elt_greater_scalar sv ztol |> M.sum in
        int_of_float Complex.(a.re)
    | Complex64 ->
        let a = M.elt_greater_scalar sv ztol |> M.sum in
        int_of_float Complex.(a.re)
    | _         -> failwith "owl_linalg:rank"
  in
  _count (M.kind sv) sv


(* Cholesky Decomposition *)


let chol ?(upper=true) x =
  let x = M.clone x in
  match upper with
  | true  -> Owl_lapacke.potrf 'U' x |> M.triu
  | false -> Owl_lapacke.potrf 'L' x |> M.tril


let schur
  : type a b c d. otyp:(c, d) kind -> (a, b) t -> (a, b) t * (a, b) t * (c, d) t
  = fun ~otyp x ->
  let x = M.clone x in
  let t, z, wr, wi = Owl_lapacke.gees ~jobvs:'V' ~a:x in

  let w = match (M.kind x) with
    | Float32   -> M.complex float32 complex32 wr wi |> Obj.magic
    | Float64   -> M.complex float64 complex64 wr wi |> Obj.magic
    | Complex32 -> Obj.magic wr
    | Complex64 -> Obj.magic wr
    | _         -> failwith "owl_linalg_generic:schur"
  in
  t, z, w


(* Eigenvalue problem *)


let eig
  : type a b c d. ?permute:bool -> ?scale:bool -> otyp:(a, b) kind -> (c, d) t -> (a, b) t * (a, b) t
  = fun ?(permute=true) ?(scale=true) ~otyp x ->
  let x = M.clone x in
  let balanc = match permute, scale with
    | true, true   -> 'B'
    | true, false  -> 'P'
    | false, true  -> 'S'
    | false, false -> 'N'
  in
  let a, wr, wi, _, vr, _, _, _, _, _, _ =
    Owl_lapacke.geevx ~balanc ~jobvl:'N' ~jobvr:'V' ~sense:'N' ~a:x
  in

  (* TODO: optimise the performance by writing in c *)
  (* construct eigen vectors from real wr and wi *)
  let _construct_v
    : type a b. (float, a) kind -> (Complex.t, b) kind -> (float, a) t -> (float, a) t -> (float, a) t -> (Complex.t, b) t -> unit
    = fun k0 k1 wr wi vr v ->
    let _a0 = Owl_dense_common._zero (M.kind wi) in
    let _, n = M.shape v in
    let j = ref 0 in

    while !j < n do
      if wi.{0,!j} = _a0 then (
        for k = 0 to n - 1 do
          v.{k,!j} <- Complex.({re=vr.{k,!j}; im=0.})
        done
      )
      else (
        for k = 0 to n - 1 do
          v.{k,!j}   <- Complex.( {re = vr.{k,!j}; im = vr.{k,!j+1}} );
          v.{k,!j+1} <- Complex.( {re = vr.{k,!j}; im = 0. -. vr.{k,!j+1}} );
        done;
        j := !j + 1
      );
      j := !j + 1
    done;
  in

  (* process eigen vectors *)
  let m, n = M.shape vr in
  let v = match (M.kind x) with
    | Float32   -> (
        let v = M.empty complex32 m n in
        _construct_v float32 complex32 wr wi vr v;
        Obj.magic v
      )
    | Float64   -> (
        let v = M.empty complex64 m n in
        _construct_v float64 complex64 wr wi vr v;
        Obj.magic v
      )
    | Complex32 -> Obj.magic vr
    | Complex64 -> Obj.magic vr
    | _         -> failwith "owl_linalg_generic:eig"
  in
  (* process eigen values *)
  let w = match (M.kind x) with
    | Float32   -> M.complex float32 complex32 wr wi |> Obj.magic
    | Float64   -> M.complex float64 complex64 wr wi |> Obj.magic
    | Complex32 -> Obj.magic wr
    | Complex64 -> Obj.magic wr
    | _         -> failwith "owl_linalg_generic:eigvals"
  in
  v, w


let eigvals
  : type a b c d. ?permute:bool -> ?scale:bool -> otyp:(a, b) kind -> (c, d) t -> (a, b) t
  = fun ?(permute=true) ?(scale=true) ~otyp x ->
  let x = M.clone x in
  let balanc = match permute, scale with
    | true, true   -> 'B'
    | true, false  -> 'P'
    | false, true  -> 'S'
    | false, false -> 'N'
  in
  let _, wr, wi, _, _, _, _, _, _, _, _ =
    Owl_lapacke.geevx ~balanc ~jobvl:'N' ~jobvr:'N' ~sense:'N' ~a:x
  in
  let w = match (M.kind x) with
    | Float32   -> M.complex float32 complex32 wr wi |> Obj.magic
    | Float64   -> M.complex float64 complex64 wr wi |> Obj.magic
    | Complex32 -> Obj.magic wr
    | Complex64 -> Obj.magic wr
    | _         -> failwith "owl_linalg_generic:eigvals"
  in
  w


(* Hessenberg form of matrix *)


let _get_hess_q
  : type a b. (a, b) kind -> int -> int -> (a, b) t -> (a, b) t -> (a, b) t
  = fun k ilo ihi a tau ->
  match k with
  | Float32   -> Owl_lapacke.orghr ilo ihi a tau
  | Float64   -> Owl_lapacke.orghr ilo ihi a tau
  | Complex32 -> Owl_lapacke.unghr ilo ihi a tau
  | Complex64 -> Owl_lapacke.unghr ilo ihi a tau
  | _         -> failwith "owl_linalg:_get_hess_q"


let hess x =
  let x = M.clone x in
  let _, n = M.shape x in
  let ilo = 1 in
  let ihi = n in
  let a, tau = Owl_lapacke.gehrd ~ilo ~ihi ~a:x in
  let h = M.triu ~k:(-1) a in
  let q = _get_hess_q (M.kind x) ilo ihi a tau in
  h, q


(* Bunch-Kaufman [Bunch1977] factorization *)

let bkfact ?(upper=true) ?(symmetric=true) ?(rook=false) x =
  let x = M.clone x in
  let uplo = match upper with
    | true  -> 'U'
    | false -> 'L'
  in
  let a, ipiv, ret =
    match rook with
    | true  -> (
        match symmetric with
        | true  -> Owl_lapacke.sytrf_rook uplo x
        | false -> Owl_lapacke.hetrf_rook uplo x
      )
    | false -> (
        match symmetric with
        | true  -> Owl_lapacke.sytrf uplo x
        | false -> Owl_lapacke.hetrf uplo x
      )
  in
  a, ipiv


(* helper functions *)


(* Check matrix properties *)
(* TODO: need to implement in C for better performance *)

let is_triu x =
  let m, n = M.shape x in
  let k = Pervasives.min m n in
  let _a0 = Owl_dense_common._zero (M.kind x) in
  try
    for i = 0 to k - 1 do
      for j = 0 to i - 1 do
        assert (x.{i,j} = _a0)
      done
    done;
    true
  with exn -> false


let is_tril x =
  let m, n = M.shape x in
  let k = Pervasives.min m n in
  let _a0 = Owl_dense_common._zero (M.kind x) in
  try
    for i = 0 to k - 1 do
      for j = i + 1 to k - 1 do
        assert (x.{i,j} = _a0)
      done
    done;
    true
  with exn -> false


let is_symmetric x =
  let m, n = M.shape x in
  if m <> n then false
  else (
    try
      for i = 0 to n - 1 do
        for j = (i + 1) to n - 1 do
          assert (x.{j,i} = x.{i,j})
        done
      done;
      true
    with exn -> false
  )


let is_hermitian x =
  let m, n = M.shape x in
  if m <> n then false
  else (
    try
      for i = 0 to n - 1 do
        for j = i to n - 1 do
          assert (x.{j,i} = Complex.conj x.{i,j})
        done
      done;
      true
    with exn -> false
  )


let is_diag x = is_triu x && is_tril x


let is_posdef x =
  try ignore (chol x); true
  with exn -> false


let _minmax_real
  : type a b. (a, b) kind -> (a, b) t -> float * float
  = fun k v ->
    match (M.kind v) with
    | Float32   -> M.minmax v
    | Float64   -> M.minmax v
    | Complex32 -> M.re_c2s v |> M.minmax
    | Complex64 -> M.re_z2d v |> M.minmax
    | _         -> failwith "owl_linalg_generic:_minmax_real"


(* local abs function, bear with obj.magic *)
let _abs
  : type a b c. (a, b) kind -> (a, b) t -> (float, c) t
  = fun k x -> match k with
    | Float32   -> M.abs x     |> Obj.magic
    | Float64   -> M.abs x     |> Obj.magic
    | Complex32 -> M.abs_c2s x |> Obj.magic
    | Complex64 -> M.abs_z2d x |> Obj.magic
    | _         -> failwith "owl_linalg_generic:_abs"


let norm ?(p=2.) x =
  let k = M.kind x in
  if p = 1. then x |> _abs k |> M.sum_rows |> M.max
  else if p = 2. then x |> svdvals |> _minmax_real k |> snd
  else if p = infinity then x |> _abs k |> M.sum_cols |> M.max
  else failwith "owl_linalg_generic:norm:p=1|2|inf"


let cond ?(p=2.) x =
  if p = 2. then (
    let v = svdvals x in
    let minv, maxv = _minmax_real (M.kind v) v in
    if maxv = 0. then infinity else maxv /. minv
  )
  else if p = 1. || p = infinity then (
    assert (M.row_num x = M.col_num x);
    let x = M.clone x in
    let a, ipiv = lufact x in
    let anorm = norm ~p x in
    let norm = if p = 1. then '1' else 'I' in
    let rcond = Owl_lapacke.gecon norm a anorm in
    1. /. rcond
  )
  else failwith "owl_linalg_generic:cond:p=1|2|inf"


let rcond x = 1. /. (cond ~p:1. x)


(* solve linear system of equations *)


let null x =
  let eps = Owl_utils.eps (M.kind x) in
  let m, n = M.shape x in
  if m = 0 || n = 0 then M.eye (M.kind x) n
  else (
    let _, s, vt = svd ~thin:false x in
    let s = _abs (M.kind s) s in
    let maxsv = M.max s in
    let maxmn = Pervasives.max m n |> float_of_int in
    let i = M.elt_greater_scalar s (maxmn *. maxsv *. eps) |> M.sum |> int_of_float in
    let vt = M.resize ~head:false (M.row_num vt - i) (M.col_num vt) vt in
    M.transpose vt
  )


let _get_trans_code
  : type a b. (a, b) kind -> char
  = function
  | Float32   -> 'T'
  | Float64   -> 'T'
  | Complex32 -> 'C'
  | Complex64 -> 'C'
  | _         -> failwith "owl_linalg_generic:_get_trans_code"


(* TODO: add opt parameter to specify the matrix properties so that we can
  choose the best solver for better performance.
 *)
let linsolve ?(trans=false) a b =
  let ma, na = M.shape a in
  let mb, nb = M.shape b in
  assert (ma = mb);
  let a = M.clone a in
  let b = M.clone b in

  let trans = match trans with
    | true  -> _get_trans_code (M.kind a)
    | false -> 'N'
  in

  match ma = na with
  | true  -> (
      let a, ipiv = lufact a in
      let x = Owl_lapacke.getrs trans a ipiv b in
      x
    )
  | false -> (
      let _, x, _ = Owl_lapacke.gels trans a b in
      x
    )


let linreg x y =
  let nx = M.numel x in
  let ny = M.numel y in
  assert (nx = ny);

  let x = M.reshape nx 1 x in
  let y = M.reshape ny 1 y in

  let k = M.kind x in
  let b = Owl_dense_common._div_elt k (M.cov ~a:x ~b:y).{0,1} (M.var ~axis:0 x).{0,0} in
  let c = Owl_dense_common._mul_elt k b (M.average x) in
  let a = Owl_dense_common._sub_elt k (M.average y) c in
  a, b


let pinv ?tol x =
  let u, s, vt = svd x in
  (* by default using float32 eps *)
  let eps = Owl_utils.eps Float32 in
  let m, n = M.shape x in
  let a = float_of_int (Pervasives.max m n) in
  let b = _minmax_real (M.kind x) s |> snd in
  let t = match tol with
    | Some tol -> tol
    | None     -> eps *. a *. b
  in
  let tol = Owl_dense_common._float_typ_elt (M.kind x) t in
  let s' = M.(reci_tol ~tol s |> diagm) in
  let ut = M.ctranspose u in
  let v = M.ctranspose vt in
  M.(v *@ s' *@ ut)


(* helper functions *)


let peakflops ?(n=2000) () =
  let x = M.ones float64 n n |> Owl_utils.array2_to_array1 in
  let z = M.ones float64 n n |> Owl_utils.array2_to_array1 in
  let layout = Owl_cblas.CblasRowMajor in
  let transa = Owl_cblas.CblasNoTrans in
  let transb = Owl_cblas.CblasNoTrans in

  let t0 = Unix.gettimeofday () in
  Owl_cblas.dgemm layout transa transb n n n 1.0 x n x n 0.0 z n;
  let t1 = Unix.gettimeofday () in

  let flops = 2. *. (float_of_int n) ** 3. /. (t1 -. t0) in
  flops
