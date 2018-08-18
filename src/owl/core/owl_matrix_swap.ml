(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_matrix_swap_rows : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_float32_matrix_swap_rows"
external owl_float64_matrix_swap_rows : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_float64_matrix_swap_rows"
external owl_complex32_matrix_swap_rows : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_complex32_matrix_swap_rows"
external owl_complex64_matrix_swap_rows : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_complex64_matrix_swap_rows"

let _matrix_swap_rows
  : type a b. (a, b) kind -> (a, b) owl_arr -> int -> int -> int -> int -> unit
  = function
  | Float32   -> owl_float32_matrix_swap_rows
  | Float64   -> owl_float64_matrix_swap_rows
  | Complex32 -> owl_complex32_matrix_swap_rows
  | Complex64 -> owl_complex64_matrix_swap_rows
  | _         -> failwith "_matrix_swap_rows: unsupported operation"


external owl_float32_matrix_swap_cols : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_float32_matrix_swap_cols"
external owl_float64_matrix_swap_cols : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_float64_matrix_swap_cols"
external owl_complex32_matrix_swap_cols : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_complex32_matrix_swap_cols"
external owl_complex64_matrix_swap_cols : ('a, 'b) owl_arr -> int -> int -> int -> int -> unit = "stub_complex64_matrix_swap_cols"

let _matrix_swap_cols
  : type a b. (a, b) kind -> (a, b) owl_arr -> int -> int -> int -> int -> unit
  = function
  | Float32   -> owl_float32_matrix_swap_cols
  | Float64   -> owl_float64_matrix_swap_cols
  | Complex32 -> owl_complex32_matrix_swap_cols
  | Complex64 -> owl_complex64_matrix_swap_cols
  | _         -> failwith "_matrix_swap_cols: unsupported operation"


external owl_float32_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float32_matrix_transpose"
external owl_float64_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float64_matrix_transpose"
external owl_complex32_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex32_matrix_transpose"
external owl_complex64_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex64_matrix_transpose"

let _matrix_transpose
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> unit
  = function
  | Float32   -> owl_float32_matrix_transpose
  | Float64   -> owl_float64_matrix_transpose
  | Complex32 -> owl_complex32_matrix_transpose
  | Complex64 -> owl_complex64_matrix_transpose
  | _         -> failwith "_matrix_transpose: unsupported operation"

external owl_float32_matrix_ctranspose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float32_matrix_ctranspose"
external owl_float64_matrix_ctranspose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_float64_matrix_ctranspose"
external owl_complex32_matrix_ctranspose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex32_matrix_ctranspose"
external owl_complex64_matrix_ctranspose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "stub_complex64_matrix_ctranspose"

let _matrix_ctranspose
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> unit
  = function
  | Float32   -> owl_float32_matrix_ctranspose
  | Float64   -> owl_float64_matrix_ctranspose
  | Complex32 -> owl_complex32_matrix_ctranspose
  | Complex64 -> owl_complex64_matrix_ctranspose
  | _         -> failwith "_matrix_ctranspose: unsupported operation"
