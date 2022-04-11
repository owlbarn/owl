(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** {5 Single precision neural network} *)

module S = struct
  include Owl_neural_generic.Make (Owl_algodiff_primal_ops.S)

  (* module Parallel = Owl_neural_parallel.Make (Graph) *)
end

(** {5 Double precision neural network} *)

module D = struct
  include Owl_neural_generic.Make (Owl_algodiff_primal_ops.D)

  (* module Parallel = Owl_neural_parallel.Make (Graph) *)
end
