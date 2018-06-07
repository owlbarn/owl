(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


 module type Ndarray_Mutable = sig

   include Owl_types_ndarray_mutable.Sig

 end


module type Sig = sig module Make : functor (A : Ndarray_Mutable) -> sig

type elt = A.elt
type arr = A.arr

val eval_elt : elt array -> unit

val eval_arr : arr array -> unit
end end
