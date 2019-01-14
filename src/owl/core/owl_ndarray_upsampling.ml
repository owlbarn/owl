(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_upsampling_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
  "stub_float32_ndarray_upsampling_spatial_backward_bytecode"
  "stub_float32_ndarray_upsampling_spatial_backward_native"

external owl_float64_ndarray_upsampling_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
  "stub_float64_ndarray_upsampling_spatial_backward_bytecode"
  "stub_float64_ndarray_upsampling_spatial_backward_native"

external owl_complex32_ndarray_upsampling_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
  "stub_complex32_ndarray_upsampling_spatial_backward_bytecode"
  "stub_complex32_ndarray_upsampling_spatial_backward_native"

external owl_complex64_ndarray_upsampling_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
  "stub_complex64_ndarray_upsampling_spatial_backward_bytecode"
  "stub_complex64_ndarray_upsampling_spatial_backward_native"

let _owl_spatial_upsampling_backward : type a b . (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = function
  | Float32   -> owl_float32_ndarray_upsampling_spatial_backward
  | Float64   -> owl_float64_ndarray_upsampling_spatial_backward
  | Complex32 -> owl_complex32_ndarray_upsampling_spatial_backward
  | Complex64 -> owl_complex64_ndarray_upsampling_spatial_backward
  | _         -> failwith "_owl_upsampling_spatial_backward: unsupported operation"
