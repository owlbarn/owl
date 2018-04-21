#!/usr/bin/env owl
(* Text Generation using LSTM.
 * The book used is Alice’s Adventures in Wonderland by Lewis Carroll.
 *)

#zoo "217ef87bc36845c4e78e398d52bc4c5b"

open Owl
open Neural.S
open Neural.S.Graph
open Algodiff.S


let prepare wndsz stepsz =
  Owl_log.info "build vocabulary ...";
  let txt = load_file ~gist:"217ef87bc36845c4e78e398d52bc4c5b" "wonderland.txt" in
  let chars = String.lowercase_ascii txt in
  let vocab = Owl_nlp.Vocabulary.build_from_string ~alphabet:true chars in

  Owl_log.info "tokenise ...";
  let tokens = Owl_nlp.Vocabulary.tokenise vocab chars in

  Owl_log.info "make x matrix (indices) ...";
  let m = (String.length chars - wndsz) / stepsz in
  let x = Dense.Matrix.S.zeros m wndsz in
  for i = 0 to m - 1 do
    for j = 0 to wndsz - 1 do
      Dense.Matrix.S.set x i j (float_of_int tokens.(i*stepsz + j))
    done;
  done;

  Owl_log.info "make y matrix (one-hot) ...";
  let y = Dense.Matrix.S.zeros m (Owl_nlp.Vocabulary.length vocab) in
  for i = 0 to m - 1 do
    let j = int_of_float (float_of_int tokens.(i*stepsz + wndsz)) in
    Dense.Matrix.S.set y i j 1.
  done;

  Owl_log.info "chars:%i, symbols:%i, wndsz:%i, stepsz:%i"
    (String.length txt) (Owl_nlp.Vocabulary.length vocab) wndsz stepsz;
  vocab, x, y


let make_network wndsz vocabsz =
  input [|wndsz|]
  |> embedding vocabsz 40
  |> lstm 128
  |> linear 512 ~act_typ:Activation.Relu
  |> linear vocabsz ~act_typ:Activation.Softmax
  |> get_network


let test nn vocab wndsz tlen x =
  let all_char = ref x in
  let nxt_char = Dense.Matrix.S.zeros 1 1 in
  for i = 0 to tlen - 1 do
    let xt = Dense.Matrix.S.get_slice [[];[i;i+wndsz-1]] !all_char in
    let yt = Graph.run (Arr xt) nn |> unpack_arr in
    let _, next_i = Dense.Matrix.S.max_i yt in
    Dense.Matrix.S.set nxt_char 0 0 (float_of_int next_i.(1));
    all_char := Dense.Matrix.S.(!all_char @|| nxt_char)
  done;
  Dense.Matrix.S.get_slice [[];[wndsz;-1]] !all_char
  |> Dense.Matrix.S.to_array
  |> Array.map (fun i -> Owl_nlp.Vocabulary.index2word vocab (int_of_float i))
  |> Array.fold_left (fun a c -> a ^ c) ""
  |> Printf.printf "generated text: %s\n"
  |> flush_all


let train () =
  let wndsz = 100 and stepsz = 1 in
  let vocab, x, y = prepare wndsz stepsz in
  let vocabsz = Owl_nlp.Vocabulary.length vocab in

  let network = make_network wndsz vocabsz in
  Graph.print network;
  let params = Params.config
    ~checkpoint:(Checkpoint.Custom (fun s ->
      if Checkpoint.(s.current_batch mod 100 = 0) then
        test network vocab wndsz 500 (Dense.Matrix.S.row x 200)
    ))
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.01) 50.
  in
  train ~params network x y |> ignore


let _ = train ()
