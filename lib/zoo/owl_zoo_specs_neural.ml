(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module NN = Owl_neural_neuron
module FN = Owl_neural_feedforward
module GN = Owl_neural_graph
module SJ = Owl_zoo_specs_neural_j


module ST = struct

  include Owl_zoo_specs_neural_t

  let make_param
    ?in_shape
    ?out_shape
    ?activation_typ
    ()
    = {
      in_shape;
      out_shape;
      activation_typ;
    }

end


module Input = struct

  let to_specs x =
    let typ = ST.(`Input) in
    let param = ST.make_param in
    typ, param ()

  let of_specs spec = None

end


module Linear = struct

  let to_specs x =
    let typ = ST.(`Linear) in
    let param = ST.make_param in
    typ, param ()

  let of_specs spec = None

end


module Activation = struct

  let to_specs x =
    let open NN.Activation in
    let typ = ST.(`Activation) in
    let param =
      match x.activation with
      | Relu    -> ST.(make_param ~activation_typ:`Relu)
      | Sigmoid -> ST.(make_param ~activation_typ:`Sigmoid)
      | Softmax -> ST.(make_param ~activation_typ:`Softmax)
      | Tanh    -> ST.(make_param ~activation_typ:`Tanh)
      | None    -> ST.(make_param ~activation_typ:`None)
      | _       -> failwith "owl_zoo_specs_neural:activation:to_specs"
    in
    typ, param ()

  let of_specs spec = None

end



module Neuron = struct

  let to_specs = function
    | NN.Input x      -> Input.to_specs x
    | NN.Linear x     -> Linear.to_specs x
    | NN.Activation x -> Activation.to_specs x
    | _               -> failwith "owl_zoo_specs_neural:neuron:to_specs"

  let to_string = function
    | NN.Input x      -> "input"
    | NN.Linear x     -> "linear"
    | NN.Activation x -> "activation"
    | _               -> failwith "owl_zoo_specs_neural:neuron:to_string"

end


module Feedforward = struct

  let to_specs x =
    let layers = FN.(x.layers)
      |> Array.to_list
      |> List.mapi (fun i l ->
          let neuron, param = Neuron.to_specs l in
          let name = Printf.sprintf "%s_%i" (Neuron.to_string l) i in
          ST.({ name; neuron; param })
        )
    in
    ST.({ name = "Feedforward"; layers })

end


let make_example_network () =
  let open Owl_neural in
  let open Feedforward in
  let nn = input [|784|]
    |> linear 300 ~act_typ:Activation.Tanh
    |> linear 10  ~act_typ:Activation.Softmax
  in
  nn


let _ =
  let nn = make_example_network () in
  let nn = Feedforward.to_specs nn in
  let s = SJ.string_of_feedforward nn in
  print_endline (Yojson.Safe.prettify s)
