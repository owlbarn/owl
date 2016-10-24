(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type dsmat = Owl_dense_real.mat

module MX = Owl_dense_real

(** [ Helper functions ]  *)

let tridiag_to_vecs x =
  let m = min (MX.row_num x) (MX.col_num x) in
  let d = MX.empty 1 m in
  let e = MX.empty 1 (m - 1) in
  let f = MX.empty 1 (m - 1) in
  for i = 0 to m - 1 do
    d.{0,i} <- x.{i,i};
    if (i > 0) then e.{0,i-1} <- x.{i-1,i};
    if (i < m - 1) then f.{0,i} <- x.{i+1,i};
  done; d, e, f


let vecs_to_tridiag d e f =
  let m = MX.numel d in
  let x = MX.zeros m m in
  for i = 0 to m - 1 do
    x.{i,i} <- d.{0,i};
    if (i > 0) then x.{i-1,i} <- e.{0,i-1};
    if (i < m - 1) then x.{i+1,i} <- f.{0,i};
  done; x


(** [ LU decomposition ]  *)

let inv x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.invert_LU (`M x) in
  match y with
    | `M y -> y
    | _ -> MX.empty 0 0

let det x =
  let open Gsl.Vectmat in
  Gsl.Linalg.det_LU (`M x)

let lu x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.decomp_LU (`M x) in
  match y with
    | `M a, b, c -> a, b, c
    | _, b, c -> MX.empty 0 0, b, c

let lu_solve = None


(** [ QR decomposition ]  *)

let qr x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let y = MX.clone x in
  let v = Gsl.Vector.create (min m n) in
  let _ = Gsl.Linalg._QR_decomp (`M y) (`V v) in
  let q = MX.empty m m in
  let r = MX.empty m n in
  let _ = Gsl.Linalg._QR_unpack (`M y) (`V v) (`M q) (`M r) in
  q, r

let qr_sqsolve a b =
  let open Gsl.Vectmat in
  let c = MX.clone a in
  let b = Gsl.Vector.of_array (MX.to_array b) in
  let v = Gsl.Vector.create (MX.row_num a) in
  let x = Gsl.Vector.create (MX.row_num a) in
  let _ = Gsl.Linalg._QR_decomp (`M c) (`V v) in
  let _ = Gsl.Linalg._QR_solve (`M c) (`V v) (`V b) (`V x) in
  MX.of_array (Gsl.Vector.to_array x) (MX.row_num a) 1

let qr_lssolve a b =
  let open Gsl.Vectmat in
  let m, n = MX.shape a in
  let c = MX.clone a in
  let b = Gsl.Vector.of_array (MX.to_array b) in
  let v = Gsl.Vector.create (min m n) in
  let x = Gsl.Vector.create n in
  let r = Gsl.Vector.create m in
  let _ = Gsl.Linalg._QR_decomp (`M c) (`V v) in
  let _ = Gsl.Linalg._QR_lssolve (`M c) (`V v) (`V b) (`V x) (`V r) in
  let x = MX.of_array (Gsl.Vector.to_array x) n 1 in
  let r = MX.of_array (Gsl.Vector.to_array r) m 1 in
  x, r

let qr_solve a b =
  let m, n = MX.shape a in
  match m = n with
  | true -> qr_sqsolve a b, MX.empty 0 0
  | false -> qr_lssolve a b

let rank = None


(** [ Sigular Value decomposition ]  *)

let _svd_decomp x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let u = MX.clone x in
  let v = MX.empty n n in
  let s = Gsl.Vector.create n in
  let w = Gsl.Vector.create n in
  let _ = Gsl.Linalg._SV_decomp (`M u) (`M v) (`V s) (`V w) in
  let s = MX.of_array (Gsl.Vector.to_array s) n 1 in
  u, s, v

let _svd_jacobi x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let u = MX.clone x in
  let v = MX.empty n n in
  let s = Gsl.Vector.create n in
  let _ = Gsl.Linalg._SV_decomp_jacobi (`M u) (`M v) (`V s) in
  let s = MX.of_array (Gsl.Vector.to_array s) n 1 in
  u, s, v

let _svd_mod x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let u = MX.clone x in
  let v = MX.empty n n in
  let s = Gsl.Vector.create n in
  let w = Gsl.Vector.create n in
  let y = MX.empty n n in
  let _ = Gsl.Linalg._SV_decomp_mod (`M u) (`M y) (`M v) (`V s) (`V w) in
  let s = MX.of_array (Gsl.Vector.to_array s) n 1 in
  u, s, v

let svd x = (* v is in un-transposed form *)
  let _f =
    if MX.numel x < 10_000 then _svd_jacobi
    else if (MX.row_num x) > (3 * (MX.col_num x)) then _svd_mod
    else _svd_decomp in
    _f x


(** [ Cholesky Decomposition ]  *)

let cholesky x =
  let open Gsl.Vectmat in
  let y = MX.clone x in
  let _ = Gsl.Linalg.cho_decomp (`M y) in
  for i = 0 to (MX.row_num y) - 1 do
    for j = 0 to (MX.col_num y) - 1 do
      if i > j then y.{i,j} <- 0.
    done
  done; y

let is_posdef x =
  try ignore (cholesky x); true
  with exn -> false


(** [ Symmetric tridiagonal decomposition ]  *)

let _symmtd x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let q = MX.clone x in
  let t = Gsl.Vector.create (m - 1) in
  let _ = Gsl.Linalg.symmtd_decomp (`M q) (`V t) in
  q, t

let symmtd x =
  let m, n = MX.shape x in
  let p, r = _symmtd x in
  let q = MX.empty m m in
  let u = Gsl.Vector.create m in
  let v = Gsl.Vector.create (m - 1) in
  let _ = Gsl.Linalg.symmtd_unpack (`M p) (`V r) (`M q) (`V u) (`V v) in
  let u = MX.of_array (Gsl.Vector.to_array u) m 1 in
  let v = MX.of_array (Gsl.Vector.to_array v) (m - 1) 1 in
  q, u, v


(** [ Bidiagonalization ]  *)

let _bidiag x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let u = MX.clone x in
  let tu = Gsl.Vector.create (min m n) in
  let tv = Gsl.Vector.create ((min m n) - 1) in
  let _ = Gsl.Linalg.bidiag_decomp (`M u) (`V tu) (`V tv) in
  u, tu, tv

let bidiag x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let u, tu, tv = _bidiag x in
  let v = MX.empty n n in
  let _ = Gsl.Linalg.bidiag_unpack2 (`M u) (`V tu) (`V tv) (`M v) in
  let d0 = MX.of_array (Gsl.Vector.to_array tu) (min m n) 1 in
  let d1 = MX.of_array (Gsl.Vector.to_array tv) ((min m n) - 1) 1 in
  u, v, d0, d1


(** [  Tridiagonal Systems ]  *)

let tridiag_solve a b =
  let open Gsl.Vectmat in
  let m, n = MX.shape a in
  let d, e, f = tridiag_to_vecs a in
  let d = Gsl.Vector.of_array (MX.to_array d) in
  let e = Gsl.Vector.of_array (MX.to_array e) in
  let f = Gsl.Vector.of_array (MX.to_array f) in
  let b = Gsl.Vector.of_array (MX.to_array b) in
  let x = Gsl.Vector.create n in
  let _ = Gsl.Linalg.solve_tridiag (`V d) (`V e) (`V f) (`V b) (`V x) in
  MX.of_array (Gsl.Vector.to_array x) 1 m

let symm_tridiag_solve a b =
  let open Gsl.Vectmat in
  let m, n = MX.shape a in
  let d, e, _ = tridiag_to_vecs a in
  let d = Gsl.Vector.of_array (MX.to_array d) in
  let e = Gsl.Vector.of_array (MX.to_array e) in
  let b = Gsl.Vector.of_array (MX.to_array b) in
  let x = Gsl.Vector.create n in
  let _ = Gsl.Linalg.solve_symm_tridiag (`V d) (`V e) (`V b) (`V x) in
  MX.of_array (Gsl.Vector.to_array x) 1 m

let cyc_tridiag_solve x = None

let symm_cyc_tridiag_solve x = None





(* ends here *)
