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

module Params         = Owl_optimise.S.Params
module Batch          = Owl_optimise.S.Batch
module Learning_Rate  = Owl_optimise.S.Learning_Rate
module Loss           = Owl_optimise.S.Loss
module Gradient       = Owl_optimise.S.Gradient
module Momentum       = Owl_optimise.S.Momentum
module Regularisation = Owl_optimise.S.Regularisation
module Clipping       = Owl_optimise.S.Clipping
module Checkpoint     = Owl_optimise.S.Checkpoint



(* ends here *)
