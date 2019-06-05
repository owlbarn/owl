#!/usr/bin/env owl
(* stochastic gradient decent algorithm *)

open Owl

let generate_data () =
  let open Mat in
  let c = 500 in
  let x1 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 5), float_of_int (Random.int 5) in
  let x1 = map_at_col (fun x -> x +. a) x1 0 in
  let x1 = map_at_col (fun x -> x +. b) x1 1 in
  let x2 = (gaussian c 2 *$ 1.) in
  let a, b = float_of_int (Random.int 5), float_of_int (Random.int 5) in
  let x2 = map_at_col (fun x -> x -. a) x2 0 in
  let x2 = map_at_col (fun x -> x -. b) x2 1 in
  let y1 = create c 1 ( 1.) in
  let y2 = create c 1 ( 0.)in
  let x = concat_vertical x1 x2 in
  let y = concat_vertical y1 y2 in
  let _ = save_txt x1 "test_log.data1.tmp" in
  let _ = save_txt x2 "test_log.data2.tmp" in
  x, y

let test_log x y =
  let p = Regression.D.logistic ~i:true x y in
  let x = Mat.(concat_horizontal x (ones (row_num x) 1)) in
  let y' = Mat.(sigmoid (x *@ (p.(0) @= p.(1)))) in
  let y' = Mat.map (fun x -> if x > 0.5 then 1. else 0.) y' in
  let e = Mat.((mean' (abs (y - y')))) in
  let _ = Owl_log.info "accuracy: %.4f" (1. -. e) in ()

let _ =
  let _ = Random.self_init () in
  let x, y = generate_data () in
  test_log x y 
