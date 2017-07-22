(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_neural
open Feedforward

module NN = Owl_neural_neuron
module FN = Owl_neural_feedforward
module GN = Owl_neural_graph
module ST = Owl_zoo_specs_neural_t
module SJ = Owl_zoo_specs_neural_j


let _get_activation_typ neuron =
  let open NN.Activation in
  match neuron.activation with
  | Relu -> ST.(`Relu)
  | Sigmoid -> ST.(`Sigmoid)
  | Softmax -> ST.(`Softmax)
  | Tanh -> ST.(`Tanh)


let _create_layer name neuron param =
  let open Owl_zoo_specs_neural_t in
  let param = { in_shape = None; out_shape = None; activation_typ = Some `Tanh } in
  { name; neuron; param }

let _layer_to_specs x =
  let open NN in
  match x with
  | Input n  -> _create_layer "input" ST.(`Input) ""
  | Linear n -> _create_layer "linear" ST.(`Linear) ""
  | Activation n -> _create_layer "activation" ST.(`Activation) ""
  | _ -> failwith "unknown"

let _feedforward_to_specs nn =
  let layers = nn.layers
    |> Array.to_list
    |> List.map _layer_to_specs
  in
  ST.({ name = "Feedforward"; layers })


let feedforward_to_json nn =
  let nn = _feedforward_to_specs nn in
  SJ.string_of_feedforward nn

let of_json x = ()

let _ =
  let nn = input [|784|]
    |> linear 300 ~act_typ:Activation.Tanh
    |> linear 10  ~act_typ:Activation.Softmax
  in
  let s = feedforward_to_json nn in
  print_endline (Yojson.Safe.prettify s)
