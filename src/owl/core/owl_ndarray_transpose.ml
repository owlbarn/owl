(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int32, int32_elt) owl_arr -> (int32, int32_elt) owl_arr -> unit = "stub_float32_ndarray_transpose"
external owl_float64_ndarray_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int32, int32_elt) owl_arr -> (int32, int32_elt) owl_arr -> unit = "stub_float64_ndarray_transpose"
external owl_complex32_ndarray_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int32, int32_elt) owl_arr -> (int32, int32_elt) owl_arr -> unit = "stub_complex32_ndarray_transpose"
external owl_complex64_ndarray_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int32, int32_elt) owl_arr -> (int32, int32_elt) owl_arr -> unit = "stub_complex64_ndarray_transpose"

let _ndarray_transpose
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int32, int32_elt) owl_arr -> (int32, int32_elt) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_transpose
  | Float64   -> owl_float64_ndarray_transpose
  | Complex32 -> owl_complex32_ndarray_transpose
  | Complex64 -> owl_complex64_ndarray_transpose
  | _         -> failwith "_ndarray_transpose: unsupported operation"
