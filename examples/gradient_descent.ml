#!/usr/bin/env owl
(* This example demonstrates how to write a gradient descent algorithm from
   using Algodiff. The passed in f must have the type [t -> t].
 *)

open Owl
open Algodiff.D


let rec desc ?(eta=F 0.01) ?(eps=1e-6) f x =
  let g = (diff f) x in
  if (unpack_flt g) < eps then x
  else desc ~eta ~eps f Maths.(x - eta * g)


let _ =
  (* plug in the function you want *)
  let f = Maths.sin in
  let y = desc f (F (Stats.Rnd.uniform ())) in
  Log.info "argmin f(x) = %g" (unpack_flt y)
