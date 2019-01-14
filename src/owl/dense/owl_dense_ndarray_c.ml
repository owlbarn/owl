(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_dense_ndarray_generic
include M

type elt = Complex.t
type arr = (Complex.t, complex32_elt, c_layout) Genarray.t
type cast_arr = (float, float32_elt, c_layout) Genarray.t

let number = Owl_types.C32


(* overload functions in Owl_dense_ndarray_generic *)

let empty dimension = M.empty Complex32 dimension

let create dimension a = M.create Complex32 dimension a

let init dimension f = M.init Complex32 dimension f

let init_nd dimension f = M.init_nd Complex32 dimension f

let zeros dimension = M.zeros Complex32 dimension

let ones dimension = M.ones Complex32 dimension

let uniform ?a ?b dimension = M.uniform Complex32 ?a ?b dimension

let gaussian ?mu ?sigma dimension = M.gaussian ?mu ?sigma Complex32 dimension

let sequential ?a ?step dimension = M.sequential Complex32 ?a ?step dimension

let linspace a b n = M.linspace Complex32 a b n

let logspace ?base a b n = M.logspace Complex32 ?base a b n

let bernoulli ?p d = M.bernoulli Complex32 ?p d

let load f = M.load Complex32 f

let of_array x d = M.of_array Complex32 x d

let mmap fd ?pos shared dims = Unix.map_file fd ?pos Complex32 c_layout shared dims

(* specific functions for complex32 ndarray *)

let re x = re_c2s x

let im x = im_c2s x

let complex = complex Float32 Complex32

let polar = polar Float32 Complex32
