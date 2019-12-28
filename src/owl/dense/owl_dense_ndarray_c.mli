(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type arr = (Complex.t, complex32_elt, c_layout) Genarray.t

type cast_arr = (float, float32_elt, c_layout) Genarray.t

include Owl_dense_ndarray_intf.Common with type elt := elt and type arr := arr

include Owl_dense_ndarray_intf.NN with type arr := arr

include
  Owl_dense_ndarray_intf.Complex
    with type elt := elt
     and type arr := arr
     and type cast_arr := cast_arr
