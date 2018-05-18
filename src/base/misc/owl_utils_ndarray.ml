(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(* convert an element of elt type to string *)
let elt_to_str : type a b. (a, b) kind -> (a -> string) = function
  | Char           -> fun v -> Printf.sprintf "%c" v
  | Nativeint      -> fun v -> Printf.sprintf "%nd" v
  | Int8_signed    -> fun v -> Printf.sprintf "%i" v
  | Int8_unsigned  -> fun v -> Printf.sprintf "%i" v
  | Int16_signed   -> fun v -> Printf.sprintf "%i" v
  | Int16_unsigned -> fun v -> Printf.sprintf "%i" v
  | Int            -> fun v -> Printf.sprintf "%i" v
  | Int32          -> fun v -> Printf.sprintf "%ld" v
  | Int64          -> fun v -> Printf.sprintf "%Ld" v
  | Float32        -> fun v -> Printf.sprintf "%G" v
  | Float64        -> fun v -> Printf.sprintf "%G" v
  | Complex32      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | Complex64      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)


(* convert an element of string to elt type *)
let elt_of_str : type a b. (a, b) kind -> (string -> a) = function
  | Char           -> fun v -> Scanf.sscanf v "%c%!" (fun c -> c)
  | Nativeint      -> fun v -> Nativeint.of_string v
  | Int8_signed    -> fun v -> int_of_string v
  | Int8_unsigned  -> fun v -> int_of_string v
  | Int16_signed   -> fun v -> int_of_string v
  | Int16_unsigned -> fun v -> int_of_string v
  | Int            -> fun v -> int_of_string v
  | Int32          -> fun v -> Int32.of_string v
  | Int64          -> fun v -> Int64.of_string v
  | Float32        -> fun v -> float_of_string v
  | Float64        -> fun v -> float_of_string v
  | Complex32      -> fun v -> Scanf.sscanf v "(%f, %fi)%!" (fun re im -> {Complex.re; im})
  | Complex64      -> fun v -> Scanf.sscanf v "(%f, %fi)%!" (fun re im -> {Complex.re; im})


(* calculate the number of elements in an ndarray *)
let numel x = Array.fold_right (fun c a -> c * a) (Genarray.dims x) 1


(* calculate the stride of a ndarray, s is the shape
  for [x] of shape [|2;3;4|], the return is [|12;4;1|]
 *)
let calc_stride s =
  let d = Array.length s in
  let r = Array.make d 1 in
  for i = 1 to d - 1 do
    r.(d - i - 1) <- s.(d - i) * r.(d - i)
  done;
  r


(* calculate the slice size in each dimension, s is the shape.
  for [x] of shape [|2;3;4|], the return is [|24;12;4|]
*)
let calc_slice s =
  let d = Array.length s in
  let r = Array.make d s.(d-1) in
  for i = d - 2 downto 0 do
    r.(i) <- s.(i) * r.(i+1)
  done;
  r


(* c layout index translation: 1d -> nd
  i is one-dimensional index;
  j is n-dimensional index;
  s is the stride.
  the space of j needs to be pre-allocated *)
let index_1d_nd i j s =
  j.(0) <- i / s.(0);
  for k = 1 to Array.length s - 1 do
    j.(k) <- (i mod s.(k - 1)) / s.(k);
  done


(* c layout index translation: nd -> 1d
  j is n-dimensional index;
  s is the stride. *)
let index_nd_1d j s =
  let i = ref 0 in
  Array.iteri (fun k a -> i := !i + (a * s.(k))) j;
  !i


(* given ndarray [x] and 1d index, return nd index. *)
let ind x i_1d =
  let shape = Genarray.dims x in
  let stride = calc_stride shape in
  let i_nd = Array.copy stride in
  index_1d_nd i_1d i_nd stride;
  i_nd


(* given ndarray [x] and nd index, return 1d index. *)
let i1d x i_nd =
  let shape = Genarray.dims x in
  let stride = calc_stride shape in
  index_nd_1d i_nd stride


(* Adjust the index according to the [0, m). m is the boundary, i can be negative. *)
let adjust_index i m =
  if i >= 0 && i < m then i
  else if i < 0 && i >= -m then i + m
  else raise Owl_exception.INDEX_OUT_OF_BOUND


(* prepare the parameters for reduce/fold operation, [a] is axis *)
let reduce_params a x =
  let d = Genarray.num_dims x in
  let a = adjust_index a d in

  let _shape = Genarray.dims x in
  let _stride = calc_stride _shape in
  let _slicez = calc_slice _shape in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) in
  let o = _stride.(a) in
  _shape.(a) <- 1;
  m, n, o, _shape


(* various functions to calculate output shape, used in computation graph. *)

let calc_broadcast_shape s0 s1 =
  let sa, sb = Owl_utils_array.align `Left 1 s0 s1 in
  Array.iter2 (fun a b ->
    Owl_exception.(check (not(a <> 1 && b <> 1 && a <> b)) NOT_BROADCASTABLE);
  ) sa sb;
  (* calculate the output shape *)
  Array.map2 max sa sb


let calc_fold_shape shape axis =
  let d = Array.length shape in
  let a = adjust_index axis d in
  assert (a >= 0 && a < d);
  let _shape = Array.copy shape in
  _shape.(a) <- 1;
  _shape


let calc_tile_shape shape repeats =
  assert (Array.exists ((>) 1) repeats = false);
  let s, r = Owl_utils_array.align `Left 1 shape repeats in
  Owl_utils_array.map2 (fun a b -> a * b) s r


let calc_repeat_shape shape axis repeats =
  let d = Array.length shape in
  let a = adjust_index axis d in
  let _shape = Array.copy shape in
  _shape.(a) <- _shape.(a) * repeats;
  _shape


let calc_concatenate_shape shape axis =
  let d = Array.length shape.(0) in
  let axis = adjust_index axis d in
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


let calc_split_shape shape axis parts =
  let d = Array.length shape in
  let a = adjust_index axis d in
  let e = Array.fold_left ( + ) 0 parts in
  assert (a < d);
  assert (e = shape.(a));
  Array.map (fun n ->
    let s = Array.copy shape in
    s.(a) <- n;
    s
  ) parts


let calc_draw_shape shape axis n =
  let d = Array.length shape in
  let a = adjust_index axis d in
  let s = Array.copy shape in
  assert (a < d);
  s.(a) <- n;
  s


let calc_reduce_shape shape axis =
  let d = Array.length shape in
  let a = Array.map (fun i -> adjust_index i d) axis in
  let s = Array.copy shape in
  Array.iter (fun i ->
    assert (i < d);
    s.(i) <- 1
  ) a;
  s


let calc_conv2d_shape input_shape padding kernel_shape stride_shape =
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


let calc_conv1d_shape input_shape padding kernel_shape stride_shape =
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

  let output_shape = calc_conv2d_shape input_shape padding kernel_shape stride_shape in
  let output_cols = output_shape.(2) in
  [|batches; output_cols; out_channel|]


let calc_conv3d_shape input_shape padding kernel_shape stride_shape =
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


let calc_transpose_conv2d_shape input_shape padding kernel_shape stride_shape =
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


let calc_transpose_shape input_shape axis =
  Array.map (fun j -> input_shape.(j)) axis


let calc_dot_shape x_shape y_shape = [|x_shape.(0); y_shape.(1)|]



(* ends here *)
