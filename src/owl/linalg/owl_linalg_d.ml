(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type elt = float

type mat = Owl_dense.Matrix.D.mat

type complex_mat = Owl_dense.Matrix.Z.mat

type int32_mat = (int32, int32_elt) Owl_dense.Matrix.Generic.t


include Owl_linalg_generic


let schur = schur ~otyp:complex64

let eig = eig ~otyp:complex64

let eigvals = eigvals ~otyp:complex64

let expm x = expm ~otyp:complex64 x |> Owl_dense_ndarray_generic.re_z2d
