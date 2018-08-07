(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  include Owl_types_ndarray_basic.Sig


  val elt_equal : arr -> arr -> arr

  val elt_not_equal : arr -> arr -> arr

  val elt_less : arr -> arr -> arr

  val elt_greater : arr -> arr -> arr

  val elt_less_equal : arr -> arr -> arr

  val elt_greater_equal : arr -> arr -> arr

  val elt_equal_scalar : arr -> elt -> arr

  val elt_not_equal_scalar : arr -> elt -> arr

  val elt_less_scalar : arr -> elt -> arr

  val elt_greater_scalar : arr -> elt -> arr

  val elt_less_equal_scalar : arr -> elt -> arr

  val elt_greater_equal_scalar : arr -> elt -> arr

end
