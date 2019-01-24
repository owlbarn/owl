open Owl_converter_types
open Owl_converter_attr

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  let make_arg type_attr name =
    {name = name; type_attr = type_attr}


  let make_op input_arg output_arg attr name =
    let input_arg  = match input_arg with
    | Some arg -> arg
    | None     -> [| make_arg "DT_EMPTY" "NilArg" |]
    in
    let output_arg  = match output_arg with
    | Some arg -> arg
    | None     -> [| make_arg "DT_EMPTY" "NilArg" |]
    in
    let attr = match attr with
    | Some attr -> attr
    | None      -> [| make_attrdef "NilAttrdef" |]
    in
    { name = name;
      input_arg = input_arg;
      output_arg = output_arg;
      attr = attr
    }


  let kv_store : (string, (argdef array * argdef array * attrdef array)) Hashtbl.t =
      let h = Hashtbl.create 20 in
      Hashtbl.add h "Dot"
        ( [|make_arg "DT_Float" "a"|],
          [|make_arg "DT_Float" "x"|],
          [|make_attrdef "NilAttrdef" |] );
      h

  let opdef_from_attr (attr : Symbol.Shape.Type.attr) =
    let name = Symbol.op_to_str attr.op in
    (* suppose args and attrs of an op are fixed *)
    let input_arg, output_arg, attr = Hashtbl.find kv_store name in
    make_op (Some input_arg) (Some output_arg) (Some attr) name


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

  let to_string (meta : metainfo) =
    Printf.sprintf "meta_info_def { %s }" meta.tensorflow_version

end
