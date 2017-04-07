(* Test neural network module *)
open Owl
open Owl_neural

let _ =
  let l0 = linear 784 300 in
  let l1 = linear 300 10 in

  let nn = Feedforward.create () in
  Feedforward.add_layer nn l0 ~act_typ:Activation.Tanh;
  Feedforward.add_layer nn l1 ~act_typ:Activation.Softmax;

  let x, _, y = Dataset.load_mnist_train_data () in
  train nn x y
