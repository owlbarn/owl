(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils

let make_tftensor ?(string_val=None) ?(float_val=None) dtype shape =
  {
    dtype        = dtype;
    tensor_shape = shape;
    string_val   = string_val;
    float_val    = float_val
  }


let make_tfop_attr name typ =
  {
    name = name;
    typ  = typ;
  }


let make_argdef ?typ_attr ?num_attr
  ?typ_attr_list ?is_ref name =
  {
    name          = name;
    typ_attr      = typ_attr;
    num_attr      = num_attr;
    typ_attr_list = typ_attr_list;
    is_ref        = is_ref;
  }


let dim_to_string dim =
  Printf.sprintf "dim {\nsize: %d}\n" dim


let tensor_to_string v =
  let dtype_str = v.dtype in
  let tshp_str = map_then_combine_string dim_to_string v.tensor_shape in
  let result_str = dtype_str ^ tshp_str in
  Printf.sprintf "tensor {\n%s\n}" result_str


let rec tfattrvalue_to_string attrv =
  match attrv with
  | ATTR_Nil      -> ""
  | ATTR_Int v    -> Printf.sprintf "int {\n%d}\n" v
  | ATTR_String v -> Printf.sprintf "string {\n%s}\n" v
  | ATTR_Bool v   -> Printf.sprintf "bool {\n%b}\n" v
  | ATTR_Float v  -> Printf.sprintf "float {\n%f}\n" v
  | ATTR_Tensor v -> Printf.sprintf "tensor {\n%s}\n" (tensor_to_string v)
  | ATTR_Type v   -> Printf.sprintf "type {\n%s}\n" v
  | ATTR_Shape v  ->
      let shp_str = map_then_combine_string dim_to_string v in
      Printf.sprintf "shape {\n%s}\n" shp_str
  | ATTR_List v   ->
      let list_str = map_then_combine_string tfattrvalue_to_string v in
      Printf.sprintf "list {\n%s}\n" list_str
