#!/usr/bin/env owl
(* This example demonstrates how to implement Newton method with Algdoff.
   The passed in [f] must have the type [f : vector -> scalar].
 *)

open Owl
open Algodiff.D


let rec newton ?(eta=F 0.01) ?(eps=1e-6) f x =
  let g, h = (gradhessian f) x in
  if (Maths.l2norm g |> unpack_flt) < eps then x
  else newton ~eta ~eps f Maths.(x - eta * g *@ (inv h))


let _ =
  (* plug in the function you want *)
  let f x = Maths.(cos x |> sum) in
  let y = newton f (Mat.uniform 1 2) in
  Mat.print y
