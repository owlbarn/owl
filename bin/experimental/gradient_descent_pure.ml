(* This example demonstrates how to write a gradient descent algorithm. *)

open Owl_ocaml_dense_ndarray_generic.PureD

let count = ref 0

let get_ind v i = Owl_ocaml_dense_ndarray_generic.NdarrayPureDouble.get (unpack_arr v) [|i|];;
let set_ind v i x = Owl_ocaml_dense_ndarray_generic.NdarrayPureDouble.set (unpack_arr v) [|i|] x;;
let offset = Arr (Owl_ocaml_dense_ndarray_generic.NdarrayPureDouble.ones [|2|]);;
let _ = (set_ind offset 0 3.0, set_ind offset 1 5.0);;
let myff = (fun v -> Maths.sum' (Maths.sqr (Maths.sub v offset)));;
let init_v =  Maths.add (Arr.ones [|2|]) (F 20.);;
let _ = set_ind init_v 0 25.0;;
let _ = set_ind init_v 0 30.0;;

let rec desc ?(eta=F 0.01) ?(eps=1e-6) f x =
  let _ = (
    if (Pervasives.(mod) (!count) 10) = 0
    then Printf.printf "Step %d at (x = %f, y = %f)\n" (!count) (get_ind x 0) (get_ind x 1)
    else ();
    count := !count + 1
  ) in
  let g = (grad f) x in
  if (unpack_flt (Maths.sum' g)) < eps then x
  else desc ~eta ~eps f Maths.(x - eta * g)

let _ = Printf.printf "HELLO ss\n"

let _ =
  (* [f] must be  [f : scalar -> scalar] *)
  let myf = myff in
  let y = desc myf init_v in
  Printf.printf "argmin f(x, y) = (%f, %f)\n" (get_ind y 0) (get_ind y 1)
