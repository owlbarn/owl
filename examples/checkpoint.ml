#!/usr/bin/env owl
(* This example shows how to use checkpoint in a stateful optimisation. *)

open Owl
open Neural.S
open Neural.S.Graph
open Owl.Algodiff.S


let make_network input_shape =
  input input_shape
  |> lambda (fun x -> Maths.(x / F 256.))
  |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> dropout 0.1
  |> fully_connected 1024 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.(Softmax 1)
  |> get_network


let train () =
  let x, _, y = Dataset.load_mnist_train_data_arr () in
  let network = make_network [|28;28;1|] in

  (* define checkpoint function *)
  let chkpt state =
    let open Checkpoint in
    if state.current_batch mod 10 = 0 then (
      Owl_log.warn "this is a customised checkpoint ...";
      state.stop <- true
    )
  in

  (* plug in chkpt into params *)
  let params = Params.config
    ~batch:(Batch.Sample 100) ~learning_rate:(Learning_Rate.Adagrad 0.005)
    ~checkpoint:(Checkpoint.Custom chkpt) ~stopping:(Stopping.Const 1e-6) 10.
  in
  (* keep restarting the optimisation until it finishes *)
  let state = Graph.train ~params network x y in
  while Checkpoint.(state.current_batch < state.batches) do
    Checkpoint.(state.stop <- false);
    Graph.train ~state ~params ~init_model:false network x y |> ignore
  done;

  network


let _ = train ()
