(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

module M = Owl_base_dense_ndarray_generic
include M

type elt = float
type arr = (float, float32_elt, c_layout) Genarray.t

let number = Owl_types.F32


let empty dims = M.empty Float32 dims


let create dims value = M.create Float32 dims value


let init dims f = M.init Float32 dims f


let zeros dims = M.zeros Float32 dims


let ones dims = M.ones Float32 dims


let sequential ?a ?step dims = M.sequential Float32 ?a ?step dims


let of_array arr dims = M.of_array Float32 arr dims


let of_arrays arrays = M.of_arrays Float32 arrays


let uniform ?a ?b dims = M.uniform Float32 ?a ?b dims


let bernoulli ?p dims = M.bernoulli Float32 ?p dims


let gaussian ?mu ?sigma dims = M.gaussian Float32 ?mu ?sigma dims
