(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

type mat_d = Owl_dense_matrix_d.mat
type mat_z = Owl_dense_matrix_z.mat

module MD = Owl_dense_matrix_d
module MZ = Owl_dense_matrix_z

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

let inv x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.invert_LU (`M x) in
  match y with
    | `M y -> y
    | _ -> MD.empty 0 0

let det x =
  let open Gsl.Vectmat in
  Gsl.Linalg.det_LU (`M x)

let lu x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.decomp_LU (`M x) in
  match y with
    | `M a, b, c -> a, b, c
    | _, b, c -> MD.empty 0 0, b, c

let lu_solve = None


(** [ QR decomposition ]  *)

let qr x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let y = MD.clone x in
  let v = Gsl.Vector.create (min m n) in
  let _ = Gsl.Linalg._QR_decomp (`M y) (`V v) in
  let q = MD.empty m m in
  let r = MD.empty m n in
  let _ = Gsl.Linalg._QR_unpack (`M y) (`V v) (`M q) (`M r) in
  q, r

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

let _svd_decomp x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let u = MD.clone x in
  let v = MD.empty n n in
  let s = Gsl.Vector.create n in
  let w = Gsl.Vector.create n in
  let _ = Gsl.Linalg._SV_decomp (`M u) (`M v) (`V s) (`V w) in
  let s = MD.of_array (Gsl.Vector.to_array s) n 1 in
  u, s, v

let _svd_jacobi x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let u = MD.clone x in
  let v = MD.empty n n in
  let s = Gsl.Vector.create n in
  let _ = Gsl.Linalg._SV_decomp_jacobi (`M u) (`M v) (`V s) in
  let s = MD.of_array (Gsl.Vector.to_array s) n 1 in
  u, s, v

let _svd_mod x =
  let open Gsl.Vectmat in
  let m, n = MD.shape x in
  let u = MD.clone x in
  let v = MD.empty n n in
  let s = Gsl.Vector.create n in
  let w = Gsl.Vector.create n in
  let y = MD.empty n n in
  let _ = Gsl.Linalg._SV_decomp_mod (`M u) (`M y) (`M v) (`V s) (`V w) in
  let s = MD.of_array (Gsl.Vector.to_array s) n 1 in
  u, s, v

let svd x = (* v is in un-transposed form *)
  let _f =
    if MD.numel x < 10_000 then _svd_jacobi
    else if (MD.row_num x) > (3 * (MD.col_num x)) then _svd_mod
    else _svd_decomp in
    _f x


(** [ Cholesky Decomposition ]  *)

let cholesky x =
  let open Gsl.Vectmat in
  let y = MD.clone x in
  let _ = Gsl.Linalg.cho_decomp (`M y) in
  for i = 0 to (MD.row_num y) - 1 do
    for j = 0 to (MD.col_num y) - 1 do
      if i > j then y.{i,j} <- 0.
    done
  done; y

let is_posdef x =
  try ignore (cholesky x); true
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
