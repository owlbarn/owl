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

  (** {6 Core functions} *)

  val op_to_str : op -> string
  (** TODO *)

  val is_random_variable : op -> bool
  (** TODO *)

  val refnum : 'a Owl_graph.node -> int
  (** TODO *)

  val node_shape : attr Owl_graph.node -> int array
  (** TODO *)

  val is_shape_unkown : attr Owl_graph.node -> bool
  (** TODO *)

  val infer_shape_graph : attr Owl_graph.node array -> unit
  (** TODO *)

  val shape_to_str : int array option array -> string
  (** TODO *)

  val node_to_str : attr Owl_graph.node -> string
  (** TODO *)

  val node_to_arr : t -> arr
  (** TODO *)

  val arr_to_node : arr -> t
  (** TODO *)

  val node_to_elt : t -> elt
  (** TODO *)

  val elt_to_node : elt -> t
  (** TODO *)

  val make_node : ?name:string -> ?value:value array -> ?shape:int array option array -> ?freeze:bool -> ?reuse:bool -> ?state:state -> op -> attr Owl_graph.node
  (** TODO *)

  val make_then_connect : ?shape:int array option array -> op -> attr Owl_graph.node array -> attr Owl_graph.node
  (** TODO *)

  val var_arr : ?shape:int array -> string -> arr
  (** TODO *)

  val var_elt : string -> elt
  (** TODO *)

  val const_arr : string -> A.arr -> arr
  (** TODO *)

  val const_elt : string -> A.elt -> elt
  (** TODO *)

  val set_value : attr Owl_graph.node -> value array -> unit
  (** TODO *)

  val get_value : attr Owl_graph.node -> value array
  (** TODO *)

  val set_operator : attr Owl_graph.node -> op -> unit
  (** TODO *)

  val get_operator : attr Owl_graph.node -> op
  (** TODO *)

  val set_reuse : attr Owl_graph.node -> bool -> unit
  (** TODO *)

  val get_reuse : attr Owl_graph.node -> bool
  (** TODO *)

  val set_vnode : attr Owl_graph.node -> t array -> unit
  (** TODO *)

  val get_vnode : attr Owl_graph.node -> t array
  (** TODO *)

  val is_inherited : attr Owl_graph.node -> bool
  (** TODO *)

  val is_var : attr Owl_graph.node -> bool
  (** TODO *)

  val is_const : attr Owl_graph.node -> bool
  (** TODO *)

  val is_arr : attr Owl_graph.node -> bool
  (** TODO *)

  val is_elt : attr Owl_graph.node -> bool
  (** TODO *)

  val is_assigned : attr Owl_graph.node -> bool
  (** TODO *)

  val check_assigned : attr Owl_graph.node -> unit
  (** TODO *)

  val is_valid : attr Owl_graph.node -> bool
  (** TODO *)

  val validate : attr Owl_graph.node -> unit
  (** TODO *)

  val invalidate : attr Owl_graph.node -> unit
  (** TODO *)

  val invalidate_graph : attr Owl_graph.node -> unit
  (** TODO *)

  val is_freeze : attr Owl_graph.node -> bool
  (** TODO *)

  val freeze : attr Owl_graph.node -> unit
  (** TODO *)

  val freeze_descendants : attr Owl_graph.node array -> unit
  (** TODO *)

  val freeze_ancestors : attr Owl_graph.node array -> unit
  (** TODO *)

  val pack_arr : A.arr -> arr
  (** TODO *)

  val unpack_arr : arr -> A.arr
  (** TODO *)

  val pack_elt : A.elt -> elt
  (** TODO *)

  val unpack_elt : elt -> A.elt
  (** TODO *)

  val unsafe_assign_arr : arr -> A.arr -> unit
  (** TODO *)

  val assign_arr : arr -> A.arr -> unit
  (** TODO *)

  val assign_elt : elt -> A.elt -> unit
  (** TODO *)

  val float_to_elt : float -> elt
  (** TODO *)

  val elt_to_float : elt -> float
  (** TODO *)


end
