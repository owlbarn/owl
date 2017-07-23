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

  let param
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


module Linear = struct

  let to_specs x =
    let typ = ST.(`Linear) in
    let param = ST.param () in
    typ, param


  let of_specs spec = None

end


module Feedforward = struct

  let to_specs x =
    let layers = FN.(x.layers)
      |> Array.to_list
      |> List.map _layer_to_specs
    in
    ST.({ name = "Feedforward"; layers })

end


let _ =
  print_endline "hello"
