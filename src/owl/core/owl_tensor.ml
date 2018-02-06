(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Tensor: tensor implementation in Owl *)

open Bigarray
open Owl_types
open Owl_dense_common_types

external owl_float32_tensor_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_maxpool_spatial_bytecode"
"stub_float32_tensor_maxpool_spatial_native"

external owl_float32_tensor_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_avgpool_spatial_bytecode"
"stub_float32_tensor_avgpool_spatial_native"

external owl_float32_tensor_maxpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_maxpool_spatial_backward_bytecode"
"stub_float32_tensor_maxpool_spatial_backward_native"

external _owl_float32_tensor_avgpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_avgpool_spatial_backward_bytecode"
"stub_float32_tensor_avgpool_spatial_backward_native"

let owl_float32_tensor_avgpool_spatial_backward
  input output
  batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride pad_rows pad_cols
  =
  (* avg_backward takes one less parameter than max_backward *)
  let dummy_input = input in
  _owl_float32_tensor_avgpool_spatial_backward
    dummy_input output input
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_rows pad_cols

external owl_float32_tensor_maxpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_maxpool_cuboid_bytecode"
"stub_float32_tensor_maxpool_cuboid_native"

external owl_float32_tensor_avgpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_avgpool_cuboid_bytecode"
"stub_float32_tensor_avgpool_cuboid_native"

external owl_float32_tensor_maxpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_maxpool_cuboid_backward_bytecode"
"stub_float32_tensor_maxpool_cuboid_backward_native"

external _owl_float32_tensor_avgpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_avgpool_cuboid_backward_bytecode"
"stub_float32_tensor_avgpool_cuboid_backward_native"

let owl_float32_tensor_avgpool_cuboid_backward
  input output
  batches input_cols input_rows input_depth in_channel
  kernel_cols kernel_rows kernel_depth
  output_cols output_rows output_depth
  row_stride col_stride depth_stride
  pad_rows pad_cols pad_depth
  =
  let dummy_input = input in
  _owl_float32_tensor_avgpool_cuboid_backward
    dummy_input output input
    batches input_cols input_rows input_depth in_channel
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
    pad_rows pad_cols pad_depth

external owl_float64_tensor_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_maxpool_spatial_bytecode"
"stub_float64_tensor_maxpool_spatial_native"

external owl_float64_tensor_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_avgpool_spatial_bytecode"
"stub_float64_tensor_avgpool_spatial_native"

external owl_float64_tensor_maxpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_maxpool_spatial_backward_bytecode"
"stub_float64_tensor_maxpool_spatial_backward_native"

external _owl_float64_tensor_avgpool_spatial_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_avgpool_spatial_backward_bytecode"
"stub_float64_tensor_avgpool_spatial_backward_native"

let owl_float64_tensor_avgpool_spatial_backward
  input output
  batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride pad_rows pad_cols
  =
  (* avg_backward takes one less parameter than max_backward *)
  let dummy_input = input in
  _owl_float64_tensor_avgpool_spatial_backward
    dummy_input output input
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_rows pad_cols

external owl_float64_tensor_maxpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_maxpool_cuboid_bytecode"
"stub_float64_tensor_maxpool_cuboid_native"

external owl_float64_tensor_avgpool_cuboid : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_avgpool_cuboid_bytecode"
"stub_float64_tensor_avgpool_cuboid_native"

external owl_float64_tensor_maxpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_maxpool_cuboid_backward_bytecode"
"stub_float64_tensor_maxpool_cuboid_backward_native"

external _owl_float64_tensor_avgpool_cuboid_backward : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float64_tensor_avgpool_cuboid_backward_bytecode"
"stub_float64_tensor_avgpool_cuboid_backward_native"

let owl_float64_tensor_avgpool_cuboid_backward
  input output
  batches input_cols input_rows input_depth in_channel
  kernel_cols kernel_rows kernel_depth
  output_cols output_rows output_depth
  row_stride col_stride depth_stride
  pad_rows pad_cols pad_depth
  =
  let dummy_input = input in
  _owl_float64_tensor_avgpool_cuboid_backward
    dummy_input output input
    batches input_cols input_rows input_depth in_channel
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
    pad_rows pad_cols pad_depth
