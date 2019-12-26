(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type mat = Owl_base_dense_matrix_z.mat

type int32_mat = (int32, int32_elt) Owl_base_dense_matrix_generic.t

include Owl_base_linalg_generic
