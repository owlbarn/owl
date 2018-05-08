(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Single precision neural network} *)

module S = struct
  include Owl_neural_generic.Make (Owl_base_dense_ndarray.S)
  module Parallel = Owl_base_neural_parallel.Make (Graph)
end
