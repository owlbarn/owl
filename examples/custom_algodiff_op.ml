#!/usr/bin/env owl

(* This example demonstrates how to build a custom operation in Algodiff . *)

open Owl
open Algodiff.D


(* Here we build a custom cosine operation that algodiff recognises.
 * Cosine is single input single output function, which is why we use
 * the `build_siso` function. This function takes a module of type 
 * Siso. Both of these are defined in side `Ops.Builder`. Inside, this
 * module we define the forward pass functions `ff_f` and `ff_arr` 
 * to handle float and Arr inputs respectively. We define the 
 * forward-mode and reverse-mode gradients with `df` and `dr` respectively.
 * Below the variable naming conventions here are based on c = cos(a). 
 * Therefore, `cp` is the primal of the output, `ca` is the adjoin of the 
 * output variable, `ap` is the primal of the input, and `at` is the 
 * tangent at the input. 
 * *)


let custom_cos =
  let open Algodiff.D.Builder in
      build_siso
        (module struct
          let label = "custom_cos"
          let ff_f a = F A.Scalar.(cos a)
          let ff_arr a = Arr A.(cos a)
          let df _cp ap at = Maths.(neg (at * sin ap))
          let dr a _cp ca = Maths.(!ca * neg (sin (primal a)))
        end
        : Siso)
     
let _ =
  let input = Mat.uniform 1 2 in
  (* [f] must be [f : vector -> scalar]. *)
  let g' = grad custom_cos in
  let h' = grad g' in
  let g = grad Maths.cos in
  let h = grad g in
  Mat.print (g' input);
  Mat.print (g input);
  Mat.print (h' input);
  Mat.print (h input);
