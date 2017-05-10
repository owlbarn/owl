(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic

type data_format = NHWC | NCHW


let reshape_filter filter =
  let shp = shape filter in
  let m = shp.(0) * shp.(1) * shp.(2) in
  let n = shp.(3) in
  reshape filter [|m;n|]
  |> Owl_dense_matrix_generic.of_ndarray


let pad2d input filter stride =
  (* assume input has NHWC format *)
  let in_shp = shape input in
  let batch = in_shp.(0) in
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
  pad [[]; [pad_top; pad_bottom]; [pad_left; pad_right]; []] input


let virtual_patch input = None


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
    | true  -> (float_of_int in_h /. float_of_int stride.(1)) |> Owl_maths.ceil |> int_of_float
    | false -> (float_of_int (in_h - ft_h + 1) /. float_of_int stride.(1)) |> Owl_maths.ceil |> int_of_float
  in
  let out_w = match padding with
    | true  -> (float_of_int in_w /. float_of_int stride.(2)) |> Owl_maths.ceil |> int_of_float
    | false -> (float_of_int (in_w - ft_w + 1) /. float_of_int stride.(2)) |> Owl_maths.ceil |> int_of_float
  in
  let out_c = ft_shp.(3) in

  let output = empty (kind input) [|batch; out_h; out_w; out_c|] in
  let filter' = reshape_filter filter in

  (* iterate all the point to convolve *)
  for b = 0 to batch - 1 do
    for i = 0 to out_h - 1 do
      let h0 = i * stride.(0) in
      let h1 = h0 + ft_h in
      for j = 0 to out_w - 1 do
        let w0 = j * stride.(1) in
        let w1 = j + ft_w in
        let s = slice [[b];[h0;h1];[w0;w1];[]] input in
        ()
      done;
    done;
  done;
  (* let i = ref 0 in
  let j = ref 0 in
  for b = 0 to batch - 1 do
    while !i + ft_h <= in_h do
      while !j + ft_w <= in_w do

      j := !j + stride.(2);
      done;

      i := !i + stride.(1);
    done;
  done;
  *)

  ()

(* ends here *)
