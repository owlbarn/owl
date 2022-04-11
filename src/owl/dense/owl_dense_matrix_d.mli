(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type elt = float

type mat = (float, float64_elt) Owl_dense_matrix_generic.t

include Owl_dense_matrix_intf.Common with type elt := elt and type mat := mat

include Owl_dense_matrix_intf.Real with type elt := elt and type mat := mat
