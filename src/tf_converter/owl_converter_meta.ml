(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils
(* open Owl_converter_attr *)

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  let make_op input_arg output_arg attr name =
    let input_arg  =
      match input_arg with
      | Some arg -> arg
      | None     -> [||]
    in
    let output_arg  =
      match output_arg with
      | Some arg -> arg
      | None     -> [||]
    in
    let attr =
      match attr with
      | Some attr -> attr
      | None      -> [||]
    in
    {
      name = name;
      input_arg = input_arg;
      output_arg = output_arg;
      attr = attr
    }


  (* A large "match" should be here for looking up operations *)
  let get_tfop name =
    let input_arg, output_arg, attr = None, None, None in
    make_op input_arg output_arg attr name


  let mem_op meta op_name =
    Array.mem op_name meta.op_names


  let add_op meta op =
    meta.stripped_op_list <- Array.append meta.stripped_op_list [|op|];
    meta.op_names <- Array.append meta.op_names [|op.name|]


  let is_var tfnode = tfnode.op_name = "VariableV2"


  let create () =
    let emty_op = make_op None None None "Noop" in
    {
      stripped_op_list = [|emty_op|];
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
