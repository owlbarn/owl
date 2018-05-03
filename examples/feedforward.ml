#!/usr/bin/env owl
(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Feedforward Neural Network
 *  This is a complete example to show how to build up a Feedforward network in
 *  Owl. The code used to be part of Owl then superseded by Graph module. Now
 *  the module can be shared and used in scripting via Zoo System.
 *)

open Owl
open Owl_types
open Algodiff.S
open Owl.Neural.S
open Owl.Neural.S.Graph.Neuron


(* definition of Feedforward neural network *)

type layer = {
  mutable name   : string;
  mutable neuron : neuron;
}

type network = {
  mutable nnid   : string;
  mutable layers : layer array;
}


(* functions to manipulate the network *)

let make_network ?nnid () =
  let nnid = match nnid with
    | Some s -> s
    | None   -> "Feedforward network"
  in
  { nnid; layers = [||]; }

let layer_num nn = Array.length nn.layers

let make_layer ?name nn neuron =
  let name = match name with
    | Some s -> s
    | None   -> Printf.sprintf "%s_%i" (to_name neuron) (layer_num nn)
  in
  { name; neuron }

let get_layer nn i =
  let c = layer_num nn in
  match i < 0 with
  | true  -> nn.layers.(c + i)
  | false -> nn.layers.(i)

let connect_layer prev_l next_l =
  let prev_neuron = prev_l.neuron in
  let next_neuron = next_l.neuron in
  let out_shape = get_out_shape prev_neuron in
  connect [|out_shape|] next_neuron

let rec add_layer ?act_typ nn l =
  (* check whether it is input layer *)
  let not_input_layer l =
    match l.neuron with Input _ -> false | _ -> true
  in
  (* insert input layer as the first one given an empty nn *)
  if layer_num nn = 0 then (
    let in_shape = get_in_shape l.neuron in
    assert (Array.length in_shape > 0);
    assert (Array.exists ((<>)0) in_shape);
    let neuron = Input Input.(create in_shape) in
    nn.layers <- [| make_layer nn neuron |];
  );
  (* retrieve the previous layer and attach the new one *)
  if not_input_layer l then (
    let prev_l = get_layer nn (-1) in
    connect_layer prev_l l;
    nn.layers <- Array.append nn.layers [|l|];
  );
  (* if activation is specified, recursively add_layer *)
  match act_typ with
  | Some act ->
      let neuron = Activation (Activation.create act) in
      add_layer nn (make_layer nn neuron)
  | None     -> ()


(* functions to interface to optimisation engine *)

let init nn = Array.iter (fun l -> init l.neuron) nn.layers

let reset nn = Array.iter (fun l -> reset l.neuron) nn.layers

let mktag t nn = Array.iter (fun l -> mktag t l.neuron) nn.layers

let mkpar nn = Array.map (fun l -> mkpar l.neuron) nn.layers

let mkpri nn = Array.map (fun l -> mkpri l.neuron) nn.layers

let mkadj nn = Array.map (fun l -> mkadj l.neuron) nn.layers

let update nn us = Array.iter2 (fun l u -> update l.neuron u) nn.layers us

let run x nn = Array.fold_left (fun a l -> run [|a|] l.neuron) x nn.layers

let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn


(* functions to create functional layers *)

let input ?name inputs =
  let nn = make_network () in
  Input (Input.create inputs)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let activation ?name act_typ nn =
  Activation (Activation.create act_typ)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let linear ?name ?(init_typ = Init.Standard) ?act_typ outputs nn =
  Linear (Linear.create outputs init_typ)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let linear_nobias ?name ?(init_typ = Init.Standard) ?act_typ outputs nn =
  LinearNoBias (LinearNoBias.create outputs init_typ)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let recurrent ?name ?(init_typ=Init.Standard) ~act_typ outputs hiddens nn =
  Recurrent (Recurrent.create hiddens outputs act_typ init_typ)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let lstm ?name ?(init_typ=Init.Tanh) cells nn =
  LSTM (LSTM.create cells init_typ)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let gru ?name ?(init_typ=Init.Tanh) cells nn =
  GRU (GRU.create cells init_typ)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let conv2d ?name ?(padding = SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides nn =
  Conv2D (Conv2D.create padding kernel strides init_typ)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let conv3d ?name ?(padding = SAME) ?(init_typ=Init.Tanh) ?act_typ kernel_width kernel strides nn =
  Conv3D (Conv3D.create padding kernel strides init_typ)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let fully_connected ?name ?(init_typ = Init.Standard) ?act_typ outputs nn =
  FullyConnected (FullyConnected.create outputs init_typ)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let max_pool2d ?name ?(padding = SAME) ?act_typ kernel stride nn =
  MaxPool2D (MaxPool2D.create padding kernel stride)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let avg_pool2d ?name ?(padding = SAME) ?act_typ kernel stride nn =
  AvgPool2D (AvgPool2D.create padding kernel stride)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn

let dropout ?name rate nn =
  Dropout (Dropout.create rate)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let reshape ?name outputs nn =
  Reshape (Reshape.create outputs)
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let flatten ?name nn =
  Flatten (Flatten.create ())
  |> make_layer ?name nn
  |> add_layer nn;
  nn

let lambda ?name ?act_typ lambda nn =
  Lambda (Lambda.create lambda)
  |> make_layer ?name nn
  |> add_layer ?act_typ nn;
  nn


(* I/O functions *)

let to_string nn =
  let s = ref (nn.nnid ^ "\n\n") in
  for i = 0 to Array.length nn.layers - 1 do
    let name = nn.layers.(i).name in
    let neuron = to_string nn.layers.(i).neuron in
    s := !s ^ (Printf.sprintf "[ Layer %s ]:\n%s\n" name neuron)
  done; !s

let print nn = to_string nn |> Printf.printf "%s"

let save nn f = Owl_io.marshal_to_file nn f

let load f : network = Owl_io.marshal_from_file f

let save_weights nn f =
  let h = Hashtbl.create (layer_num nn) in
  Array.iter (fun l ->
    let ws = Graph.Neuron.mkpar l.neuron in
    Hashtbl.add h l.name ws
  ) nn.layers;
  Owl_io.marshal_to_file h f

let load_weights nn f =
  let h = Owl_io.marshal_from_file f in
  Array.iter (fun l ->
    let ws = Hashtbl.find h l.name in
    Graph.Neuron.update l.neuron ws
  ) nn.layers


(* training functions *)

let train ?state ?params ?(init_model=true) nn x y =
  if init_model = true then init nn;
  let p = match params with
    | Some p -> p
    | None   -> Params.default ()
  in
  Optimise.S.minimise_network ?state p (forward nn) (backward nn) (update nn) (save nn) (Arr x) (Arr y)

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Owl_dataset.print_mnist_image (unpack_arr u);
    let p = run u nn |> unpack_arr in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, i = Owl_dense_matrix_generic.max_i p in i.(1))
  ) (Arr x) (Arr y)



(* ends here *)
