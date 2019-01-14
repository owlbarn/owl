(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_fma : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float32_ndarray_fma"
external owl_float64_ndarray_fma : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float64_ndarray_fma"
external owl_complex32_ndarray_fma : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex32_ndarray_fma"
external owl_complex64_ndarray_fma : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex64_ndarray_fma"

let _ndarray_fma
  : type a b. (a, b) kind -> int -> (a, b) owl_arr -> (a, b) owl_arr -> (a, b) owl_arr -> (a, b) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_fma
  | Float64   -> owl_float64_ndarray_fma
  | Complex32 -> owl_complex32_ndarray_fma
  | Complex64 -> owl_complex64_ndarray_fma
  | _         -> failwith "_ndarray_fma: unsupported operation"


external owl_float32_ndarray_fma_broadcast : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "stub_float32_ndarray_fma_broadcast_byte" "stub_float32_ndarray_fma_broadcast_native"
external owl_float64_ndarray_fma_broadcast : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "stub_float64_ndarray_fma_broadcast_byte" "stub_float64_ndarray_fma_broadcast_native"
external owl_complex32_ndarray_fma_broadcast : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "stub_complex32_ndarray_fma_broadcast_byte" "stub_complex32_ndarray_fma_broadcast_native"
external owl_complex64_ndarray_fma_broadcast : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "stub_complex64_ndarray_fma_broadcast_byte" "stub_complex64_ndarray_fma_broadcast_native"

let _ndarray_fma_broadcast
  : type a b. (a, b) kind -> (a, b) owl_arr -> (int64, int64_elt) owl_arr -> (a, b) owl_arr -> (int64, int64_elt) owl_arr -> (a, b) owl_arr -> (int64, int64_elt) owl_arr -> (a, b) owl_arr -> (int64, int64_elt) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_fma_broadcast
  | Float64   -> owl_float64_ndarray_fma_broadcast
  | Complex32 -> owl_complex32_ndarray_fma_broadcast
  | Complex64 -> owl_complex64_ndarray_fma_broadcast
  | _         -> failwith "_ndarray_fma_broadcast: unsupported operation"
