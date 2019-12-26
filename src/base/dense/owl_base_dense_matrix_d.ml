(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
module M = Owl_base_dense_matrix_generic
include M

type elt = float

type mat = (float, Bigarray.float64_elt) M.t

let eye = M.eye Float64
