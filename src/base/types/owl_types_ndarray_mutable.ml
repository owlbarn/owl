(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  include Owl_types_ndarray_compare.Sig


  val hypot : arr -> arr -> arr

  val fmod : arr -> arr -> arr

  val min2 : arr -> arr -> arr

  val max2 : arr -> arr -> arr

  val add_ : arr -> arr -> unit

  val sub_ : arr -> arr -> unit

  val mul_ : arr -> arr -> unit

  val div_ : arr -> arr -> unit

  val pow_ : arr -> arr -> unit

  val atan2_ : arr -> arr -> unit

  val hypot_ : arr -> arr -> unit

  val fmod_ : arr -> arr -> unit

  val min2_ : arr -> arr -> unit

  val max2_ : arr -> arr -> unit

  val add_scalar_ : arr -> elt -> unit

  val sub_scalar_ : arr -> elt -> unit

  val mul_scalar_ : arr -> elt -> unit

  val div_scalar_ : arr -> elt -> unit

  val pow_scalar_ : arr -> elt -> unit

  val atan2_scalar_ : arr -> elt -> unit

  val fmod_scalar_ : arr -> elt -> unit

  val scalar_add_ : elt -> arr -> unit

  val scalar_sub_ : elt -> arr -> unit

  val scalar_mul_ : elt -> arr -> unit

  val scalar_div_ : elt -> arr -> unit

  val scalar_pow_ : elt -> arr -> unit

  val scalar_atan2_ : elt -> arr -> unit

  val scalar_fmod_ : elt -> arr -> unit

  val abs_ : arr -> unit

  val neg_ : arr -> unit

  val conj_ : arr -> unit

  val reci_ : arr -> unit

  val signum_ : arr -> unit

  val sqr_ : arr -> unit

  val sqrt_ : arr -> unit

  val cbrt_ : arr -> unit

  val exp_ : arr -> unit

  val exp2_ : arr -> unit

  val exp10_ : arr -> unit

  val expm1_ : arr -> unit

  val log_ : arr -> unit

  val log2_ : arr -> unit

  val log10_ : arr -> unit

  val log1p_ : arr -> unit

  val sin_ : arr -> unit

  val cos_ : arr -> unit

  val tan_ : arr -> unit

  val asin_ : arr -> unit

  val acos_ : arr -> unit

  val atan_ : arr -> unit

  val sinh_ : arr -> unit

  val cosh_ : arr -> unit

  val tanh_ : arr -> unit

  val asinh_ : arr -> unit

  val acosh_ : arr -> unit

  val atanh_ : arr -> unit

  val floor_ : arr -> unit

  val ceil_ : arr -> unit

  val round_ : arr -> unit

  val trunc_ : arr -> unit

  val fix_ : arr -> unit

  val erf_ : arr -> unit

  val erfc_ : arr -> unit

  val relu_ : arr -> unit

  val softplus_ : arr -> unit

  val softsign_ : arr -> unit

  val softmax_ : arr -> unit

  val sigmoid_ : arr -> unit

  val sum : ?axis:int -> arr -> arr

  val prod : ?axis:int -> arr -> arr

  val min : ?axis:int -> arr -> arr

  val max : ?axis:int -> arr -> arr

  val mean : ?axis:int -> arr -> arr

  val var : ?axis:int -> arr -> arr

  val std : ?axis:int -> arr -> arr

  val l1norm : ?axis:int -> arr -> arr

  val l2norm : ?axis:int -> arr -> arr

  val cumsum_ : ?axis:int -> arr -> unit

  val cumprod_ : ?axis:int -> arr -> unit

  val cummin_ : ?axis:int -> arr -> unit

  val cummax_ : ?axis:int -> arr -> unit

  val dropout_ : ?rate:float -> arr -> unit

  val prod' : arr -> elt

  val mean' : arr -> elt

  val var' : arr -> elt

  val std' : arr -> elt

  val elt_equal_ : arr -> arr -> unit

  val elt_not_equal_ : arr -> arr -> unit

  val elt_less_ : arr -> arr -> unit

  val elt_greater_ : arr -> arr -> unit

  val elt_less_equal_ : arr -> arr -> unit

  val elt_greater_equal_ : arr -> arr -> unit

  val elt_equal_scalar_ : arr -> elt -> unit

  val elt_not_equal_scalar_ : arr -> elt -> unit

  val elt_less_scalar_ : arr -> elt -> unit

  val elt_greater_scalar_ : arr -> elt -> unit

  val elt_less_equal_scalar_ : arr -> elt -> unit

  val elt_greater_equal_scalar_ : arr -> elt -> unit

end
