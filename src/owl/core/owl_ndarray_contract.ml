(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_contract_one : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_float32_ndarray_contract_one"
external owl_float64_ndarray_contract_one : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_float64_ndarray_contract_one"
external owl_complex32_ndarray_contract_one : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_complex32_ndarray_contract_one"
external owl_complex64_ndarray_contract_one : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_complex64_ndarray_contract_one"

let _ndarray_contract_one
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit
  = function
  | Float32   -> owl_float32_ndarray_contract_one
  | Float64   -> owl_float64_ndarray_contract_one
  | Complex32 -> owl_complex32_ndarray_contract_one
  | Complex64 -> owl_complex64_ndarray_contract_one
  | _         -> failwith "_ndarray_contract_one: unsupported operation"


external owl_float32_ndarray_contract_two : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_float32_ndarray_contract_two_byte" "stub_float32_ndarray_contract_two"
external owl_float64_ndarray_contract_two : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_float64_ndarray_contract_two_byte" "stub_float64_ndarray_contract_two"
external owl_complex32_ndarray_contract_two : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_complex32_ndarray_contract_two_byte" "stub_complex32_ndarray_contract_two"
external owl_complex64_ndarray_contract_two : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit = "stub_complex64_ndarray_contract_two_byte" "stub_complex64_ndarray_contract_two"

let _ndarray_contract_two
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> (int64, int64_elt) owl_arr -> int64 -> unit
  = function
  | Float32   -> owl_float32_ndarray_contract_two
  | Float64   -> owl_float64_ndarray_contract_two
  | Complex32 -> owl_complex32_ndarray_contract_two
  | Complex64 -> owl_complex64_ndarray_contract_two
  | _         -> failwith "_ndarray_contract_two: unsupported operation"
