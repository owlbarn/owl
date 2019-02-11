(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
 *)


open Owl_converter_types


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct


  (* get version from tensorflow itself, probably by running command
   * `python -c 'import tensorflow as tf; print(tf.__version__)'`
   *)
  let create () =
    {
      stripped_op_list   = [||];
      tensorflow_version = "1.12.0";
      op_names           = [||]
    }


  let mem_opdef meta op_name =
    Array.mem op_name meta.op_names


  let add_opdef meta op =
    meta.stripped_op_list <- Array.append meta.stripped_op_list [|op|];
    meta.op_names <- Array.append meta.op_names [|op.name|]


  let is_var tfnode = (Owl_converter_node.get_op_name tfnode) = "VariableV2"


  let to_pbtxt meta =
    let tfop_str = Owl_utils_array.to_string ~sep:"\n"
      Owl_converter_node.opdef_to_pbtxt meta.stripped_op_list
    in
    Printf.sprintf "meta_info_def {\nstripped_op_list{\n%s}\ntensorflow_version: \"%s\"\n}\n" tfop_str meta.tensorflow_version

end
