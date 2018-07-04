(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module Optimiser : Owl_computation_optimiser_sig.Sig

  open Optimiser

  open Optimiser.Operator.Symbol.Shape.Type

  open Optimiser.Operator.Symbol.Shape.Type.Device


  type graph

      val shape_or_value : t -> string
      val graph_to_dot : graph -> string
      val graph_to_trace : graph -> string
      val save_graph : 'a -> string -> unit
      val load_graph : string -> 'a * 'b
      val collect_rvs : attr Owl_graph.node array -> attr Owl_graph.node array
      val invalidate_rvs : graph -> unit
      val make_graph :
        input:attr Owl_graph.node array ->
        output:attr Owl_graph.node array -> string -> graph
      val get_inputs : graph -> attr Owl_graph.node array
      val get_outputs : graph -> attr Owl_graph.node array
      val get_node_arr_val : attr Owl_graph.node -> A.arr
      val get_node_elt_val : attr Owl_graph.node -> A.elt
      val set_node_arr_val : attr Owl_graph.node -> value -> unit
      val set_node_elt_val : attr Owl_graph.node -> value -> unit
      val is_iopair_safe : 'a Owl_graph.node -> 'a Owl_graph.node -> bool
      val make_iopair :
        graph -> attr Owl_graph.node array -> attr Owl_graph.node array -> unit
      val update_iopair : graph -> unit
      val remove_unused_iopair :
        'a Owl_graph.node array ->
        'b array -> 'a Owl_graph.node array * 'b array
      val init_inputs : (attr Owl_graph.node -> value) -> graph -> unit
      val optimise : graph -> unit


end
