(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_conv_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_spatial_bytecode"
"stub_float32_ndarray_conv_spatial_native"

external owl_float32_ndarray_conv_spatial_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_spatial_backward_kernel_bytecode"
"stub_float32_ndarray_conv_spatial_backward_kernel_native"

external owl_float32_ndarray_conv_spatial_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_spatial_backward_input_bytecode"
"stub_float32_ndarray_conv_spatial_backward_input_native"

external owl_float32_ndarray_conv_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_cuboid_bytecode"
"stub_float32_ndarray_conv_cuboid_native"

external owl_float32_ndarray_conv_cuboid_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_cuboid_backward_kernel_bytecode"
"stub_float32_ndarray_conv_cuboid_backward_kernel_native"

external owl_float32_ndarray_conv_cuboid_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_cuboid_backward_input_bytecode"
"stub_float32_ndarray_conv_cuboid_backward_input_native"

external owl_float64_ndarray_conv_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_spatial_bytecode"
"stub_float64_ndarray_conv_spatial_native"

external owl_float64_ndarray_conv_spatial_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_spatial_backward_kernel_bytecode"
"stub_float64_ndarray_conv_spatial_backward_kernel_native"

external owl_float64_ndarray_conv_spatial_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_spatial_backward_input_bytecode"
"stub_float64_ndarray_conv_spatial_backward_input_native"

external owl_float64_ndarray_conv_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_cuboid_bytecode"
"stub_float64_ndarray_conv_cuboid_native"

external owl_float64_ndarray_conv_cuboid_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_cuboid_backward_kernel_bytecode"
"stub_float64_ndarray_conv_cuboid_backward_kernel_native"

external owl_float64_ndarray_conv_cuboid_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_cuboid_backward_input_bytecode"
"stub_float64_ndarray_conv_cuboid_backward_input_native"

external owl_complex32_ndarray_conv_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_spatial_bytecode"
"stub_complex32_ndarray_conv_spatial_native"

external owl_complex32_ndarray_conv_spatial_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_spatial_backward_kernel_bytecode"
"stub_complex32_ndarray_conv_spatial_backward_kernel_native"

external owl_complex32_ndarray_conv_spatial_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_spatial_backward_input_bytecode"
"stub_complex32_ndarray_conv_spatial_backward_input_native"

external owl_complex32_ndarray_conv_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_cuboid_bytecode"
"stub_complex32_ndarray_conv_cuboid_native"

external owl_complex32_ndarray_conv_cuboid_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_cuboid_backward_kernel_bytecode"
"stub_complex32_ndarray_conv_cuboid_backward_kernel_native"

external owl_complex32_ndarray_conv_cuboid_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_cuboid_backward_input_bytecode"
"stub_complex32_ndarray_conv_cuboid_backward_input_native"

external owl_complex64_ndarray_conv_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_spatial_bytecode"
"stub_complex64_ndarray_conv_spatial_native"

external owl_complex64_ndarray_conv_spatial_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_spatial_backward_kernel_bytecode"
"stub_complex64_ndarray_conv_spatial_backward_kernel_native"

external owl_complex64_ndarray_conv_spatial_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_spatial_backward_input_bytecode"
"stub_complex64_ndarray_conv_spatial_backward_input_native"

external owl_complex64_ndarray_conv_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_cuboid_bytecode"
"stub_complex64_ndarray_conv_cuboid_native"

external owl_complex64_ndarray_conv_cuboid_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_cuboid_backward_kernel_bytecode"
"stub_complex64_ndarray_conv_cuboid_backward_kernel_native"

external owl_complex64_ndarray_conv_cuboid_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_cuboid_backward_input_bytecode"
"stub_complex64_ndarray_conv_cuboid_backward_input_native"

external owl_float32_ndarray_conv_spatial_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_spatial_transpose_bytecode"
"stub_float32_ndarray_conv_spatial_transpose_native"

external owl_float64_ndarray_conv_spatial_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_spatial_transpose_bytecode"
"stub_float64_ndarray_conv_spatial_transpose_native"

external owl_complex32_ndarray_conv_spatial_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_spatial_transpose_bytecode"
"stub_complex32_ndarray_conv_spatial_transpose_native"

external owl_complex64_ndarray_conv_spatial_transpose : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_spatial_transpose_bytecode"
"stub_complex64_ndarray_conv_spatial_transpose_native"

external owl_float32_ndarray_conv_spatial_transpose_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_spatial_transpose_backward_input_bytecode"
"stub_float32_ndarray_conv_spatial_transpose_backward_input_native"

external owl_float64_ndarray_conv_spatial_transpose_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_spatial_transpose_backward_input_bytecode"
"stub_float64_ndarray_conv_spatial_transpose_backward_input_native"

external owl_complex32_ndarray_conv_spatial_transpose_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_spatial_transpose_backward_input_bytecode"
"stub_complex32_ndarray_conv_spatial_transpose_backward_input_native"

external owl_complex64_ndarray_conv_spatial_transpose_backward_input : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_spatial_transpose_backward_input_bytecode"
"stub_complex64_ndarray_conv_spatial_transpose_backward_input_native"

let _owl_spatial_conv : type a b . (a, b) kind -> (a, b) owl_arr_op22 = function
  | Float32   -> owl_float32_ndarray_conv_spatial
  | Float64   -> owl_float64_ndarray_conv_spatial
  | Complex32 -> owl_complex32_ndarray_conv_spatial
  | Complex64 -> owl_complex64_ndarray_conv_spatial
  | _         -> failwith "_owl_spatial_conv: unsupported operation"

let _owl_spatial_conv_backward_input : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_input
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_input
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_input
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_input
  | _         -> failwith "_owl_spatial_conv_backward_input: unsupported operation"

let _owl_spatial_conv_backward_kernel : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_kernel
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_kernel
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_kernel
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_kernel
  | _         -> failwith "_owl_spatial_conv_backward_kernel: unsupported operation"

let _owl_cuboid_conv : type a b . (a, b) kind -> (a, b) owl_arr_op24 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid
  | Float64   -> owl_float64_ndarray_conv_cuboid
  | Complex32 -> owl_complex32_ndarray_conv_cuboid
  | Complex64 -> owl_complex64_ndarray_conv_cuboid
  | _         -> failwith "_owl_cuboid_conv: unsupported operation"

let _owl_cuboid_conv_backward_input : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_input
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_input
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_input
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_input
  | _         -> failwith "_owl_cuboid_conv_backward_input: unsupported operation"

let _owl_cuboid_conv_backward_kernel : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_kernel
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_kernel
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_kernel
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_kernel
  | _         -> failwith "_owl_cuboid_conv_backward_kernel: unsupported operation"

(* Is op22 the correct number? *)
let _owl_spatial_trans_conv: type a b . (a, b) kind -> (a, b) owl_arr_op22 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_transpose
  | Float64   -> owl_float64_ndarray_conv_spatial_transpose
  | Complex32 -> owl_complex32_ndarray_conv_spatial_transpose
  | Complex64 -> owl_complex64_ndarray_conv_spatial_transpose
  | _         -> failwith "_owl_spatial_trans_conv: unsupported operation"

external owl_float32_ndarray_conv_spatial_transpose_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_conv_spatial_transpose_backward_kernel_bytecode"
"stub_float32_ndarray_conv_spatial_transpose_backward_kernel_native"

external owl_float64_ndarray_conv_spatial_transpose_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_conv_spatial_transpose_backward_kernel_bytecode"
"stub_float64_ndarray_conv_spatial_transpose_backward_kernel_native"

external owl_complex32_ndarray_conv_spatial_transpose_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_conv_spatial_transpose_backward_kernel_bytecode"
"stub_complex32_ndarray_conv_spatial_transpose_backward_kernel_native"

external owl_complex64_ndarray_conv_spatial_transpose_backward_kernel : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_conv_spatial_transpose_backward_kernel_bytecode"
"stub_complex64_ndarray_conv_spatial_transpose_backward_kernel_native"

let _owl_spatial_trans_conv_backward_input: type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_transpose_backward_input
  | Float64   -> owl_float64_ndarray_conv_spatial_transpose_backward_input
  | Complex32 -> owl_complex32_ndarray_conv_spatial_transpose_backward_input
  | Complex64 -> owl_complex64_ndarray_conv_spatial_transpose_backward_input
  | _         -> failwith "_owl_spatial_trans_conv_backward_input: unsupported operation"

let _owl_spatial_trans_conv_backward_kernel: type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_transpose_backward_kernel
  | Float64   -> owl_float64_ndarray_conv_spatial_transpose_backward_kernel
  | Complex32 -> owl_complex32_ndarray_conv_spatial_transpose_backward_kernel
  | Complex64 -> owl_complex64_ndarray_conv_spatial_transpose_backward_kernel
  | _         -> failwith "_owl_spatial_trans_conv_backward_kernel: unsupported operation"
