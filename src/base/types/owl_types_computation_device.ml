(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module Make : functor (A : Owl_types_ndarray_basic.Sig) -> sig

    type device

    type value


    val make_device : unit -> device


    val arr_to_value : A.arr -> value


    val value_to_arr : value -> A.arr


    val elt_to_value : A.elt -> value


    val value_to_elt : value -> A.elt


    val value_to_float : value -> float


  end

end
