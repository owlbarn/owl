(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Neural network: module aliases *)

(** NOTE: this is an experimental module being built now *)


(** {6 Single precision neural network} *)
module S = struct

  (* module aliases: graphical network & parallel *)

  module Graph          = Owl_neural_graph.Make (Owl_dense_matrix.S) (Owl_dense_ndarray.S)
  module Parallel       = Owl_neural_parallel.Make (Graph)

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
  module Checkpoint     = Graph.Optimise.Checkpoint


end


(** {6 Double precision neural network} *)
module D = struct

  (* module aliases: graphical network & parallel *)

  module Graph          = Owl_neural_graph.Make (Owl_dense_matrix.D) (Owl_dense_ndarray.D)
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
  module Checkpoint     = Graph.Optimise.Checkpoint


end



(* ends here *)
