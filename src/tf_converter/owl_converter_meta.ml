(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils

module AT = Owl_converter_attr
module OpDef = Owl_converter_tfopdef

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  let create () =
    {
      stripped_op_list = [||];
      tensorflow_version = "1.12.0";
      op_names = [||]
    }


  let get_op = OpDef.get_tfop


  let mem_op meta op_name =
    Array.mem op_name meta.op_names


  let add_op meta op =
    meta.stripped_op_list <- Array.append meta.stripped_op_list [|op|];
    meta.op_names <- Array.append meta.op_names [|op.name|]


  let is_var tfnode = tfnode.op_name = "VariableV2"


  let tfop_to_string op =
    let input_arg_arr = map_then_combine_string ~sep:"\n"
      (AT.argdef_to_string "input_arg") op.input_arg in
    let output_arg_arr = map_then_combine_string ~sep:"\n"
      (AT.argdef_to_string "output_arg") op.output_arg in
    let attr_string = map_then_combine_string ~sep:"\n"
      AT.tfop_attr_to_string op.attr in
    Printf.sprintf "op {\nname: %s\n%s%s%s}\n" op.name
      input_arg_arr output_arg_arr attr_string


  let to_string meta =
    let tfop_str = map_then_combine_string
      tfop_to_string meta.stripped_op_list
    in
    Printf.sprintf "meta_info_def {\n%s\n%s\n}" tfop_str meta.tensorflow_version

end
