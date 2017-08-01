#!/usr/bin/env owl
(* Test recurrent neural network LSTM *)

open Owl
open Algodiff.S
open Owl_neural
open Owl_neural_graph

let model_name = "basic_lstm.model"

let s = "I sing of arms and the man he who exiled by fate first came from the coast of Troy to Italy and to Lavinian shores hurled about endlessly by land and sea by the will of the gods, by cruel Junos remorseless anger long suffering also in war until he founded a city and brought his gods to Latium from that the Latin people came the lords of Alba Longa the walls of noble Rome Muse tell me the cause how was she offended in her divinity how was she grieved the Queen of Heaven to drive a man noted for virtue to endure such dangers to face so many trials Can there be such anger in the minds of the gods"

let prepare_data s =
  (* Each word in the sentence is projected to a unique index. Total index number is n.
    In x and y, each row represent one word. w2i and i2w are the projection hash tables.
   *)

  (* split string to list of words *)
  let s = Owl_nlp_utils.load_from_string s in
  (* build word-index exchange tables *)
  let w2i, i2w = Owl_nlp_utils.build_vocabulary [|s|] in
  let m = Array.length s in
  let n = Hashtbl.length w2i in
  let x = Dense.Matrix.S.zeros (m-1) n in
  let y = Dense.Matrix.S.zeros (m-1) n in
  (* project each word into a index integer *)
  let s = Owl_nlp_utils.tokenise w2i s in
  for i = 0 to m - 2 do x.{i, s.(i)} <- 1. done;
  for i = 1 to m - 1 do y.{i-1, s.(i)} <- 1. done;
  n, w2i, i2w, x, y

let sample w2i i2w nn =
  let headword = "I" in
  let m = 20 in
  let n = Hashtbl.length w2i in
  let w = Hashtbl.find w2i headword  in
  (* The sentence to be generated. Initialized by head word *)
  let l = Array.make m headword in
  let v = ref (Mat (Dense.Vector.S.unit_basis n w)) in
  for i = 1 to m - 1 do
    v := Graph.run !v nn;
    (* Choose the most likely candidate for next word *)
    let _, j = Dense.Vector.S.max_i (unpack_mat !v) in
    let w = Hashtbl.find i2w j in
    l.(i) <- w;
  done;
  (* Print words in a list as a string *)
  let s = Array.fold_left (fun a b -> a ^ " " ^ b) "" l in
  print_endline s

let train_lstm () =
  let n, w2i, i2w, x, y = prepare_data s in
  let nn = input [|n|]
    |> linear 20
    |> lstm 100
    |> linear n ~act_typ:Activation.Softmax
    |> get_network
  in
  print nn;
  (* Using this learning_rate to makes things much faster. *)
  let params = Params.config
    ~batch:Batch.Full ~learning_rate:(Learning_Rate.Adagrad 0.01) 500. in
  train ~params nn x y;
  Owl_neural_graph.save nn model_name

let inference_lstm () =
  let nn = Owl_neural_graph.load model_name in
  let _, w2i, i2w, _, _ = prepare_data s in
  sample w2i i2w nn

let _ =
  try
    inference_lstm ()
  with
    Sys_error _ ->
      Log.info "Pretrained model not found. Start to train.";
      train_lstm (); inference_lstm ()
