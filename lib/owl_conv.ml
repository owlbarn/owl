(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic

type data_format = NHWC | NCHW
type padding = SAME | VALID


let reshape_kernel_2D kernel =
  let shp = shape kernel in
  let m = shp.(0) * shp.(1) * shp.(2) in
  let n = shp.(3) in
  reshape kernel [|m;n|]
  |> Owl_dense_matrix_generic.of_ndarray


let pad2d input kernel stride =
  (* assume input has NHWC format *)
  let in_shp = shape input in
  let in_h = in_shp.(1) in
  let in_w = in_shp.(2) in

  let ft_shp = shape kernel in
  let ft_h = ft_shp.(0) in
  let ft_w = ft_shp.(1) in

  (* calculate output size *)
  let out_h = (float_of_int in_h /. float_of_int stride.(1))
    |> Owl_maths.ceil |> int_of_float
  in
  let out_w = (float_of_int in_w /. float_of_int stride.(2))
    |> Owl_maths.ceil |> int_of_float
  in

  (* calculate total padding size *)
  let pad_h = Pervasives.max ((out_h - 1) * stride.(1) + ft_h - in_h) 0 in
  let pad_w = Pervasives.max ((out_w - 1) * stride.(2) + ft_w - in_w) 0 in

  (* calculate padding size along each side *)
  let pad_top = pad_h / 2 in
  let pad_bottom = pad_h - pad_top in
  let pad_left = pad_w / 2 in
  let pad_right = pad_w - pad_left in

  (* padding then return a new array *)
  pad [[]; [pad_top; pad_bottom]; [pad_left; pad_right]; []] input


let owl_conv2d ?(format=NHWC) ?(padding=false) input kernel stride =
  (* TODO: convert to default NHWC if needed *)
  let input = match format with
    | NHWC -> input
    | NCHW -> input
  in

  (* pad the input if needed *)
  let input = match padding with
    | true  -> pad2d input kernel stride
    | false -> input
  in

  let in_shp = shape input in
  let batch = in_shp.(0) in
  let in_h = in_shp.(1) in
  let in_w = in_shp.(2) in
  let in_c = in_shp.(3) in

  let ft_shp = shape kernel in
  let ft_h = ft_shp.(0) in
  let ft_w = ft_shp.(1) in

  (* calculate output shape *)
  let out_h = match padding with
    | true  -> (float_of_int (in_h - ft_h) /. float_of_int stride.(1)) |> Owl_maths.ceil |> int_of_float
    | false -> (float_of_int (in_h - ft_h + 1) /. float_of_int stride.(1)) |> Owl_maths.ceil |> int_of_float
  in
  let out_w = match padding with
    | true  -> (float_of_int (in_w - ft_w) /. float_of_int stride.(2)) |> Owl_maths.ceil |> int_of_float
    | false -> (float_of_int (in_w - ft_w + 1) /. float_of_int stride.(2)) |> Owl_maths.ceil |> int_of_float
  in
  let out_c = ft_shp.(3) in
  let output = empty (kind input) [|batch; out_h; out_w; out_c|] in

  (* prepare some temp variables *)
  let kernel' = reshape kernel [|ft_h * ft_w * in_c; out_c|]
    |> Owl_dense_matrix_generic.of_ndarray
  in
  let output' = reshape output [|batch * out_h * out_w; out_c|]
    |> Owl_dense_matrix_generic.of_ndarray
  in
  let row_i = ref 0 in

  (* iterate all the point to convolve *)
  for b = 0 to batch - 1 do

    for i = 0 to out_h - 1 do
      let h0 = i * stride.(0) in
      let h1 = h0 + ft_h - 1 in

      for j = 0 to out_w - 1 do
        let w0 = j * stride.(1) in
        let w1 = w0 + ft_w - 1 in

        let s = slice [[b];[h0;h1];[w0;w1];[]] input in
        let u = reshape s [|1;numel s|]
          |> Owl_dense_matrix_generic.of_ndarray
        in
        (*
        Printf.printf "+++ %i %i\n" (Owl_dense_matrix_generic.row_num u) (Owl_dense_matrix_generic.col_num u);
        Printf.printf "--- %i %i\n" (Owl_dense_matrix_generic.row_num kernel') (Owl_dense_matrix_generic.col_num kernel');
        *)
        let v = Owl_dense_matrix_generic.dot u kernel' in
        Owl_dense_matrix_generic.copy_row_to v output' !row_i;
        row_i := !row_i + 1;
      done;
      (* Log.info "==> b:%i h:%i row:%i" b i !row_i; *)
    done;
  done;

  (* return the output tensor *)
  output



(* similar to im2col, but convert a tensor to a row-based matrix *)
let im2row x = None



let calc_output_2dshape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride =
  let output_cols = match padding with
    | SAME  -> (float_of_int input_cols /. float_of_int col_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> (float_of_int (input_cols - kernel_cols + 1) /. float_of_int col_stride) |> Owl_maths.ceil |> int_of_float
  in
  let output_rows = match padding with
    | SAME  -> (float_of_int input_rows /. float_of_int row_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> (float_of_int (input_rows - kernel_rows + 1) /. float_of_int row_stride) |> Owl_maths.ceil |> int_of_float
  in
  (output_cols, output_rows)


let conv2d ?(padding=VALID) input kernel stride =
  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in

  let row_stride = stride.(0) in
  let col_stride = stride.(1) in
  let row_in_stride = 1 in
  let col_in_stride = 1 in

  let output_cols, output_rows =
    calc_output_2dshape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  (* DEBUG *)
  Printf.printf "input:\t [ b:%i, c:%i, r:%i, i:%i ]\n" batches input_cols input_rows in_channel;
  Printf.printf "kernel:\t [ c:%i, r:%i, i:%i, o:%i ]\n" kernel_cols kernel_rows in_channel out_channel;
  Printf.printf "output:\t [ b:%i, c:%i, r:%i, o:%i ]\n" batches output_cols output_rows out_channel;
  flush_all ();

  Eigen.Tensor.S.spatial_conv
    input kernel output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  (* return the output *)
  output


(* ends here *)
