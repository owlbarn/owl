(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module A : Owl_types_ndarray_mutable.Sig


  module CGraph : sig

    include Owl_types_ndarray_algodiff.Sig

    type op

    type attr

    type value

    type graph


    (** {6 Type conversion functions} *)

    val node_to_arr : attr Owl_graph.node -> arr

    val arr_to_node : arr -> attr Owl_graph.node

    val node_to_elt : attr Owl_graph.node -> elt

    val elt_to_node : elt -> attr Owl_graph.node

    val pack_arr : A.arr -> arr

    val unpack_arr : arr -> A.arr

    val pack_elt : A.elt -> elt

    val unpack_elt : elt -> A.elt

    val float_to_elt : float -> elt

    val elt_to_float : elt -> float


    (** {6 Variable creation functions} *)

    val var_arr : ?shape:int array -> string -> arr

    val var_elt : string -> elt

    val const_arr : string -> A.arr -> arr

    val const_elt : string -> A.elt -> elt

    val assign_arr : arr -> A.arr -> unit

    val assign_elt : elt -> A.elt -> unit

    val unsafe_assign_arr : arr -> A.arr -> unit


    (** {6 Graph property and manipulation} *)

    val refnum : attr Owl_graph.node -> int

    val is_var : attr Owl_graph.node -> bool

    val is_const : attr Owl_graph.node -> bool

    val is_freeze : attr Owl_graph.node -> bool

    val is_arr : attr Owl_graph.node -> bool

    val is_elt : attr Owl_graph.node -> bool

    val is_assigned : attr Owl_graph.node -> bool

    val check_assigned : attr Owl_graph.node -> unit

    val is_valid : attr Owl_graph.node -> bool

    val validate : attr Owl_graph.node -> unit

    val invalidate : attr Owl_graph.node -> unit

    val invalidate_graph : attr Owl_graph.node -> unit

    val set_operator : attr Owl_graph.node -> op -> unit

    val get_operator : attr Owl_graph.node -> op

    val set_value : attr Owl_graph.node -> value array -> unit

    val get_value : attr Owl_graph.node -> value array

    val set_reuse : attr Owl_graph.node -> bool -> unit

    val get_reuse : attr Owl_graph.node -> bool

    val freeze : attr Owl_graph.node -> unit

    val freeze_ancestors : attr Owl_graph.node array -> unit

    val freeze_descendants : attr Owl_graph.node array -> unit

    val is_shape_unkown : attr Owl_graph.node -> bool

    val infer_shape : op -> attr Owl_graph.node array -> int array option array

    val infer_shape_graph : attr Owl_graph.node array -> unit

    val make_iopair : graph -> attr Owl_graph.node array -> attr Owl_graph.node array -> unit

    val remove_unused_iopair : attr Owl_graph.node array -> attr Owl_graph.node array -> attr Owl_graph.node array * attr Owl_graph.node array

    val update_iopair : graph -> unit

    val collect_rvs : attr Owl_graph.node array -> attr Owl_graph.node array

    val invalidate_rvs : graph -> unit

    val make_graph : input:attr Owl_graph.node array -> output:attr Owl_graph.node array -> string -> graph

    val graph_to_dot : graph -> string

    val save_graph : graph -> string -> unit

    val load_graph : string -> graph * Owl_types_common.number

    val optimise : graph -> unit

  end


  (** {6 Type aliases} *)

  type arr = CGraph.arr

  type elt = CGraph.elt

  type graph = CGraph.graph


  (** {6 Core evaluation functions of the engine} *)

  val eval_arr : arr array -> unit

  val eval_elt : elt array -> unit

  val eval_graph : graph -> unit


end
