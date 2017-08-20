#!/usr/bin/env owl
(* This example demonstrates how to build a VGG-like convolutional neural
  network for CIFAR10 dataset.
 *)

open Owl
open Neural
open Neural.Graph


let make_network input_shape =
  input input_shape
  |> normalisation
  |> conv2d [|3;3;3;32|] [|1;1|] ~act_typ:Activation.Relu
  |> conv2d [|3;3;32;32|] [|1;1|] ~act_typ:Activation.Relu ~padding:Dense.Ndarray.Generic.VALID
  |> max_pool2d [|2;2|] [|2;2|] ~padding:Dense.Ndarray.Generic.VALID
  |> dropout 0.1
  |> conv2d [|3;3;32;64|] [|1;1|] ~act_typ:Activation.Relu
  |> conv2d [|3;3;64;64|] [|1;1|] ~act_typ:Activation.Relu ~padding:Dense.Ndarray.Generic.VALID
  |> max_pool2d [|2;2|] [|2;2|] ~padding:Dense.Ndarray.Generic.VALID
  |> dropout 0.1
  |> fully_connected 512 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.Softmax
  |> get_network


let train () =
  let x, _, y = Dataset.load_cifar_train_data 1 in
  let network = make_network [|32;32;3|] in
  Graph.print network;
  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.01) ~checkpoint:5. 10.
  in
  Graph.train_cnn ~params network x y


let _ = train ()
