(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Tensor: tensor implementation in Owl *)

open Ctypes
open Foreign

let elt = float

let ml_tensor_spatial_avg_pooling = foreign "c_tensor_s_spatial_avg_pooling" (ptr elt @-> ptr elt @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> returning void)

(*
let ml_tensor_spatial_max_pooling = foreign "c_tensor_s_spatial_max_pooling" (ptr elt @-> ptr elt @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> returning void)

*)

(* external tensor_add : ('a, 'b) owl_arr -> int -> unit = "c_tensor_add" *)

(*
external ml_tensor_spatial_avg_pooling : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "c_tensor_s_spatial_avg_pooling"
*)

let spatial_avg_pooling
  input output batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride padding row_in_stride col_in_stride
  =
  let input_ptr = Ctypes.bigarray_start Ctypes_static.Genarray input in
  let output_ptr = Ctypes.bigarray_start Ctypes_static.Genarray output in

  (*
  let input_ptr = input in
  let output_ptr = output in
  *)

  ml_tensor_spatial_avg_pooling
    input_ptr output_ptr
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride padding row_in_stride col_in_stride

(*
let spatial_max_pooling
  input output batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride padding row_in_stride col_in_stride
  =
  let input_ptr = Ctypes.bigarray_start Ctypes_static.Genarray input in
  let output_ptr = Ctypes.bigarray_start Ctypes_static.Genarray output in

  ml_tensor_spatial_max_pooling
    input_ptr output_ptr
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride padding row_in_stride col_in_stride
*)
