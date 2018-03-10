(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common_types


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

external owl_float32_matrix_is_triu : ('a, 'b) owl_arr -> bool = "stub_float32_matrix_is_triu"
external owl_float64_matrix_is_triu : ('a, 'b) owl_arr -> bool = "stub_float64_matrix_is_triu"
external owl_complex32_matrix_is_triu : ('a, 'b) owl_arr -> bool = "stub_complex32_matrix_is_triu"
external owl_complex64_matrix_is_triu : ('a, 'b) owl_arr -> bool = "stub_complex64_matrix_is_triu"

let _matrix_is_triu
  : type a b. (a, b) kind -> (a, b) owl_arr -> bool
  = function
  | Float32   -> owl_float32_matrix_is_triu
  | Float64   -> owl_float64_matrix_is_triu
  | Complex32 -> owl_complex32_matrix_is_triu
  | Complex64 -> owl_complex64_matrix_is_triu
  | _         -> failwith "_matrix_is_triu: unsupported operation"

external owl_float32_matrix_is_tril : ('a, 'b) owl_arr -> bool = "stub_float32_matrix_is_tril"
external owl_float64_matrix_is_tril : ('a, 'b) owl_arr -> bool = "stub_float64_matrix_is_tril"
external owl_complex32_matrix_is_tril : ('a, 'b) owl_arr -> bool = "stub_complex32_matrix_is_tril"
external owl_complex64_matrix_is_tril : ('a, 'b) owl_arr -> bool = "stub_complex64_matrix_is_tril"

let _matrix_is_tril
  : type a b. (a, b) kind -> (a, b) owl_arr -> bool
  = function
  | Float32   -> owl_float32_matrix_is_tril
  | Float64   -> owl_float64_matrix_is_tril
  | Complex32 -> owl_complex32_matrix_is_tril
  | Complex64 -> owl_complex64_matrix_is_tril
  | _         -> failwith "_matrix_is_tril: unsupported operation"

external owl_float32_matrix_is_diag : ('a, 'b) owl_arr -> bool = "stub_float32_matrix_is_diag"
external owl_float64_matrix_is_diag : ('a, 'b) owl_arr -> bool = "stub_float64_matrix_is_diag"
external owl_complex32_matrix_is_diag : ('a, 'b) owl_arr -> bool = "stub_complex32_matrix_is_diag"
external owl_complex64_matrix_is_diag : ('a, 'b) owl_arr -> bool = "stub_complex64_matrix_is_diag"

let _matrix_is_diag
  : type a b. (a, b) kind -> (a, b) owl_arr -> bool
  = function
  | Float32   -> owl_float32_matrix_is_diag
  | Float64   -> owl_float64_matrix_is_diag
  | Complex32 -> owl_complex32_matrix_is_diag
  | Complex64 -> owl_complex64_matrix_is_diag
  | _         -> failwith "_matrix_is_diag: unsupported operation"

external owl_float32_matrix_is_symmetric : ('a, 'b) owl_arr -> bool = "stub_float32_matrix_is_symmetric"
external owl_float64_matrix_is_symmetric : ('a, 'b) owl_arr -> bool = "stub_float64_matrix_is_symmetric"
external owl_complex32_matrix_is_symmetric : ('a, 'b) owl_arr -> bool = "stub_complex32_matrix_is_symmetric"
external owl_complex64_matrix_is_symmetric : ('a, 'b) owl_arr -> bool = "stub_complex64_matrix_is_symmetric"

let _matrix_is_symmetric
  : type a b. (a, b) kind -> (a, b) owl_arr -> bool
  = function
  | Float32   -> owl_float32_matrix_is_symmetric
  | Float64   -> owl_float64_matrix_is_symmetric
  | Complex32 -> owl_complex32_matrix_is_symmetric
  | Complex64 -> owl_complex64_matrix_is_symmetric
  | _         -> failwith "_matrix_is_symmetric: unsupported operation"

external owl_float32_matrix_is_hermitian : ('a, 'b) owl_arr -> bool = "stub_float32_matrix_is_hermitian"
external owl_float64_matrix_is_hermitian : ('a, 'b) owl_arr -> bool = "stub_float64_matrix_is_hermitian"
external owl_complex32_matrix_is_hermitian : ('a, 'b) owl_arr -> bool = "stub_complex32_matrix_is_hermitian"
external owl_complex64_matrix_is_hermitian : ('a, 'b) owl_arr -> bool = "stub_complex64_matrix_is_hermitian"

let _matrix_is_hermitian
  : type a b. (a, b) kind -> (a, b) owl_arr -> bool
  = function
  | Float32   -> owl_float32_matrix_is_hermitian
  | Float64   -> owl_float64_matrix_is_hermitian
  | Complex32 -> owl_complex32_matrix_is_hermitian
  | Complex64 -> owl_complex64_matrix_is_hermitian
  | _         -> failwith "_matrix_is_hermitian: unsupported operation"
