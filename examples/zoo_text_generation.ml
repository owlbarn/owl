(*
Example script to generate text from Nietzsche's writings.
At least 20 epochs are required before the generated text
starts sounding coherent.
It is recommended to run this script on GPU, as recurrent
networks are quite computationally intensive.

Adapted from Keras example: lstm_text_generation.py
*)

open Algodiff.S
open Owl_neural
open Owl_neural_graph

let model_name = "basic_lstm.model"
let maxlen = 40
let step = 3
let fname = "sherlock_short.txt" (* https://sherlock-holm.es/ascii/ *)

(* On 32-bit machine this function can load at most 16M text. For loading
larger file, see https://rosettacode.org/wiki/Read_entire_file#OCaml *)
let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  s

let prepare_data fname =
  (* requires ver > 4.03; returns a copy *)
  let text = load_file fname |> String.lowercase_ascii in

  (* Extra processing: \t, \n and multiple spaces to one space *)
  (* let remove_special = Str.global_replace (Str.regexp "[\n|\t]") " "
  let remove_whitespaces = Str.global_replace (Str.regexp " +") " "
  let s = s |> remove_special |> remove_whitespaces *)

  let text_len = String.length text in
  Printf.printf "Corpus length: %d " text_len;

  (* string to list of chars -- not quite fast*)
  let explode s =
    let rec exp i l =
      if i < 0 then l else exp (i - 1) (s.[i] :: l) in
    exp (String.length s - 1) []
  in
  let char_comp a b =
    if a = b then 0 else
    if a > b then 1 else -1
  in
  let chars = text
    |> explode
    |> List.sort_uniq char_comp
  in

  let chars_len = List.length chars in
  Printf.printf "Corpus length: %d " chars_len;

  (* build volcabulary *)
  let c2i = Hashtbl.create chars_len in
  let i2c = Hashtbl.create chars_len in
  let _ = List.iteri (fun i c ->
      Hashtbl.add c2i c i;
      Hashtbl.add i2c i c;
    ) chars
  in
  (* cut the text in semi-redundant sequences of maxlen characters *)

  (* let for_step a b step fn =
    let rec aux i =
      if i <= b then begin
        fn i;
        aux (i+step)
      end
    in
    aux a
  *)

  (* Generate Dataset *)

  let sentences  = ref [] in  (* each element is of length maxlen *)
  let next_chars = ref [] in (* each element is the next char of the elem in sentences *)

  (* Possible inefficiency? *)
  let i = ref 0 in
  while !i < (text_len - maxlen) do
    sentences  := List.append !sentences  [ String.sub text !i maxlen ];
    next_chars := List.append !next_chars [ String.get text (!i + maxlen) ];
    i := !i + step;
  done;

  let sentences = !sentences in
  let next_chars = !next_chars in
  let sent_len = List.length next_chars in

  (* Vectorization *)
  Log.info "Vectorization...";
  let x = Dense.Ndarray.S.zeros [|sent_len; maxlen; chars_len|] in (* we just need each elem to be bool *)
  let y = Dense.Matrix.S.zeros  sent_len chars_len in

  List.iteri (fun i s ->
    String.iteri (fun j c ->
      (* x.(i, j, (Hashtbl.find c2i c)) <- 1. *)
      Dense.Ndarray.S.set x [|i; j; (Hashtbl.find c2i c)|] 1.;
    ) s;

    let ch = List.nth next_chars i in
    let c_ind = Hashtbl.find c2i ch in
    y.{i, c_ind } <- 1.
  ) sentences;
  (* assert  Dense.Matrix.S.sum = sent_len *)
  chars_len, c2i, i2c, x, y

(* Currently the training is unavailable  *)
let train_tg () =
  (* Build a simple LSTM model *)
  let chars_len, c2i, i2c, x, y = prepare_data fname in
  let nn = input [|maxlen; chars_len|]
    |> flatten  (* lstm node only support 1D input? *)
    |> lstm 128
    |> fully_connected chars_len ~act_typ:Activation.Softmax
    |> get_network
  in
  print nn;
  (* add an optimizer RMSprop(lr=0.01) ? *)
  let params = Params.config
      ~batch:Batch.Full ~learning_rate:(Learning_Rate.Adagrad 0.01) 500. in
  train_cnn ~params nn x y
