(* This example demonstrates using lazy functor to train a LSTM network. *)

open Owl

module CPU_Engine = Owl_computation_cpu_engine.Make (Owl_algodiff_primal_ops.S)
module CGCompiler = Owl_neural_compiler.Make (CPU_Engine)

open CGCompiler.Neural
open CGCompiler.Neural.Graph


let prepare window step =
  Owl_log.info "build vocabulary and tokenise ...";
  let chars = Owl_io.read_file ~trim:true (Sys.getenv "HOME" ^ "/.owl/dataset/wonderland.txt") |> Array.to_list in
  let chars = String.concat "" chars  |> String.lowercase_ascii in
  let vocab = Nlp.Vocabulary.build_from_string ~alphabet:true chars in
  let t_arr = Nlp.Vocabulary.tokenise vocab chars |> Array.map float_of_int in
  let tokens = Dense.Ndarray.S.of_array t_arr [| Array.length t_arr |] in

  Owl_log.info "construct x (sliding) and y (one-hot) ...";
  let x = Dense.Ndarray.S.slide ~step:1 ~window tokens in
  let l = Dense.Ndarray.S.get_slice [[window; -1]] tokens in
  let y = Dense.Ndarray.S.(one_hot (Nlp.Vocabulary.length vocab) l) in

  Owl_log.info "chars:%i, symbols:%i, wndsz:%i, stepsz:%i"
    (String.length chars) (Nlp.Vocabulary.length vocab) window step;
  vocab, x, y


let make_network wndsz vocabsz =
  input [|wndsz|]
  |> embedding vocabsz 40
  |> lstm 128
  |> linear 512 ~act_typ:Activation.Relu
  |> linear vocabsz ~act_typ:Activation.(Softmax 1)
  |> get_network ~name:"lstm"


let train () =
  Owl_log.(set_level INFO);
  let wndsz = 100 and stepsz = 1 in
  let vocab, x, y = prepare wndsz stepsz in
  let vocabsz = Nlp.Vocabulary.length vocab in
  let x = CGCompiler.Engine.pack_arr x |> Algodiff.pack_arr in
  let y = CGCompiler.Engine.pack_arr y |> Algodiff.pack_arr in

  let network = make_network wndsz vocabsz in
  Graph.print network;
  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.01) 50.
  in
  CGCompiler.train ~params network x y |> ignore


let _ = train ()
