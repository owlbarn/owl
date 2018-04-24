#!/usr/bin/env owl
(* Text Generation using LSTM.
   The book used is Alice’s Adventures in Wonderland by Lewis Carroll.
 *)

#zoo "217ef87bc36845c4e78e398d52bc4c5b"

open Owl
open Neural.S
open Neural.S.Graph


let prepare window step =
  Owl_log.info "build vocabulary and tokenise ...";
  let chars = load_file ~gist:"217ef87bc36845c4e78e398d52bc4c5b" "wonderland.txt" |> String.lowercase_ascii in
  let vocab = Nlp.Vocabulary.build_from_string ~alphabet:true chars in
  let t_arr = Nlp.Vocabulary.tokenise vocab chars |> Array.map float_of_int in
  let tokens = Dense.Ndarray.S.of_array t_arr [| Array.length t_arr |] in

  Owl_log.info "construct x (sliding) and y (one-hot) ...";
  let x = Dense.Ndarray.S.slide ~step:1 ~window tokens in
  let y = Dense.Ndarray.S.(one_hot (Nlp.Vocabulary.length vocab) tokens.${[[window;-1]]}) in

  Owl_log.info "chars:%i, symbols:%i, wndsz:%i, stepsz:%i"
    (String.length chars) (Nlp.Vocabulary.length vocab) window step;
  vocab, x, y


let make_network wndsz vocabsz =
  input [|wndsz|]
  |> embedding vocabsz 40
  |> lstm 128
  |> linear 512 ~act_typ:Activation.Relu
  |> linear vocabsz ~act_typ:Activation.Softmax
  |> get_network


let sample nn vocab wndsz tlen x =
  let all_char = Dense.Matrix.S.resize x [|1; wndsz + tlen|] in
  for i = 0 to tlen - 1 do
    let xt = Dense.Matrix.S.get_slice [[];[i;i+wndsz-1]] all_char in
    let yt = Graph.run (Arr xt) nn |> Algodiff.S.unpack_arr |> Dense.Matrix.S.to_array in
    let next_i = Stats.(choose (Array.sub (argsort ~inc:false yt) 0 5) 1).(0) in
    Dense.Matrix.S.set all_char 0 (wndsz + i) (float_of_int next_i);
  done;
  Dense.Matrix.S.(to_array all_char.${ [[];[wndsz;-1]] })
  |> Array.fold_left (fun a i -> a ^ Nlp.Vocabulary.index2word vocab (int_of_float i)) ""
  |> Printf.printf "generated text: %s\n"
  |> flush_all


let train () =
  let wndsz = 100 and stepsz = 1 in
  let vocab, x, y = prepare wndsz stepsz in
  let vocabsz = Nlp.Vocabulary.length vocab in

  let network = make_network wndsz vocabsz in
  Graph.print network;
  let params = Params.config
    ~checkpoint:(Checkpoint.Custom (fun s ->
      if Checkpoint.(s.current_batch mod 100 = 0) then
        let xt = Dense.Matrix.S.draw_rows x 1 |> fst in
        sample network vocab wndsz 100 xt
    ))
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.01) 50.
  in
  train ~params network x y |> ignore


let _ = train ()
