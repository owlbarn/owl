(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


(*
 * im2col convolution implementation
 *)

external owl_float32_ndarray_conv_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_im2col_bytecode"
 "stub_float32_ndarray_conv_spatial_im2col_native"

 external owl_float32_ndarray_conv_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_backward_kernel_im2col_bytecode"
 "stub_float32_ndarray_conv_spatial_backward_kernel_im2col_native"

 external owl_float32_ndarray_conv_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_backward_input_im2col_bytecode"
 "stub_float32_ndarray_conv_spatial_backward_input_im2col_native"

 external owl_float32_ndarray_conv_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_im2col_bytecode"
 "stub_float32_ndarray_conv_cuboid_im2col_native"

 external owl_float32_ndarray_conv_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_backward_kernel_im2col_bytecode"
 "stub_float32_ndarray_conv_cuboid_backward_kernel_im2col_native"

 external owl_float32_ndarray_conv_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_backward_input_im2col_bytecode"
 "stub_float32_ndarray_conv_cuboid_backward_input_im2col_native"

 external owl_float64_ndarray_conv_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_im2col_bytecode"
 "stub_float64_ndarray_conv_spatial_im2col_native"

 external owl_float64_ndarray_conv_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_backward_kernel_im2col_bytecode"
 "stub_float64_ndarray_conv_spatial_backward_kernel_im2col_native"

 external owl_float64_ndarray_conv_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_backward_input_im2col_bytecode"
 "stub_float64_ndarray_conv_spatial_backward_input_im2col_native"

 external owl_float64_ndarray_conv_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_im2col_bytecode"
 "stub_float64_ndarray_conv_cuboid_im2col_native"

 external owl_float64_ndarray_conv_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_backward_kernel_im2col_bytecode"
 "stub_float64_ndarray_conv_cuboid_backward_kernel_im2col_native"

 external owl_float64_ndarray_conv_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_backward_input_im2col_bytecode"
 "stub_float64_ndarray_conv_cuboid_backward_input_im2col_native"

 external owl_complex32_ndarray_conv_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_im2col_bytecode"
 "stub_complex32_ndarray_conv_spatial_im2col_native"

 external owl_complex32_ndarray_conv_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_backward_kernel_im2col_bytecode"
 "stub_complex32_ndarray_conv_spatial_backward_kernel_im2col_native"

 external owl_complex32_ndarray_conv_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_backward_input_im2col_bytecode"
 "stub_complex32_ndarray_conv_spatial_backward_input_im2col_native"

 external owl_complex32_ndarray_conv_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_im2col_bytecode"
 "stub_complex32_ndarray_conv_cuboid_im2col_native"

 external owl_complex32_ndarray_conv_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_backward_kernel_im2col_bytecode"
 "stub_complex32_ndarray_conv_cuboid_backward_kernel_im2col_native"

 external owl_complex32_ndarray_conv_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_backward_input_im2col_bytecode"
 "stub_complex32_ndarray_conv_cuboid_backward_input_im2col_native"

 external owl_complex64_ndarray_conv_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_im2col_bytecode"
 "stub_complex64_ndarray_conv_spatial_im2col_native"

 external owl_complex64_ndarray_conv_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_backward_kernel_im2col_bytecode"
 "stub_complex64_ndarray_conv_spatial_backward_kernel_im2col_native"

 external owl_complex64_ndarray_conv_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_backward_input_im2col_bytecode"
 "stub_complex64_ndarray_conv_spatial_backward_input_im2col_native"

 external owl_complex64_ndarray_conv_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_im2col_bytecode"
 "stub_complex64_ndarray_conv_cuboid_im2col_native"

 external owl_complex64_ndarray_conv_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_backward_kernel_im2col_bytecode"
 "stub_complex64_ndarray_conv_cuboid_backward_kernel_im2col_native"

 external owl_complex64_ndarray_conv_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_backward_input_im2col_bytecode"
 "stub_complex64_ndarray_conv_cuboid_backward_input_im2col_native"


let _owl_spatial_conv : type a b . (a, b) kind -> (a, b) owl_arr_op22 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_im2col
  | Float64   -> owl_float64_ndarray_conv_spatial_im2col
  | Complex32 -> owl_complex32_ndarray_conv_spatial_im2col
  | Complex64 -> owl_complex64_ndarray_conv_spatial_im2col
  | _         -> failwith "_owl_spatial_conv_im2col: unsupported operation"

let _owl_spatial_conv_backward_input : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_input_im2col
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_input_im2col
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_input_im2col
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_input_im2col
  | _         -> failwith "_owl_spatial_conv_backward_input_im2col: unsupported operation"

let _owl_spatial_conv_backward_kernel : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_kernel_im2col
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_kernel_im2col
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_kernel_im2col
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_kernel_im2col
  | _         -> failwith "_owl_spatial_conv_backward_kernel_im2col: unsupported operation"

let _owl_cuboid_conv : type a b . (a, b) kind -> (a, b) owl_arr_op24 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_im2col
  | Float64   -> owl_float64_ndarray_conv_cuboid_im2col
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_im2col
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_im2col
  | _         -> failwith "_owl_cuboid_conv_im2col: unsupported operation"

let _owl_cuboid_conv_backward_input : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_input_im2col
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_input_im2col
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_input_im2col
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_input_im2col
  | _         -> failwith "_owl_cuboid_conv_backward_input_im2col: unsupported operation"

let _owl_cuboid_conv_backward_kernel : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_kernel_im2col
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_kernel_im2col
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_kernel_im2col
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_kernel_im2col
  | _         -> failwith "_owl_cuboid_conv_backward_kernel_im2col: unsupported operation"


(*
 * memory-efficient convolution implementation
 *)

external owl_float32_ndarray_conv_spatial_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_mec_bytecode"
 "stub_float32_ndarray_conv_spatial_mec_native"

 external owl_float32_ndarray_conv_spatial_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_backward_kernel_mec_bytecode"
 "stub_float32_ndarray_conv_spatial_backward_kernel_mec_native"

 external owl_float32_ndarray_conv_spatial_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_backward_input_mec_bytecode"
 "stub_float32_ndarray_conv_spatial_backward_input_mec_native"

 external owl_float32_ndarray_conv_cuboid_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_mec_bytecode"
 "stub_float32_ndarray_conv_cuboid_mec_native"

 external owl_float32_ndarray_conv_cuboid_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_backward_kernel_mec_bytecode"
 "stub_float32_ndarray_conv_cuboid_backward_kernel_mec_native"

 external owl_float32_ndarray_conv_cuboid_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_backward_input_mec_bytecode"
 "stub_float32_ndarray_conv_cuboid_backward_input_mec_native"

 external owl_float64_ndarray_conv_spatial_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_mec_bytecode"
 "stub_float64_ndarray_conv_spatial_mec_native"

 external owl_float64_ndarray_conv_spatial_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_backward_kernel_mec_bytecode"
 "stub_float64_ndarray_conv_spatial_backward_kernel_mec_native"

 external owl_float64_ndarray_conv_spatial_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_backward_input_mec_bytecode"
 "stub_float64_ndarray_conv_spatial_backward_input_mec_native"

 external owl_float64_ndarray_conv_cuboid_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_mec_bytecode"
 "stub_float64_ndarray_conv_cuboid_mec_native"

 external owl_float64_ndarray_conv_cuboid_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_backward_kernel_mec_bytecode"
 "stub_float64_ndarray_conv_cuboid_backward_kernel_mec_native"

 external owl_float64_ndarray_conv_cuboid_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_backward_input_mec_bytecode"
 "stub_float64_ndarray_conv_cuboid_backward_input_mec_native"

 external owl_complex32_ndarray_conv_spatial_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_mec_bytecode"
 "stub_complex32_ndarray_conv_spatial_mec_native"

 external owl_complex32_ndarray_conv_spatial_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_backward_kernel_mec_bytecode"
 "stub_complex32_ndarray_conv_spatial_backward_kernel_mec_native"

 external owl_complex32_ndarray_conv_spatial_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_backward_input_mec_bytecode"
 "stub_complex32_ndarray_conv_spatial_backward_input_mec_native"

 external owl_complex32_ndarray_conv_cuboid_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_mec_bytecode"
 "stub_complex32_ndarray_conv_cuboid_mec_native"

 external owl_complex32_ndarray_conv_cuboid_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_backward_kernel_mec_bytecode"
 "stub_complex32_ndarray_conv_cuboid_backward_kernel_mec_native"

 external owl_complex32_ndarray_conv_cuboid_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_backward_input_mec_bytecode"
 "stub_complex32_ndarray_conv_cuboid_backward_input_mec_native"

 external owl_complex64_ndarray_conv_spatial_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_mec_bytecode"
 "stub_complex64_ndarray_conv_spatial_mec_native"

 external owl_complex64_ndarray_conv_spatial_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_backward_kernel_mec_bytecode"
 "stub_complex64_ndarray_conv_spatial_backward_kernel_mec_native"

 external owl_complex64_ndarray_conv_spatial_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_backward_input_mec_bytecode"
 "stub_complex64_ndarray_conv_spatial_backward_input_mec_native"

 external owl_complex64_ndarray_conv_cuboid_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_mec_bytecode"
 "stub_complex64_ndarray_conv_cuboid_mec_native"

 external owl_complex64_ndarray_conv_cuboid_backward_kernel_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_backward_kernel_mec_bytecode"
 "stub_complex64_ndarray_conv_cuboid_backward_kernel_mec_native"

 external owl_complex64_ndarray_conv_cuboid_backward_input_mec : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_backward_input_mec_bytecode"
 "stub_complex64_ndarray_conv_cuboid_backward_input_mec_native"


let _owl_spatial_conv_mec : type a b . (a, b) kind -> (a, b) owl_arr_op22 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_mec
  | Float64   -> owl_float64_ndarray_conv_spatial_mec
  | Complex32 -> owl_complex32_ndarray_conv_spatial_mec
  | Complex64 -> owl_complex64_ndarray_conv_spatial_mec
  | _         -> failwith "_owl_spatial_conv_mec: unsupported operation"

let _owl_spatial_conv_backward_input_mec : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_input_mec
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_input_mec
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_input_mec
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_input_mec
  | _         -> failwith "_owl_spatial_conv_backward_input_mec: unsupported operation"

let _owl_spatial_conv_backward_kernel_mec : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_kernel_mec
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_kernel_mec
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_kernel_mec
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_kernel_mec
  | _         -> failwith "_owl_spatial_conv_backward_kernel_mec: unsupported operation"

let _owl_cuboid_conv_mec : type a b . (a, b) kind -> (a, b) owl_arr_op24 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_mec
  | Float64   -> owl_float64_ndarray_conv_cuboid_mec
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_mec
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_mec
  | _         -> failwith "_owl_cuboid_conv_mec: unsupported operation"

let _owl_cuboid_conv_backward_input_mec : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_input_mec
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_input_mec
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_input_mec
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_input_mec
  | _         -> failwith "_owl_cuboid_conv_backward_input_mec: unsupported operation"

let _owl_cuboid_conv_backward_kernel_mec : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_kernel_mec
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_kernel_mec
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_kernel_mec
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_kernel_mec
  | _         -> failwith "_owl_cuboid_conv_backward_kernel_mec: unsupported operation"


(*
 * naive convolution implementation
 *)

 external owl_float32_ndarray_conv_spatial_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_naive_bytecode"
 "stub_float32_ndarray_conv_spatial_naive_native"

 external owl_float32_ndarray_conv_spatial_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_backward_kernel_naive_bytecode"
 "stub_float32_ndarray_conv_spatial_backward_kernel_naive_native"

 external owl_float32_ndarray_conv_spatial_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_spatial_backward_input_naive_bytecode"
 "stub_float32_ndarray_conv_spatial_backward_input_naive_native"

 external owl_float32_ndarray_conv_cuboid_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_naive_bytecode"
 "stub_float32_ndarray_conv_cuboid_naive_native"

 external owl_float32_ndarray_conv_cuboid_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_backward_kernel_naive_bytecode"
 "stub_float32_ndarray_conv_cuboid_backward_kernel_naive_native"

 external owl_float32_ndarray_conv_cuboid_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_cuboid_backward_input_naive_bytecode"
 "stub_float32_ndarray_conv_cuboid_backward_input_naive_native"

 external owl_float64_ndarray_conv_spatial_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_naive_bytecode"
 "stub_float64_ndarray_conv_spatial_naive_native"

 external owl_float64_ndarray_conv_spatial_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_backward_kernel_naive_bytecode"
 "stub_float64_ndarray_conv_spatial_backward_kernel_naive_native"

 external owl_float64_ndarray_conv_spatial_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_spatial_backward_input_naive_bytecode"
 "stub_float64_ndarray_conv_spatial_backward_input_naive_native"

 external owl_float64_ndarray_conv_cuboid_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_naive_bytecode"
 "stub_float64_ndarray_conv_cuboid_naive_native"

 external owl_float64_ndarray_conv_cuboid_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_backward_kernel_naive_bytecode"
 "stub_float64_ndarray_conv_cuboid_backward_kernel_naive_native"

 external owl_float64_ndarray_conv_cuboid_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_cuboid_backward_input_naive_bytecode"
 "stub_float64_ndarray_conv_cuboid_backward_input_naive_native"

 external owl_complex32_ndarray_conv_spatial_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_naive_bytecode"
 "stub_complex32_ndarray_conv_spatial_naive_native"

 external owl_complex32_ndarray_conv_spatial_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_backward_kernel_naive_bytecode"
 "stub_complex32_ndarray_conv_spatial_backward_kernel_naive_native"

 external owl_complex32_ndarray_conv_spatial_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_spatial_backward_input_naive_bytecode"
 "stub_complex32_ndarray_conv_spatial_backward_input_naive_native"

 external owl_complex32_ndarray_conv_cuboid_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_naive_bytecode"
 "stub_complex32_ndarray_conv_cuboid_naive_native"

 external owl_complex32_ndarray_conv_cuboid_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_backward_kernel_naive_bytecode"
 "stub_complex32_ndarray_conv_cuboid_backward_kernel_naive_native"

 external owl_complex32_ndarray_conv_cuboid_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_cuboid_backward_input_naive_bytecode"
 "stub_complex32_ndarray_conv_cuboid_backward_input_naive_native"

 external owl_complex64_ndarray_conv_spatial_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_naive_bytecode"
 "stub_complex64_ndarray_conv_spatial_naive_native"

 external owl_complex64_ndarray_conv_spatial_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_backward_kernel_naive_bytecode"
 "stub_complex64_ndarray_conv_spatial_backward_kernel_naive_native"

 external owl_complex64_ndarray_conv_spatial_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_spatial_backward_input_naive_bytecode"
 "stub_complex64_ndarray_conv_spatial_backward_input_naive_native"

 external owl_complex64_ndarray_conv_cuboid_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_naive_bytecode"
 "stub_complex64_ndarray_conv_cuboid_naive_native"

 external owl_complex64_ndarray_conv_cuboid_backward_kernel_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_backward_kernel_naive_bytecode"
 "stub_complex64_ndarray_conv_cuboid_backward_kernel_naive_native"

 external owl_complex64_ndarray_conv_cuboid_backward_input_naive : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_cuboid_backward_input_naive_bytecode"
 "stub_complex64_ndarray_conv_cuboid_backward_input_naive_native"


let _owl_spatial_conv_naive : type a b . (a, b) kind -> (a, b) owl_arr_op22 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_naive
  | Float64   -> owl_float64_ndarray_conv_spatial_naive
  | Complex32 -> owl_complex32_ndarray_conv_spatial_naive
  | Complex64 -> owl_complex64_ndarray_conv_spatial_naive
  | _         -> failwith "_owl_spatial_conv_naive: unsupported operation"

let _owl_spatial_conv_backward_input_naive : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_input_naive
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_input_naive
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_input_naive
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_input_naive
  | _         -> failwith "_owl_spatial_conv_backward_input_naive: unsupported operation"

let _owl_spatial_conv_backward_kernel_naive : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_spatial_backward_kernel_naive
  | Float64   -> owl_float64_ndarray_conv_spatial_backward_kernel_naive
  | Complex32 -> owl_complex32_ndarray_conv_spatial_backward_kernel_naive
  | Complex64 -> owl_complex64_ndarray_conv_spatial_backward_kernel_naive
  | _         -> failwith "_owl_spatial_conv_backward_kernel_naive: unsupported operation"

let _owl_cuboid_conv_naive : type a b . (a, b) kind -> (a, b) owl_arr_op24 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_naive
  | Float64   -> owl_float64_ndarray_conv_cuboid_naive
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_naive
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_naive
  | _         -> failwith "_owl_cuboid_conv_naive: unsupported operation"

let _owl_cuboid_conv_backward_input_naive : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_input_naive
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_input_naive
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_input_naive
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_input_naive
  | _         -> failwith "_owl_cuboid_conv_backward_input_naive: unsupported operation"

let _owl_cuboid_conv_backward_kernel_naive : type a b . (a, b) kind -> (a, b) owl_arr_op25 = function
  | Float32   -> owl_float32_ndarray_conv_cuboid_backward_kernel_naive
  | Float64   -> owl_float64_ndarray_conv_cuboid_backward_kernel_naive
  | Complex32 -> owl_complex32_ndarray_conv_cuboid_backward_kernel_naive
  | Complex64 -> owl_complex64_ndarray_conv_cuboid_backward_kernel_naive
  | _         -> failwith "_owl_cuboid_conv_backward_kernel_naive: unsupported operation"


(*
 * dilated convolution
 *)


external owl_float32_ndarray_conv_dilated_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_dilated_spatial_im2col_bytecode"
 "stub_float32_ndarray_conv_dilated_spatial_im2col_native"

 external owl_float32_ndarray_conv_dilated_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_dilated_spatial_backward_kernel_im2col_bytecode"
 "stub_float32_ndarray_conv_dilated_spatial_backward_kernel_im2col_native"

 external owl_float32_ndarray_conv_dilated_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_dilated_spatial_backward_input_im2col_bytecode"
 "stub_float32_ndarray_conv_dilated_spatial_backward_input_im2col_native"

 external owl_float32_ndarray_conv_dilated_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_dilated_cuboid_im2col_bytecode"
 "stub_float32_ndarray_conv_dilated_cuboid_im2col_native"

 external owl_float32_ndarray_conv_dilated_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_dilated_cuboid_backward_kernel_im2col_bytecode"
 "stub_float32_ndarray_conv_dilated_cuboid_backward_kernel_im2col_native"

 external owl_float32_ndarray_conv_dilated_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float32_ndarray_conv_dilated_cuboid_backward_input_im2col_bytecode"
 "stub_float32_ndarray_conv_dilated_cuboid_backward_input_im2col_native"

 external owl_float64_ndarray_conv_dilated_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_dilated_spatial_im2col_bytecode"
 "stub_float64_ndarray_conv_dilated_spatial_im2col_native"

 external owl_float64_ndarray_conv_dilated_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_dilated_spatial_backward_kernel_im2col_bytecode"
 "stub_float64_ndarray_conv_dilated_spatial_backward_kernel_im2col_native"

 external owl_float64_ndarray_conv_dilated_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_dilated_spatial_backward_input_im2col_bytecode"
 "stub_float64_ndarray_conv_dilated_spatial_backward_input_im2col_native"

 external owl_float64_ndarray_conv_dilated_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_dilated_cuboid_im2col_bytecode"
 "stub_float64_ndarray_conv_dilated_cuboid_im2col_native"

 external owl_float64_ndarray_conv_dilated_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_dilated_cuboid_backward_kernel_im2col_bytecode"
 "stub_float64_ndarray_conv_dilated_cuboid_backward_kernel_im2col_native"

 external owl_float64_ndarray_conv_dilated_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_float64_ndarray_conv_dilated_cuboid_backward_input_im2col_bytecode"
 "stub_float64_ndarray_conv_dilated_cuboid_backward_input_im2col_native"

 external owl_complex32_ndarray_conv_dilated_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_dilated_spatial_im2col_bytecode"
 "stub_complex32_ndarray_conv_dilated_spatial_im2col_native"

 external owl_complex32_ndarray_conv_dilated_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_dilated_spatial_backward_kernel_im2col_bytecode"
 "stub_complex32_ndarray_conv_dilated_spatial_backward_kernel_im2col_native"

 external owl_complex32_ndarray_conv_dilated_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_dilated_spatial_backward_input_im2col_bytecode"
 "stub_complex32_ndarray_conv_dilated_spatial_backward_input_im2col_native"

 external owl_complex32_ndarray_conv_dilated_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_dilated_cuboid_im2col_bytecode"
 "stub_complex32_ndarray_conv_dilated_cuboid_im2col_native"

 external owl_complex32_ndarray_conv_dilated_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_dilated_cuboid_backward_kernel_im2col_bytecode"
 "stub_complex32_ndarray_conv_dilated_cuboid_backward_kernel_im2col_native"

 external owl_complex32_ndarray_conv_dilated_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex32_ndarray_conv_dilated_cuboid_backward_input_im2col_bytecode"
 "stub_complex32_ndarray_conv_dilated_cuboid_backward_input_im2col_native"

 external owl_complex64_ndarray_conv_dilated_spatial_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_dilated_spatial_im2col_bytecode"
 "stub_complex64_ndarray_conv_dilated_spatial_im2col_native"

 external owl_complex64_ndarray_conv_dilated_spatial_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_dilated_spatial_backward_kernel_im2col_bytecode"
 "stub_complex64_ndarray_conv_dilated_spatial_backward_kernel_im2col_native"

 external owl_complex64_ndarray_conv_dilated_spatial_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_dilated_spatial_backward_input_im2col_bytecode"
 "stub_complex64_ndarray_conv_dilated_spatial_backward_input_im2col_native"

 external owl_complex64_ndarray_conv_dilated_cuboid_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_dilated_cuboid_im2col_bytecode"
 "stub_complex64_ndarray_conv_dilated_cuboid_im2col_native"

 external owl_complex64_ndarray_conv_dilated_cuboid_backward_kernel_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int  -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_dilated_cuboid_backward_kernel_im2col_bytecode"
 "stub_complex64_ndarray_conv_dilated_cuboid_backward_kernel_im2col_native"

 external owl_complex64_ndarray_conv_dilated_cuboid_backward_input_im2col : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
 "stub_complex64_ndarray_conv_dilated_cuboid_backward_input_im2col_bytecode"
 "stub_complex64_ndarray_conv_dilated_cuboid_backward_input_im2col_native"

let _owl_dilated_spatial_conv : type a b . (a, b) kind -> (a, b) owl_arr_op22 = function
  | Float32   -> owl_float32_ndarray_conv_dilated_spatial_im2col
  | Float64   -> owl_float64_ndarray_conv_dilated_spatial_im2col
  | Complex32 -> owl_complex32_ndarray_conv_dilated_spatial_im2col
  | Complex64 -> owl_complex64_ndarray_conv_dilated_spatial_im2col
  | _         -> failwith "_owl_dilated_spatial_conv_im2col: unsupported operation"

let _owl_dilated_spatial_conv_backward_input : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_dilated_spatial_backward_input_im2col
  | Float64   -> owl_float64_ndarray_conv_dilated_spatial_backward_input_im2col
  | Complex32 -> owl_complex32_ndarray_conv_dilated_spatial_backward_input_im2col
  | Complex64 -> owl_complex64_ndarray_conv_dilated_spatial_backward_input_im2col
  | _         -> failwith "_owl_dilated_spatial_conv_backward_input_im2col: unsupported operation"

let _owl_dilated_spatial_conv_backward_kernel : type a b . (a, b) kind -> (a, b) owl_arr_op23 = function
  | Float32   -> owl_float32_ndarray_conv_dilated_spatial_backward_kernel_im2col
  | Float64   -> owl_float64_ndarray_conv_dilated_spatial_backward_kernel_im2col
  | Complex32 -> owl_complex32_ndarray_conv_dilated_spatial_backward_kernel_im2col
  | Complex64 -> owl_complex64_ndarray_conv_dilated_spatial_backward_kernel_im2col
  | _         -> failwith "_owl_dilated_spatial_conv_backward_kernel_im2col: unsupported operation"

let _owl_dilated_cuboid_conv : type a b . (a, b) kind -> (a, b) owl_arr_op34 = function
  | Float32   -> owl_float32_ndarray_conv_dilated_cuboid_im2col
  | Float64   -> owl_float64_ndarray_conv_dilated_cuboid_im2col
  | Complex32 -> owl_complex32_ndarray_conv_dilated_cuboid_im2col
  | Complex64 -> owl_complex64_ndarray_conv_dilated_cuboid_im2col
  | _         -> failwith "_owl_dilated_cuboid_conv_im2col: unsupported operation"

let _owl_dilated_cuboid_conv_backward_input : type a b . (a, b) kind -> (a, b) owl_arr_op35 = function
  | Float32   -> owl_float32_ndarray_conv_dilated_cuboid_backward_input_im2col
  | Float64   -> owl_float64_ndarray_conv_dilated_cuboid_backward_input_im2col
  | Complex32 -> owl_complex32_ndarray_conv_dilated_cuboid_backward_input_im2col
  | Complex64 -> owl_complex64_ndarray_conv_dilated_cuboid_backward_input_im2col
  | _         -> failwith "_owl_dilated_cuboid_conv_backward_input_im2col: unsupported operation"

let _owl_dilated_cuboid_conv_backward_kernel : type a b . (a, b) kind -> (a, b) owl_arr_op35 = function
  | Float32   -> owl_float32_ndarray_conv_dilated_cuboid_backward_kernel_im2col
  | Float64   -> owl_float64_ndarray_conv_dilated_cuboid_backward_kernel_im2col
  | Complex32 -> owl_complex32_ndarray_conv_dilated_cuboid_backward_kernel_im2col
  | Complex64 -> owl_complex64_ndarray_conv_dilated_cuboid_backward_kernel_im2col
  | _         -> failwith "_owl_dilated_cuboid_conv_backward_kernel_im2col: unsupported operation"
