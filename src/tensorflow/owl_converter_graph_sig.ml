(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_converter_node

module type Sig = sig

  module G : Owl_computation_graph_sig.Sig

  open G.Optimiser.Operator

  type tfgraph = {
    mutable nodes   : tfnode array;
    mutable version : string;
    mutable nametbl : (string, string) Hashtbl.t
  }

  val create : unit -> tfgraph

  val get_tfnode : tfgraph  -> string -> tfnode

  val expand_tfgraph : tfgraph -> Symbol.Shape.Type.attr Owl_graph.node -> unit

end
