(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type mat = Owl_dense_matrix_z.mat

type complex_mat = Owl_dense_matrix_z.mat

type int32_mat = (int32, int32_elt) Owl_dense_matrix_generic.t


include Owl_linalg_generic


let schur = schur ~otyp:complex64

let ordschur = ordschur ~otyp:complex64

let qz = qz ~otyp:complex64

let ordqz = ordqz ~otyp:complex64

let qzvals = qzvals ~otyp:complex64

let eig = eig ~otyp:complex64

let eigvals = eigvals ~otyp:complex64
