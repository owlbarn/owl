#!/usr/bin/env owl
(* Text Generation using LSTM.
 * The book used is Alice’s Adventures in Wonderland by Lewis Carroll.
 *)

#zoo "217ef87bc36845c4e78e398d52bc4c5b"

open Owl
open Neural.S
open Neural.S.Graph
open Algodiff.S


let str_to_chars s =
  let l = Array.make (String.length s) ' ' in
  String.iteri (fun i c -> l.(i) <- c) s;
  l


let prepare wndsz stepsz =
  Owl_log.info "load file ...";
  let txt = load_file "217ef87bc36845c4e78e398d52bc4c5b" "wonderland.txt" in
  let chars = txt |> String.lowercase_ascii |> str_to_chars in

  Owl_log.info "build vocabulary ...";
  let h = Hashtbl.create 1024 in
  Array.iter (fun c ->
    if Hashtbl.mem h c = false then Hashtbl.add h c c
  ) chars;
  let w2i = Hashtbl.create 1024 in
  let i2w = Hashtbl.create 1024 in
  Hashtbl.fold (fun k v a -> v :: a) h []
  |> List.sort (Pervasives.compare)
  |> List.iteri (fun i w ->
      Hashtbl.add w2i w (float_of_int i);
      Hashtbl.add i2w (float_of_int i) w;
    );

  Owl_log.info "tokenise ...";
  let tokens = Array.map (Hashtbl.find w2i) chars in

  Owl_log.info "make x matrix (indices) ...";
  let m = (Array.length chars - wndsz) / stepsz in
  let x = Dense.Matrix.S.zeros m wndsz in
  for i = 0 to m - 1 do
    for j = 0 to wndsz - 1 do
      Dense.Matrix.S.set x i j tokens.(i*stepsz + j)
    done;
  done;

  Owl_log.info "make y matrix (one-hot) ...";
  let y = Dense.Matrix.S.zeros m (Hashtbl.length w2i) in
  for i = 0 to m - 1 do
    let j = int_of_float tokens.(i*stepsz + wndsz) in
    Dense.Matrix.S.set y i j 1.
  done;

  Owl_log.info "chars:%i, symbols:%i, wndsz:%i, stepsz:%i"
    (String.length txt) (Hashtbl.length w2i) wndsz stepsz;
  w2i, i2w, x, y


let make_network wndsz vocabsz =
  input [|wndsz|]
  |> embedding vocabsz 40
  |> lstm 128
  |> linear 512 ~act_typ:Activation.Relu
  |> linear vocabsz ~act_typ:Activation.Softmax
  |> get_network


let test nn i2w wndsz tlen x =
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
  |> Array.map (Hashtbl.find i2w)
  |> Array.fold_left (fun a c -> a ^ (String.make 1 c)) ""
  |> Printf.printf "generated text: %s\n"
  |> flush_all


let train () =
  let wndsz = 100 and stepsz = 1 in
  let w2i, i2w, x, y = prepare wndsz stepsz in
  let vocabsz = Hashtbl.length w2i in

  let network = make_network wndsz vocabsz in
  Graph.print network;
  let params = Params.config
    ~checkpoint:(Checkpoint.Custom (fun s ->
      if Checkpoint.(s.current_batch mod 100 = 0) then
        test network i2w wndsz 1000 (Dense.Matrix.S.row x 200)
    ))
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.01) 50.
  in
  train ~params network x y |> ignore


let _ = train ()
