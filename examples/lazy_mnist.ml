#!/usr/bin/env owl
(* This example demonstrates using lazy functor to train a model on mnist. *)

open Owl

module C = Owl_neural_graph_compiler.Make (Dense.Ndarray.S) (Computation.Engine)

open C.Neural
open C.Neural.Graph
open C.Neural.Algodiff


let make_network input_shape =
  input input_shape
  |> lambda (fun x -> Maths.(x / pack_flt 256.))
  |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> dropout 0.1
  |> fully_connected 1024 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.(Softmax 1)
  |> get_network ~name:"mnist"


let train network =
  let x, _, y = Dataset.load_mnist_train_data_arr () in
  let x = C.CGraph.pack_arr x |> Algodiff.pack_arr in
  let y = C.CGraph.pack_arr y |> Algodiff.pack_arr in
  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.005) 0.1
    (* ~momentum:(Momentum.Standard 0.1) *)
  in
  C.train ~params network x y


let _ =
  Owl_log.(set_level INFO);
  let network = make_network [|28;28;1|] in
  Graph.print network; flush_all ();
  train network
