(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_dense_ndarray_generic
include M

type elt = float
type arr = (float, float32_elt, c_layout) Genarray.t


(* overload functions in Owl_dense_ndarray_generic *)

let empty dimension = M.empty Float32 dimension

let create dimension a = M.create Float32 dimension a

let init dimension f = M.init Float32 dimension f

let init_nd dimension f = M.init_nd Float32 dimension f

let zeros dimension = M.zeros Float32 dimension

let ones dimension = M.ones Float32 dimension

let uniform ?a ?b dimension = M.uniform Float32 ?a ?b dimension

let gaussian ?mu ?sigma dimension = M.gaussian ?mu ?sigma Float32 dimension

let sequential ?a ?step dimension = M.sequential Float32 ?a ?step dimension

let linspace a b n = M.linspace Float32 a b n

let logspace ?base a b n = M.logspace Float32 a b n

let bernoulli ?p d = M.bernoulli Float32 ?p d

let load f = M.load Float32 f

let of_array x d = M.of_array Float32 x d

let mmap fd ?pos shared dims = Genarray.map_file fd ?pos Float32 c_layout shared dims

let conj x = copy x

let of_arrays x = of_arrays Float32 x
