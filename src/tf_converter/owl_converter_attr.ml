(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils

let make_tensordef dtype shape =
  {
    dtype        = dtype;
    tensor_shape = shape
  }


let make_opattr name typ =
  {
    name = name;
    typ  = typ;
  }


let make_argdef type_attr name =
  {name = name; type_attr = type_attr}


let dim_to_string dim =
  Printf.sprintf "dim {\nsize: %d}\n" dim


let tensor_to_string v =
  let dtype_str = v.dtype in
  let tshp_str  = map_then_combine_string dim_to_string v.tensor_shape in
  (* let float_val = match v.float_val with
  | Some v -> Owl_utils_array.to_string ~sep:" " string_of_float v
  | None   -> ""
  in
  let float_str = Printf.sprintf "float_val : %s" float_val in
  let string_val = match v.string_val with
  | Some v -> Owl_utils_array.to_string ~sep:" " (fun s -> s) v
  | None -> ""
  in
  let string_str = Printf.sprintf "string_val : %s" string_val in
  let result_str =
    dtype_str ^
    tshp_str  ^
    float_str ^
    string_str
  in *)
  let result_str = dtype_str ^ tshp_str in
  Printf.sprintf "tensor {\n%s\n}" result_str


let rec attrvalue_to_string attrv =
  match attrv with
  | ATTR_Int v    -> Printf.sprintf "int {\n%d}\n" v
  | ATTR_String v -> Printf.sprintf "string {\n%s}\n" v
  | ATTR_Bool v   -> Printf.sprintf "bool {\n%b}\n" v
  | ATTR_Float v  -> Printf.sprintf "float {\n%f}\n" v
  | ATTR_Tensor v -> Printf.sprintf "tensor {\n%s}\n" (tensor_to_string v)
  | ATTR_Shape v  ->
    let shp_str = map_then_combine_string dim_to_string v in
    Printf.sprintf "shape {\n%s}\n" shp_str
  | ATTR_List v   ->
    let list_str = map_then_combine_string attrvalue_to_string v in
    Printf.sprintf "list {\n%s}\n" list_str
