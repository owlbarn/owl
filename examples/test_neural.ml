(* Test neural network module *)
open Owl
open Owl_neural

let _ =
  let l0 = linear ~inputs:784 ~outputs:300 ~init_typ:Init.(Uniform (-0.075,0.075)) in
  let l1 = linear ~inputs:300 ~outputs:10 ~init_typ:Init.(Uniform (-0.075,0.075)) in

  let nn = Feedforward.create () in
  Feedforward.add_layer nn l0;
  Feedforward.add_activation nn Activation.Tanh;
  Feedforward.add_layer nn l1;
  Feedforward.add_activation nn Activation.Softmax;

  let x, _, y = Dataset.load_mnist_train_data () in
  let x, y = Algodiff.AD.Mat x, Algodiff.AD.Mat y in
  train nn x y
