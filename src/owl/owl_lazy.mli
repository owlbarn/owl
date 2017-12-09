(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
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
  (A : InpureSig)
  : sig

  type t
  (** [t] is an abstract type to represent an experssion, it is also an alias
    for type [node]. Type [node] is only for internal use in the module.
   *)


  (** {6 Core functions} *)

  val variable : unit -> t
  (** [variable ()] creates a placeholder for the variable in the graph. *)

  val assign_arr : t -> A.arr -> unit
  (** [assign_arr x a] assigns value [a] to [x]. [x] is the variable created by
    [variable ()] function before. Note that assignment will invalidate all the
    nodes in the subgraph depending on [x].
   *)

  val assign_elt : t -> A.elt -> unit
  (** [assign_elt x a] assigns value [a] to [x], simiar to [assign_arr]. *)

  val to_arr : t -> A.arr
  (** [to_arr x] unpacks an ndarray from [x] of type [t]. *)

  val to_elt : t -> A.elt
  (** [to_elt x] unpacks an element from [x] of type [t]. *)

  val of_arr : A.arr -> t
  (** [of_arr x] creates a constant value from [x] in the computation graph. The
    constant value cannot be re-assigned by [assign_arr] or [assign_elt] later.
   *)

  val of_elt : A.elt -> t
  (** [of_elt x] is similar to [of_arr] but used for the value of type [elt]. *)

  val eval : t -> unit
  (** [eval x] evaluates the experssion represented by [x]. Note only the
    subgraph that [x] depends on will be evaluated rather than the whole graph.
   *)


  (** {6 Printing functions} *)

  val pp_lazy : Format.formatter -> t -> unit
  (** [pp_lazy x] pretty prints [x]. *)

  val to_trace : t list -> string
  (** [to_trace x] returns the trace string that can be printed on the terminal
    for a list of given expressions. The trace shows the structure of the graph.
   *)

  val to_dot : t list -> string
  (** [to_dot x] converts a list of experssions into graph using dot-formatted
    string. The returned string can be used for visualising the computation
    graph with third-party tool such as graphviz.
   *)


  (** {6 Properties and manipulations} *)

  val is_var : t -> bool
  (** [is_var x] returns [true] if [x] is a variable created by [variable]. *)

  val is_const : t -> bool
  (** [is_const x] returns [true] if [x] is a const created by [of_arr] or [of_elt]. *)

  val refnum : t -> int
  (** [refnum x] returns the number of [x]'s parents in the computation graph. *)

  val map : ?name:string -> (t array -> t) -> t array -> t
  (** [map f x] is a general mechanism that allows you to plug in any functions
    into a compuation graph as a computation node in case the unary and binary
    math operators defined in this functor are not sufficient.

    [f : t array -> t] takes an array of [t] as inputs and outputs a constant
    value of [t]. This means the output must be wrapped up using either [of_arr]
    or [of_elt] function before returning the result.
   *)

  val tile : t -> int array -> t

  val repeat : ?axis:int -> t -> int -> t

  val concatenate : ?axis:int -> t array -> t


  (** {6 Unary operators} *)

  val abs : t -> t

  val neg : t -> t

  val conj : t -> t

  val reci : t -> t

  val signum : t -> t

  val sqr : t -> t

  val sqrt : t -> t

  val cbrt : t -> t

  val exp : t -> t

  val exp2 : t -> t

  val exp10 : t -> t

  val expm1 : t -> t

  val log : t -> t

  val log2 : t -> t

  val log10 : t -> t

  val log1p : t -> t

  val sin : t -> t

  val cos : t -> t

  val tan : t -> t

  val asin : t -> t

  val acos : t -> t

  val atan : t -> t

  val sinh : t -> t

  val cosh : t -> t

  val tanh : t -> t

  val asinh : t -> t

  val acosh : t -> t

  val atanh : t -> t

  val floor : t -> t

  val ceil : t -> t

  val round : t -> t

  val trunc : t -> t

  val fix : t -> t

  val erf : t -> t

  val erfc : t -> t

  val relu : t -> t

  val softplus : t -> t

  val softsign : t -> t

  val softmax : t -> t

  val sigmoid : t -> t

  val sum : ?axis:int -> t -> t

  val prod : ?axis:int -> t -> t

  val min : ?axis:int -> t -> t

  val max : ?axis:int -> t -> t

  val mean : ?axis:int -> t -> t

  val var : ?axis:int -> t -> t

  val std : ?axis:int -> t -> t

  val l1norm : ?axis:int -> t -> t

  val l2norm : ?axis:int -> t -> t

  val cumsum : ?axis:int -> t -> t

  val cumprod : ?axis:int -> t -> t

  val cummin : ?axis:int -> t -> t

  val cummax : ?axis:int -> t -> t

  val sum' : t -> t

  val prod' : t -> t

  val min' : t -> t

  val max' : t -> t

  val mean' : t -> t

  val var' : t -> t

  val std' : t -> t

  val l1norm' : t -> t

  val l2norm' : t -> t

  val l2norm_sqr' : t -> t


  (** {6 Binary operators} *)

  val add : t -> t -> t

  val sub : t -> t -> t

  val mul : t -> t -> t

  val div : t -> t -> t

  val pow : t -> t -> t

  val dot : t -> t -> t

  val atan2 : t -> t -> t

  val hypot : t -> t -> t

  val fmod : t -> t -> t

  val min2 : t -> t -> t

  val max2 : t -> t -> t

  val add_scalar : t -> t -> t

  val sub_scalar : t -> t -> t

  val mul_scalar : t -> t -> t

  val div_scalar : t -> t -> t

  val pow_scalar : t -> t -> t

  val atan2_scalar : t -> t -> t

  val fmod_scalar : t -> t -> t

  val scalar_add : t -> t -> t

  val scalar_sub : t -> t -> t

  val scalar_mul : t -> t -> t

  val scalar_div : t -> t -> t

  val scalar_pow : t -> t -> t

  val scalar_atan2 : t -> t -> t

  val scalar_fmod : t -> t -> t

  val conv1d : ?padding:padding -> t -> t -> int array -> t

  val conv2d : ?padding:padding -> t -> t -> int array -> t

  val conv3d : ?padding:padding -> t -> t -> int array -> t

  val max_pool1d : ?padding:padding -> t -> int array -> int array -> t

  val max_pool2d : ?padding:padding -> t -> int array -> int array -> t

  val max_pool3d : ?padding:padding -> t -> int array -> int array -> t

  val avg_pool1d : ?padding:padding -> t -> int array -> int array -> t

  val avg_pool2d : ?padding:padding -> t -> int array -> int array -> t

  val avg_pool3d : ?padding:padding -> t -> int array -> int array -> t

  val conv1d_backward_input : t -> t -> int array -> t -> t

  val conv1d_backward_kernel : t -> t -> int array -> t -> t

  val conv2d_backward_input : t -> t -> int array -> t -> t

  val conv2d_backward_kernel : t -> t -> int array -> t -> t

  val conv3d_backward_input : t -> t -> int array -> t -> t

  val conv3d_backward_kernel : t -> t -> int array -> t -> t

  val max_pool1d_backward : padding -> t -> int array -> int array -> t -> t

  val max_pool2d_backward : padding -> t -> int array -> int array -> t -> t

  val avg_pool1d_backward : padding -> t -> int array -> int array -> t -> t

  val avg_pool2d_backward : padding -> t -> int array -> int array -> t -> t


  (** {6 Comparion functions} *)

  val elt_equal : t -> t -> t

  val elt_not_equal : t -> t -> t

  val elt_less : t -> t -> t

  val elt_greater : t -> t -> t

  val elt_less_equal : t -> t -> t

  val elt_greater_equal : t -> t -> t

  val elt_equal_scalar : t -> t -> t

  val elt_not_equal_scalar : t -> t -> t

  val elt_less_scalar : t -> t -> t

  val elt_greater_scalar : t -> t -> t

  val elt_less_equal_scalar : t -> t -> t

  val elt_greater_equal_scalar : t -> t -> t


end
