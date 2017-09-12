(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_sparse_ndarray_generic
include M

type elt = float
type arr = (float, float32_elt) Owl_sparse_ndarray_generic.t

(* overload functions in Owl_dense_ndarray_generic *)

let zeros s = M.zeros Float32 s

let binary ?density s = M.binary ?density Float32 s

let uniform ?scale ?density s = M.uniform ?scale ?density Float32 s

let of_array s x = M.of_array Float32 s x

let load f = M.load Float32 f
