(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_base_dense_ndarray_generic
include M

type elt = Complex.t
type arr = (Complex.t, complex64_elt, c_layout) Genarray.t

let number = Owl_types.C64


let empty dims = M.empty Complex64 dims


let create dims value = M.create Complex64 dims value


let init dims f = M.init Complex64 dims f


let init_nd dims f = M.init_nd Complex64 dims f


let zeros dims = M.zeros Complex64 dims


let ones dims = M.ones Complex64 dims


let sequential ?a ?step dims = M.sequential Complex64 ?a ?step dims


let of_array arr dims = M.of_array Complex64 arr dims


let of_arrays arrays = M.of_arrays Complex64 arrays


let uniform ?a ?b dims = M.uniform Complex64 ?a ?b dims


let bernoulli ?p dims = M.bernoulli Complex64 ?p dims


let gaussian ?mu ?sigma dims = M.gaussian Complex64 ?mu ?sigma dims
