(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = float

type mat = Owl_base_dense_matrix_s.mat

type complex_mat = Owl_base_dense_matrix_c.mat

type int32_mat = (int32, int32_elt) Owl_base_dense_matrix_generic.t

include
  Owl_base_linalg_intf.Common
    with type elt := elt
     and type mat := mat
     and type complex_mat := complex_mat
     and type int32_mat := int32_mat

include Owl_base_linalg_intf.Real with type elt := elt and type mat := mat
