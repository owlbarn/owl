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
 let y = Owl_parallel.mymap (fun i a -> a +. 1.) x in
 print_array1 x;
 print_array1 y

let _ =
  let x = Array.init 10 (fun i -> float_of_int i) in
  let x = Array1.of_array Float64 c_layout x in
  let f lo hi x y = (
    let x = genarray_of_array1 x in
    let x = Genarray.change_layout x fortran_layout in
    let x = array1_of_genarray x in
    let y = genarray_of_array1 y in
    let y = Genarray.change_layout y fortran_layout in
    let y = array1_of_genarray y in
    let lo = lo + 1 in
    let hi = hi + 1 in
    let _  = Lacaml.D.Vec.map (fun a -> a +. 1.) ~n:(hi - lo + 1) ~ofsy:lo ~y:y ~ofsx:lo x in
    ()
  )
  in
  let y = Owl_parallel.map_block f x in
  print_array1 x;
  print_array1 y
