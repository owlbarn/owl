#!/usr/bin/env owl
(* Text Generation using LSTM.
  The book used is Alice’s Adventures in Wonderland by Lewis Carroll.
 *)

#zoo "ead57c6e9d645fcd1770d61659f4762c"

open Owl
open Owl_neural
open Algodiff.S
open Owl_neural_graph


let check_xy i2w x y =
  Dense.Matrix.S.(iter2_rows (fun x' y' ->
    Printf.printf "x: ";
    iter (fun i -> Printf.printf "%c" (Hashtbl.find i2w i)) x';
    Printf.printf "  y: ";
    iter (fun i -> Printf.printf "%c" (Hashtbl.find i2w i)) y';
    print_endline ""
  )) x y

(*
let test_model nn i2w x y =
  let model = model nn in
  let start_chars = ref x in
  for i = 0 to wndsz - 1 do
    let xt = Dense.Matrix.S.slice [[];[i;i+wndsz-1]] !start_chars in
    let yt = model xt in
    let next_i = Dense.Matrix.S.max_i yt in
    start_chars := Dense.Matrix.S.
  done
*)

let str_to_chars s =
  let l = Array.make (String.length s) ' ' in
  String.iteri (fun i c -> l.(i) <- c) s;
  l


let preprocess wndsz stepsz =
  Log.info "load file ...";
  let txt = load_file "ead57c6e9d645fcd1770d61659f4762c/wonderland.txt" in
  let chars = txt |> String.lowercase_ascii |> str_to_chars in

  Log.info "build vocabulary ...";
  let h = Hashtbl.create 1024 in
  Array.iter (fun c ->
    if Hashtbl.mem h c = false then (
      Hashtbl.add h c c;
    )
  ) chars;
  let w2i = Hashtbl.create 1024 in
  let i2w = Hashtbl.create 1024 in
  Hashtbl.fold (fun k v a -> v :: a) h []
  |> List.sort (Pervasives.compare)
  |> List.iteri (fun i w ->
      Hashtbl.add w2i w (float_of_int i);
      Hashtbl.add i2w (float_of_int i) w;
    );

  Log.info "tokenise ...";
  let tokens = Array.map (Hashtbl.find w2i) chars in

  Log.info "make x matrix ...";
  let m = (Array.length chars - wndsz) / stepsz in
  let x = Dense.Matrix.S.zeros m wndsz in
  for i = 0 to m - 1 do
    for j = 0 to wndsz - 1 do
      x.{i,j} <- tokens.(i*stepsz + j)
    done;
  done;

  Log.info "make y matrix (one-hot) ...";
  let y = Dense.Matrix.S.zeros m (Hashtbl.length w2i) in
  for i = 0 to m - 1 do
    let j = int_of_float tokens.(i*stepsz + wndsz) in
    y.{i,j} <- 1.
  done;

  Log.info "chars:%i, symbols:%i, wndsz:%i, stepsz:%i"
    (String.length txt) (Hashtbl.length w2i) wndsz stepsz;
  (* return vocabulary and data *)
  w2i, i2w, x, y


let make_network wndsz vocabsz =
  input [|wndsz|]
  |> embedding vocabsz 40
  |> lstm 128
  |> linear 512 ~act_typ:Activation.Relu
  |> linear vocabsz ~act_typ:Activation.Softmax
  |> get_network


let _ =
  let wndsz = 50 in
  let stepsz = 1 in
  let w2i, i2w, x, y = preprocess wndsz stepsz in
  let vocabsz = Hashtbl.length w2i in
  (* check_xy i2w x y;
  Printf.printf "[%i,%i]\n" (Dense.Matrix.S.row_num x) (Dense.Matrix.S.col_num x);
  *)

  let network = make_network wndsz vocabsz in
  Graph.print network;
  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.01) 100.
  in
  train ~params network x y |> ignore
