(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_slide : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_float32_ndarray_slide_byte" "stub_float32_ndarray_slide_native"
external owl_float64_ndarray_slide : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_float64_ndarray_slide_byte" "stub_float64_ndarray_slide_native"
external owl_complex32_ndarray_slide : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_complex32_ndarray_slide_byte" "stub_complex32_ndarray_slide_native"
external owl_complex64_ndarray_slide : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_complex64_ndarray_slide_byte" "stub_complex64_ndarray_slide_native"


let _ndarray_slide
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = function
  | Float32   -> owl_float32_ndarray_slide
  | Float64   -> owl_float64_ndarray_slide
  | Complex32 -> owl_complex32_ndarray_slide
  | Complex64 -> owl_complex64_ndarray_slide
  | _         -> failwith "_ndarray_slide: unsupported operation"
