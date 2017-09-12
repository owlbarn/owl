(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_dense_ndarray_generic
include M

type elt = Complex.t
type arr = (Complex.t, complex64_elt, c_layout) Genarray.t
type cast_arr = (float, float64_elt, c_layout) Genarray.t


(* overload functions in Owl_dense_ndarray_generic *)

let empty dimension = M.empty Complex64 dimension

let create dimension a = M.create Complex64 dimension a

let init dimension f = M.init Complex64 dimension f

let init_nd dimension f = M.init_nd Complex64 dimension f

let zeros dimension = M.zeros Complex64 dimension

let ones dimension = M.ones Complex64 dimension

let uniform ?scale dimension = M.uniform ?scale Complex64 dimension

let gaussian ?sigma dimension = M.gaussian ?sigma Complex64 dimension

let sequential ?a ?step dimension = M.sequential Complex64 ?a ?step dimension

let linspace a b n = M.linspace Complex64 a b n

let logspace ?base a b n = M.logspace Complex64 a b n

let bernoulli ?p ?seed d = M.bernoulli Complex64 ?p ?seed d

let load f = M.load Complex64 f

let of_array x d = M.of_array Complex64 x d

let mmap fd ?pos shared dims = Genarray.map_file fd ?pos Complex64 c_layout shared dims

(* specific functions for complex64 ndarray *)

let re x = re_z2d x

let im x = im_z2d x

let abs x = abs_z2d x

let abs2 x = abs2_z2d x

let complex = complex Float64 Complex64

let polar = polar Float64 Complex64
