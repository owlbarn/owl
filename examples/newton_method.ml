#!/usr/bin/env owl
(* This example demonstrates how to implement Newton method with Algdoff. *)

open Owl
open Algodiff.D


let rec newton ?(eta=F 0.01) ?(eps=1e-6) f x =
  let g, h = (gradhessian f) x in
  if (Maths.l2norm' g |> unpack_flt) < eps then x
  else newton ~eta ~eps f Maths.(x - eta * g *@ (inv h))


let _ =
  (* [f] must be [f : vector -> scalar]. *)
  let f x = Maths.(cos x |> sum') in
  let y = newton f (Mat.uniform 1 2) in
  Mat.print y
