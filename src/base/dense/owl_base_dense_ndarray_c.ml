(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_base_dense_ndarray_generic
include M

type elt = Complex.t
type arr = (Complex.t, complex32_elt, c_layout) Genarray.t

let number = Owl_types.C32


let empty dims = M.empty Complex32 dims


let create dims value = M.create Complex32 dims value


let init dims f = M.init Complex32 dims f


let init_nd dims f = M.init_nd Complex32 dims f


let zeros dims = M.zeros Complex32 dims


let ones dims = M.ones Complex32 dims


let sequential ?a ?step dims = M.sequential Complex32 ?a ?step dims


let of_array arr dims = M.of_array Complex32 arr dims


let of_arrays arrays = M.of_arrays Complex32 arrays


let uniform ?a ?b dims = M.uniform Complex32 ?a ?b dims


let bernoulli ?p dims = M.bernoulli Complex32 ?p dims


let gaussian ?mu ?sigma dims = M.gaussian Complex32 ?mu ?sigma dims
