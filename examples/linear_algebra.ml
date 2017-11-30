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
  Mat.(l *@ u |> print)

(* SVD factorisation *)
let svd_fact x = ()

let _ =
  let x0 = Mat.uniform 8 8 in
  let x1 = Mat.uniform 8 10 in
  lq_fact x0;
  qr_fact x0;
  lu_fact x0;
  svd_fact x0
