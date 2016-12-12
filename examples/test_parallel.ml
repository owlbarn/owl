(* Test parallel map *)

open Bigarray

let print_array x =
  Array.iter (fun a -> Printf.printf "%.2f " a) x;
  print_endline ""

let print_array1 x =
  for i = 0 to (Array1.dim x - 1) do
    Printf.printf "%.2f " x.{i}
  done;
  print_endline ""

let test_1 () =
 let x = Array.init 10 (fun i -> float_of_int i) in
 let x = Array1.of_array Float64 c_layout x in
 let y = Owl_parallel.map_element (fun i a -> a +. 1.) x in
 print_array1 x;
 print_array1 y

let _ =
  let x = Owl_dense_ndarray.uniform Float64 [|2;2;2|] in
  let y = Owl_dense_ndarray.pmap (fun a -> a *. 10.) x in
  Owl_dense_ndarray.print x;
  print_endline "======================";
  Owl_dense_ndarray.print y
