(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff.S
open Owl_neural_neuron

(* Simple Feedforward neural network module *)

type network = {
  mutable layers : neuron array;
}


let create () = { layers = [||]; }

let layer_num nn = Array.length nn.layers

let get_layer nn i =
  let c = layer_num nn in
  match i < 0 with
  | true  -> nn.layers.(c + i)
  | false -> nn.layers.(i)

let connect_layer prev_l next_l =
  let out_shape = get_out_shape prev_l in
  match next_l with
  | Input l          -> () (* always the first layer *)
  | Linear l         -> Linear.connect out_shape l
  | LinearNoBias l   -> LinearNoBias.connect out_shape l
  | LSTM l           -> LSTM.connect out_shape l
  | GRU l            -> GRU.connect out_shape l
  | Recurrent l      -> Recurrent.connect out_shape l
  | Conv2D l         -> Conv2D.connect out_shape l
  | Conv3D l         -> Conv3D.connect out_shape l
  | FullyConnected l -> FullyConnected.connect out_shape l
  | MaxPool2D l      -> MaxPool2D.connect out_shape l
  | AvgPool2D l      -> AvgPool2D.connect out_shape l
  | Dropout l        -> Dropout.connect out_shape l
  | Reshape l        -> Reshape.connect out_shape l
  | Flatten l        -> Flatten.connect out_shape l
  | Lambda l         -> Lambda.connect out_shape l
  | Activation l     -> Activation.connect out_shape l

let rec add_layer ?act_typ nn l =
  (* check whether it is input layer *)
  let not_input_layer =
    function Input _ -> false | _ -> true
  in
  (* insert input layer as the first one given an empty nn *)
  if layer_num nn = 0 then (
    let in_shape = get_in_shape l in
    assert (Array.length in_shape > 0);
    assert (Array.exists ((<>)0) in_shape);
    nn.layers <- [|Input Input.(create in_shape)|];
  );
  (* retrieve the previous layer and attach the new one *)
  if not_input_layer l then (
    let prev_l = get_layer nn (-1) in
    connect_layer prev_l l;
    nn.layers <- Array.append nn.layers [|l|];
  );
  (* if activation is specified, recursively add_layer *)
  match act_typ with
  | Some act -> add_layer nn (Activation (Activation.create act))
  | None     -> ()

let init nn = Array.iter (function
  | Linear l         -> Linear.init l
  | LinearNoBias l   -> LinearNoBias.init l
  | LSTM l           -> LSTM.init l
  | GRU l            -> GRU.init l
  | Recurrent l      -> Recurrent.init l
  | Conv2D l         -> Conv2D.init l
  | Conv3D l         -> Conv3D.init l
  | FullyConnected l -> FullyConnected.init l
  | _                -> () (* activation, etc. *)
  ) nn.layers

let reset nn = Array.iter (function
  | Linear l          -> Linear.reset l
  | LinearNoBias l   -> LinearNoBias.reset l
  | LSTM l           -> LSTM.reset l
  | GRU l            -> GRU.reset l
  | Recurrent l      -> Recurrent.reset l
  | Conv2D l         -> Conv2D.reset l
  | Conv3D l         -> Conv3D.reset l
  | FullyConnected l -> FullyConnected.reset l
  | _                -> () (* activation, etc. *)
  ) nn.layers

let mktag t nn = Array.iter (function
  | Linear l         -> Linear.mktag t l
  | LinearNoBias l   -> LinearNoBias.mktag t l
  | LSTM l           -> LSTM.mktag t l
  | GRU l            -> GRU.mktag t l
  | Recurrent l      -> Recurrent.mktag t l
  | Conv2D l         -> Conv2D.mktag t l
  | Conv3D l         -> Conv3D.mktag t l
  | FullyConnected l -> FullyConnected.mktag t l
  | _                -> () (* activation, etc. *)
  ) nn.layers

let mkpar nn = Array.map (function
  | Linear l         -> Linear.mkpar l
  | LinearNoBias l   -> LinearNoBias.mkpar l
  | LSTM l           -> LSTM.mkpar l
  | GRU l            -> GRU.mkpar l
  | Recurrent l      -> Recurrent.mkpar l
  | Conv2D l         -> Conv2D.mkpar l
  | Conv3D l         -> Conv3D.mkpar l
  | FullyConnected l -> FullyConnected.mkpar l
  | _                -> [||] (* activation, etc. *)
  ) nn.layers

let mkpri nn = Array.map (function
  | Linear l         -> Linear.mkpri l
  | LinearNoBias l   -> LinearNoBias.mkpri l
  | LSTM l           -> LSTM.mkpri l
  | GRU l            -> GRU.mkpri l
  | Recurrent l      -> Recurrent.mkpri l
  | Conv2D l         -> Conv2D.mkpri l
  | Conv3D l         -> Conv3D.mkpri l
  | FullyConnected l -> FullyConnected.mkpri l
  | _                -> [||] (* activation, etc. *)
  ) nn.layers

let mkadj nn = Array.map (function
  | Linear l         -> Linear.mkadj l
  | LinearNoBias l   -> LinearNoBias.mkadj l
  | LSTM l           -> LSTM.mkadj l
  | GRU l            -> GRU.mkadj l
  | Recurrent l      -> Recurrent.mkadj l
  | Conv2D l         -> Conv2D.mkadj l
  | Conv3D l         -> Conv3D.mkadj l
  | FullyConnected l -> FullyConnected.mkadj l
  | _                -> [||] (* activation, etc. *)
  ) nn.layers

let update nn us = Array.iter2 (fun l u ->
  match l with
  | Linear l         -> Linear.update l u
  | LinearNoBias l   -> LinearNoBias.update l u
  | LSTM l           -> LSTM.update l u
  | GRU l            -> GRU.update l u
  | Recurrent l      -> Recurrent.update l u
  | Conv2D l         -> Conv2D.update l u
  | Conv3D l         -> Conv3D.update l u
  | FullyConnected l -> FullyConnected.update l u
  | _                -> () (* activation, etc. *)
  ) nn.layers us

let run x nn = Array.fold_left (fun a l ->
  match l with
  | Input l          -> Input.run a l
  | Linear l         -> Linear.run a l
  | LinearNoBias l   -> LinearNoBias.run a l
  | LSTM l           -> LSTM.run a l
  | GRU l            -> GRU.run a l
  | Recurrent l      -> Recurrent.run a l
  | Conv2D l         -> Conv2D.run a l
  | Conv3D l         -> Conv3D.run a l
  | FullyConnected l -> FullyConnected.run a l
  | MaxPool2D l      -> MaxPool2D.run a l
  | AvgPool2D l      -> AvgPool2D.run a l
  | Dropout l        -> Dropout.run a l
  | Reshape l        -> Reshape.run a l
  | Flatten l        -> Flatten.run a l
  | Lambda l         -> Lambda.run a l
  | Activation l     -> Activation.run a l
  ) x nn.layers

let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn

(*
let train nn loss_fun x =
  mktag (tag ()) nn;
  let loss = loss_fun (run x nn) in
  reverse_prop (F 1.) loss;
  loss
*)

let to_string nn =
  let s = ref "Feedforward network\n\n" in
  for i = 0 to Array.length nn.layers - 1 do
    let t = match nn.layers.(i) with
      | Input l          -> Input.to_string l
      | Linear l         -> Linear.to_string l
      | LinearNoBias l   -> LinearNoBias.to_string l
      | LSTM l           -> LSTM.to_string l
      | GRU l            -> GRU.to_string l
      | Recurrent l      -> Recurrent.to_string l
      | Conv2D l         -> Conv2D.to_string l
      | Conv3D l         -> Conv3D.to_string l
      | FullyConnected l -> FullyConnected.to_string l
      | MaxPool2D l      -> MaxPool2D.to_string l
      | AvgPool2D l      -> AvgPool2D.to_string l
      | Dropout l        -> Dropout.to_string l
      | Reshape l        -> Reshape.to_string l
      | Flatten l        -> Flatten.to_string l
      | Lambda l         -> Lambda.to_string l
      | Activation l     -> Activation.to_string l
    in
    s := !s ^ (Printf.sprintf "(%i): %s\n" i t)
  done; !s



(* ends here *)
