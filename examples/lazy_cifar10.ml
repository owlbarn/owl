#!/usr/bin/env owl
(* This example demonstrates using lazy functor to train a model on mnist. *)

open Owl

module C = Owl_neural_graph_compiler.Make (Dense.Ndarray.S) (Computation.Engine)

open C.Neural
open C.Neural.Graph
open C.Neural.Algodiff


let make_network input_shape =
  input input_shape
  |> normalisation ~decay:0.9
  |> conv2d [|3;3;3;32|] [|1;1|] ~act_typ:Activation.Relu
  |> conv2d [|3;3;32;32|] [|1;1|] ~act_typ:Activation.Relu ~padding:VALID
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  |> dropout 0.1
  |> conv2d [|3;3;32;64|] [|1;1|] ~act_typ:Activation.Relu
  |> conv2d [|3;3;64;64|] [|1;1|] ~act_typ:Activation.Relu ~padding:VALID
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  |> dropout 0.1
  |> fully_connected 512 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.(Softmax 1)
  |> get_network ~name:"cifar"


let train network =
  let x, _, y = Dataset.load_cifar_train_data 1 in
  let x = C.CGraph.pack_arr x |> Algodiff.pack_arr in
  let y = C.CGraph.pack_arr y |> Algodiff.pack_arr in
  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.005) 10.
  in
  C.train ~params network x y


let _ =
  Owl_log.(set_level INFO);
  let network = make_network [|32;32;3|] in
  Graph.print network; flush_all ();
  train network
