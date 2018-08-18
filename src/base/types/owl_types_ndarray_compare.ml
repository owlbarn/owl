(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  include Owl_types_ndarray_eltcmp.Sig


  val is_zero : arr -> bool

  val is_positive : arr -> bool

  val is_negative : arr -> bool

  val is_nonpositive : arr -> bool

  val is_nonnegative : arr -> bool

  val equal : arr -> arr -> bool

  val not_equal : arr -> arr -> bool

  val less : arr -> arr -> bool

  val greater : arr -> arr -> bool

  val less_equal : arr -> arr -> bool

  val greater_equal : arr -> arr -> bool

  val approx_equal : ?eps:float -> arr -> arr -> bool

  val approx_equal_scalar : ?eps:float -> arr -> elt -> bool

  val approx_elt_equal : ?eps:float -> arr -> arr -> arr

  val approx_elt_equal_scalar : ?eps:float -> arr -> elt -> arr

end
