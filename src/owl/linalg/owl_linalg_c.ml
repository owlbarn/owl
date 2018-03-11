(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type mat = Owl_dense_matrix_c.mat

type int32_mat = (int32, int32_elt) Owl_dense_matrix_generic.t


include Owl_linalg_generic


let schur = schur ~otyp:complex32

let ordschur = ordschur ~otyp:complex32

let qz = qz ~otyp:complex32

let ordqz = ordqz ~otyp:complex32

let eig = eig ~otyp:complex32

let eigvals = eigvals ~otyp:complex32
