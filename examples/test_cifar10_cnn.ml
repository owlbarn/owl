open Owl_neural
open Owl_neural_graph
open Algodiff.S
open Owl_neural_neuron

let model_name = "cifar10.model"
let test_batch = 10

let model () =
  let open Owl_neural_graph in
  let nn = input [|32;32;3|]
    |> conv2d [|3;3;3;32|] [|1;1|] ~act_typ:Activation.Relu
    |> conv2d [|3;3;32;32|] [|1;1|] ~act_typ:Activation.Relu ~padding:Owl_dense_ndarray_generic.VALID
    |> max_pool2d [|2;2|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID
    |> dropout 0.25
    |> conv2d [|3;3;32;64|] [|1;1|] ~act_typ:Activation.Relu
    |> conv2d [|3;3;64;64|] [|1;1|] ~act_typ:Activation.Relu ~padding:Owl_dense_ndarray_generic.VALID
    |> max_pool2d [|2;2|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID
    |> dropout 0.25
    |> fully_connected 512 ~act_typ:Activation.Relu
    |> linear 10 ~act_typ:Activation.Softmax
    |> get_network
  in
  print nn;
  nn

(* Problem: the training phase won't converge, with different learning_rate settings *)
let train_cifar () =
  let x, y = Dataset.load_cifar_train_data 1 in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;32;32;3|] in
  let nn = model () in
  let params = Params.config
    ~batch:(Batch.Mini 50) ~learning_rate:(Learning_Rate.RMSprop (0.0001, 1e-6)) 10.0 in
  train_cnn ~params nn x y |> ignore;
  Owl_neural_graph.save nn model_name


let inference_cifar nn x y num_inf =
  let images = Algodiff.S.unpack_arr x in
  let labels = Algodiff.S.unpack_mat y in
  let images = Dense.Ndarray.S.reshape images [|num_inf;32;32;3|] in
  let p = Graph.run (Arr images) nn |> Algodiff.S.unpack_mat in
  let mat2num mat =
    mat |> Dense.Matrix.Generic.max_rows
        |> Array.map (fun tp -> let _, _, num = tp in num)
  in
  let p = mat2num p in
  Printf.printf "Expectation: ";
  Dense.Matrix.S.(print (transpose labels));
  Printf.printf "\nPrediction: \n";
  Array.iter (fun i -> Printf.printf "%d " i) p;
  ()

let test_cifar () = None

let start_inference () =
  let x, y = Dataset.load_cifar_train_data 1 in
  let m = Dense.Matrix.S.row_num x in
  let x = Dense.Matrix.S.to_ndarray x in
  let x = Dense.Ndarray.S.reshape x [|m;32;32;3|] in
  let num_test = 9 in
  let a, b = Owl_neural_optimise.Utils.draw_samples (Arr x) (Mat y) num_test in
  (* load model *)
  let nn = Owl_neural_graph.load model_name in
  inference_cifar nn a b num_test

let start_test () = None

(* TODO: visualize color pictures *)
let show_cifar () = None

let _ =
  try
    start_inference ()
  with
    (* model file not found *)
    _ -> train_cifar (); start_inference ()
