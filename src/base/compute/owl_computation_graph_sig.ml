(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Sig = sig
  module Optimiser : Owl_computation_optimiser_sig.Sig

  open Optimiser.Operator.Symbol.Shape.Type
  open Optimiser.Operator.Symbol.Shape.Type.Device

  (** {5 Type definition} *)

  type graph

  (** {5 Core functions} *)

  val shape_or_value : t -> string
  (** print shape for ndarrays, whilst value for scalars *)

  val graph_to_dot : graph -> string
  (** generate a string that can be written to a .dot file to draw the graph *)

  val graph_to_trace : graph -> string
  (** print the graph structure to a string *)

  val save_graph : 'a -> string -> unit
  (** save the graph object to a file with given name, using marshall format *)

  val load_graph : string -> 'a * 'b
  (** load the graph object from a file with given name *)

  val collect_rvs : attr Owl_graph.node array -> attr Owl_graph.node array
  (** traverse each node in the input array, and return the random variable type nodes. *)

  val invalidate_rvs : graph -> unit
  (** TODO *)

  val make_graph
    :  input:attr Owl_graph.node array
    -> output:attr Owl_graph.node array
    -> string
    -> graph
  (** Build a graph based on input nodes, output nodes, and graph name *)

  val get_inputs : graph -> attr Owl_graph.node array
  (** get input nodes of a graph *)

  val get_outputs : graph -> attr Owl_graph.node array
  (** get output nodes of a graph *)

  val get_node_arr_val : attr Owl_graph.node -> A.arr

  val get_node_elt_val : attr Owl_graph.node -> A.elt

  val set_node_arr_val : attr Owl_graph.node -> value -> unit

  val set_node_elt_val : attr Owl_graph.node -> value -> unit

  val is_iopair_safe : 'a Owl_graph.node -> 'a Owl_graph.node -> bool

  val make_iopair
    :  graph
    -> attr Owl_graph.node array
    -> attr Owl_graph.node array
    -> unit
  (** create an iopair between the input nodes and output nodes in a graph *)

  val update_iopair : graph -> unit

  val remove_unused_iopair
    :  'a Owl_graph.node array
    -> 'b array
    -> 'a Owl_graph.node array * 'b array
  (** remove unuserd iopair from an array of nodes *)

  val init_inputs : (attr Owl_graph.node -> value) -> graph -> unit
  (** initialize inputs nodes of a graph with given function [f] *)

  val optimise : graph -> unit
  (** optimise the graph structure *)
  
end
