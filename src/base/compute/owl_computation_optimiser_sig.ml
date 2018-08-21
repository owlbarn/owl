(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Operator : Owl_computation_operator_sig.Sig

  open Operator.Symbol.Shape.Type

  (** {6 Core functions} *)

  val estimate_complexity : 'a Owl_graph.node array -> int * int
  (** TODO *)

  val optimise_nodes : attr Owl_graph.node array -> unit
  (** TODO *)


end
