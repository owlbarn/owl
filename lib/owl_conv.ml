(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic

type data_format = NHWC | NCHW


(* FIXME: obsolete fun *)
let reshape_filter filter =
  let shp = shape filter in
  let m = shp.(0) * shp.(1) * shp.(2) in
  let n = shp.(3) in
  reshape filter [|m;n|]
  |> Owl_dense_matrix_generic.of_ndarray


let pad2d input filter stride =
  (* assume input has NHWC format *)
  let in_shp = shape input in
  let in_h = in_shp.(1) in
  let in_w = in_shp.(2) in
  let in_c = in_shp.(3) in

  let ft_shp = shape filter in
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
  Log.info "+++ %i %i %i %i" pad_top pad_bottom pad_left pad_right;
  pad [[]; [pad_top; pad_bottom]; [pad_left; pad_right]; []] input


let conv2d ?(format=NHWC) ?(padding=true) input filter stride =
  (* TODO: convert to default NHWC if needed *)
  let input = match format with
    | NHWC -> input
    | NCHW -> input
  in

  (* pad the input if needed *)
  let input = match padding with
    | true  -> pad2d input filter stride
    | false -> input
  in

  let in_shp = shape input in
  let batch = in_shp.(0) in
  let in_h = in_shp.(1) in
  let in_w = in_shp.(2) in
  let in_c = in_shp.(3) in

  let ft_shp = shape filter in
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
  let filter' = reshape filter [|ft_h * ft_w * in_c; out_c|]
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
        Printf.printf "--- %i %i\n" (Owl_dense_matrix_generic.row_num filter') (Owl_dense_matrix_generic.col_num filter');
        *)
        let v = Owl_dense_matrix_generic.dot u filter' in
        Owl_dense_matrix_generic.copy_row_to v output' !row_i;
        row_i := !row_i + 1;
      done;
      (* Log.info "==> b:%i h:%i row:%i" b i !row_i; *)
    done;
  done;

  (* return the output tensor *)
  output



(* ends here *)
