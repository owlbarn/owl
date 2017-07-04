(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_dense_ndarray_generic
include M

type elt = float
type arr = (float, float64_elt, c_layout) Genarray.t


(* overload functions in Owl_dense_ndarray_generic *)

let empty dimension = M.empty Float64 dimension

let create dimension a = M.create Float64 dimension a

let init dimension f = M.init Float64 dimension f

let init_nd dimension f = M.init_nd Float64 dimension f

let zeros dimension = M.zeros Float64 dimension

let ones dimension = M.ones Float64 dimension

let uniform ?scale dimension = M.uniform ?scale Float64 dimension

let gaussian ?sigma dimension = M.gaussian ?sigma Float64 dimension

let sequential ?a ?step dimension = M.sequential Float64 ?a ?step dimension

let linspace a b n = M.linspace Float64 a b n

let logspace ?base a b n = M.logspace Float64 a b n

let bernoulli ?p ?seed d = M.bernoulli Float64 ?p ?seed d

let load f = M.load Float64 f

let of_array x d = M.of_array Float64 x d

let mmap fd ?pos shared dims = Genarray.map_file fd ?pos Float64 c_layout shared dims

let conj x = clone x
