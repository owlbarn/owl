(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* NOTE: this is an experimental module being built now *)

open Owl_algodiff_ad
type t = Owl_algodiff_ad.t


(* module for initialising weight matrix *)
module Init = struct

  type typ =
    | Uniform  of float * float
    | Gaussian of float * float
    | Custom   of (int -> int -> float)

  let run t m n = match t with
    | Uniform (a, b)       -> Mat.(add (uniform ~scale:(b-.a) m n) (F a))
    | Gaussian (mu, sigma) -> Mat.(add (gaussian ~sigma m n) (F mu))
    | Custom f             -> Mat.(empty m n |> mapi (fun i j _ -> f i j))

  let to_string = function
    | Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
    | Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
    | Custom _        -> Printf.sprintf "customise"

end


(* module for various activation functions *)
module Activation = struct

  type typ =
    | Relu
    | Sigmoid
    | Softmax
    | Tanh
    | Custom of (t -> t)

  let run x l = match l with
    | Relu     -> Maths.relu x
    | Sigmoid  -> Maths.sigmoid x
    | Softmax  -> Mat.map_by_row Maths.softmax x
    | Tanh     -> Maths.tanh x
    | Custom f -> f x

  let to_string = function
    | Relu     -> "Activation layer: relu\n"
    | Sigmoid  -> "Activation layer: sigmoid\n"
    | Softmax  -> "Activation layer: softmax\n"
    | Tanh     -> "Activation layer: tanh\n"
    | Custom _ -> "Activation layer: customise\n"

end


(* definition of linear layer *)
module Linear = struct

  type layer = {
    mutable w : t;
    mutable b : t;
    mutable init_typ : Init.typ;
  }

  let create m n init_typ = {
    w = Mat.empty m n;
    b = Mat.empty 1 n;
    init_typ = init_typ;
  }

  let init l =
    let m, n = Mat.shape l.w in
    l.w <- Init.run l.init_typ m n;
    l.b <- Mat.zeros 1 n

  let reset l =
    Mat.reset l.w;
    Mat.reset l.b

  let run x l = Maths.((x $@ l.w) + l.b)

  let to_string l =
    let wm, wn = Mat.shape l.w in
    let bn = Mat.col_num l.b in
    Printf.sprintf "Linear layer:
    init : %s
    params : %i
    w : %i x %i
    b : %i
    "
    (Init.to_string l.init_typ) (wm * wn + bn) wm wn bn

end


(* definition of LTSM layer *)
module LTSM = struct

  type layer = {
    mutable wxi : t;
    mutable init_typ : Init.typ;
  }

  let create init_typ = {
    wxi = Mat.empty 1 1;
    init_typ = init_typ;
  }

  let init l = ()

  let reset l = ()

  let run x l = F 0.

end


(* definition of recurrent layer *)
module Recurrent = struct

  type layer = {
    mutable w : t;
    mutable b : t;
    mutable init_typ : Init.typ;
  }

  let create init_typ = {
    w = Mat.empty 1 1;
    b = Mat.empty 1 1;
    init_typ = init_typ;
  }

  let init l = ()

  let reset l = ()

  let run x l = F 0.

end


(* type and functions of neural network *)

type layer =
  | Linear     of Linear.layer
  | LTSM       of LTSM.layer
  | Recurrent  of Recurrent.layer
  | Activation of Activation.typ

type network = {
  mutable layers : layer list;
}


(* Feedforward network module *)
module Feedforward = struct

  let create () = { layers = []; }

  let add_layer nn l = nn.layers <- nn.layers @ [l]

  let add_activation nn l = nn.layers <- nn.layers @ [Activation l]

  let init nn = List.iter (function
    | Linear l    -> Linear.init l
    | LTSM l      -> LTSM.init l
    | Recurrent l -> Recurrent.init l
    | _           -> () (* activation *)
    ) nn.layers

  let reset nn = List.iter (function
    | Linear l    -> Linear.reset l
    | LTSM l      -> LTSM.reset l
    | Recurrent l -> Recurrent.reset l
    | _           -> () (* activation *)
    ) nn.layers

  let run x nn = List.fold_left (fun a l ->
    match l with
    | Linear l     -> Linear.run a l
    | LTSM l       -> LTSM.run a l
    | Recurrent l  -> Recurrent.run a l
    | Activation l -> Activation.run a l
    ) x nn.layers

  let to_string () = "Feedforward network"

end


(* helper functions *)

let linear ~inputs ~outputs ~init_typ = Linear (Linear.create inputs outputs init_typ)

let _layer_info = function
  | Linear l     -> Linear.to_string l
  | Recurrent l  -> "Recurrent"
  | LTSM l       -> "LTSM"
  | Activation l -> Activation.to_string l

let print nn =
  Printf.printf "%s\n\n" (Feedforward.to_string ());
  List.iteri (fun i l ->
    Printf.printf "(%i): %s\n" i (_layer_info l)
  ) nn.layers

let backprop nn eta x y =
  let t = tag () in
  List.iter (function
    | Linear l ->
      l.w <- make_reverse l.w t;
      l.b <- make_reverse l.b t;
    | _       -> ()
  ) nn.layers;
  let loss = Maths.(cross_entropy y (Feedforward.run x nn) / (F (Mat.row_num x |> float_of_int))) in
  reverse_prop (F 1.) loss;
  List.iter (function
    | Linear l ->
      l.w <- Maths.((primal l.w) - (eta * (adjval l.w))) |> primal;
      l.b <- Maths.((primal l.b) - (eta * (adjval l.b))) |> primal;
    | _       -> ()
  ) nn.layers;
  loss |> unpack_flt

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Owl_dataset.print_mnist_image (unpack_mat u);
    let p = Feedforward.run u nn |> unpack_mat in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j)
  ) x y

let train nn x y =
  Feedforward.init nn;
  for i = 1 to 1000 do
    let x', y' = Owl_dataset.draw_samples x y 100 in
    backprop nn (F 0.01) (Mat x') (Mat y')
    |> Printf.printf "#%i : loss = %g\n" i
    |> flush_all;
  done;
  let x, y, _ = Owl_dataset.load_mnist_test_data () in
  let x, y = Owl_dataset.draw_samples x y 10 in
  test_model nn (Mat x) (Mat y)

(* ends here *)
