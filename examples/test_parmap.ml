(* Test parallel map *)

let print_array x =
  Array.iter (fun a -> Printf.printf "%.2f " a) x;
  print_endline ""

let _ =
 let x = Array.init 10 (fun i -> float_of_int i) in
 print_array x;
 let y = Parmap.parmap ~ncores:2 (fun a -> a +. 1.) (Parmap.A x) in
 print_array (Array.of_list y);
