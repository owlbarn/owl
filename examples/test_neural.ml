(* Test neural network module *)
open Owl
open Owl_neural


let test_minist_with_linear () =
  let l0 = linear 784 300 in
  let l1 = linear 300 10 in

  let nn = Feedforward.create () in
  Feedforward.add_layer nn l0 ~act_typ:Activation.Tanh;
  Feedforward.add_layer nn l1 ~act_typ:Activation.Softmax;
  print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  train nn x y


let test_minist_with_cnn () =
  let nn = Feedforward.create () in

  Feedforward.add_layer nn (conv2d 3 3 1 32 [|3;3|]);
  Feedforward.add_activation nn Activation.Relu;
  Feedforward.add_layer nn (conv2d 3 3 32 8 [|3;3|]);
  Feedforward.add_activation nn Activation.Relu;
  Feedforward.add_layer nn (fully_connected 128 10 ~init_typ:Init.(Uniform (0.,0.1)));
  (* Feedforward.add_activation nn Activation.Tanh; *)
  (* Feedforward.add_activation nn Activation.Softmax; *)

  print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in

  let params = Owl_neural_optimise.Params.default () in
  params.batch <- Batch.Stochastic;
  train_cnn ~params nn x y


let _ = test_minist_with_cnn ()
