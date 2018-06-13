(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* This module is for calculating the shape of an ndarray given inputs. *)

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


let repeat shape axis repeats =
  let d = Array.length shape in
  let a = Owl_utils_ndarray.adjust_index axis d in
  let _shape = Array.copy shape in
  _shape.(a) <- _shape.(a) * repeats;
  _shape


let concatenate shape axis =
  let d = Array.length shape.(0) in
  let axis = Owl_utils_ndarray.adjust_index axis d in
  let shapes = Array.(map copy shape) in
  let shape0 = Array.copy shapes.(0) in
  shape0.(axis) <- 0;
  let acc_dim = ref 0 in
  Array.iteri (fun i shape1 ->
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
    Owl_utils_conv.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
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
    Owl_utils_conv.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  [|batches; output_cols; output_rows; output_dpts; out_channel|]


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
    Owl_utils_conv.calc_transpose_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
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
  failwith "transpose_conv3d: not implemented yet"


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
    Owl_utils_conv.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  [|batches; output_cols; output_rows; in_channel|]


let transpose input_shape axis =
  Array.map (fun j -> input_shape.(j)) axis


let dot x_shape y_shape = [|x_shape.(0); y_shape.(1)|]


let onehot input_shape depth = Array.append input_shape [|depth|]


(* ends here *)
