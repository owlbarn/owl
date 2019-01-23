open Owl_converter_types
open Owl_converter_attr


let make_arg () =
  {name = "empty_arg"; type_attr = "nil"}


let make_op () =
  let arg  = make_arg () in
  let attr = make_attrdef () in
  {input_arg = [|arg|]; output_arg = [|arg|]; attr = [|attr|]}


let create () =
  let emty_op = make_op () in
  {stripped_op_list = [|emty_op|]; tensorflow_version = "1.12.0"}


let to_string (meta : metainfo) =
  Printf.sprintf "meta_info_def { %s }" meta.tensorflow_version
