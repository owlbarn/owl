(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type elt = float

type mat = Owl_dense_matrix_d.mat

type complex_mat = Owl_dense_matrix_z.mat

type int32_mat = (int32, int32_elt) Owl_dense_matrix_generic.t

include
  Owl_linalg_intf.Common
    with type elt := elt
     and type mat := mat
     and type complex_mat := complex_mat
     and type int32_mat := int32_mat

include Owl_linalg_intf.Real with type mat := mat and type elt := elt
