(* Test neural network module *)
open Owl
open Owl_neural
open Algodiff.S
open Owl_neural_layer


let test_minist_with_linear () =
  let l0 = linear ~inputs:784 300 in
  let l1 = linear ~inputs:300 10 in

  let nn = Feedforward.create () in
  Feedforward.add_layer nn l0 ~act_typ:Activation.Tanh;
  Feedforward.add_layer nn l1 ~act_typ:Activation.Softmax;
  print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  train nn x y


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

let test_minist_with_cnn0 () =
  let nn = Feedforward.create () in

  (*
  Feedforward.add_layer nn (conv2d 3 3 1 32 [|3;3|]);
  Feedforward.add_activation nn Activation.Relu;
  Feedforward.add_layer nn (conv2d 3 3 32 8 [|3;3|]);
  Feedforward.add_activation nn Activation.Relu;
  Feedforward.add_layer nn (fully_connected 128 10 ~init_typ:Init.(Uniform (0.,0.1)));
  Feedforward.add_activation nn Activation.Softmax; *)

  Feedforward.add_layer nn (conv2d ~padding:VALID 28 28 1 300 [|1;1|]);
  (* Feedforward.add_activation nn Activation.Tanh; *)
  Feedforward.add_layer nn (fully_connected 10);
  Feedforward.add_layer nn (activation Activation.Softmax);

  print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in

  let params = Owl_neural_optimise.Params.default () in
  params.batch <- Batch.Mini 100;
  params.learning_rate <- Learning_Rate.Const 0.00001;
  train_cnn ~params nn x y;

  let x, y = Owl_neural_optimise.Utils.draw_samples (Arr x) (Mat y) 10 in
  test_cnn nn (Algodiff.S.unpack_arr x) (Algodiff.S.unpack_mat y)


let test_minist_with_cnn1 () =
  let nn = Feedforward.create () in

  Feedforward.add_layer nn (input [|28;28;1|]);
  Feedforward.add_layer nn (conv2d ~padding:VALID 8 8 1 50 [|1;1|]);
  Feedforward.add_layer nn (activation Activation.Relu);
  Feedforward.add_layer nn (conv2d ~padding:VALID 8 8 50 50 [|2;2|]);
  Feedforward.add_layer nn (activation Activation.Relu);
  Feedforward.add_layer nn (conv2d ~padding:VALID 7 7 50 50 [|1;1|]);
  Feedforward.add_layer nn (activation Activation.Relu);
  Feedforward.add_layer nn (fully_connected 10);
  Feedforward.add_layer nn (activation Activation.Softmax);

  print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in

  let params = Owl_neural_optimise.Params.default () in
  params.batch <- Batch.Mini 100;
  params.learning_rate <- Learning_Rate.Const 0.01;
  train_cnn ~params nn x y;

  let x, y = Owl_neural_optimise.Utils.draw_samples (Arr x) (Mat y) 10 in
  test_cnn nn (Algodiff.S.unpack_arr x) (Algodiff.S.unpack_mat y)


let _ = test_minist_with_linear ()
