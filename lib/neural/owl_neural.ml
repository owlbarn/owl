(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* NOTE: this is an experimental module being built now *)

open Owl_algodiff.S
open Owl_neural_neuron


(* module aliases *)

module Feedforward    = Owl_neural_feedforward
module Init           = Owl_neural_neuron.Init
module Activation     = Owl_neural_neuron.Activation

module Params         = Owl_neural_optimise.Params
module Batch          = Owl_neural_optimise.Batch
module Learning_Rate  = Owl_neural_optimise.Learning_Rate
module Loss           = Owl_neural_optimise.Loss
module Gradient       = Owl_neural_optimise.Gradient
module Momentum       = Owl_neural_optimise.Momentum
module Regularisation = Owl_neural_optimise.Regularisation
module Clipping       = Owl_neural_optimise.Clipping


(* core layer functions *)

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
  FullyConnected (FullyConnected.create ?inputs outputs init_typ )

let max_pool2d ?(padding = Owl_dense_ndarray_generic.SAME) kernel stride =
  MaxPool2D (MaxPool2D.create padding kernel stride)

let avg_pool2d ?(padding = Owl_dense_ndarray_generic.SAME) kernel stride =
  AvgPool2D (AvgPool2D.create padding kernel stride)

let dropout rate = Dropout (Dropout.create rate)

let reshape ?conv_typ ?inputs outputs =
  Reshape (Reshape.create ?conv_typ ?inputs outputs)

let flatten ?conv_typ () = Flatten (Flatten.create ?conv_typ ())

let lambda lambda = Lambda (Lambda.create lambda)


(* training functions *)

let train ?params nn x y =
  Feedforward.init nn;
  let f = Feedforward.forward nn in
  let b = Feedforward.backward nn in
  let u = Feedforward.update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  let x, y = Mat x, Mat y in
  Owl_neural_optimise.train_nn p f b u x y

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Owl_dataset.print_mnist_image (unpack_mat u);
    let p = Feedforward.run u nn |> unpack_mat in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j)
  ) (Mat x) (Mat y)


let train_cnn ?params nn x y =
  Feedforward.init nn;
  let f = Feedforward.forward nn in
  let b = Feedforward.backward nn in
  let u = Feedforward.update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  let x, y = Arr x, Mat y in
  Owl_neural_optimise.train_nn p f b u x y


(* I/O functions *)

let print nn = Feedforward.to_string nn |> Printf.printf "%s"

let save nn f = Owl_utils.marshal_to_file nn f

let load f : Feedforward.network = Owl_utils.marshal_from_file f


(* ends here *)
