(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = float

type mat = (float, float32_elt) Owl_dense_matrix_generic.t

include Owl_dense_matrix_intf.Common with type elt := elt and type mat := mat

include Owl_dense_matrix_intf.Real with type elt := elt and type mat := mat
