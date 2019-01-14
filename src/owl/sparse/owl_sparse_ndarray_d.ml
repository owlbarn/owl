(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_sparse_ndarray_generic
include M

type elt = float
type arr = (float, float64_elt) Owl_sparse_ndarray_generic.t

(* overload functions in Owl_dense_ndarray_generic *)

let zeros s = M.zeros Float64 s

let binary ?density s = M.binary ?density Float64 s

let uniform ?scale ?density s = M.uniform ?scale ?density Float64 s

let of_array s x = M.of_array Float64 s x

let load f = M.load Float64 f
