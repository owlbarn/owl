(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Tensor: tensor implementation in Owl *)

open Bigarray
open Owl_types
open Owl_dense_common_types

external owl_float32_tensor_maxpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_maxpool_spatial_bytecode"
"stub_float32_tensor_maxpool_spatial_native"

external owl_float32_tensor_avgpool_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_avgpool_spatial_bytecode"
"stub_float32_tensor_avgpool_spatial_native"

external owl_float32_tensor_maxpool_backward_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_maxpool_spatial_backward_bytecode"
"stub_float32_tensor_maxpool_spatial_backward_native"

external owl_float32_tensor_avgpool_backward_spatial : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit =
"stub_float32_tensor_avgpool_spatial_backward_bytecode"
"stub_float32_tensor_avgpool_spatial_backward_native"
