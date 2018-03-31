(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_float32_ndarray_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_maxpool_spatial_bytecode"
"stub_float32_ndarray_maxpool_spatial_native"

external owl_float32_ndarray_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_avgpool_spatial_bytecode"
"stub_float32_ndarray_avgpool_spatial_native"

external owl_float32_ndarray_maxpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_maxpool_spatial_backward_bytecode"
"stub_float32_ndarray_maxpool_spatial_backward_native"

external _owl_float32_ndarray_avgpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_avgpool_spatial_backward_bytecode"
"stub_float32_ndarray_avgpool_spatial_backward_native"

let owl_float32_ndarray_avgpool_spatial_backward
  input output
  batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride pad_rows pad_cols
  =
  (* avg_backward takes one less parameter than max_backward *)
  let dummy_input = input in
  _owl_float32_ndarray_avgpool_spatial_backward
    dummy_input output input
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_rows pad_cols

external owl_float32_ndarray_maxpool_argmax_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_maxpool_spatial_arg_bytecode"
"stub_float32_ndarray_maxpool_spatial_arg_native"

external owl_float32_ndarray_maxpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_maxpool_cuboid_bytecode"
"stub_float32_ndarray_maxpool_cuboid_native"

external owl_float32_ndarray_avgpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_avgpool_cuboid_bytecode"
"stub_float32_ndarray_avgpool_cuboid_native"

external owl_float32_ndarray_maxpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_maxpool_cuboid_backward_bytecode"
"stub_float32_ndarray_maxpool_cuboid_backward_native"

external _owl_float32_ndarray_avgpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_ndarray_avgpool_cuboid_backward_bytecode"
"stub_float32_ndarray_avgpool_cuboid_backward_native"

let owl_float32_ndarray_avgpool_cuboid_backward
  input output
  batches input_cols input_rows input_depth in_channel
  kernel_cols kernel_rows kernel_depth
  output_cols output_rows output_depth
  row_stride col_stride depth_stride
  pad_typ
  =
  let dummy_input = input in
  _owl_float32_ndarray_avgpool_cuboid_backward
    dummy_input output input
    batches input_cols input_rows input_depth in_channel
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
    pad_typ

external owl_float64_ndarray_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_maxpool_spatial_bytecode"
"stub_float64_ndarray_maxpool_spatial_native"

external owl_float64_ndarray_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_avgpool_spatial_bytecode"
"stub_float64_ndarray_avgpool_spatial_native"

external owl_float64_ndarray_maxpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_maxpool_spatial_backward_bytecode"
"stub_float64_ndarray_maxpool_spatial_backward_native"

external _owl_float64_ndarray_avgpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_avgpool_spatial_backward_bytecode"
"stub_float64_ndarray_avgpool_spatial_backward_native"

let owl_float64_ndarray_avgpool_spatial_backward
  input output
  batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride pad_rows pad_cols
  =
  (* avg_backward takes one less parameter than max_backward *)
  let dummy_input = input in
  _owl_float64_ndarray_avgpool_spatial_backward
    dummy_input output input
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_rows pad_cols

external owl_float64_ndarray_maxpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_maxpool_cuboid_bytecode"
"stub_float64_ndarray_maxpool_cuboid_native"

external owl_float64_ndarray_avgpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_avgpool_cuboid_bytecode"
"stub_float64_ndarray_avgpool_cuboid_native"

external owl_float64_ndarray_maxpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_maxpool_cuboid_backward_bytecode"
"stub_float64_ndarray_maxpool_cuboid_backward_native"

external _owl_float64_ndarray_avgpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_avgpool_cuboid_backward_bytecode"
"stub_float64_ndarray_avgpool_cuboid_backward_native"

let owl_float64_ndarray_avgpool_cuboid_backward
  input output
  batches input_cols input_rows input_depth in_channel
  kernel_cols kernel_rows kernel_depth
  output_cols output_rows output_depth
  row_stride col_stride depth_stride
  pad_typ
  =
  let dummy_input = input in
  _owl_float64_ndarray_avgpool_cuboid_backward
    dummy_input output input
    batches input_cols input_rows input_depth in_channel
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
    pad_typ

external owl_float64_ndarray_maxpool_argmax_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_ndarray_maxpool_spatial_arg_bytecode"
"stub_float64_ndarray_maxpool_spatial_arg_native"

external owl_complex32_ndarray_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_maxpool_spatial_bytecode"
"stub_complex32_ndarray_maxpool_spatial_native"

external owl_complex32_ndarray_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_avgpool_spatial_bytecode"
"stub_complex32_ndarray_avgpool_spatial_native"

external owl_complex32_ndarray_maxpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_maxpool_spatial_backward_bytecode"
"stub_complex32_ndarray_maxpool_spatial_backward_native"

external _owl_complex32_ndarray_avgpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_avgpool_spatial_backward_bytecode"
"stub_complex32_ndarray_avgpool_spatial_backward_native"

let owl_complex32_ndarray_avgpool_spatial_backward
  input output
  batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride pad_rows pad_cols
  =
  (* avg_backward takes one less parameter than max_backward *)
  let dummy_input = input in
  _owl_complex32_ndarray_avgpool_spatial_backward
    dummy_input output input
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_rows pad_cols

external owl_complex32_ndarray_maxpool_argmax_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_maxpool_spatial_arg_bytecode"
"stub_complex32_ndarray_maxpool_spatial_arg_native"

external owl_complex32_ndarray_maxpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_maxpool_cuboid_bytecode"
"stub_complex32_ndarray_maxpool_cuboid_native"

external owl_complex32_ndarray_avgpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_avgpool_cuboid_bytecode"
"stub_complex32_ndarray_avgpool_cuboid_native"

external owl_complex32_ndarray_maxpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_maxpool_cuboid_backward_bytecode"
"stub_complex32_ndarray_maxpool_cuboid_backward_native"

external _owl_complex32_ndarray_avgpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex32_ndarray_avgpool_cuboid_backward_bytecode"
"stub_complex32_ndarray_avgpool_cuboid_backward_native"

let owl_complex32_ndarray_avgpool_cuboid_backward
  input output
  batches input_cols input_rows input_depth in_channel
  kernel_cols kernel_rows kernel_depth
  output_cols output_rows output_depth
  row_stride col_stride depth_stride
  pad_typ
  =
  let dummy_input = input in
  _owl_complex32_ndarray_avgpool_cuboid_backward
    dummy_input output input
    batches input_cols input_rows input_depth in_channel
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
    pad_typ

external owl_complex64_ndarray_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_maxpool_spatial_bytecode"
"stub_complex64_ndarray_maxpool_spatial_native"

external owl_complex64_ndarray_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_avgpool_spatial_bytecode"
"stub_complex64_ndarray_avgpool_spatial_native"

external owl_complex64_ndarray_maxpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_maxpool_spatial_backward_bytecode"
"stub_complex64_ndarray_maxpool_spatial_backward_native"

external _owl_complex64_ndarray_avgpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_avgpool_spatial_backward_bytecode"
"stub_complex64_ndarray_avgpool_spatial_backward_native"

let owl_complex64_ndarray_avgpool_spatial_backward
  input output
  batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride pad_rows pad_cols
  =
  (* avg_backward takes one less parameter than max_backward *)
  let dummy_input = input in
  _owl_complex64_ndarray_avgpool_spatial_backward
    dummy_input output input
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_rows pad_cols

external owl_complex64_ndarray_maxpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_maxpool_cuboid_bytecode"
"stub_complex64_ndarray_maxpool_cuboid_native"

external owl_complex64_ndarray_avgpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_avgpool_cuboid_bytecode"
"stub_complex64_ndarray_avgpool_cuboid_native"

external owl_complex64_ndarray_maxpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_maxpool_cuboid_backward_bytecode"
"stub_complex64_ndarray_maxpool_cuboid_backward_native"

external _owl_complex64_ndarray_avgpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_avgpool_cuboid_backward_bytecode"
"stub_complex64_ndarray_avgpool_cuboid_backward_native"

let owl_complex64_ndarray_avgpool_cuboid_backward
  input output
  batches input_cols input_rows input_depth in_channel
  kernel_cols kernel_rows kernel_depth
  output_cols output_rows output_depth
  row_stride col_stride depth_stride
  pad_typ
  =
  let dummy_input = input in
  _owl_complex64_ndarray_avgpool_cuboid_backward
    dummy_input output input
    batches input_cols input_rows input_depth in_channel
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
    pad_typ

external owl_complex64_ndarray_maxpool_argmax_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_complex64_ndarray_maxpool_spatial_arg_bytecode"
"stub_complex64_ndarray_maxpool_spatial_arg_native"


let _owl_spatial_max_pooling : type a b . (a, b) kind -> (a, b) owl_arr_op26 = function
  | Float32   -> owl_float32_ndarray_maxpool_spatial
  | Float64   -> owl_float64_ndarray_maxpool_spatial
  | Complex32 -> owl_complex32_ndarray_maxpool_spatial
  | Complex64 -> owl_complex64_ndarray_maxpool_spatial
  | _         -> failwith "_owl_spatial_max_pooling: unsupported operation"

let _owl_spatial_avg_pooling : type a b . (a, b) kind -> (a, b) owl_arr_op26 = function
  | Float32   -> owl_float32_ndarray_avgpool_spatial
  | Float64   -> owl_float64_ndarray_avgpool_spatial
  | Complex32 -> owl_complex32_ndarray_avgpool_spatial
  | Complex64 -> owl_complex64_ndarray_avgpool_spatial
  | _         -> failwith "_owl_spatial_avg_pooling: unsupported operation"

let _owl_cuboid_max_pooling : type a b . (a, b) kind -> (a, b) owl_arr_op27 = function
  | Float32   -> owl_float32_ndarray_maxpool_cuboid
  | Float64   -> owl_float64_ndarray_maxpool_cuboid
  | Complex32 -> owl_complex32_ndarray_maxpool_cuboid
  | Complex64 -> owl_complex64_ndarray_maxpool_cuboid
  | _         -> failwith "_owl_cuboid_max_pooling: unsupported operation"

let _owl_cuboid_avg_pooling : type a b . (a, b) kind -> (a, b) owl_arr_op27 = function
  | Float32   -> owl_float32_ndarray_avgpool_cuboid
  | Float64   -> owl_float64_ndarray_avgpool_cuboid
  | Complex32 -> owl_complex32_ndarray_avgpool_cuboid
  | Complex64 -> owl_complex64_ndarray_avgpool_cuboid
  | _         -> failwith "_owl_cuboid_avg_pooling: unsupported operation"

let _owl_spatial_max_pooling_argmax : type a b . (a, b) kind -> (a, b) owl_arr_op28 = function
  | Float32   -> owl_float32_ndarray_maxpool_argmax_spatial
  | Float64   -> owl_float64_ndarray_maxpool_argmax_spatial
  | Complex32 -> owl_complex32_ndarray_maxpool_argmax_spatial
  | Complex64 -> owl_complex64_ndarray_maxpool_argmax_spatial
  | _         -> failwith "_owl_spatial_max_pooling_argmax: unsupported operation"

let _owl_spatial_max_pooling_backward : type a b . (a, b) kind -> (a, b) owl_arr_op29 = function
  | Float32   -> owl_float32_ndarray_maxpool_spatial_backward
  | Float64   -> owl_float64_ndarray_maxpool_spatial_backward
  | Complex32 -> owl_complex32_ndarray_maxpool_spatial_backward
  | Complex64 -> owl_complex64_ndarray_maxpool_spatial_backward
  | _         -> failwith "_owl_spatial_max_pooling_backward: unsupported operation"

let _owl_spatial_avg_pooling_backward : type a b . (a, b) kind -> (a, b) owl_arr_op30 = function
  | Float32   -> owl_float32_ndarray_avgpool_spatial_backward
  | Float64   -> owl_float64_ndarray_avgpool_spatial_backward
  | Complex32 -> owl_complex32_ndarray_avgpool_spatial_backward
  | Complex64 -> owl_complex64_ndarray_avgpool_spatial_backward
  | _         -> failwith "_owl_spatial_avg_pooling_backward: unsupported operation"

let _owl_cuboid_max_pooling_backward : type a b . (a, b) kind -> (a, b) owl_arr_op31 = function
  | Float32   -> owl_float32_ndarray_maxpool_cuboid_backward
  | Float64   -> owl_float64_ndarray_maxpool_cuboid_backward
  | Complex32 -> owl_complex32_ndarray_maxpool_cuboid_backward
  | Complex64 -> owl_complex64_ndarray_maxpool_cuboid_backward
  | _         -> failwith "_owl_cuboid_max_pooling_backward: unsupported operation"

let _owl_cuboid_avg_pooling_backward : type a b . (a, b) kind -> (a, b) owl_arr_op32 = function
  | Float32   -> owl_float32_ndarray_avgpool_cuboid_backward
  | Float64   -> owl_float64_ndarray_avgpool_cuboid_backward
  | Complex32 -> owl_complex32_ndarray_avgpool_cuboid_backward
  | Complex64 -> owl_complex64_ndarray_avgpool_cuboid_backward
  | _         -> failwith "_owl_cuboid_avg_pooling_backward: unsupported operation"
