(* Test recurrent neural network LSTM *)

open Owl
open Owl_neural

let _ =
  let nn = Feedforward.create () in
  let l0 = linear ~inputs:10 ~outputs:20 ~init_typ:Init.(Uniform (-0.05, 0.05)) in
  Feedforward.add_layer nn l0;
  print nn
