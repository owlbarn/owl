(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Functor to create neural networks of different precision. *)

open Owl_types


module Make (A : Ndarray_Algodiff) = struct

  (* module aliases: graphical network & parallel *)

  module Algodiff       = Owl_algodiff_generic.Make (A)
  module Graph          = Owl_neural_graph.Make (A)
  (* module Parallel       = Owl_neural_parallel.Make (Graph) *)

  (* module aliases: weight init and activation *)

  module Init           = Graph.Neuron.Init
  module Activation     = Graph.Neuron.Activation

  (* module aliases: optimisation configuration *)

  module Params         = Graph.Optimise.Params
  module Batch          = Graph.Optimise.Batch
  module Learning_Rate  = Graph.Optimise.Learning_Rate
  module Loss           = Graph.Optimise.Loss
  module Gradient       = Graph.Optimise.Gradient
  module Momentum       = Graph.Optimise.Momentum
  module Regularisation = Graph.Optimise.Regularisation
  module Clipping       = Graph.Optimise.Clipping
  module Stopping       = Graph.Optimise.Stopping
  module Checkpoint     = Graph.Optimise.Checkpoint

end


(* ends here *)
