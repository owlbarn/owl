(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type elt = float

type mat = Owl_dense.Matrix.S.mat

type complex_mat = Owl_dense.Matrix.C.mat

type int32_mat = (int32, int32_elt) Owl_dense.Matrix.Generic.t


include Owl_linalg_generic


let schur = schur ~otyp:complex32

let eig = eig ~otyp:complex32

let eigvals = eigvals ~otyp:complex32
