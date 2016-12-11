(* Test parallel map *)

open Bigarray

let print_array x =
  Array.iter (fun a -> Printf.printf "%.2f " a) x;
  print_endline ""

let _ =
 let x = Array.init 10 (fun i -> float_of_int i) in
 let x = Array1.of_array Float64 c_layout x in
 Parmap.mymap (fun i a -> a) x
