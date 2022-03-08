(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type elt = float

type arr = (float, float32_elt, c_layout) Genarray.t

include Owl_dense_ndarray_intf.Common with type elt := elt and type arr := arr

include Owl_dense_ndarray_intf.Real with type elt := elt and type arr := arr

include Owl_dense_ndarray_intf.NN with type arr := arr
