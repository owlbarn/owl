(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Tensor: tensor implementation in Owl *)


open Bigarray
open Owl_types
open Owl_dense_common_types

external plus : int -> int -> int = "plus_fuck"

(*
external tensor_op : ('a, 'b) owl_arr -> float -> unit = "c_tensor_op"
external haha_float32_ndarray_get_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_get_slice"
external shit: ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "c_float64_matrix_transpose"
*)

(*
open Ctypes
open Foreign

let plus = foreign "plus_fuck" (int @-> int @-> returning int)
let fuck = foreign "c_ndarray_slice_dim" (ptr float @-> returning int)
*)

(*
let ml_tensor_spatial_avg_pooling = foreign "c_tensor_s_spatial_avg_pooling" (ptr elt @-> ptr elt @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> returning void)


let ml_tensor_spatial_max_pooling = foreign "c_tensor_s_spatial_max_pooling" (ptr elt @-> ptr elt @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> returning void)

*)

(* external tensor_add : ('a, 'b) owl_arr -> int -> unit = "c_tensor_add" *)

(*
external ml_tensor_spatial_avg_pooling : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "c_tensor_s_spatial_avg_pooling"
*)

(*
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
*)

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
