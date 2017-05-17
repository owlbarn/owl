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

  Feedforward.add_layer nn (conv2d 3 3 3 32 [|3;3|]);
  Feedforward.add_activation nn Activation.Relu;
  Feedforward.add_layer nn (conv2d 3 3 3 32 [|3;3|]);
  Feedforward.add_activation nn Activation.Relu;
  Feedforward.add_layer nn (fully_connected 100 10);

  print nn;
  
  let x, _, y = Dataset.load_mnist_train_data () in
  train nn x y


let _ = test_minist_with_cnn ()
