(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type mat_d = Owl_dense.Matrix.D.mat
type mat_z = Owl_dense.Matrix.Z.mat
type ('a, 'b) t = ('a, 'b) Owl_dense.Matrix.Generic.t

module MD = Owl_dense_matrix_d
module MZ = Owl_dense_matrix_z

module M = Owl_dense.Matrix.Generic


(** [ Helper functions ]  *)

let tridiag_to_vecs x =
  let m = min (MD.row_num x) (MD.col_num x) in
  let d = MD.empty 1 m in
  let e = MD.empty 1 (m - 1) in
  let f = MD.empty 1 (m - 1) in
  for i = 0 to m - 1 do
    d.{0,i} <- x.{i,i};
    if (i > 0) then e.{0,i-1} <- x.{i-1,i};
    if (i < m - 1) then f.{0,i} <- x.{i+1,i};
  done; d, e, f


let vecs_to_tridiag d e f =
  let m = MD.numel d in
  let x = MD.zeros m m in
  for i = 0 to m - 1 do
    x.{i,i} <- d.{0,i};
    if (i > 0) then x.{i-1,i} <- e.{0,i-1};
    if (i < m - 1) then x.{i+1,i} <- f.{0,i};
  done; x


(** [ LU decomposition ]  *)


let lu ?(pivot=true) x =
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


(** [ QR decomposition ]  *)


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


let qrfact x = None


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


let qr_sqsolve a b =
  let open Gsl.Vectmat in
  let c = MD.clone a in
  let b = Gsl.Vector.of_array (MD.to_array b) in
  let v = Gsl.Vector.create (MD.row_num a) in
  let x = Gsl.Vector.create (MD.row_num a) in
  let _ = Gsl.Linalg._QR_decomp (`M c) (`V v) in
  let _ = Gsl.Linalg._QR_solve (`M c) (`V v) (`V b) (`V x) in
  MD.of_array (Gsl.Vector.to_array x) (MD.row_num a) 1

let qr_lssolve a b =
  let open Gsl.Vectmat in
  let m, n = MD.shape a in
  let c = MD.clone a in
  let b = Gsl.Vector.of_array (MD.to_array b) in
  let v = Gsl.Vector.create (min m n) in
  let x = Gsl.Vector.create n in
  let r = Gsl.Vector.create m in
  let _ = Gsl.Linalg._QR_decomp (`M c) (`V v) in
  let _ = Gsl.Linalg._QR_lssolve (`M c) (`V v) (`V b) (`V x) (`V r) in
  let x = MD.of_array (Gsl.Vector.to_array x) n 1 in
  let r = MD.of_array (Gsl.Vector.to_array r) m 1 in
  x, r

let qr_solve a b =
  let m, n = MD.shape a in
  match m = n with
  | true -> qr_sqsolve a b, MD.empty 0 0
  | false -> qr_lssolve a b

let rank = None


(** [ Sigular Value decomposition ]  *)

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
  let eps = 1e-10 in
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
        int_of_float a.re
    | Complex64 ->
        let a = M.elt_greater_scalar sv ztol |> M.sum in
        int_of_float a.re
    | _         -> failwith "owl_linalg:rank"
  in
  _count (M.kind sv) sv


(** [ Cholesky Decomposition ]  *)


let chol ?(upper=true) x =
  let x = M.clone x in
  match upper with
  | true  -> Owl_lapacke.potrf 'U' x |> M.triu
  | false -> Owl_lapacke.potrf 'L' x |> M.tril


let is_posdef x =
  try ignore (chol x); true
  with exn -> false


(** [ Symmetric tridiagonal decomposition ]  *)

let _symmtd x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let q = MD.clone x in
  let t = Gsl.Vector.create (m - 1) in
  let _ = Gsl.Linalg.symmtd_decomp (`M q) (`V t) in
  q, t

let symmtd x =
  let m, n = MD.shape x in
  let p, r = _symmtd x in
  let q = MD.empty m m in
  let u = Gsl.Vector.create m in
  let v = Gsl.Vector.create (m - 1) in
  let _ = Gsl.Linalg.symmtd_unpack (`M p) (`V r) (`M q) (`V u) (`V v) in
  let u = MD.of_array (Gsl.Vector.to_array u) m 1 in
  let v = MD.of_array (Gsl.Vector.to_array v) (m - 1) 1 in
  q, u, v


(** [ Bidiagonalization ]  *)

let _bidiag x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let u = MD.clone x in
  let tu = Gsl.Vector.create (min m n) in
  let tv = Gsl.Vector.create ((min m n) - 1) in
  let _ = Gsl.Linalg.bidiag_decomp (`M u) (`V tu) (`V tv) in
  u, tu, tv

let bidiag x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let u, tu, tv = _bidiag x in
  let v = MD.empty n n in
  let _ = Gsl.Linalg.bidiag_unpack2 (`M u) (`V tu) (`V tv) (`M v) in
  let d0 = MD.of_array (Gsl.Vector.to_array tu) (min m n) 1 in
  let d1 = MD.of_array (Gsl.Vector.to_array tv) ((min m n) - 1) 1 in
  u, v, d0, d1


(** [  Tridiagonal Systems ]  *)

let tridiag_solve a b =
  let open Gsl.Vectmat in
  let m, n = MD.shape a in
  let d, e, f = tridiag_to_vecs a in
  let d = Gsl.Vector.of_array (MD.to_array d) in
  let e = Gsl.Vector.of_array (MD.to_array e) in
  let f = Gsl.Vector.of_array (MD.to_array f) in
  let b = Gsl.Vector.of_array (MD.to_array b) in
  let x = Gsl.Vector.create n in
  let _ = Gsl.Linalg.solve_tridiag (`V d) (`V e) (`V f) (`V b) (`V x) in
  MD.of_array (Gsl.Vector.to_array x) 1 m

let symm_tridiag_solve a b =
  let open Gsl.Vectmat in
  let m, n = MD.shape a in
  let d, e, _ = tridiag_to_vecs a in
  let d = Gsl.Vector.of_array (MD.to_array d) in
  let e = Gsl.Vector.of_array (MD.to_array e) in
  let b = Gsl.Vector.of_array (MD.to_array b) in
  let x = Gsl.Vector.create n in
  let _ = Gsl.Linalg.solve_symm_tridiag (`V d) (`V e) (`V b) (`V x) in
  MD.of_array (Gsl.Vector.to_array x) 1 m

let cyc_tridiag_solve x = None

let symm_cyc_tridiag_solve x = None


(* Eigenvalues & Eigenvectors *)

let eigen_symm x =
  let m, n = MD.shape x in
  let y = MD.clone x in
  let v = Gsl.Eigen.symm (`M y) in
  let v = MD.of_array (Gsl.Vector.to_array v) 1 m in
  v

let eigen_symmv x =
  let m, n = MD.shape x in
  let y = MD.clone x in
  let v, z = Gsl.Eigen.symmv (`M y) in
  let v = MD.of_array (Gsl.Vector.to_array v) 1 m in
  v, z

let eigen_nonsymm x =
  let m, n = MD.shape x in
  let y = MD.clone x in
  let v = Gsl.Eigen.nonsymm (`M y) in
  let v = MZ.of_array (Gsl.Vector_complex.to_array v) 1 m in
  v

let eigen_nonsymmv x =
  let m, n = MD.shape x in
  let y = MD.clone x in
  let v, z = Gsl.Eigen.nonsymmv (`M y) in
  let v = MZ.of_array (Gsl.Vector_complex.to_array v) 1 m in
  v, z

let eigen_herm x =
  let m, n = MZ.shape x in
  let y = MZ.clone x in
  let v = Gsl.Eigen.herm (`CM y) in
  let v = MD.of_array (Gsl.Vector.to_array v) 1 m in
  v

let eigen_hermv x =
  let m, n = MZ.shape x in
  let y = MZ.clone x in
  let v, z = Gsl.Eigen.hermv (`CM y) in
  let v = MD.of_array (Gsl.Vector.to_array v) 1 m in
  v, z


(* ends here *)
