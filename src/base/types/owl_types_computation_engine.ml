(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Sig = sig
  module Graph : Owl_computation_graph_sig.Sig

  open Graph
  open Graph.Optimiser.Operator.Symbol.Shape.Type

  (** {5 Core evaluation functions of the engine} *)

  val eval_arr : arr array -> unit
  (** TODO *)

  val eval_elt : elt array -> unit
  (** TODO *)

  val eval_graph : graph -> unit
  (** TODO *)
end
