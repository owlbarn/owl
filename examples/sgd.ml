#!/usr/bin/env owl
(* *)

module LL = Owl_optimise

let centerise x =
  let open MX in
  let v = mean_rows x in
  map_by_row (row_num v) (fun x -> x - v) x

let test () =
  let p = Mat.uniform_int 100 10 in
  let x = centerise (Mat.uniform 10000 100) in
  let y = Mat.(x *@ p) in
  let q = Mat.uniform_int 100 10 in
  let p' = LL.sgd q x y in
  Printf.printf "error ==> %.4f\n" Mat.(sum' (abs (p'- p)))

let test_small () =
  let p = Mat.uniform_int 5 3 in
  let p = Mat.map_at_row (fun _ -> float_of_int (Random.int 30)) p 4 in
  let x = Mat.uniform 1000 5 in
  let x = Mat.map_at_col (fun _ -> 1.) x 4 in
  let y = Mat.(x *@ p) in
  let q = Mat.uniform_int 5 3 in
  let p' = LL.sgd q x y in
  Mat.(pp_dsmat (p));
  Mat.(pp_dsmat (p'));
  Mat.(pp_dsmat (p' - p));
  Printf.printf "error ==> %.4f\n" Mat.(sum' (abs (p'- p)))

let test_intercept () =
  let p = Mat.uniform_int 5 3 in
  let p = Mat.map_at_row (fun _ -> float_of_int (Random.int 30)) p 4 in
  let x = Mat.uniform 1000 5 in
  let x = Mat.map_at_col (fun _ -> 1.) x 4 in
  let y = Mat.(x *@ p) in
  let q = Mat.uniform_int 4 3 in
  let p' = LL.sgd ~i:true q Mat.(cols x [|0;1;2;3|]) y in
  Printf.printf "error ==> %.4f\n" Mat.(sum' (abs (p'- p)))

let _ =
  Random.self_init ();
  test_small ()
