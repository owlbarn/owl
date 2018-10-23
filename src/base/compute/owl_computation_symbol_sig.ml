(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

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

  val node_numel : attr Owl_graph.node -> int
  (** TODO *)

  val is_shape_unknown : attr Owl_graph.node -> bool
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

  val new_block_id : unit -> int
  (** ``new_block_id ()`` returns an unused block id. *)

  val make_empty_block : ?block_id:int -> int -> block
  (** ``make_empty_block s`` returns an empty block of memory of size ``s``. *)

  val make_value_block : value -> attr Owl_graph.node -> unit
  (**
  ``make_value_block value node`` creates a block of memory initialised with
  ``value`` and links the new block to ``node``.
   *)

  val get_block : attr Owl_graph.node -> block array
  (**
  ``get_block node`` returns the memory block allocated to ``node``.
  If no block is allocated, throws an exception.
   *)

  val add_node_to_block : attr Owl_graph.node -> block -> unit
  (**
  Link a node to a reusable block and initialises its memory on the memory of
  the block.
   *)

  val get_active_node : block -> (attr Owl_graph.node) option
  (** Return the node that is currently using the memory of the block. *)

  val set_active_node : block -> attr Owl_graph.node -> unit
  (** Update the node that is currently using the block of memory. *)

  val get_block_id : attr Owl_graph.node -> int
  (**
  ``get_block_id node`` returns the id of the block assigned to ``node``. If
  ``node`` has not been assigned yet, returns ``-1``.
   *)

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

  val is_reusable : attr Owl_graph.node -> bool
  (** TODO *)

  val is_shared : attr Owl_graph.node -> bool
  (** TODO *)

  val get_shared_nodes : attr Owl_graph.node -> (attr Owl_graph.node) array
  (**
  ``get_shared_nodes node`` returns the nodes sharing the same block of memory
  as ``node``.
   *)

  val is_var : attr Owl_graph.node -> bool
  (** TODO *)

  val is_const : attr Owl_graph.node -> bool
  (** TODO *)

  val is_node_arr : attr Owl_graph.node -> bool
  (** TODO *)

  val is_node_elt : attr Owl_graph.node -> bool
  (** TODO *)

  val is_assigned : attr Owl_graph.node -> bool
  (**
  ``is_assigned node`` checks if a block of memory has been assigned to
  ``node``.
   *)

  val check_assigned : attr Owl_graph.node -> unit
  (**
  ``check_assigned node`` throws an exception if ``node`` has not been
  assigned to a block.
   *)

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
