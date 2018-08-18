(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_repeat_native"
external owl_float64_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_repeat_native"
external owl_complex32_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_repeat_native"
external owl_complex64_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_repeat_native"

let _ndarray_repeat
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, 'c) owl_arr-> (int64, 'c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_repeat
  | Float64   -> owl_float64_ndarray_repeat
  | Complex32 -> owl_complex32_ndarray_repeat
  | Complex64 -> owl_complex64_ndarray_repeat
  | _         -> failwith "_ndarray_repeat: unsupported operation"


external owl_float32_ndarray_repeat_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_float32_ndarray_repeat_axis_native"
external owl_float64_ndarray_repeat_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_float64_ndarray_repeat_axis_native"
external owl_complex32_ndarray_repeat_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_complex32_ndarray_repeat_axis_native"
external owl_complex64_ndarray_repeat_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_complex64_ndarray_repeat_axis_native"

let _ndarray_repeat_axis
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> unit
  = function
  | Float32   -> owl_float32_ndarray_repeat_axis
  | Float64   -> owl_float64_ndarray_repeat_axis
  | Complex32 -> owl_complex32_ndarray_repeat_axis
  | Complex64 -> owl_complex64_ndarray_repeat_axis
  | _         -> failwith "_ndarray_repeat_axis: unsupported operation"


external owl_float32_ndarray_tile : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_tile_native"
external owl_float64_ndarray_tile : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_tile_native"
external owl_complex32_ndarray_tile : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_tile_native"
external owl_complex64_ndarray_tile : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_tile_native"

let _ndarray_tile
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, 'c) owl_arr-> (int64, 'c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_tile
  | Float64   -> owl_float64_ndarray_tile
  | Complex32 -> owl_complex32_ndarray_tile
  | Complex64 -> owl_complex64_ndarray_tile
  | _         -> failwith "_ndarray_tile: unsupported operation"


external owl_float32_ndarray_tile_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_float32_ndarray_tile_axis_native"
external owl_float64_ndarray_tile_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_float64_ndarray_tile_axis_native"
external owl_complex32_ndarray_tile_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_complex32_ndarray_tile_axis_native"
external owl_complex64_ndarray_tile_axis : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> unit = "stub_complex64_ndarray_tile_axis_native"

let _ndarray_tile_axis
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> unit
  = function
  | Float32   -> owl_float32_ndarray_tile_axis
  | Float64   -> owl_float64_ndarray_tile_axis
  | Complex32 -> owl_complex32_ndarray_tile_axis
  | Complex64 -> owl_complex64_ndarray_tile_axis
  | _         -> failwith "_ndarray_tile_axis: unsupported operation"
