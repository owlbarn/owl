(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Tensor: tensor implementation in Owl *)


open Bigarray
open Owl_types
open Owl_dense_common_types


(*
external plus  : int -> int -> int = "plus_fuck"
external test :  ('a, 'b) owl_arr -> float -> unit = "c_tensor_op"


external plus : int -> int -> int = "plus_fuck"

external fuck : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "fuck_float64_ndarray_get_slice"
external shit : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "stub_float64_ndarray_get_slice"

external fuck_shit_tensor : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "fuck_float32_shit_tensor"
*)

external ml_tensor_spatial_max_pooling : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_tensor_spatial_max_pooling_bytecode"
"stub_tensor_spatial_max_pooling_native"

(*
let ml_tensor_spatial_avg_pooling = foreign "c_tensor_s_spatial_avg_pooling" (ptr elt @-> ptr elt @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> returning void)

let ml_tensor_spatial_max_pooling = foreign "c_tensor_s_spatial_max_pooling" (ptr elt @-> ptr elt @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> int @-> returning void)

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

let spatial_max_pooling
  input output batches input_cols input_rows in_channel
  kernel_cols kernel_rows output_cols output_rows
  row_stride col_stride padding row_in_stride col_in_stride
  =
  (*
  let input_ptr = Ctypes.bigarray_start Ctypes_static.Genarray input in
  let output_ptr = Ctypes.bigarray_start Ctypes_static.Genarray output in
  *)

  let input_ptr = input in
  let output_ptr = output in

  ml_tensor_spatial_max_pooling
    input_ptr output_ptr
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride padding row_in_stride col_in_stride
