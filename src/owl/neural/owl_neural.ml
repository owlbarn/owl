(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Single precision neural network} *)

module S = struct
  include Owl_neural_generic.Make (Owl_dense_ndarray.S)
  (* module Parallel = Owl_neural_parallel.Make (Graph) *)
end


(** {6 Double precision neural network} *)

module D = struct
  include Owl_neural_generic.Make (Owl_dense_ndarray.D)
  (* module Parallel = Owl_neural_parallel.Make (Graph) *)
end
