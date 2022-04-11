(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type elt = Complex.t

type arr = (Complex.t, complex64_elt, c_layout) Genarray.t

type cast_arr = (float, float64_elt, c_layout) Genarray.t

include Owl_dense_ndarray_intf.Common with type elt := elt and type arr := arr

include Owl_dense_ndarray_intf.NN with type arr := arr

include
  Owl_dense_ndarray_intf.Complex
    with type elt := elt
     and type arr := arr
     and type cast_arr := cast_arr
