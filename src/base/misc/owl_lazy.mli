(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Lazy module
  The module is used to construct a computation graph explicitly for evaluation.
  The module can be used to simulate the lazy evaluation atop of OCaml. It can
  also be used for dataflow programming and supports incremental computation.
  If a variable is updated, only the subgraph depending on such variable will be
  evaluated.

  The module also tracks the reference of each node in the compuation graph and
  tries to reuse the allocated memory if possible. This mechanism avoids the
  overhead from memory allocation but may also cause extra computation in
  incremental compuation.
 *)

open Owl_types


module Make
  (A : Ndarray_Mutable)
  : sig


  (** {6 Type definition} *)

  type t
  (**
``t`` is an abstract type to represent an expression, it is also an alias
for type ``node``. Type ``node`` is only for internal use in the module.
   *)


  (** {6 Core functions} *)

  val variable : ?name:string -> unit -> t
  (** ``variable ()`` creates a placeholder for the variable in the graph. *)

  val assign_arr : t -> A.arr -> unit
  (**
``assign_arr x a`` assigns value ``a`` to ``x``. ``x`` is the variable created by
``variable ()`` function before. Note that assignment will invalidate all the
nodes in the subgraph depending on ``x``.
   *)

  val assign_elt : t -> A.elt -> unit
  (** ``assign_elt x a`` assigns value ``a`` to ``x``, simiar to ``assign_arr``. *)

  val to_arr : t -> A.arr
  (** ``to_arr x`` unpacks an ndarray from ``x`` of type ``t``. *)

  val to_elt : t -> A.elt
  (** ``to_elt x`` unpacks an element from ``x`` of type ``t``. *)

  val of_arr : ?name:string -> A.arr -> t
  (**
``of_arr x`` creates a constant value from ``x`` in the computation graph. The
constant value cannot be re-assigned by ``assign_arr`` or ``assign_elt`` later.
   *)

  val of_elt : ?name:string -> A.elt -> t
  (** ``of_elt x`` is similar to ``of_arr`` but used for the value of type ``elt``. *)

  val eval : t -> unit
  (**
``eval x`` evaluates the experssion represented by ``x``. Note only the
subgraph that ``x`` depends on will be evaluated rather than the whole graph.
   *)


  (** {6 Printing functions} *)

  val pp_lazy : Format.formatter -> t -> unit
  (** ``pp_lazy x`` pretty prints ``x``. *)

  val to_trace : t list -> string
  (**
``to_trace x`` returns the trace string that can be printed on the terminal
for a list of given expressions. The trace shows the structure of the graph.
   *)

  val to_dot : t list -> string
  (**
``to_dot x`` converts a list of experssions into graph using dot-formatted
string. The returned string can be used for visualising the computation
graph with third-party tool such as graphviz.
   *)

  val copy : t array -> t array
  (** ``copy x`` *)


  (** {6 Properties and manipulations} *)

  val is_var : t -> bool
  (** ``is_var x`` returns ``true`` if ``x`` is a variable created by ``variable``. *)

  val is_const : t -> bool
  (** ``is_const x`` returns ``true`` if ``x`` is a const created by ``of_arr`` or ``of_elt``. *)

  val refnum : t -> int
  (** ``refnum x`` returns the number of ``x``'s parents in the computation graph. *)

  val map : ?name:string -> (t array -> t) -> t array -> t
  (**
``map f x`` is a general mechanism that allows you to plug in any functions
into a compuation graph as a computation node in case the unary and binary
math operators defined in this functor are not sufficient. Also because of
``map``, we do not really need the control flow node in Owl as that in
TensorFlow since ``map`` is more general can be used to implement arbitrary
operations (almost).

``f : t array -> t`` takes an array of ``t`` as inputs and outputs a constant
value of ``t``. This means the output must be wrapped up using either ``of_arr``
or ``of_elt`` function before returning the result.
   *)

  val tile : t -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val repeat : ?axis:int -> t -> int -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val concatenate : ?axis:int -> t array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)


  (** {6 Unary operators} *)

  val abs : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val neg : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conj : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val reci : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val signum : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sqr : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sqrt : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cbrt : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val exp : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val exp2 : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val exp10 : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val expm1 : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val log : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val log2 : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val log10 : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val log1p : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sin : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cos : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val tan : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val asin : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val acos : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val atan : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sinh : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cosh : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val tanh : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val asinh : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val acosh : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val atanh : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val floor : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val ceil : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val round : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val trunc : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val fix : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val erf : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val erfc : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val relu : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val softplus : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val softsign : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val softmax : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sigmoid : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sum : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val prod : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val min : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val mean : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val var : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val std : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val l1norm : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val l2norm : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cumsum : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cumprod : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cummin : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val cummax : ?axis:int -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sum' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val prod' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val min' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val mean' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val var' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val std' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val l1norm' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val l2norm' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val l2norm_sqr' : t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)


  (** {6 Binary operators} *)

  val add : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sub : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val mul : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val div : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val pow : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val dot : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val atan2 : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val hypot : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val fmod : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val min2 : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max2 : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val add_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val sub_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val mul_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val div_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val pow_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val atan2_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val fmod_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_add : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_sub : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_mul : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_div : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_pow : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_atan2 : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val scalar_fmod : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv1d : ?padding:padding -> t -> t -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv2d : ?padding:padding -> t -> t -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv3d : ?padding:padding -> t -> t -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max_pool1d : ?padding:padding -> t -> int array -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max_pool2d : ?padding:padding -> t -> int array -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max_pool3d : ?padding:padding -> t -> int array -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val avg_pool1d : ?padding:padding -> t -> int array -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val avg_pool2d : ?padding:padding -> t -> int array -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val avg_pool3d : ?padding:padding -> t -> int array -> int array -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv1d_backward_input : t -> t -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv1d_backward_kernel : t -> t -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv2d_backward_input : t -> t -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv2d_backward_kernel : t -> t -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv3d_backward_input : t -> t -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val conv3d_backward_kernel : t -> t -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max_pool1d_backward : padding -> t -> int array -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val max_pool2d_backward : padding -> t -> int array -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val avg_pool1d_backward : padding -> t -> int array -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val avg_pool2d_backward : padding -> t -> int array -> int array -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)


  (** {6 Comparion functions} *)

  val elt_equal : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_not_equal : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_less : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_greater : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_less_equal : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_greater_equal : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_equal_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_not_equal_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_less_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_greater_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_less_equal_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)

  val elt_greater_equal_scalar : t -> t -> t
  (** Refer to :doc:`owl_dense_ndarray_generic`. *)


  (** {6 Advanced operations} *)

  val invalidate : t -> unit
  (**
``invalidate x`` set the status of ``x`` to ``Invalid``. Therefore the value of
``x`` will be re-computed when in the future evaluation.
   *)

  val id : t -> int
  (** ``id x`` retrieves the id number of ``x``. *)

  val name : t -> string
  (** ``name x`` retrieves the name of ``x``. *)

  val get_by_id : t -> int -> t
  (**
``get_by_id x id`` retrieves the node with the given ``id`` in the subgraph of
``x``.
   *)

  val get_by_name : t -> string -> t array
  (**
``get_by_name x name`` retrieves the node with the given ``name`` in the
subgraph of ``x``.
   *)


end
