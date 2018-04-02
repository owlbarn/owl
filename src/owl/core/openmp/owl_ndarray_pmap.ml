(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_pmap : ('a -> 'a) -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float32_ndarray_pmap"
external owl_float64_ndarray_pmap : ('a -> 'a) -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float64_ndarray_pmap"
external owl_complex32_ndarray_pmap : ('a -> 'a) -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex32_ndarray_pmap"
external owl_complex64_ndarray_pmap : ('a -> 'a) -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex64_ndarray_pmap"

let _ndarray_pmap
  : type a b. (a, b) kind -> (a -> a) -> (a, b) owl_arr -> (a, b) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_pmap
  | Float64   -> owl_float64_ndarray_pmap
  | Complex32 -> owl_complex32_ndarray_pmap
  | Complex64 -> owl_complex64_ndarray_pmap
  | _         -> failwith "_ndarray_pmap: unsupported operation"
