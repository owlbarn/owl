(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t
type mat = Owl_dense_matrix_c.mat
type int32_mat = (int32, int32_elt) Owl_dense_matrix_generic.t

include
  Owl_linalg_intf.Common
    with type elt := elt
     and type mat := mat
     and type complex_mat = mat
     and type int32_mat := int32_mat
