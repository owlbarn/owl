(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

(** Lazy module implments lazy evaluation atop of owl's ndarray. *)

open Owl_types

module Make
  (A : InpureSig)
  : sig

  type t

  (** {6 core functions} *)

  val variable : unit -> t

  val assign_arr : t -> A.arr -> unit

  val assign_elt : t -> A.elt -> unit

  val to_arr : t -> A.arr

  val to_elt : t -> A.elt

  val eval : t -> unit


  (** {6 Properties and manipulations} *)

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
