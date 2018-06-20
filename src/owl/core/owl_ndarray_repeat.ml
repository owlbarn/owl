(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types

(*
external owl_float32_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_float32_ndarray_repeat_byte" "stub_float32_ndarray_repeat_native"
external owl_float64_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_float64_ndarray_repeat_byte" "stub_float64_ndarray_repeat_native"
external owl_complex32_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_complex32_ndarray_repeat_byte" "stub_complex32_ndarray_repeat_native"
external owl_complex64_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "stub_complex64_ndarray_repeat_byte" "stub_complex64_ndarray_repeat_native"


let _ndarray_repeat
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = function
  | Float32   -> owl_float32_ndarray_repeat
  | Float64   -> owl_float64_ndarray_repeat
  | Complex32 -> owl_complex32_ndarray_repeat
  | Complex64 -> owl_complex64_ndarray_repeat
  | _         -> failwith "_ndarray_repeat: unsupported operation"
*)

external owl_float32_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> int array -> int -> int -> int -> unit = "stub_float32_ndarray_repeat_byte" "stub_float32_ndarray_repeat_native"
external owl_float64_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> int array -> int -> int -> int -> unit = "stub_float64_ndarray_repeat_byte" "stub_float64_ndarray_repeat_native"
external owl_complex32_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> int array -> int -> int -> int -> unit = "stub_complex32_ndarray_repeat_byte" "stub_complex32_ndarray_repeat_native"
external owl_complex64_ndarray_repeat : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> int array -> int -> int -> int -> unit = "stub_complex64_ndarray_repeat_byte" "stub_complex64_ndarray_repeat_native"


let _ndarray_repeat
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int array -> int array -> int array -> int array -> int array -> int array -> int -> int -> int -> unit
  = function
  | Float32   -> owl_float32_ndarray_repeat
  | Float64   -> owl_float64_ndarray_repeat
  | Complex32 -> owl_complex32_ndarray_repeat
  | Complex64 -> owl_complex64_ndarray_repeat
  | _         -> failwith "_ndarray_repeat: unsupported operation"


external owl_float32_ndarray_repeat2 : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> unit = "stub_float32_ndarray_repeat2_byte" "stub_float32_ndarray_repeat2_native"
external owl_float64_ndarray_repeat2 : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> unit = "stub_float64_ndarray_repeat2_byte" "stub_float64_ndarray_repeat2_native"
external owl_complex32_ndarray_repeat2 : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> unit = "stub_complex32_ndarray_repeat2_byte" "stub_complex32_ndarray_repeat2_native"
external owl_complex64_ndarray_repeat2 : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int array -> int array -> int array -> int array -> int array -> unit = "stub_complex64_ndarray_repeat2_byte" "stub_complex64_ndarray_repeat2_native"


let _ndarray_repeat2
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int array -> int array -> int array -> int array -> int array -> unit
  = function
  | Float32   -> owl_float32_ndarray_repeat2
  | Float64   -> owl_float64_ndarray_repeat2
  | Complex32 -> owl_complex32_ndarray_repeat2
  | Complex64 -> owl_complex64_ndarray_repeat2
  | _         -> failwith "_ndarray_repeat2: unsupported operation"
