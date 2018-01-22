(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_dense_common

open Owl_dense_common_types


external owl_float32_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_get_fancy"
external owl_float64_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_get_fancy"
external owl_complex32_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_get_fancy"
external owl_complex64_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_get_fancy"

let _ndarray_get_fancy
  : type a b c. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, c) owl_arr -> (int64, c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_get_fancy
  | Float64   -> owl_float64_ndarray_get_fancy
  | Complex32 -> owl_complex32_ndarray_get_fancy
  | Complex64 -> owl_complex64_ndarray_get_fancy
  | _         -> failwith "_ndarray_get_fancy: unsupported operation"


external owl_float32_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_set_fancy"
external owl_float64_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_set_fancy"
external owl_complex32_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_set_fancy"
external owl_complex64_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_set_fancy"

let _ndarray_set_fancy
  : type a b c. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, c) owl_arr -> (int64, c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_set_fancy
  | Float64   -> owl_float64_ndarray_set_fancy
  | Complex32 -> owl_complex32_ndarray_set_fancy
  | Complex64 -> owl_complex64_ndarray_set_fancy
  | _         -> failwith "_ndarray_set_fancy: unsupported operation"
