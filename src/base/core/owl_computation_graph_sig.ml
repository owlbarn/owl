(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module Optimiser : Owl_computation_optimiser_sig.Sig

  open Optimiser

  open Optimiser.Operator.Symbol.Shape.Type

  open Optimiser.Operator.Symbol.Shape.Type.Device


  (** {6 Type definition} *)

  type graph
  (** TODO *)


  (** {6 Core functions} *)

  val shape_or_value : t -> string
  (** TODO *)

  val graph_to_dot : graph -> string
  (** TODO *)

  val graph_to_trace : graph -> string
  (** TODO *)

  val save_graph : 'a -> string -> unit
  (** TODO *)

  val load_graph : string -> 'a * 'b
  (** TODO *)

  val collect_rvs : attr Owl_graph.node array -> attr Owl_graph.node array
  (** TODO *)

  val invalidate_rvs : graph -> unit
  (** TODO *)

  val make_graph : input:attr Owl_graph.node array -> output:attr Owl_graph.node array -> string -> graph
  (** TODO *)

  val get_inputs : graph -> attr Owl_graph.node array
  (** TODO *)

  val get_outputs : graph -> attr Owl_graph.node array
  (** TODO *)

  val get_node_arr_val : attr Owl_graph.node -> A.arr
  (** TODO *)

  val get_node_elt_val : attr Owl_graph.node -> A.elt
  (** TODO *)

  val set_node_arr_val : attr Owl_graph.node -> value -> unit
  (** TODO *)

  val set_node_elt_val : attr Owl_graph.node -> value -> unit
  (** TODO *)

  val is_iopair_safe : 'a Owl_graph.node -> 'a Owl_graph.node -> bool
  (** TODO *)

  val make_iopair : graph -> attr Owl_graph.node array -> attr Owl_graph.node array -> unit
  (** TODO *)

  val update_iopair : graph -> unit
  (** TODO *)

  val remove_unused_iopair : 'a Owl_graph.node array -> 'b array -> 'a Owl_graph.node array * 'b array
  (** TODO *)

  val init_inputs : (attr Owl_graph.node -> value) -> graph -> unit
  (** TODO *)

  val optimise : graph -> unit
  (** TODO *)


end
