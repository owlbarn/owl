(* This example demonstrates how to write a gradient descent algorithm. *)

open Owl_ocaml_dense_ndarray_generic.PureD

let count = ref 0

let rec desc ?(eta=F 0.01) ?(eps=1e-6) f x =
  let _ = (
    if (Pervasives.(mod) (!count) 10) = 0
    then Printf.printf "Step %d at x = %f\n" (!count) (unpack_flt x)
    else ();
    count := !count + 1
  ) in
  let g = (diff f) x in
  if (unpack_flt g) < eps then x
  else desc ~eta ~eps f Maths.(x - eta * g)

let _ = Printf.printf "HELLO ss\n"

let _ =
  (* [f] must be  [f : scalar -> scalar] *)
  let myf = (fun x -> Maths.(x * x - (F 4.) * x + (F 4.))) in
  let y = desc myf (F (Random.float 1e9)) in
  Printf.printf "argmin f(x) = %g\n" (unpack_flt y)
