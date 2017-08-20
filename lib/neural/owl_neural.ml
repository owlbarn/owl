(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Neural network: module aliases *)

(** NOTE: this is an experimental module being built now *)


open Owl_algodiff.S
open Owl_neural_neuron


(* module aliases: two network types & parallel *)

module Graph          = Owl_neural_graph
module Parallel       = Owl_neural_parallel


(* module aliases: weight init and activation *)

module Init           = Owl_neural_neuron.Init
module Activation     = Owl_neural_neuron.Activation


(* module aliases: optimisation configuration *)

module Params         = Owl_neural_optimise.Params
module Batch          = Owl_neural_optimise.Batch
module Learning_Rate  = Owl_neural_optimise.Learning_Rate
module Loss           = Owl_neural_optimise.Loss
module Gradient       = Owl_neural_optimise.Gradient
module Momentum       = Owl_neural_optimise.Momentum
module Regularisation = Owl_neural_optimise.Regularisation
module Clipping       = Owl_neural_optimise.Clipping
module Checkpoint     = Owl_neural_optimise.Checkpoint



(* ends here *)
