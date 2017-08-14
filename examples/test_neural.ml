#!/usr/bin/env owl

open Owl
open Owl_neural
open Algodiff.S
open Owl_neural_neuron
open Owl_neural_feedforward


let test_cnn nn x y =
  for i = 0 to 9 do
    let u = Dense.Ndarray.S.slice [[i]] x in
    Dense.Ndarray.S.reshape u [|28;28|]
    |> Dense.Matrix.S.of_ndarray
    |> Dataset.print_mnist_image;
    let p = Feedforward.run (Arr u) nn |> Algodiff.S.unpack_mat in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j)
  done


let test_mnist_cnn_functional () =
  let nn = input [|28;28;1|]
    |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
    |> max_pool2d [|2;2|] [|2;2|]
    |> conv2d [|5;5;32;64|] [|1;1|] ~act_typ:Activation.Relu
    |> max_pool2d [|2;2|] [|2;2|]
    |> dropout 0.1
    |> fully_connected 1024 ~act_typ:Activation.Relu
    |> linear 10 ~act_typ:Activation.Softmax
  in print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in

  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.005) 1. in
  train_cnn ~params nn x y |> ignore;

  let x, y = Owl_neural_optimise.Utils.draw_samples (Arr x) (Mat y) 10 in
  test_cnn nn (Algodiff.S.unpack_arr x) (Algodiff.S.unpack_mat y)


let test_mnist_linear_graph () =
  let open Owl_neural_graph in
  let nn = input [|784|]
    |> linear 300 ~act_typ:Activation.Tanh
    |> linear 10 ~act_typ:Activation.Softmax
    |> get_network
  in print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  train nn x y


let test_mnist_cnn_graph () =
  let open Owl_neural_graph in
  let nn = input [|28;28;1|]
    |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
    |> max_pool2d [|2;2|] [|2;2|]
    |> conv2d [|5;5;32;64|] [|1;1|] ~act_typ:Activation.Relu
    |> max_pool2d [|2;2|] [|2;2|]
    |> dropout 0.1
    |> fully_connected 1024 ~act_typ:Activation.Relu
    |> linear 10 ~act_typ:Activation.Softmax
    |> get_network
  in print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in

  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.005) ~checkpoint:0.1 0.2 in
  train_cnn ~params nn x y |> ignore


let _ = test_mnist_cnn_graph ()
