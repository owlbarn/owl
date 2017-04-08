(* Test recurrent neural network LSTM *)

open Owl
open Owl_algodiff_ad
open Owl_neural

let s = "I sing of arms and the man he who exiled by fate first came from the coast of Troy to Italy and to Lavinian shores hurled about endlessly by land and sea by the will of the gods, by cruel Junos remorseless anger long suffering also in war until he founded a city and brought his gods to Latium from that the Latin people came the lords of Alba Longa the walls of noble Rome Muse tell me the cause how was she offended in her divinity how was she grieved the Queen of Heaven to drive a man noted for virtue to endure such dangers to face so many trials Can there be such anger in the minds of the gods"

let prepare_data s =
  let s = Owl_topic_utils.load_from_string s in
  let w2i, i2w = Owl_topic_utils.build_vocabulary [|s|] in
  let m = Array.length s in
  let n = Hashtbl.length w2i in
  let x = Dense.Matrix.S.zeros (m-1) n in
  let y = Dense.Matrix.S.zeros (m-1) n in
  let s = Owl_topic_utils.tokenise w2i s in
  for i = 0 to m - 2 do x.{i, s.(i)} <- 1. done;
  for i = 1 to m - 1 do y.{i-1, s.(i)} <- 1. done;
  n, w2i, i2w, x, y

let sample w2i i2w nn =
  let n = Hashtbl.length w2i in
  let w = Hashtbl.find w2i "I"  in
  let m = 20 in
  let l = Array.make m "I" in
  let v = ref (Mat (Dense.Vector.S.unit_basis n w)) in
  for i = 1 to m - 1 do
    v := Feedforward.run !v nn;
    let _, j = Dense.Vector.S.max_i (unpack_mat !v) in
    let w = Hashtbl.find i2w j in
    l.(i) <- w;
  done;
  let s = Array.fold_left (fun a b -> a ^ " " ^ b) "" l in
  print_endline s

let _ =
  let n, w2i, i2w, x, y = prepare_data s in
  let nn = Feedforward.create () in
  let l0 = linear n 20 in
  let l1 = lstm 20 100 in
  let l2 = linear 100 n in
  Feedforward.add_layer nn l0;
  Feedforward.add_layer nn l1;
  Feedforward.add_layer nn l2 ~act_typ:Activation.Softmax;
  print nn;

  let p = Params.default () in
  p.batch <- Batch.Fullbatch;
  p.epochs <- 500;
  p.learning_rate <- Learning_Rate.Adagrad 0.01;  (* this makes things much faster. *)
  train ~params:p nn x y;
  sample w2i i2w nn
