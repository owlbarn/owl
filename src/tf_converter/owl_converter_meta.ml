(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils

module OpDef = Owl_converter_tfopdef


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  let get_tfop = OpDef.get_tfop


  let mem_op meta op_name =
    Array.mem op_name meta.op_names


  let add_op meta op =
    meta.stripped_op_list <- Array.append meta.stripped_op_list [|op|];
    meta.op_names <- Array.append meta.op_names [|op.name|]


  let is_var tfnode = tfnode.op_name = "VariableV2"


  let create () =
    {
      stripped_op_list = [||];
      tensorflow_version = "1.12.0";
      op_names = [||]
    }


  let tfop_to_string _tfop = ""


  let to_string meta =
    let tfop_str = map_then_combine_string
      tfop_to_string meta.stripped_op_list
    in
    Printf.sprintf "meta_info_def {\n%s\n%s\n}" tfop_str meta.tensorflow_version

end
