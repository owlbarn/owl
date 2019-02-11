(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
 *)


open Owl_converter_types


let make_tftensor ?tensor_content ?string_val ?float_val ?int_val dtype shape =
  {
    dtype          = dtype;
    tensor_shape   = shape;
    tensor_content = tensor_content;
    string_val     = string_val;
    float_val      = float_val;
    int_val        = int_val
  }


let make_tfop_attr name typ =
  {
    name = name;
    typ  = typ;
  }


let make_argdef ?typ ?typ_attr ?num_attr
  ?typ_list_attr ?is_ref name =
  {
    name          = name;
    typ           = typ;
    typ_attr      = typ_attr;
    num_attr      = num_attr;
    typ_list_attr = typ_list_attr;
    is_ref        = is_ref;
  }


let argdef_to_pbtxt name argdef =
  let get_str ?(quote=true) x label =
    let formatter =
      if (quote = true) then (Printf.sprintf "%s: \"%s\"\n")
      else (Printf.sprintf "%s: %s\n")
    in
    match x with
    | Some s -> formatter label s
    | None   -> ""
  in
  let typ = get_str argdef.typ ~quote:false "type" in
  let typ_attr = get_str argdef.typ_attr "type_attr" in
  let num_attr = get_str argdef.num_attr "number_attr" in
  let typ_list_attr = get_str argdef.typ_list_attr "type_list_attr" in
  let is_ref =
    match argdef.is_ref with
    | Some b -> Printf.sprintf "is_ref: %b\n" b
    | None   -> ""
  in
  Printf.sprintf "%s{\nname: \"%s\"\n%s%s%s%s%s}\n" name argdef.name
    typ typ_attr num_attr typ_list_attr is_ref


let tfop_attr_to_pbtxt (attr : tfop_attr) =
  let name_str = Printf.sprintf "name: \"%s\"\n" attr.name in
  let type_str = Printf.sprintf "type: \"%s\"\n" attr.typ in
  Printf.sprintf "attr {\n%s%s}\n" name_str type_str


let dim_to_pbtxt dim =
  Printf.sprintf "dim {\nsize: %d\n}\n" dim


(* TODO: incorprate the unknown_rank situation;
 * empty shape should be printed as is.
 *)
let shape_to_pbtxt shape =
  Owl_utils_array.to_string ~sep:"" dim_to_pbtxt shape


let tensor_to_pbtxt v =
  let dtype_str = v.dtype in
  let tshp_str = shape_to_pbtxt v.tensor_shape in
  let strval_str =
    match v.string_val with
    | Some s ->
      let f x = Printf.sprintf "string_val: \"%s\"\n" x in
      Owl_utils_array.to_string ~sep:"" f s
    | None   -> ""
  in
  let fltval_str =
    match v.float_val with
    | Some n ->
      let f x = Printf.sprintf "float_val: %f\n" x in
      Owl_utils_array.to_string ~sep:"" f n
    | None   -> ""
  in
  let intval_str =
    match v.int_val with
    | Some n ->
      let f x = Printf.sprintf "int_val: %d\n" x in
      Owl_utils_array.to_string ~sep:"" f n
    | None   -> ""
  in
  let tensor_content_str =
    match v.tensor_content with
    | Some c -> Printf.sprintf "tensor_content: \"%s\"\n" (Bytes.to_string c)
    | None   -> ""
  in
  Printf.sprintf "dtype: %s\ntensor_shape:{\n%s}\n%s%s%s%s" dtype_str tshp_str strval_str fltval_str intval_str tensor_content_str


let rec tfattrvalue_to_pbtxt attrv =
  match attrv with
  | ATTR_Nil        -> ""
  | ATTR_Int v      -> Printf.sprintf "i: %d\n" v
  | ATTR_String v   -> Printf.sprintf "s: \"%s\"\n" v
  | ATTR_Bool v     -> Printf.sprintf "b: %b\n" v
  | ATTR_Float v    -> Printf.sprintf "f: %f\n" v
  | ATTR_Tensor v   -> Printf.sprintf "tensor {\n%s}\n" (tensor_to_pbtxt v)
  | ATTR_Type v     -> Printf.sprintf "type: %s\n" v
  | ATTR_Shape v    -> Printf.sprintf "shape {\n%s}\n" (shape_to_pbtxt v)
  | ATTR_List v     ->
      let list_str = Owl_utils_array.to_string ~sep:"" tfattrvalue_to_pbtxt v in
      Printf.sprintf "list {\n%s}\n" list_str
  | ATTR_Namelist _ -> failwith "not implemented yet"
