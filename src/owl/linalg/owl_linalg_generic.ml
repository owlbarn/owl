(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

type ('a, 'b) t = ('a, 'b) Owl_dense_matrix_generic.t


(*
We create a local generic matrix module with basic operators. This is only
way to let us use operators to write concise math but avoid circular dependency
at the same time.
*)
module M = struct

  include Owl_dense_matrix_generic
  include Owl_operator.Make_Basic (Owl_dense_matrix_generic)
  include Owl_operator.Make_Extend (Owl_dense_matrix_generic)
  include Owl_operator.Make_Matrix (Owl_dense_matrix_generic)

end


(* LU decomposition *)

let lu x =
  let x = M.copy x in
  let m, n = M.shape x in
  let minmn = Pervasives.min m n in

  let a, ipiv = Owl_lapacke.getrf x in
  let l = M.tril a in
  let u = M.resize (M.triu a) [|n; n|] in

  let _a1 = Owl_const.one (M.kind x) in
  for i = 0 to minmn - 1 do
    M.set l i i _a1
  done;

  l, u, ipiv


let lufact x =
  let a, ipiv = Owl_lapacke.getrf x in
  a, ipiv


(* basic functions *)

let inv x =
  let x = M.copy x in
  let a, ipiv = Owl_lapacke.getrf x in
  Owl_lapacke.getri a ipiv


let det x =
  let x = M.copy x in
  let m, n = M.shape x in
  assert (m = n);

  let a, ipiv = Owl_lapacke.getrf x in
  let d = ref (Owl_const.one (M.kind x)) in
  let c = ref 0 in

  let _mul_op = Owl_dense_common._mul_elt (M.kind x) in
  for i = 0 to m - 1 do
    d := _mul_op !d (M.get a i i);
    (* NOTE: +1 to adjust to Fortran index *)
    if (M.get ipiv 0 i) <> Int32.of_int (i + 1) then
      c := !c + 1
  done;

  match Owl_maths.is_odd !c with
  | true  -> Owl_dense_common._neg_elt (M.kind x) !d
  | false -> !d


(* FIXME: need to check ... *)
let logdet x =
  let x = M.copy x in
  let m, n = M.shape x in
  assert (m = n);

  let _kind = M.kind x in
  let a, ipiv = Owl_lapacke.getrf x in
  let d = ref (Owl_const.zero _kind) in
  let c = ref 0 in

  let _add_op = Owl_dense_common._add_elt _kind in
  let _log_op = Owl_dense_common._log_elt _kind in
  let _neg_op = Owl_dense_common._neg_elt _kind in

  for i = 0 to m - 1 do
    d := _add_op !d (_log_op (M.get a i i));
    (* NOTE: +1 to adjust to Fortran index *)
    if (M.get ipiv 0 i) <> Int32.of_int (i + 1) then
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
  let x = M.copy x in
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
    | true  -> M.resize ~head:true (M.triu a) [|minmn; n|]
    | false -> M.resize ~head:true (M.triu a) [|m; n|]
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
  let x = M.copy x in
  let m, n = M.shape x in
  let minmn = Pervasives.min m n in
  let a, tau = Owl_lapacke.gelqf x in
  let l = match thin with
    | true  ->
        if m < n then
          M.get_slice [[]; [0; minmn-1]] (M.tril a)
        else M.tril a
    | false -> M.tril a
  in
  let a = match thin with
    | true  -> a
    | false ->
        if m >= n then a
        else M.resize ~head:true a [|n; n|]
  in
  let q = _get_lq_q (M.kind x) a tau in
  l, q


(* Sigular Value decomposition *)


let svd ?(thin=true) x =
  let x = M.copy x in
  let jobz = match thin with
    | true  -> 'S'
    | false -> 'A'
  in
  let u, s, vt = Owl_lapacke.gesdd ~jobz ~a:x in
  u, s, vt


let svdvals x =
  let x = M.copy x in
  let _, s, _ = Owl_lapacke.gesdd ~jobz:'N' ~a:x in
  s


let gsvd x y =
  let x = M.copy x in
  let y = M.copy y in
  let m, n = M.shape x in
  let p, _ = M.shape y in
  let u, v, q, alpha, beta, k, l, r =
    Owl_lapacke.ggsvd3 ~jobu:'U' ~jobv:'V' ~jobq:'Q' ~a:x ~b:y
  in
  let alpha = M.resize ~head:true alpha [|1; (k + l)|] in
  let d1 = M.resize ~head:true (M.diagm alpha) [|m; k + l|] in
  let beta = M.resize ~head:true beta [|1; k + l|] in
  let beta = M.resize ~head:false beta [|1; l|] in
  let d2 = M.resize (M.diagm ~k beta) [|p; k + l|] in
  u, v, q, d1, d2, r


let gsvdvals x y =
  let x = M.copy x in
  let y = M.copy y in
  let _, _, _, alpha, beta, k, l, _ =
    Owl_lapacke.ggsvd3 ~jobu:'N' ~jobv:'N' ~jobq:'N' ~a:x ~b:y
  in
  let alpha = M.resize ~head:true alpha [|1; k + l|] in
  let beta = M.resize ~head:true beta [|1; k + l|] in
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
    | Float32   -> M.elt_greater_scalar sv dtol |> M.sum' |> int_of_float
    | Float64   -> M.elt_greater_scalar sv dtol |> M.sum' |> int_of_float
    | Complex32 ->
        let a = M.elt_greater_scalar sv ztol |> M.sum' in
        int_of_float Complex.(a.re)
    | Complex64 ->
        let a = M.elt_greater_scalar sv ztol |> M.sum' in
        int_of_float Complex.(a.re)
    | _         -> failwith "owl_linalg:rank"
  in
  _count (M.kind sv) sv


(* Cholesky Decomposition *)


let chol ?(upper=true) x =
  let x = M.copy x in
  match upper with
  | true  -> Owl_lapacke.potrf 'U' x |> M.triu
  | false -> Owl_lapacke.potrf 'L' x |> M.tril


let schur
  : type a b c d. otyp:(c, d) kind -> (a, b) t -> (a, b) t * (a, b) t * (c, d) t
  = fun ~otyp x ->
  let x = M.copy x in
  let t, z, wr, wi = Owl_lapacke.gees ~jobvs:'V' ~a:x in

  let w = match (M.kind x) with
    | Float32   -> M.complex float32 complex32 wr wi |> Obj.magic
    | Float64   -> M.complex float64 complex64 wr wi |> Obj.magic
    | Complex32 -> Obj.magic wr
    | Complex64 -> Obj.magic wr
    | _         -> failwith "owl_linalg_generic:schur"
  in
  t, z, w


let schur_tz x =
  let x = M.copy x in
  let t, z, _, _ = Owl_lapacke.gees ~jobvs:'V' ~a:x in
  t, z


let ordschur ~select t z =
  let t = M.copy t in
  let q = M.copy z in
  M.iter (fun a -> assert (a = 0l || a = 1l)) select;
  let ts, zs, _, _ = Owl_lapacke.trsen ~job:'V' ~compq:'N' ~select ~t ~q in
  ts, zs


(* Eigenvalue problem *)


let eig
  : type a b c d. ?permute:bool -> ?scale:bool -> otyp:(a, b) kind -> (c, d) t -> (a, b) t * (a, b) t
  = fun ?(permute=true) ?(scale=true) ~otyp x ->
  let x = M.copy x in
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
    let _a0 = Owl_const.zero (M.kind wi) in
    let _, n = M.shape v in
    let j = ref 0 in

    while !j < n do
      if (M.get wi 0 !j) = _a0 then (
        for k = 0 to n - 1 do
          M.set v k !j Complex.({re = M.get vr k !j; im = 0.})
        done
      )
      else (
        for k = 0 to n - 1 do
          M.set v k !j Complex.( {re = M.get vr k !j; im = M.get vr k (!j+1)} );
          M.set v k (!j+1) Complex.( {re = M.get vr k !j; im = 0. -. (M.get vr k (!j+1))} );
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
  let x = M.copy x in
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
  let x = M.copy x in
  let _, n = M.shape x in
  let ilo = 1 in
  let ihi = n in
  let a, tau = Owl_lapacke.gehrd ~ilo ~ihi ~a:x in
  let h = M.triu ~k:(-1) a in
  let q = _get_hess_q (M.kind x) ilo ihi a tau in
  h, q


(* Bunch-Kaufman [Bunch1977] factorization *)

let bkfact ?(upper=true) ?(symmetric=true) ?(rook=false) x =
  let x = M.copy x in
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


(* Check matrix properties *)

let is_square x =
  let m, n = M.shape x in
  m = n


let is_triu x = Owl_core._matrix_is_triu (M.kind x) x


let is_tril x = Owl_core._matrix_is_tril (M.kind x) x


let is_symmetric x = Owl_core._matrix_is_symmetric (M.kind x) x


let is_hermitian x = Owl_core._matrix_is_hermitian (M.kind x) x


let is_diag x = Owl_core._matrix_is_diag (M.kind x) x


let is_posdef x =
  try ignore (chol x); true
  with exn -> false


let _minmax_real
  : type a b. (a, b) kind -> (a, b) t -> float * float
  = fun k v ->
    match (M.kind v) with
    | Float32   -> M.minmax' v
    | Float64   -> M.minmax' v
    | Complex32 -> M.re_c2s v |> M.minmax'
    | Complex64 -> M.re_z2d v |> M.minmax'
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
  if p = 1. then x |> _abs k |> M.sum_rows |> M.max'
  else if p = -1. then x |> _abs k |> M.sum_rows |> M.min'
  else if p = 2. then x |> svdvals |> _minmax_real k |> snd
  else if p = -2. then x |> svdvals |> _minmax_real k |> fst
  else if p = infinity then x |> _abs k |> M.sum_cols |> M.max'
  else if p = neg_infinity then x |> _abs k |> M.sum_cols |> M.min'
  else failwith "owl_linalg_generic:norm:p=±1|±2|±inf"


let vecnorm ?(p=2.) x =
  let k = M.kind x in
  if p = 1. then
    M.l1norm' x |> Owl_dense_common._re_elt k
  else if p = 2. then
    M.l2norm' x |> Owl_dense_common._re_elt k
  else (
    let v = M.flatten x |> M.abs in
    if p = infinity then
      M.max' v |> Owl_dense_common._re_elt k
    else if p = neg_infinity then
      M.min' v |> Owl_dense_common._re_elt k
    else (
      M.pow_scalar_ v (Owl_dense_common._float_typ_elt k p);
      let a = M.sum' v |> Owl_dense_common._re_elt k in
      a ** (1. /. p)
    )
  )


let cond ?(p=2.) x =
  if p = 2. then (
    let v = svdvals x in
    let minv, maxv = _minmax_real (M.kind v) v in
    if maxv = 0. then infinity else maxv /. minv
  )
  else if p = 1. || p = infinity then (
    assert (M.row_num x = M.col_num x);
    let x = M.copy x in
    let a, ipiv = lufact x in
    let anorm = norm ~p x in
    let _norm = if p = 1. then '1' else 'I' in
    let rcond = Owl_lapacke.gecon _norm a anorm in
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
    let maxsv = M.max' s in
    let maxmn = Pervasives.max m n |> float_of_int in
    let i = M.elt_greater_scalar s (maxmn *. maxsv *. eps) |> M.sum' |> int_of_float in
    let vt = M.resize ~head:false vt [|M.row_num vt - i; M.col_num vt|] in
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
  let a = M.copy a in
  let b = M.copy b in

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

  let x = M.reshape x [|nx; 1|] in
  let y = M.reshape y [|ny; 1|] in

  let k = M.kind x in
  let p = M.get (M.cov ~a:x ~b:y) 0 1 in
  let q = M.get (M.var ~axis:0 x) 0 0 in
  let b = Owl_dense_common._div_elt k p q in
  let c = Owl_dense_common._mul_elt k b (M.mean' x) in
  let a = Owl_dense_common._sub_elt k (M.mean' y) c in
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


let sylvester a b c =
  let ra, qa = schur_tz a in
  let rb, qb = schur_tz b in
  let d = M.((ctranspose qa) *@ (c *@ qb)) in
  let y, s = Owl_lapacke.trsyl 'N' 'N' 1 ra rb d in
  let z = M.(qa *@ (y *@ (ctranspose qb))) in
  M.mul_scalar_ z (Owl_dense_common._float_typ_elt (M.kind c) (1. /. s));
  z


let lyapunov a c =
  let r, q = schur_tz a in
  let d = M.((ctranspose q) *@ (c *@ q)) in
  let tb = _get_trans_code (M.kind c) in
  let y, s = Owl_lapacke.trsyl 'N' tb 1 r r d in
  let z = M.(q *@ (y *@ (ctranspose q))) in
  M.mul_scalar_ z (Owl_dense_common._float_typ_elt (M.kind c) (1. /. s));
  z


let care a b q r =
  let g = M.(b *@ (inv r) *@ (transpose b)) in
  let z = M.((a @|| (neg g)) @= ((neg q) @|| (transpose a |> neg))) in

  let t, u, wr, _ = Owl_lapacke.gees ~jobvs:'V' ~a:z in
  let select = M.(zeros Int32 (row_num wr) (col_num wr)) in
  M.iteri_2d (fun i j re -> if re < 0. then M.set select i j 1l) wr;
  ignore (Owl_lapacke.trsen ~job:'V' ~compq:'N' ~select ~t ~q:u);

  let m, n = M.shape u in
  let u0 = M.get_slice [[0; m / 2 - 1]; [0; n / 2 - 1]] u in
  let u1 = M.get_slice [[m / 2; m - 1]; [0; n / 2 - 1]] u in
  M.((inv u0) *@ u1)


let dare a b q r =
  let g = M.(b *@ (inv r) *@ (transpose b)) in
  let c = M.(transpose (inv a)) in
  let z = M.(concat_vh [| [| a + g *@ c *@ q; (neg g) *@ c |];
                          [| (neg c) *@ q   ; c            |] |]) in

  let t, u, wr, wi = Owl_lapacke.gees ~jobvs:'V' ~a:z in
  let select = M.(zeros Int32 (row_num wr) (col_num wr)) in
  M.iteri_2d (fun i j re ->
    let im = M.get wi i j in
    let x = Complex.(norm {re; im}) in
    if x <= 1. then M.set select i j 1l
  ) wr;
  ignore (Owl_lapacke.trsen ~job:'V' ~compq:'N' ~select ~t ~q:u);

  let m, n = M.shape u in
  let u0 = M.get_slice [[0; m / 2 - 1]; [0; n / 2 - 1]] u in
  let u1 = M.get_slice [[m / 2; m - 1]; [0; n / 2 - 1]] u in
  M.(u1 *@ (inv u0))


(* helper functions *)


let peakflops ?(n=2000) () =
  let x = M.ones float64 n n |> M.flatten |> array1_of_genarray in
  let z = M.ones float64 n n |> M.flatten |> array1_of_genarray in
  let layout = Owl_cblas.CblasRowMajor in
  let transa = Owl_cblas.CblasNoTrans in
  let transb = Owl_cblas.CblasNoTrans in

  let t0 = Unix.gettimeofday () in
  Owl_cblas.gemm layout transa transb n n n 1.0 x n x n 0.0 z n;
  let t1 = Unix.gettimeofday () in

  let flops = 2. *. (float_of_int n) ** 3. /. (t1 -. t0) in
  flops


(* Matrix functions *)

(* DEBUG: initial expm implemented with eig, obsoleted *)
let expm_eig
  : type a b c d. otyp:(c, d) kind -> (a, b) t -> (c, d) t
  = fun ~otyp x ->
  Owl_exception.(check (is_square x) NOT_SQUARE);
  let v, w = eig ~otyp x in
  let vi = inv v in
  let u = M.(exp w |> diagm) in
  M.( dot (dot v u) vi )


let expm x =
  Owl_exception.(check (is_square x) NOT_SQUARE);
  (* trivial case *)
  if M.shape x = (1, 1) then M.exp x
  else (
    (* TODO: use gebal to balance to improve accuracy, refer to Julia's impl *)
    let xe = M.(eye (kind x) (row_num x)) in
    let norm_x = norm ~p:1. x in
    (* for small norm, use lower order Padé-approximation *)
    if norm_x <= 2.097847961257068 then (
      let c = Array.map (Owl_dense_common._float_typ_elt (M.kind x)) (
        if norm_x > 0.9504178996162932 then
          [|17643225600.; 8821612800.; 2075673600.; 302702400.; 30270240.; 2162160.; 110880.; 3960.; 90.; 1.|]
        else if norm_x > 0.2539398330063230 then
          [|17297280.; 8648640.; 1995840.; 277200.; 25200.; 1512.; 56.; 1.|]
        else if norm_x > 0.01495585217958292 then
          [|30240.; 15120.; 3360.; 420.; 30.; 1.|]
        else
          [|120.; 60.; 12.; 1.|]
      ) in

      let x2 = M.dot x x in
      let p = ref M.(copy xe) in
      let u = M.mul_scalar !p c.(1) in
      let v = M.mul_scalar !p c.(0) in

      for i = 1 to Array.(length c / 2 - 1) do
        let j = 2 * i in
        let k = j + 1 in
        p := M.dot !p x2;
        M.(add_ u (mul_scalar !p c.(k)));
        M.(add_ v (mul_scalar !p c.(j)));
      done;

      let u = M.dot x u in
      let a = M.sub v u in
      let b = M.add v u in
      Owl_lapacke.gesv a b |> ignore;
      b
    )
    (* for larger norm, Padé-13 approximation *)
    else (
      let s = Owl_maths.log2 (norm_x /. 5.4) in
      let t = ceil s in
      let x =
        if s > 0. then
          Owl_dense_common._float_typ_elt (M.kind x) (2. ** t)
          |> M.div_scalar x
        else x
      in

      let c = Array.map (Owl_dense_common._float_typ_elt (M.kind x))
        [|64764752532480000.; 32382376266240000.; 7771770303897600.;
          1187353796428800.;  129060195264000.;   10559470521600.;
          670442572800.;      33522128640.;       1323241920.;
          40840800.;          960960.;            16380.;
          182.;               1.|]
      in

      let x2 = M.dot x x in
      let x4 = M.dot x2 x2 in
      let x6 = M.dot x2 x4 in
      let u = M.( x *@ (x6 *@ (x6 *$ c.(13) + x4 *$ c.(11) + x2 *$ c.(9)) +
                  x6 *$ c.(7) + x4 *$ c.(5) + x2 *$ c.(3) + xe *$ c.(1)) ) in
      let v = M.( x6 *@ (x6 *$ c.(12) + x4 *$ c.(10) + x2 *$ c.(8)) +
                  x6 *$ c.(6) + x4 *$ c.(4) + x2 *$ c.(2) + xe *$ c.(0) ) in

      let a = M.sub v u in
      let b = M.add v u in
      Owl_lapacke.gesv a b |> ignore;

      let x = ref b in
      if s > 0. then (
        for i = 1 to int_of_float t do
          x := M.dot !x !x
        done;
      );

      !x
    )
  )


let _sinm :
  type a b. (a, b) kind -> (a, b) t -> (a, b) t
  = fun k x ->
  match k with
  | Float32   -> (
      let a = Complex.({re=0.; im=1.}) in
      let x = M.cast_s2c x in
      M.(expm (a $* x) |> im_c2s)
    )
  | Float64   -> (
      let a = Complex.({re=0.; im=1.}) in
      let x = M.cast_d2z x in
      M.(expm (a $* x) |> im_z2d)
    )
  | Complex32 -> (
      let a = Complex.({re=0.; im=(-0.5)}) in
      let b = Complex.({re=0.; im=1.}) in
      let c = Complex.({re=0.; im=(-1.)}) in
      M.(a $* (expm (b $* x) - expm (c $* x)))
    )
  | Complex64 -> (
      let a = Complex.({re=0.; im=(-0.5)}) in
      let b = Complex.({re=0.; im=1.}) in
      let c = Complex.({re=0.; im=(-1.)}) in
      M.(a $* (expm (b $* x) - expm (c $* x)))
    )
  | _        -> failwith "_sinm: unsupported operation"


let sinm x = _sinm (M.kind x) x


let _cosm :
  type a b. (a, b) kind -> (a, b) t -> (a, b) t
  = fun k x ->
  match k with
  | Float32   -> (
      let a = Complex.({re=0.; im=1.}) in
      let x = M.cast_s2c x in
      M.(expm (a $* x) |> re_c2s)
    )
  | Float64   -> (
      let a = Complex.({re=0.; im=1.}) in
      let x = M.cast_d2z x in
      M.(expm (a $* x) |> re_z2d)
    )
  | Complex32 -> (
      let a = Complex.({re=0.5; im=0.}) in
      let b = Complex.({re=0.; im=1.}) in
      let c = Complex.({re=0.; im=(-1.)}) in
      M.(a $* (expm (b $* x) + expm (c $* x)))
    )
  | Complex64 -> (
      let a = Complex.({re=0.5; im=0.}) in
      let b = Complex.({re=0.; im=1.}) in
      let c = Complex.({re=0.; im=(-1.)}) in
      M.(a $* (expm (b $* x) + expm (c $* x)))
    )
  | _        -> failwith "_cosm: unsupported operation"


let cosm x = _cosm (M.kind x) x


let _sincosm :
  type a b. (a, b) kind -> (a, b) t -> (a, b) t * (a, b) t
  = fun k x ->
  match k with
  | Float32   -> (
      let a = Complex.({re=0.; im=1.}) in
      let x = M.cast_s2c x in
      let y = M.(expm (a $* x)) in
      M.(im_c2s y, re_c2s y)
    )
  | Float64   -> (
      let a = Complex.({re=0.; im=1.}) in
      let x = M.cast_d2z x in
      let y = M.(expm (a $* x)) in
      M.(im_z2d y, re_z2d y)
    )
  | Complex32 -> (
      let b = Complex.({re=0.; im=1.}) in
      let c = Complex.({re=0.; im=(-1.)}) in
      let x = M.(expm (b $* x)) in
      let y = M.(expm (c $* x)) in
      let _sin = M.( Complex.({re=0.; im=(-0.5)}) $* (x - y) ) in
      let _cos = M.( Complex.({re=0.5; im=0.}) $* (x + y)) in
      _sin, _cos
    )
  | Complex64 -> (
      let b = Complex.({re=0.; im=1.}) in
      let c = Complex.({re=0.; im=(-1.)}) in
      let x = M.(expm (b $* x)) in
      let y = M.(expm (c $* x)) in
      let _sin = M.( Complex.({re=0.; im=(-0.5)}) $* (x - y) ) in
      let _cos = M.( Complex.({re=0.5; im=0.}) $* (x + y)) in
      _sin, _cos
    )
  | _        -> failwith "_sincosm: unsupported operation"


let sincosm x = _sincosm (M.kind x) x


let tanm x =
  let s, c = sincosm x in
  Owl_lapacke.gesv c s |> ignore;
  s


let sinhm x =
  let a = Owl_dense_common._float_typ_elt (M.kind x) 0.5 in
  M.( a $* ((expm x) - (expm (neg x))) )


let coshm x =
  let a = Owl_dense_common._float_typ_elt (M.kind x) 0.5 in
  M.( a $* ((expm x) + (expm (neg x))) )


let sinhcoshm x =
  let a = Owl_dense_common._float_typ_elt (M.kind x) 0.5 in
  let b = expm x in
  let c = expm (M.neg x) in
  M.(a $* (b - c)), M.(a $* (b + c))


let tanhm x =
  let s, c = sinhcoshm x in
  Owl_lapacke.gesv c s |> ignore;
  s


(* TODO *)
let logm x = "logm: not implemented"


(* TODO *)
let sqrtm x = failwith "sqrtm: not implemented"


(* ends here *)
