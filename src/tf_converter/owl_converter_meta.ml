(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
(* open Owl_converter_attr *)

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

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


  let opdef_from_attr (attr : Symbol.Shape.Type.attr) =
    let name = Symbol.op_to_str attr.op in
    let input_arg, output_arg, attr = None, None, None in
    make_op input_arg output_arg attr name


  let mem_op meta op_name =
    Array.mem op_name meta.op_names


  let add_op meta op =
    meta.stripped_op_list <- Array.append meta.stripped_op_list [|op|];
    meta.op_names <- Array.append meta.op_names [|op.name|]


  let post_process _metadef = ()


  let create () =
    let emty_op = make_op None None None "Noop" in
    {
      stripped_op_list = [|emty_op|];
      tensorflow_version = "1.12.0";
      op_names = [||]
    }


  let to_string meta =
    Printf.sprintf "meta_info_def { %s }" meta.tensorflow_version


end



(*
let op_database : (string, (argdef array * argdef array * opattr array)) Hashtbl.t =
  let h = Hashtbl.create 20 in
  Hashtbl.add h "Dot"
    ( [|make_argdef "DT_Float" "a"|],
      [|make_argdef "DT_Float" "x"|],
      [|make_opattr "NilAttrdef" "Nil"|]);
  h


let get_op_attr op_name =
  try
    Some (Hashtbl.find op_database op_name)
  with
    Not_found -> None

*)
