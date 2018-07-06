(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module Graph : Owl_neural_graph_sig.Sig

  module Optimise : Owl_optimise_generic_sig.Sig

  module Algodiff : Owl_algodiff_generic_sig.Sig

  (* FIXME: urgh, I don't know how to write the signature for Make functor! *)

end
