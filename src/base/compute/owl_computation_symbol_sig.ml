(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(* Functor of making the symbols of a computation graph. *)

module type Sig = sig
  module Shape : Owl_computation_shape_sig.Sig

  open Shape
  open Type
  open Device

  (** {5 Core functions} *)

  val op_to_str : op -> string
  (** return the name of the operator as string *)

  val is_random_variable : op -> bool
  (** check if operator is randon variable *)

  val refnum : 'a Owl_graph.node -> int
  (** return the reference number of the given node  *)

  val node_shape : attr Owl_graph.node -> int array
  (** return the shape of a node  *)

  val node_numel : attr Owl_graph.node -> int
  (** return the number of elements of a node *)

  val is_shape_unknown : attr Owl_graph.node -> bool
  (** check if the shape of the input node is unknown *)

  val infer_shape_graph : attr Owl_graph.node array -> unit
  (** automatically infer the shape of input node according to its descendents' shapes *)

  val shape_to_str : int array option array -> string
  (** helper function; return the input array in string format. *)

  val node_to_str : attr Owl_graph.node -> string
  (** print node's information to string *)

  val node_to_arr : t -> arr
  (** Wrap computation graph node in an array type *)

  val arr_to_node : arr -> t
  (** Unwrap the array type to get the computation graph node within *)

  val node_to_elt : t -> elt
  (** Wrap computation graph node in an Elt type *)

  val elt_to_node : elt -> t
  (** Unwrap the Elt type to get the computation graph node within *)

  val make_node
    :  ?name:string
    -> ?value:value array
    -> ?shape:int array option array
    -> ?freeze:bool
    -> ?reuse:bool
    -> ?state:state
    -> op
    -> attr Owl_graph.node
  (** crate a computation graph node *)

  val make_then_connect
    :  ?shape:int array option array
    -> op
    -> attr Owl_graph.node array
    -> attr Owl_graph.node
  (** make nodes and then connect parents and children *)

  val var_arr : ?shape:int array -> string -> arr
  (** creat a node and wrap in Arr type *)

  val var_elt : string -> elt
  (** creat a node and wrap in Elt type *)

  val const_arr : string -> A.arr -> arr
  (** get ndarray value from input and create an node and wrap in Arr type *)

  val const_elt : string -> A.elt -> elt
  (** get value from input and create an node and wrap in Elt type *)

  val new_block_id : unit -> int
  (** [new_block_id ()] returns an unused block id. *)

  val make_empty_block : ?block_id:int -> int -> block
  (** [make_empty_block s] returns an empty block of memory of size [s]. *)

  val make_value_block : value -> attr Owl_graph.node -> unit
  (**
  [make_value_block value node] creates a block of memory initialised with
  [value] and links the new block to [node].
   *)

  val get_block : attr Owl_graph.node -> block array
  (**
  [get_block node] returns the memory block allocated to [node].
  If no block is allocated, throws an exception.
   *)

  val add_node_to_block : attr Owl_graph.node -> block -> unit
  (**
  Link a node to a reusable block and initialises its memory on the memory of
  the block.
   *)

  val get_active_node : block -> attr Owl_graph.node option
  (** Return the node that is currently using the memory of the block. *)

  val set_active_node : block -> attr Owl_graph.node -> unit
  (** Update the node that is currently using the block of memory. *)

  val get_block_id : attr Owl_graph.node -> int
  (**
  [get_block_id node] returns the id of the block assigned to [node]. If
  [node] has not been assigned yet, returns [-1].
   *)

  val set_value : attr Owl_graph.node -> value array -> unit
  (** set the arrays of value to cgraph node *)

  val get_value : attr Owl_graph.node -> value array
  (** get the arrays of value of cgraph node *)

  val set_operator : attr Owl_graph.node -> op -> unit
  (** set the operator of cgraph node *)

  val get_operator : attr Owl_graph.node -> op
  (** get the operator of cgraph node *)

  val set_reuse : attr Owl_graph.node -> bool -> unit
  (** set reuse attribute in a node *)

  val get_reuse : attr Owl_graph.node -> bool
  (** get reuse attribute in a node *)

  val is_shared : attr Owl_graph.node -> bool
  (** check of the data block of memory is shared in a node *)

  val get_shared_nodes : attr Owl_graph.node -> attr Owl_graph.node array
  (**
  [get_shared_nodes node] returns the nodes sharing the same block of memory
  as [node].
   *)

  val is_var : attr Owl_graph.node -> bool
  (** check if the node's operator is Var type *)

  val is_const : attr Owl_graph.node -> bool
  (** check if the node's operator is Const type *)

  val is_node_arr : attr Owl_graph.node -> bool
  (** check the shape of a node's attr and return if it indicates an ndarray *)

  val is_node_elt : attr Owl_graph.node -> bool
  (** check the shape of a node's attr and return if it indicates an elt *)

  val is_assigned : attr Owl_graph.node -> bool
  (**
  [is_assigned node] checks if a block of memory has been assigned to
  [node].
   *)

  val check_assigned : attr Owl_graph.node -> unit
  (**
  [check_assigned node] throws an exception if [node] has not been
  assigned to a block.
   *)

  val is_valid : attr Owl_graph.node -> bool
  (** check if the state attribute of a node is Valid *)

  val validate : attr Owl_graph.node -> unit
  (** set Valid to the state attribute of a node *)

  val invalidate : attr Owl_graph.node -> unit
  (** set Invalid to the state attribute of a node *)

  val invalidate_graph : attr Owl_graph.node -> unit
  (** iteratively invalidate the nodes in a graph *)

  val is_freeze : attr Owl_graph.node -> bool
  (** check the freeze attribute of a node *)

  val freeze : attr Owl_graph.node -> unit
  (** return the freeze attribute of a node *)

  val freeze_descendants : attr Owl_graph.node array -> unit
  (** iteratively freeze the descendants of a node *)

  val freeze_ancestors : attr Owl_graph.node array -> unit
  (** iteratively freeze the ancestors of a node *)

  val pack_arr : A.arr -> arr
  (** pack an A.arr type input into Arr type *)

  val unpack_arr : arr -> A.arr
  (** unpack input into A.arr type *)

  val pack_elt : A.elt -> elt
  (** pack an A.elt type input into Elt type *)

  val unpack_elt : elt -> A.elt
  (** unpack input into A.elt type *)

  val unsafe_assign_arr : arr -> A.arr -> unit
  (** assign Arr type value *)

  val assign_arr : arr -> A.arr -> unit
  (** assign Arr type value *)

  val assign_elt : elt -> A.elt -> unit
  (** assign Elt type value *)

  val float_to_elt : float -> elt
  (** build an Elt type based on float value *)

  val elt_to_float : elt -> float
  (** retrive a float value from an Elt type value *)
end
