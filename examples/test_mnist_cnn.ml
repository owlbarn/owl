#!/usr/bin/env owl
#zoo "980a43a65e78613b4912c69008b3e909" (*Import the VisualModule *)

(* Trains a simple convnet on the MNIST dataset. Network structure adapted from
 * Keras example: https://github.com/fchollet/keras/blob/master/examples/mnist_cnn.py
*)

open Owl
open Owl_neural
open Algodiff.S
open Owl_neural_neuron

let model_name = "mnist.model"

let train_mnist () =
  let open Owl_neural_graph in
  let nn = input [|28;28;1|]
    |> conv2d [|3;3;1;32|] [|1;1|] ~act_typ:Activation.Relu ~padding:Owl_dense_ndarray_generic.VALID
    |> conv2d [|3;3;32;64|] [|1;1|] ~act_typ:Activation.Relu ~padding:Owl_dense_ndarray_generic.VALID
    |> max_pool2d [|2;2|] [|2;2|]
    |> dropout 0.25
    |> fully_connected 1024 ~act_typ:Activation.Relu
    |> linear 10 ~act_typ:Activation.Softmax
    |> get_network
  in print nn;

  let x, _, y = Dataset.load_mnist_train_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in

  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.RMSprop (0.0001, 1e-6)) 0.2 in
  train_cnn ~params nn x y |> ignore;
  Owl_neural_graph.save nn model_name

let inference_mnist nn x y num_test =
  let images = Algodiff.S.unpack_arr x in
  let labels = Algodiff.S.unpack_mat y in
  let images = Dense.Ndarray.S.reshape images [|num_test;28;28;1|] in
  let p = Graph.run (Arr images) nn |> Algodiff.S.unpack_mat in
  (* Owl_dense_matrix_generic.print p; *)
  let mat2num mat =
    mat |> Dense.Matrix.Generic.max_rows
        |> Array.map (fun tp -> let _, _, num = tp in num)
  in
  let p = mat2num p in
  let labels = mat2num labels in
  Printf.printf "Expectation:";
  Array.iter (fun i -> Printf.printf "%d " i) labels;
  Printf.printf "\nPrediction: ";
  Array.iter (fun i -> Printf.printf "%d " i) p
  (* Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j) *)


(* with zoo, there is no need to write this function;
  instead, we only need a one-liner to import it. *)
(*
let visualize_dataset x len  =
  assert( len > 1 && len < 100 );
  let num = len * len in
  let mats = Array.make num (Dense.Matrix.D.zeros 1 1) in

  for i = 0 to num - 1 do
    let fig = Dense.Ndarray.D.slice [[i];[];[]] x
              |> Dense.Ndarray.D.squeeze
              |> Dense.Matrix.D.of_ndarray
    in
    mats.(i) <- fig;
  done;

  let mats2 = Array.make len (Dense.Matrix.D.zeros 1 1) in
  for i = 0 to (len-1) do
    let m = Array.sub mats (i*len) len
            |> Dense.Matrix.D.concatenate ~axis:0
    in
    mats2.(i) <- m
  done;

  let img = Dense.Matrix.D.concatenate ~axis:1 mats2 in
  Plot.image img
*)

let start_inference () =
  let x, _, y = Dataset.load_mnist_test_data () in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;28;28;1|] in
  (* visualize dataset *)
  let len = 6 in
  let imgs = x |>  Dense.Ndarray.Generic.cast_s2d in
  VisualModule.visualize_dataset imgs len;
  (* draw (len * len) samples *)
  let num_test = len * len in
  let a, b = Owl_neural_optimise.Utils.draw_samples (Arr x) (Mat y) num_test in
  (* load model *)
  let nn = Owl_neural_graph.load model_name in
  inference_mnist nn a b num_test

(* High CPU/Mem usage *)
let test_mnist () =
  let imgs, _, labels = Dataset.load_mnist_test_data () in
  let m = Dense.Matrix.S.row_num imgs in
  let imgs = Dense.Matrix.S.to_ndarray imgs in
  let imgs = Dense.Ndarray.S.reshape imgs [|m;28;28;1|] in
  let nn = Owl_neural_graph.load model_name in
  let pred = Graph.run (Arr imgs) nn |> Algodiff.S.unpack_mat in
  let mat2num mat =
    let mat = mat
      |> Dense.Matrix.Generic.max_rows
      |> Array.map (fun tp -> let _, _, num = tp in float_of_int num)
    in
    Dense.Matrix.S.of_array mat 1 m
  in
  let pred   = mat2num pred in
  let labels = mat2num labels in
  let accu = Dense.Matrix.S.elt_equal pred labels
             |> Dense.Matrix.S.sum
  in
  Printf.printf "\nAccuracy on test set: %f\n" (accu /. (float_of_int m))

let _ =
  try
    start_inference ();
    (* comment out the test phase as you need since it takes some time *)
    test_mnist ()
  with
    (* when model file not found *)
    Sys_error _ ->
      Log.info "Pretrained model not found. Start to train.";
      train_mnist (); start_inference (); test_mnist ()
