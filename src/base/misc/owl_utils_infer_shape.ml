(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* This module is for calculating the shape of an ndarray given inputs. *)


(* check if broadcasting is required *)

let require_broadcasting shape_x shape_y =
  let shape_a, shape_b = Owl_utils_array.align `Left 1 shape_x shape_y in
  (* NOTE: compare content, not physical address *)
  shape_a <> shape_b


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


(* calculate the output shape of [transpose_conv2d] given input and kernel and stride *)
let calc_transpose_conv2d_output_shape
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


(* calc_transpose_conv1d_output_shape actually calls its 2d version  *)
let calc_transpose_conv1d_output_shape padding input_cols kernel_cols col_stride =
  let input_rows = 1 in
  let kernel_rows = 1 in
  let row_stride = 1 in
  calc_transpose_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
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


(* calculate the output shape of [transpose_conv3d] given input and kernel and stride *)
let calc_transpose_conv3d_output_shape
  padding input_cols input_rows input_dpts
  kernel_cols kernel_rows kernel_dpts
  row_stride col_stride dpt_stride
  =
  let output_cols = match padding with
    | SAME  -> input_cols * col_stride
    | VALID -> input_cols * col_stride + (max (kernel_cols - col_stride) 0)
  in
  let output_rows = match padding with
    | SAME  -> input_rows * row_stride
    | VALID -> input_rows * row_stride + (max (kernel_rows - row_stride) 0)
  in
  let output_dpts = match padding with
    | SAME  -> input_dpts * dpt_stride
    | VALID -> input_dpts * dpt_stride + (max (kernel_dpts - dpt_stride) 0)
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


(* various functions to calculate output shape, used in computation graph. *)

let broadcast1 s0 s1 =
  let sa, sb = Owl_utils_array.align `Left 1 s0 s1 in
  Array.iter2 (fun a b ->
    Owl_exception.(check (not(a <> 1 && b <> 1 && a <> b)) NOT_BROADCASTABLE);
  ) sa sb;
  (* calculate the output shape *)
  Array.map2 max sa sb


let broadcast2 s0 s1 s2 =
  let sa, sb, sc = Owl_utils_array.align3 `Left 1 s0 s1 s2 in
  let sd = Owl_utils_array.map3 (fun a b c -> max a (max b c)) sa sb sc in
  Owl_utils_array.iter4 (fun a b c d ->
    Owl_exception.(check (not(a <> 1 && a <> d)) NOT_BROADCASTABLE);
    Owl_exception.(check (not(b <> 1 && b <> d)) NOT_BROADCASTABLE);
    Owl_exception.(check (not(c <> 1 && c <> d)) NOT_BROADCASTABLE);
  ) sa sb sc sd;
  sd


(* no need to align two shapes before passing in. *)
let broadcast1_stride s0 s1 =
  let sa, sb = Owl_utils_array.align `Left 1 s0 s1 in
  let stride_0 = Owl_utils_ndarray.calc_stride sa in
  let stride_1 = Owl_utils_ndarray.calc_stride sb in
  Owl_utils_array.iter2i (fun i d0 d1 ->
    if d0 <> d1 then
      if d0 = 1 then stride_0.(i) <- 0 else stride_1.(i) <- 0
  ) sa sb;
  stride_0, stride_1


let fold shape axis =
  let d = Array.length shape in
  let a = Owl_utils_ndarray.adjust_index axis d in
  assert (a >= 0 && a < d);
  let _shape = Array.copy shape in
  _shape.(a) <- 1;
  _shape


let tile shape repeats =
  assert (Array.exists ((>) 1) repeats = false);
  let s, r = Owl_utils_array.align `Left 1 shape repeats in
  Owl_utils_array.map2 (fun a b -> a * b) s r


let repeat shape repeats =
  assert (Array.exists ((>) 1) repeats = false);
  assert (Array.length shape = Array.length repeats);
  Owl_utils_array.map2 ( * ) shape repeats


let concatenate shape axis =
  let d = Array.length shape.(0) in
  let axis = Owl_utils_ndarray.adjust_index axis d in
  let shapes = Array.(map copy shape) in
  let shape0 = Array.copy shapes.(0) in
  shape0.(axis) <- 0;
  let acc_dim = ref 0 in
  Array.iteri (fun _i shape1 ->
    acc_dim := !acc_dim + shape1.(axis);
    shape1.(axis) <- 0;
    assert (shape0 = shape1);
  ) shapes;
  shape0.(axis) <- !acc_dim;
  shape0


let split shape axis parts =
  let d = Array.length shape in
  let a = Owl_utils_ndarray.adjust_index axis d in
  let e = Array.fold_left ( + ) 0 parts in
  assert (a < d);
  assert (e = shape.(a));
  Array.map (fun n ->
    let s = Array.copy shape in
    s.(a) <- n;
    s
  ) parts


let draw shape axis n =
  let d = Array.length shape in
  let a = Owl_utils_ndarray.adjust_index axis d in
  let s = Array.copy shape in
  assert (a < d);
  s.(a) <- n;
  s


let reduce shape axis =
  let d = Array.length shape in
  let a = Array.map (fun i -> Owl_utils_ndarray.adjust_index i d) axis in
  let s = Array.copy shape in
  Array.iter (fun i ->
    assert (i < d);
    s.(i) <- 1
  ) a;
  s


let conv2d input_shape padding kernel_shape stride_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let input_rows = input_shape.(2) in
  let in_channel = input_shape.(3) in

  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in
  let out_channel = kernel_shape.(3) in
  assert (in_channel = kernel_shape.(2));

  let col_stride = stride_shape.(0) in
  let row_stride = stride_shape.(1) in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  [|batches; output_cols; output_rows; out_channel|]


let conv1d input_shape padding kernel_shape stride_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let in_channel = input_shape.(2) in
  let input_shape = [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel_shape.(0) in
  let out_channel = kernel_shape.(2) in
  assert (in_channel = kernel_shape.(1));
  let kernel_shape = [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride_shape.(0) in
  let stride_shape = [|1; col_stride|] in

  let output_shape = conv2d input_shape padding kernel_shape stride_shape in
  let output_cols = output_shape.(2) in
  [|batches; output_cols; out_channel|]


let conv3d input_shape padding kernel_shape stride_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let input_rows = input_shape.(2) in
  let input_dpts = input_shape.(3) in
  let in_channel = input_shape.(4) in

  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in
  let kernel_dpts = kernel_shape.(2) in
  let out_channel = kernel_shape.(4) in
  assert (in_channel = kernel_shape.(3));

  let col_stride = stride_shape.(0) in
  let row_stride = stride_shape.(1) in
  let dpt_stride = stride_shape.(2) in

  let output_cols, output_rows, output_dpts =
    calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  [|batches; output_cols; output_rows; output_dpts; out_channel|]


let dilated_conv2d input_shape padding kernel_shape stride_shape rate_shape =
  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in
  let in_channel  = kernel_shape.(2) in
  let out_channel = kernel_shape.(3) in

  let rate_cols = rate_shape.(0) in
  let rate_rows = rate_shape.(1) in

  let col_up = kernel_cols + (kernel_cols - 1) * (rate_cols - 1) in
  let row_up = kernel_rows + (kernel_rows - 1) * (rate_rows - 1) in
  let kernel_shape' = [|col_up; row_up; in_channel; out_channel|] in

  conv2d input_shape padding kernel_shape' stride_shape


let dilated_conv1d input_shape padding kernel_shape stride_shape rate_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let in_channel = input_shape.(2) in
  let input_shape = [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel_shape.(0) in
  let out_channel = kernel_shape.(2) in
  assert (in_channel = kernel_shape.(1));
  let kernel_shape = [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride_shape.(0) in
  let stride_shape = [|1; col_stride|] in

  let col_rate = rate_shape.(0) in
  let rate_shape = [|1; col_rate|] in

  let output_shape = dilated_conv2d input_shape padding kernel_shape stride_shape rate_shape in
  let output_cols = output_shape.(2) in
  [|batches; output_cols; out_channel|]


let dilated_conv3d input_shape padding kernel_shape stride_shape rate_shape =
  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in
  let kernel_dpts = kernel_shape.(2) in
  let in_channel  = kernel_shape.(3) in
  let out_channel = kernel_shape.(4) in

  let rate_cols = rate_shape.(0) in
  let rate_rows = rate_shape.(1) in
  let rate_dpts = rate_shape.(2) in

  let col_up = kernel_cols + (kernel_cols - 1) * (rate_cols - 1) in
  let row_up = kernel_rows + (kernel_rows - 1) * (rate_rows - 1) in
  let dpt_up = kernel_dpts + (kernel_dpts - 1) * (rate_dpts - 1) in
  let kernel_shape' = [|col_up; row_up; dpt_up; in_channel; out_channel|] in

  conv3d input_shape padding kernel_shape' stride_shape


let transpose_conv2d input_shape padding kernel_shape stride_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let input_rows = input_shape.(2) in
  let in_channel = input_shape.(3) in

  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in
  let out_channel = kernel_shape.(3) in
  assert (in_channel = kernel_shape.(2));

  let col_stride = stride_shape.(0) in
  let row_stride = stride_shape.(1) in

  let output_cols, output_rows =
    calc_transpose_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  [|batches; output_cols; output_rows; out_channel|]


let transpose_conv1d input_shape padding kernel_shape stride_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let in_channel = input_shape.(2) in
  let input_shape = [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel_shape.(0) in
  let out_channel = kernel_shape.(2) in
  assert (in_channel = kernel_shape.(1));
  let kernel_shape = [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride_shape.(0) in
  let stride_shape = [|1; col_stride|] in

  let output_shape = transpose_conv2d input_shape padding kernel_shape stride_shape in
  let output_cols = output_shape.(2) in
  [|batches; output_cols; out_channel|]


let transpose_conv3d input_shape padding kernel_shape stride_shape =
  let batches    = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let input_rows = input_shape.(2) in
  let input_dpts = input_shape.(3) in
  let in_channel = input_shape.(4) in

  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in
  let kernel_dpts = kernel_shape.(2) in
  let out_channel = kernel_shape.(4) in
  assert (in_channel = kernel_shape.(3));

  let col_stride = stride_shape.(0) in
  let row_stride = stride_shape.(1) in
  let dpt_stride = stride_shape.(2) in

  let output_cols, output_rows, output_dpts =
    calc_transpose_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  [|batches; output_cols; output_rows; output_dpts; out_channel|]


let pool2d input_shape padding kernel_shape stride_shape =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let input_rows = input_shape.(2) in
  let in_channel = input_shape.(3) in

  let kernel_cols = kernel_shape.(0) in
  let kernel_rows = kernel_shape.(1) in

  let col_stride = stride_shape.(0) in
  let row_stride = stride_shape.(1) in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  [|batches; output_cols; output_rows; in_channel|]


let upsampling2d input_shape size =
  let batches = input_shape.(0) in
  let input_cols = input_shape.(1) in
  let input_rows = input_shape.(2) in
  let in_channel = input_shape.(3) in

  let col_size = size.(0) in
  let row_size = size.(1) in

  [|batches; input_cols * col_size; input_rows * row_size; in_channel|]


let transpose input_shape axis =
  Array.map (fun j -> input_shape.(j)) axis


let dot x_shape y_shape = [|x_shape.(0); y_shape.(1)|]


let onehot input_shape depth = Array.append input_shape [|depth|]


(* ends here *)
