(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff.S
open Owl_neural_neuron

(* Simple Feedforward neural network module *)

type network = {
  mutable layers : neuron array;
}


(* functions to manipulate the network *)

let create () = { layers = [||]; }


let layer_num nn = Array.length nn.layers


let get_layer nn i =
  let c = layer_num nn in
  match i < 0 with
  | true  -> nn.layers.(c + i)
  | false -> nn.layers.(i)


let connect_layer prev_l next_l =
  let out_shape = get_out_shape prev_l in
  connect out_shape next_l


let rec add_layer ?act_typ nn l =
  (* check whether it is input layer *)
  let not_input_layer =
    function Input _ -> false | _ -> true
  in
  (* insert input layer as the first one given an empty nn *)
  if layer_num nn = 0 then (
    let in_shape = get_in_shape l in
    assert (Array.length in_shape > 0);
    assert (Array.exists ((<>)0) in_shape);
    nn.layers <- [|Input Input.(create in_shape)|];
  );
  (* retrieve the previous layer and attach the new one *)
  if not_input_layer l then (
    let prev_l = get_layer nn (-1) in
    connect_layer prev_l l;
    nn.layers <- Array.append nn.layers [|l|];
  );
  (* if activation is specified, recursively add_layer *)
  match act_typ with
  | Some act -> add_layer nn (Activation (Activation.create act))
  | None     -> ()


(* functions to interface to optimisation engine *)

let init nn = Array.iter init nn.layers


let reset nn = Array.iter reset nn.layers


let mktag t nn = Array.iter (mktag t) nn.layers


let mkpar nn = Array.map mkpar nn.layers


let mkpri nn = Array.map mkpri nn.layers


let mkadj nn = Array.map mkadj nn.layers


let update nn us = Array.iter2 update nn.layers us


let run x nn = Array.fold_left run x nn.layers


let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn


let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn


(* functions to create stand-alone layers *)

let input inputs = Input (Input.create inputs)


let activation act_typ = Activation (Activation.create act_typ)


let linear ?(init_typ = Init.Standard) ?inputs outputs =
  Linear (Linear.create ?inputs outputs init_typ)


let linear_nobias ?(init_typ = Init.Standard) ?inputs outputs =
  LinearNoBias (LinearNoBias.create ?inputs outputs init_typ)


let recurrent ?(init_typ=Init.Standard) ~act_typ ?inputs outputs hiddens =
  Recurrent (Recurrent.create ?inputs hiddens outputs act_typ init_typ)


let lstm ?inputs cells = LSTM (LSTM.create ?inputs cells)


let gru ?inputs cells = GRU (GRU.create ?inputs cells)


let conv2d ?(padding = Owl_dense_ndarray_generic.SAME) ?inputs kernel strides =
  Conv2D (Conv2D.create padding ?inputs kernel strides)


let conv3d ?(padding = Owl_dense_ndarray_generic.SAME) ?inputs kernel_width kernel strides =
  Conv3D (Conv3D.create padding ?inputs kernel strides)


let fully_connected ?(init_typ = Init.Standard) ?inputs outputs =
  FullyConnected (FullyConnected.create ?inputs outputs init_typ)


let max_pool2d ?(padding = Owl_dense_ndarray_generic.SAME) kernel stride =
  MaxPool2D (MaxPool2D.create padding kernel stride)


let avg_pool2d ?(padding = Owl_dense_ndarray_generic.SAME) kernel stride =
  AvgPool2D (AvgPool2D.create padding kernel stride)


let dropout rate = Dropout (Dropout.create rate)


let reshape ?convert ?inputs outputs =
  Reshape (Reshape.create ?convert ?inputs outputs)


let flatten ?convert () = Flatten (Flatten.create ?convert ())


let lambda lambda = Lambda (Lambda.create lambda)


(* functions to create functional layers *)



(* training functions *)

let train ?params nn x y =
  init nn;
  let f = forward nn in
  let b = backward nn in
  let u = update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  let x, y = Mat x, Mat y in
  Owl_neural_optimise.train_nn p f b u x y

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Owl_dataset.print_mnist_image (unpack_mat u);
    let p = run u nn |> unpack_mat in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j)
  ) (Mat x) (Mat y)


let train_cnn ?params nn x y =
  init nn;
  let f = forward nn in
  let b = backward nn in
  let u = update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  let x, y = Arr x, Mat y in
  Owl_neural_optimise.train_nn p f b u x y


(* I/O functions *)

let to_string nn =
  let s = ref "Feedforward network\n\n" in
  for i = 0 to Array.length nn.layers - 1 do
    let t = to_string nn.layers.(i) in
    s := !s ^ (Printf.sprintf "(%i): %s\n" i t)
  done; !s

let print nn = to_string nn |> Printf.printf "%s"

let save nn f = Owl_utils.marshal_to_file nn f

let load f : network = Owl_utils.marshal_from_file f



(* ends here *)
