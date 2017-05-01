(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_dense_ndarray_generic
include M

type elt = Complex.t
type arr = (Complex.t, complex32_elt, c_layout) Genarray.t
type cast_arr = (float, float32_elt, c_layout) Genarray.t


(* overload functions in Owl_dense_ndarray_generic *)

let empty dimension = M.empty Complex32 dimension

let create dimension a = M.create Complex32 dimension a

let zeros dimension = M.zeros Complex32 dimension

let ones dimension = M.zeros Complex32 dimension

let uniform ?scale dimension = M.uniform ?scale Complex32 dimension

let sequential dimension = M.sequential Complex32 dimension

let linspace a b n = M.linspace Complex32 a b n

let logspace ?base a b n = M.logspace Complex32 a b n

let load f = M.load Complex32 f

let mmap fd ?pos shared dims = Genarray.map_file fd ?pos Complex32 c_layout shared dims

(* specific functions for complex32 ndarray *)

let re x = re_c2s x

let im x = im_c2s x

let abs x = abs_c2s x

let abs2 x = abs2_c2s x
