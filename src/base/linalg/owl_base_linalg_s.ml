(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type elt = float

type mat = Owl_base_dense_matrix_s.mat

type complex_mat = Owl_base_dense_matrix_c.mat

type int32_mat = (int32, int32_elt) Owl_base_dense_matrix_generic.t

include Owl_base_linalg_generic
