#!/usr/bin/env owl
(* This example shows how to use linear algebra module in Owl. *)

open Owl

(* LQ factorisation *)
let lq_fact x =
  let l, q = Linalg.D.lq x in
  Mat.(l *@ q - x |> print)

(* QR factorisation *)
let qr_fact x =
  let q, r, _ = Linalg.D.qr x in
  Mat.(q *@ r - x |> print)

(* LU factorisation *)
let lu_fact x =
  let l, u, a = Linalg.D.lu x in
  (* TODO: permutation *)
  Mat.(l *@ u)

(* SVD factorisation *)
let svd_fact x =
  let u, s, v = Linalg.D.svd x in
  let s = Mat.diagm s in
  Mat.(u *@ s *@ v - x |> print)

(* inverse a matrix *)
let inv_mat x =
  let y = Linalg.D.inv x in
  Mat.(x *@ y |> print)

(* pseudo inversion *)
let pinv_mat x =
  let y = Linalg.D.pinv x in
  Mat.(x *@ y |> print)

(* rank of a matrix *)
let rank_mat x =
  let r = Linalg.D.rank x in
  Printf.printf "\nrank of x is %i\n" r

(* determinant of a matrix *)
let det_mat x =
  let a = Linalg.D.det x in
  Printf.printf "determinant of x is %f\n" a

let _ =
  let x0 = Mat.uniform 8 8 in
  let x1 = Mat.uniform 8 10 in
  lq_fact x0;
  qr_fact x0;
  lu_fact x0;
  svd_fact x0;
  inv_mat x0;
  pinv_mat x0;
  rank_mat x0;
  det_mat x0
