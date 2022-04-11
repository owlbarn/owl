(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(* Functor of making the symbols of a computation graph. *)

module type Sig = sig
  module Operator : Owl_computation_operator_sig.Sig

  open Operator.Symbol.Shape.Type

  (** {5 Core functions} *)

  val estimate_complexity : 'a Owl_graph.node array -> int * int
  (** TODO *)

  val optimise_nodes : attr Owl_graph.node array -> unit
  (** TODO *)
end
