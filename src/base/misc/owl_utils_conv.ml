(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* This module contains helper function for ndarray convolution functions. *)


(* calculate the output shape of [conv2d] given input and kernel and stride *)
let calc_conv2d_output_shape
  padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  =
  let input_cols = float_of_int input_cols in
  let input_rows = float_of_int input_rows in
  let kernel_cols = float_of_int kernel_cols in
  let kernel_rows = float_of_int kernel_rows in
  let row_stride = float_of_int row_stride in
  let col_stride = float_of_int col_stride in
  let output_cols = match padding with
    | SAME  -> (input_cols /. col_stride) |> ceil |> int_of_float
    | VALID -> ((input_cols -. kernel_cols +. 1.) /. col_stride) |> ceil |> int_of_float
  in
  let output_rows = match padding with
    | SAME  -> (input_rows /. row_stride) |> ceil |> int_of_float
    | VALID -> ((input_rows -. kernel_rows +. 1.) /. row_stride) |> ceil |> int_of_float
  in
  (output_cols, output_rows)


(* calculate the output shape of [conv2d_transpose] given input and kernel and stride *)
let calc_conv2d_transpose_output_shape
  padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  =
  let output_cols = match padding with
    | SAME  -> input_cols * col_stride
    | VALID -> input_cols * col_stride + (max (kernel_cols - col_stride) 0)
  in
  let output_rows = match padding with
    | SAME  -> input_rows * row_stride
    | VALID -> input_rows * row_stride + (max (kernel_rows - row_stride) 0)
  in
  (output_cols, output_rows)


(* calculate the output shape of [conv2d_transpose] given input and kernel and stride *)
let calc_conv2d_transpose_output_shape
  padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  =
  let output_cols = match padding with
    | SAME  -> input_cols * col_stride
    | VALID -> input_cols * col_stride + (max (kernel_cols - col_stride) 0)
  in
  let output_rows = match padding with
    | SAME  -> input_rows * row_stride
    | VALID -> input_rows * row_stride + (max (kernel_rows - row_stride) 0)
  in
  (output_cols, output_rows)


(* calculate the padding size along width and height *)
let calc_conv2d_padding
  input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  =
  let pad_along_height = Pervasives.max ((output_rows - 1) * row_stride + kernel_rows - input_rows) 0 in
  let pad_along_width = Pervasives.max ((output_cols - 1) * col_stride + kernel_cols - input_cols) 0 in
  let pad_top = pad_along_height / 2 in
  let pad_bottom = pad_along_height - pad_top in
  let pad_left = pad_along_width / 2 in
  let pad_right = pad_along_width - pad_left in
  pad_top, pad_left, pad_bottom, pad_right


(* calc_conv1d_output_shape actually calls its 2d version  *)
let calc_conv1d_output_shape padding input_cols kernel_cols col_stride =
  let input_rows = 1 in
  let kernel_rows = 1 in
  let row_stride = 1 in
  calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  |> fst


(* calculate the output shape of [conv3d] given input and kernel and stride *)
let calc_conv3d_output_shape
  padding input_cols input_rows input_dpts
  kernel_cols kernel_rows kernel_dpts
  row_stride col_stride dpt_stride
  =
  let input_cols = float_of_int input_cols in
  let input_rows = float_of_int input_rows in
  let input_dpts = float_of_int input_dpts in
  let kernel_cols = float_of_int kernel_cols in
  let kernel_rows = float_of_int kernel_rows in
  let kernel_dpts = float_of_int kernel_dpts in
  let row_stride = float_of_int row_stride in
  let col_stride = float_of_int col_stride in
  let dpt_stride = float_of_int dpt_stride in
  let output_cols = match padding with
    | SAME  -> (input_cols /. col_stride) |> ceil |> int_of_float
    | VALID -> ((input_cols -. kernel_cols +. 1.) /. col_stride) |> ceil |> int_of_float
  in
  let output_rows = match padding with
    | SAME  -> (input_rows /. row_stride) |> ceil |> int_of_float
    | VALID -> ((input_rows -. kernel_rows +. 1.) /. row_stride) |> ceil |> int_of_float
  in
  let output_dpts = match padding with
    | SAME  -> (input_dpts /. dpt_stride) |> ceil |> int_of_float
    | VALID -> ((input_dpts -. kernel_dpts +. 1.) /. dpt_stride) |> ceil |> int_of_float
  in
  (output_cols, output_rows, output_dpts)


(* calculate the padding size along width, height, and depth. *)
let calc_conv3d_padding
    input_cols input_rows input_depth
    kernel_cols kernel_rows kernel_depth
    output_cols output_rows output_depth
    row_stride col_stride depth_stride
  =
  let pad_along_height = Pervasives.max ((output_rows - 1) * row_stride + kernel_rows - input_rows) 0 in
  let pad_along_width = Pervasives.max ((output_cols - 1) * col_stride + kernel_cols - input_cols) 0 in
  let pad_along_depth = Pervasives.max ((output_depth - 1) * depth_stride + kernel_depth - input_depth) 0 in
  let pad_top = pad_along_height / 2 in
  let pad_bottom = pad_along_height - pad_top in
  let pad_left = pad_along_width / 2 in
  let pad_right = pad_along_width - pad_left in
  let pad_shallow = pad_along_depth / 2 in
  let pad_deep = pad_along_depth - pad_shallow in
  pad_top, pad_left, pad_shallow, pad_bottom, pad_right, pad_deep
