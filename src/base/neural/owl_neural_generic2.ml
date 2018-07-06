(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Functor to create neural networks of different precision. *)

module Make_Embedded
  (A : Owl_types_ndarray_algodiff.Sig)
  = struct

  include
    Owl_neural_graph2.Make (
      Owl_neural_neuron2.Make (
        Owl_optimise_generic2.Make (
          Owl_algodiff_generic2.Make (A)
        )
      )
    )

end


module Flatten
  (Graph : Owl_neural_graph_sig2.Sig)
  = struct

  (* module aliases: graphical network & parallel *)

  module Graph          = Graph
  module Algodiff       = Graph.Neuron.Optimise.Algodiff
  (* module Parallel       = Owl_neural_parallel.Make (Graph) *)

  (* module aliases: weight init and activation *)

  module Init           = Graph.Neuron.Init
  module Activation     = Graph.Neuron.Activation

  (* module aliases: optimisation configuration *)

  module Params         = Graph.Neuron.Optimise.Params
  module Batch          = Graph.Neuron.Optimise.Batch
  module Learning_Rate  = Graph.Neuron.Optimise.Learning_Rate
  module Loss           = Graph.Neuron.Optimise.Loss
  module Gradient       = Graph.Neuron.Optimise.Gradient
  module Momentum       = Graph.Neuron.Optimise.Momentum
  module Regularisation = Graph.Neuron.Optimise.Regularisation
  module Clipping       = Graph.Neuron.Optimise.Clipping
  module Stopping       = Graph.Neuron.Optimise.Stopping
  module Checkpoint     = Graph.Neuron.Optimise.Checkpoint

end


module Make
  (A : Owl_types_ndarray_algodiff.Sig)
  = struct

  include Flatten (Make_Embedded (A))

end


(* ends here *)
