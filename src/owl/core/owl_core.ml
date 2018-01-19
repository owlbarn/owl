(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common_types


external owl_float32_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_matrix_transpose"
external owl_float64_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_matrix_transpose"
external owl_complex32_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_matrix_transpose"
external owl_complex64_matrix_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_matrix_transpose"

let _matrix_transpose
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> unit
  = function
  | Float32   -> owl_float32_matrix_transpose
  | Float64   -> owl_float64_matrix_transpose
  | Complex32 -> owl_complex32_matrix_transpose
  | Complex64 -> owl_complex64_matrix_transpose
  | _         -> failwith "_matrix_transpose: unsupported operation"
