#!/usr/bin/env owl

open Owl
open Algodiff.S

type layer = {
  mutable w : t;
  mutable b : t;
  a : t -> t;
}

type network = { layers : layer array }

let run_layer x l = Maths.((x *@ l.w) + l.b) |> l.a

let run_network x nn = Array.fold_left run_layer x nn.layers

let l0 = {
  w = Maths.(Mat.uniform 784 300 * F 0.15 - F 0.075);
  b = Mat.zeros 1 300;
  a = Maths.tanh;
}

let l1 = {
  w = Maths.(Mat.uniform 300 10 * F 0.15 - F 0.075);
  b = Mat.zeros 1 10;
  a = Mat.map_by_row Maths.softmax;
}

let nn = {layers = [|l0; l1|]}

let backprop nn eta x y =
  let t = tag () in
  Array.iter (fun l ->
    l.w <- make_reverse l.w t;
    l.b <- make_reverse l.b t;
  ) nn.layers;
  let loss = Maths.(cross_entropy y (run_network x nn) / (F (Mat.row_num y |> float_of_int))) in
  reverse_prop (F 1.) loss;
  Array.iter (fun l ->
    l.w <- Maths.((primal l.w) - (eta * (adjval l.w))) |> primal;
    l.b <- Maths.((primal l.b) - (eta * (adjval l.b))) |> primal;
  ) nn.layers;
  loss |> unpack_flt

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Dataset.print_mnist_image (unpack_mat u);
    let p = run_network u nn |> unpack_mat in
    Dense.Matrix.Generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Dense.Matrix.Generic.max_i p in j)
  ) x y

let _ =
  let x, _, y = Dataset.load_mnist_train_data () in
  for i = 1 to 1000 do
    let x', y' = Dataset.draw_samples x y 100 in
    backprop nn (F 0.01) (Mat x') (Mat y')
    |> Printf.printf "#%i : loss = %g\n" i
    |> flush_all;
  done;
  let x, y, _ = Dataset.load_mnist_test_data () in
  let x, y = Dataset.draw_samples x y 10 in
  test_model nn (Mat x) (Mat y)
