(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Operator : Owl_computation_operator_sig.Sig

  open Operator

  open Operator.Symbol.Shape.Type


  val estimate_complexity : 'a Owl_graph.node array -> int * int

  val optimise_nodes : attr Owl_graph.node array -> unit


end
