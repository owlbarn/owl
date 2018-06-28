(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types_common


module type Sig = sig

  include Owl_types_ndarray_algodiff.Sig


  val create_ : out:arr -> elt -> unit

  val uniform_ : ?a:elt -> ?b:elt -> out:arr -> unit

  val bernoulli_ : ?p:float -> out:arr -> unit

  val zeros_ : out:arr -> unit

  val ones_ : out:arr -> unit

  val one_hot_ : out:arr -> int -> arr -> unit

  val reshape_ : out:arr -> arr -> unit

  val transpose_ : out:arr -> ?axis:int array -> arr -> unit

  val hypot : arr -> arr -> arr

  val fmod : arr -> arr -> arr

  val min2 : arr -> arr -> arr

  val max2 : arr -> arr -> arr

  val add_ : ?out:arr -> arr -> arr -> unit

  val sub_ : ?out:arr -> arr -> arr -> unit

  val mul_ : ?out:arr -> arr -> arr -> unit

  val div_ : ?out:arr -> arr -> arr -> unit

  val pow_ : ?out:arr -> arr -> arr -> unit

  val atan2_ : ?out:arr -> arr -> arr -> unit

  val hypot_ : ?out:arr -> arr -> arr -> unit

  val fmod_ : ?out:arr -> arr -> arr -> unit

  val min2_ : ?out:arr -> arr -> arr -> unit

  val max2_ : ?out:arr -> arr -> arr -> unit

  val add_scalar_ : ?out:arr -> arr -> elt -> unit

  val sub_scalar_ : ?out:arr -> arr -> elt -> unit

  val mul_scalar_ : ?out:arr -> arr -> elt -> unit

  val div_scalar_ : ?out:arr -> arr -> elt -> unit

  val pow_scalar_ : ?out:arr -> arr -> elt -> unit

  val atan2_scalar_ : ?out:arr -> arr -> elt -> unit

  val fmod_scalar_ : ?out:arr -> arr -> elt -> unit

  val scalar_add_ : ?out:arr -> elt -> arr -> unit

  val scalar_sub_ : ?out:arr -> elt -> arr -> unit

  val scalar_mul_ : ?out:arr -> elt -> arr -> unit

  val scalar_div_ : ?out:arr -> elt -> arr -> unit

  val scalar_pow_ : ?out:arr -> elt -> arr -> unit

  val scalar_atan2_ : ?out:arr -> elt -> arr -> unit

  val scalar_fmod_ : ?out:arr -> elt -> arr -> unit

  val fma_ : ?out:arr -> arr -> arr -> arr -> unit

  val dot_ : ?transa:bool -> ?transb:bool -> ?alpha:elt -> ?beta:elt -> c:arr -> arr -> arr -> unit

  val abs_ : ?out:arr -> arr -> unit

  val neg_ : ?out:arr -> arr -> unit

  val conj_ : ?out:arr -> arr -> unit

  val reci_ : ?out:arr -> arr -> unit

  val signum_ : ?out:arr -> arr -> unit

  val sqr_ : ?out:arr -> arr -> unit

  val sqrt_ : ?out:arr -> arr -> unit

  val cbrt_ : ?out:arr -> arr -> unit

  val exp_ : ?out:arr -> arr -> unit

  val exp2_ : ?out:arr -> arr -> unit

  val exp10_ : ?out:arr -> arr -> unit

  val expm1_ : ?out:arr -> arr -> unit

  val log_ : ?out:arr -> arr -> unit

  val log2_ : ?out:arr -> arr -> unit

  val log10_ : ?out:arr -> arr -> unit

  val log1p_ : ?out:arr -> arr -> unit

  val sin_ : ?out:arr -> arr -> unit

  val cos_ : ?out:arr -> arr -> unit

  val tan_ : ?out:arr -> arr -> unit

  val asin_ : ?out:arr -> arr -> unit

  val acos_ : ?out:arr -> arr -> unit

  val atan_ : ?out:arr -> arr -> unit

  val sinh_ : ?out:arr -> arr -> unit

  val cosh_ : ?out:arr -> arr -> unit

  val tanh_ : ?out:arr -> arr -> unit

  val asinh_ : ?out:arr -> arr -> unit

  val acosh_ : ?out:arr -> arr -> unit

  val atanh_ : ?out:arr -> arr -> unit

  val floor_ : ?out:arr -> arr -> unit

  val ceil_ : ?out:arr -> arr -> unit

  val round_ : ?out:arr -> arr -> unit

  val trunc_ : ?out:arr -> arr -> unit

  val fix_ : ?out:arr -> arr -> unit

  val erf_ : ?out:arr -> arr -> unit

  val erfc_ : ?out:arr -> arr -> unit

  val relu_ : ?out:arr -> arr -> unit

  val softplus_ : ?out:arr -> arr -> unit

  val softsign_ : ?out:arr -> arr -> unit

  val softmax_ : ?out:arr -> ?axis:int -> arr -> unit

  val sigmoid_ : ?out:arr -> arr -> unit

  val sum_ : out:arr -> axis:int -> arr -> unit

  val min_ : out:arr -> axis:int -> arr -> unit

  val max_ : out:arr -> axis:int -> arr -> unit

  val sum : ?axis:int -> arr -> arr

  val prod : ?axis:int -> arr -> arr

  val min : ?axis:int -> arr -> arr

  val max : ?axis:int -> arr -> arr

  val mean : ?axis:int -> arr -> arr

  val var : ?axis:int -> arr -> arr

  val std : ?axis:int -> arr -> arr

  val l1norm : ?axis:int -> arr -> arr

  val l2norm : ?axis:int -> arr -> arr

  val cumsum_ : ?out:arr -> ?axis:int -> arr -> unit

  val cumprod_ : ?out:arr -> ?axis:int -> arr -> unit

  val cummin_ : ?out:arr -> ?axis:int -> arr -> unit

  val cummax_ : ?out:arr -> ?axis:int -> arr -> unit

  val dropout_ : ?out:arr -> ?rate:float -> arr -> unit

  val prod' : arr -> elt

  val mean' : arr -> elt

  val var' : arr -> elt

  val std' : arr -> elt

  val elt_equal_ : ?out:arr -> arr -> arr -> unit

  val elt_not_equal_ : ?out:arr -> arr -> arr -> unit

  val elt_less_ : ?out:arr -> arr -> arr -> unit

  val elt_greater_ : ?out:arr -> arr -> arr -> unit

  val elt_less_equal_ : ?out:arr -> arr -> arr -> unit

  val elt_greater_equal_ : ?out:arr -> arr -> arr -> unit

  val elt_equal_scalar_ : ?out:arr -> arr -> elt -> unit

  val elt_not_equal_scalar_ : ?out:arr -> arr -> elt -> unit

  val elt_less_scalar_ : ?out:arr -> arr -> elt -> unit

  val elt_greater_scalar_ : ?out:arr -> arr -> elt -> unit

  val elt_less_equal_scalar_ : ?out:arr -> arr -> elt -> unit

  val elt_greater_equal_scalar_ : ?out:arr -> arr -> elt -> unit

  val conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val dilated_conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> int array -> unit

  val dilated_conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> int array -> unit

  val dilated_conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> int array -> unit

  val transpose_conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val transpose_conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val transpose_conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val max_pool1d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

  val max_pool2d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

  val max_pool3d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

  val avg_pool1d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

  val avg_pool2d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

  val avg_pool3d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

  val conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val conv1d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val conv2d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val conv3d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val dilated_conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

  val dilated_conv1d_backward_kernel_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

  val dilated_conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

  val dilated_conv2d_backward_kernel_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

  val dilated_conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

  val dilated_conv3d_backward_kernel_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

  val transpose_conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv1d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv2d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv3d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val max_pool1d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

  val max_pool2d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

  val max_pool3d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

  val avg_pool1d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

  val avg_pool2d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

  val avg_pool3d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

  val fused_adagrad_ : ?out:arr -> rate:float -> eps:float -> arr -> unit


end
