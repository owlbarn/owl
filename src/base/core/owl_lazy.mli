(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_graph

(*
  Lazy functor: this module is an alias of the CPU-based engine for Owl's
  computation graph.
 *)

module Make (A : Ndarray_Mutable) : sig


  (** {6 Type definition} *)

  type arr
  (** TODO *)

  type elt
  (** TODO *)

  type value
  (** TODO *)

  type attr
  (** TODO *)

  type graph
  (** TODO *)


  (** {6 Type conversion functions} *)

  val arr_to_value : A.arr -> value
  (** TODO *)

  val value_to_arr : value -> A.arr
  (** TODO *)

  val elt_to_value : A.elt -> value
  (** TODO *)

  val value_to_elt : value -> A.elt
  (** TODO *)

  val value_to_float : value -> float
  (** TODO *)

  val node_to_arr : attr node -> arr
  (** TODO *)

  val arr_to_node : arr -> attr node
  (** TODO *)

  val node_to_elt : attr node -> elt
  (** TODO *)

  val elt_to_node : elt -> attr node
  (** TODO *)

  val pack_arr : A.arr -> arr
  (** TODO *)

  val unpack_arr : arr -> A.arr
  (** TODO *)

  val pack_elt : A.elt -> elt
  (** TODO *)

  val unpack_elt : elt -> A.elt
  (** TODO *)

  val float_to_elt : float -> elt
  (** TODO *)

  val elt_to_float : elt -> float
  (** TODO *)


  (** {6 Utility functions} *)

  val graph_to_dot : graph -> string
  (** TODO *)

  val graph_to_trace : graph -> string
  (** TODO *)


  (** {6 Create variables} *)

  val var_arr : ?shape:int array -> string -> arr
  (** TODO *)

  val var_elt : string -> elt
  (** TODO *)

  val const_arr : string -> A.arr -> arr
  (** TODO *)

  val const_elt : string -> A.elt -> elt
  (** TODO *)

  val assign_arr : arr -> A.arr -> unit
  (** TODO *)

  val assign_elt : elt -> A.elt -> unit
  (** TODO *)

  val unsafe_assign_arr : arr -> A.arr -> unit
  (** TODO *)


  (** {6 Maths funcitons} *)

  val noop : arr -> arr
  (** TODO *)

  val empty : int array -> arr
  (** TODO *)

  val zeros : int array -> arr
  (** TODO *)

  val ones : int array -> arr
  (** TODO *)

  val create : int array -> elt -> arr
  (** TODO *)

  val sequential : ?a:elt -> ?step:elt -> int array -> arr
  (** TODO *)

  val uniform : ?a:elt -> ?b:elt -> int array -> arr
  (** TODO *)

  val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr
  (** TODO *)

  val bernoulli : ?p:float -> int array -> arr
  (** TODO *)

  val init : int array -> (int -> elt) -> arr
  (** TODO *)

  val shape : arr -> int array
  (** TODO *)

  val numel : arr -> int
  (** TODO *)

  val get : arr -> int array -> elt
  (** TODO *)

  val set : arr -> int array -> elt -> unit
  (** TODO *)

  val get_slice : int list list -> arr -> arr
  (** TODO *)

  val set_slice : int list list -> arr -> arr -> unit
  (** TODO *)

  val copy : arr -> arr
  (** TODO *)

  val reset : arr -> unit
  (** TODO *)

  val reshape : arr -> int array -> arr
  (** TODO *)

  val reverse : arr -> arr
  (** TODO *)

  val tile : arr -> int array -> arr
  (** TODO *)

  val repeat : arr -> int array -> arr
  (** TODO *)

  val concatenate : ?axis:int -> arr array -> arr
  (** TODO *)

  val split : ?axis:int -> int array -> arr -> arr array
  (** TODO *)

  val draw : ?axis:int -> arr -> int -> arr * 'a array
  (** TODO *)

  val map : (elt -> elt) -> arr -> arr
  (** TODO *)

  val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> arr -> arr
  (** TODO *)

  val scan : ?axis:int -> (elt -> elt -> elt) -> arr -> arr
  (** TODO *)

  val one_hot : int -> arr -> arr
  (** TODO *)

  val print : ?max_row:'a -> ?max_col:'b -> ?header:'c -> ?fmt:'d -> 'e -> unit
  (** TODO *)

  val abs : arr -> arr
  (** TODO *)

  val neg : arr -> arr
  (** TODO *)

  val floor : arr -> arr
  (** TODO *)

  val ceil : arr -> arr
  (** TODO *)

  val round : arr -> arr
  (** TODO *)

  val sqr : arr -> arr
  (** TODO *)

  val sqrt : arr -> arr
  (** TODO *)

  val log : arr -> arr
  (** TODO *)

  val log2 : arr -> arr
  (** TODO *)

  val log10 : arr -> arr
  (** TODO *)

  val exp : arr -> arr
  (** TODO *)

  val sin : arr -> arr
  (** TODO *)

  val cos : arr -> arr
  (** TODO *)

  val tan : arr -> arr
  (** TODO *)

  val sinh : arr -> arr
  (** TODO *)

  val cosh : arr -> arr
  (** TODO *)

  val tanh : arr -> arr
  (** TODO *)

  val asin : arr -> arr
  (** TODO *)

  val acos : arr -> arr
  (** TODO *)

  val atan : arr -> arr
  (** TODO *)

  val asinh : arr -> arr
  (** TODO *)

  val acosh : arr -> arr
  (** TODO *)

  val atanh : arr -> arr
  (** TODO *)

  val min : ?axis:int -> arr -> arr
  (** TODO *)

  val max : ?axis:int -> arr -> arr
  (** TODO *)

  val sum : ?axis:int -> arr -> arr
  (** TODO *)

  val sum_reduce : ?axis:int array -> arr -> arr
  (** TODO *)

  val signum : arr -> arr
  (** TODO *)

  val sigmoid : arr -> arr
  (** TODO *)

  val relu : arr -> arr
  (** TODO *)

  val min' : arr -> elt
  (** TODO *)

  val max' : arr -> elt
  (** TODO *)

  val sum' : arr -> elt
  (** TODO *)

  val l1norm' : arr -> elt
  (** TODO *)

  val l2norm' : arr -> elt
  (** TODO *)

  val l2norm_sqr' : arr -> elt
  (** TODO *)

  val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr
  (** TODO *)

  val clip_by_l2norm : elt -> arr -> arr
  (** TODO *)

  val pow : arr -> arr -> arr
  (** TODO *)

  val scalar_pow : elt -> arr -> arr
  (** TODO *)

  val pow_scalar : arr -> elt -> arr
  (** TODO *)

  val atan2 : arr -> arr -> arr
  (** TODO *)

  val scalar_atan2 : elt -> arr -> arr
  (** TODO *)

  val atan2_scalar : arr -> elt -> arr
  (** TODO *)

  val hypot : arr -> arr -> arr
  (** TODO *)

  val min2 : arr -> arr -> arr
  (** TODO *)

  val max2 : arr -> arr -> arr
  (** TODO *)

  val add : arr -> arr -> arr
  (** TODO *)

  val sub : arr -> arr -> arr
  (** TODO *)

  val mul : arr -> arr -> arr
  (** TODO *)

  val div : arr -> arr -> arr
  (** TODO *)

  val add_scalar : arr -> elt -> arr
  (** TODO *)

  val sub_scalar : arr -> elt -> arr
  (** TODO *)

  val mul_scalar : arr -> elt -> arr
  (** TODO *)

  val div_scalar : arr -> elt -> arr
  (** TODO *)

  val scalar_add : elt -> arr -> arr
  (** TODO *)

  val scalar_sub : elt -> arr -> arr
  (** TODO *)

  val scalar_mul : elt -> arr -> arr
  (** TODO *)

  val scalar_div : elt -> arr -> arr
  (** TODO *)

  val fma : arr -> arr -> arr -> arr
  (** TODO *)

  val elt_equal : arr -> arr -> arr
  (** TODO *)

  val elt_not_equal : arr -> arr -> arr
  (** TODO *)

  val elt_less : arr -> arr -> arr
  (** TODO *)

  val elt_greater : arr -> arr -> arr
  (** TODO *)

  val elt_less_equal : arr -> arr -> arr
  (** TODO *)

  val elt_greater_equal : arr -> arr -> arr
  (** TODO *)

  val elt_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_not_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_less_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_greater_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_less_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_greater_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val conv1d : ?padding:padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val conv2d : ?padding:padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val conv3d : ?padding:padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val transpose_conv2d : ?padding:padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val max_pool1d : ?padding:padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val max_pool2d : ?padding:padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val max_pool3d : ?padding:padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val avg_pool1d : ?padding:padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val avg_pool2d : ?padding:padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val avg_pool3d : ?padding:padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val conv1d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv2d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv3d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv2d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val max_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val avg_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val row_num : arr -> int
  (** TODO *)

  val col_num : arr -> int
  (** TODO *)

  val row : arr -> 'a -> arr
  (** TODO *)

  val rows : arr -> int array -> arr
  (** TODO *)

  val copy_row_to : arr -> 'a -> 'b -> unit
  (** TODO *)

  val copy_col_to : arr -> 'a -> 'b -> unit
  (** TODO *)

  val inv : arr -> arr
  (** TODO *)

  val trace : arr -> elt
  (** TODO *)

  val dot : arr -> arr -> arr
  (** TODO *)

  val transpose : ?axis:int array -> arr -> arr
  (** TODO *)

  val to_rows : arr -> 'a array
  (** TODO *)

  val of_rows : arr array -> arr
  (** TODO *)

  val of_array : 'a -> 'b -> 'c
  (** TODO *)

  val of_arrays : 'a -> 'b
  (** TODO *)


  (** {6 Evaluation functions} *)

  val make_graph : input:attr node array -> output:attr node array -> string -> graph
  (** TODO *)

  val get_inputs : graph -> attr node array
  (** TODO *)

  val get_outputs : graph -> attr node array
  (** TODO *)

  val make_iopair : graph -> attr node array -> attr node array -> unit
  (** TODO *)

  val update_iopair : graph -> unit
  (** TODO *)

  val init_inputs : (attr node -> value) -> graph -> unit
  (** TODO *)

  val optimise : graph -> unit
  (** TODO *)

  val eval_elt : elt array -> unit
  (** TODO *)

  val eval_arr : arr array -> unit
  (** TODO *)

  val eval_graph : graph -> unit
  (** TODO *)


end
