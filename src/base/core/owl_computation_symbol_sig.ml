(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Shape : Owl_computation_shape_sig.Sig

  open Shape

  open Type

  open Device
  
  val op_to_str : op -> string
      val is_random_variable : op -> bool
      val refnum : 'a Owl_graph.node -> int
      val node_shape : attr Owl_graph.node -> int array
      val is_shape_unkown : attr Owl_graph.node -> bool
      val infer_shape_graph : attr Owl_graph.node array -> unit
      val shape_to_str : int array option array -> string
      val node_to_str : attr Owl_graph.node -> string
      val node_to_arr : t -> arr
      val arr_to_node : arr -> t
      val node_to_elt : t -> elt
      val elt_to_node : elt -> t
      val make_node :
        ?name:string ->
        ?value:value array ->
        ?shape:int array option array ->
        ?freeze:bool ->
        ?reuse:bool -> ?state:state -> op -> attr Owl_graph.node
      val make_then_connect :
        ?shape:int array option array ->
        op -> attr Owl_graph.node array -> attr Owl_graph.node
      val var_arr : ?shape:int array -> string -> arr
      val var_elt : string -> elt
      val const_arr : string -> A.arr -> arr
      val const_elt : string -> A.elt -> elt
      val set_value : attr Owl_graph.node -> value array -> unit
      val get_value : attr Owl_graph.node -> value array
      val set_operator : attr Owl_graph.node -> op -> unit
      val get_operator : attr Owl_graph.node -> op
      val set_reuse : attr Owl_graph.node -> bool -> unit
      val get_reuse : attr Owl_graph.node -> bool
      val set_vnode : attr Owl_graph.node -> t array -> unit
      val get_vnode : attr Owl_graph.node -> t array
      val is_inherited : attr Owl_graph.node -> bool
      val is_var : attr Owl_graph.node -> bool
      val is_const : attr Owl_graph.node -> bool
      val is_arr : attr Owl_graph.node -> bool
      val is_elt : attr Owl_graph.node -> bool
      val is_assigned : attr Owl_graph.node -> bool
      val check_assigned : attr Owl_graph.node -> unit
      val is_valid : attr Owl_graph.node -> bool
      val validate : attr Owl_graph.node -> unit
      val invalidate : attr Owl_graph.node -> unit
      val invalidate_graph : attr Owl_graph.node -> unit
      val is_freeze : attr Owl_graph.node -> bool
      val freeze : attr Owl_graph.node -> unit
      val freeze_descendants : attr Owl_graph.node array -> unit
      val freeze_ancestors : attr Owl_graph.node array -> unit
      val pack_arr : A.arr -> arr
      val unpack_arr : arr -> A.arr
      val pack_elt : A.elt -> elt
      val unpack_elt : elt -> A.elt
      val unsafe_assign_arr : arr -> A.arr -> unit
      val assign_arr : arr -> A.arr -> unit
      val assign_elt : elt -> A.elt -> unit
      val float_to_elt : float -> elt
      val elt_to_float : elt -> float


end
