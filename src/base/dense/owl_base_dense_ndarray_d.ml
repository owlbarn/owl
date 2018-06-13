(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

module M = Owl_base_dense_ndarray_generic
include M

type elt = float
type arr = (float, float64_elt, c_layout) Genarray.t

let number = Owl_types.F64


let empty dims = M.empty Float64 dims


let create dims value = M.create Float64 dims value


let init dims f = M.init Float64 dims f


let zeros dims = M.zeros Float64 dims


let ones dims = M.ones Float64 dims


let sequential ?a ?step dims = M.sequential Float64 ?a ?step dims


let of_array arr dims = M.of_array Float64 arr dims


let of_arrays arrays = M.of_arrays Float64 arrays


let uniform ?a ?b dims = M.uniform Float64 ?a ?b dims


let bernoulli ?p dims = M.bernoulli Float64 ?p dims


let gaussian ?mu ?sigma dims = M.gaussian Float64 ?mu ?sigma dims
