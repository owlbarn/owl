#!/usr/bin/env owl
(* This example demonstrates SVM regression. *)

open Owl

let generate_data () =
  let open Mat in
  let c = 500 in
  let x1 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 15), float_of_int (Random.int 15) in
  let x1 = map_at_col (fun x -> x +. a) x1 0 in
  let x1 = map_at_col (fun x -> x +. b) x1 1 in
  let x2 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 15), float_of_int (Random.int 15) in
  let x2 = map_at_col (fun x -> x +. a) x2 0 in
  let x2 = map_at_col (fun x -> x +. b) x2 1 in
  let y1 = create c 1 ( 1.) in
  let y2 = create c 1 ( -1.)in
  let x = concat_vertical x1 x2 in
  let y = concat_vertical y1 y2 in
  x, y


let draw_line x0 y0 p =
  let a, b, c = 0., 20., 100 in
  let x' = Mat.empty 1 c in
  let y' = Mat.empty 1 c in
  for i = 0 to c - 1 do
    let x = a +. (float_of_int i *. (b -. a) /. float_of_int c) in
    let y = (Mat.get p 0 0 *. x +. Mat.get p 2 0) /. (Mat.get p 1 0 *. (-1.)) in
    Mat.set x' 0 i x; Mat.set y' 0 i y
  done;
  let h = Plot.create "plot_svm.png" in
  Plot.(plot ~h ~spec:[ RGB (100,100,100) ] x' y');
  Plot.(scatter ~h ~spec:[ RGB (150,150,150) ] x0 y0);
  Plot.output h


let _ =
  let _ = Random.self_init () in
  let x, y = generate_data () in
  let r = Regression.D.svm ~i:true x y in
  let p = Mat.(r.(0) @= r.(1)) in
  draw_line (Mat.col x 0) (Mat.col x 1) p;
  Owl_pretty.print_dsnda Mat.(r.(0) @= r.(1))
