open Owl_converter_types
open Owl_converter_attr
open Owl_converter_utils

(*

Should DT_TYPE be part of the def? not now.
*)


let default_tensor = {
  dtype = "DT_FLOAT";
  tensor_shape = [|1; 1|];
  float_val  = Some [|1.|];
  string_val = None
}


let database : (string, attr_pair array option) Hashtbl.t =
  let h = Hashtbl.create 10 in

  (* for dot in Owl *)
  let k = "MatMul" in
  let v = [|
    (make_attr_pair ~value:(ATTR_Bool false) "transpose_a");
    (make_attr_pair ~value:(ATTR_Bool false) "transpose_b")
  |]
  in
  Hashtbl.add h k (Some v);

  (* for AddScalar *)
  let k = "Add" in
  Hashtbl.add h k None;

  let k = "Sub" in
  Hashtbl.add h k None;

  (* for Const *)
  let k = "Const" in
  let v = [|
    (make_attr_pair ~value:(ATTR_String "DT_FLOAT") "dtype");
    (make_attr_pair ~value:(ATTR_Float 0.) "value")
  |]
  in
  Hashtbl.add h k (Some v);

  (* for ScalarMul *)
  let k = "Mul" in
  let v = [|
    (make_attr_pair ~value:(ATTR_Tensor default_tensor) "x");
    (make_attr_pair ~value:(ATTR_Tensor default_tensor) "x")
  |]
  in
  Hashtbl.add h k (Some v);

  h


let get_node_attr op_name =
  try
    Hashtbl.find database op_name
  with Not_found -> None


module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  open G.Optimiser.Operator

  let preprocess_cgraph _owl_graph = ()

  let get_extra_attr (cgrah_attr : Symbol.Shape.Type.attr) =
    let shape : (int array option) array = cgrah_attr.shape in
    let output_shape = Array.map (fun s ->
      match s with
      | Some s -> ATTR_Shape s
      | None   -> ATTR_Shape [||]
    ) shape
    in
    let output_shape = ATTR_List output_shape in
    let output_attr  = make_attr_pair ~value:output_shape "_output_shape" in
    let type_attr    = make_attr_pair ~value:(ATTR_String "DT_FLOAT") "dtype" in
    [|output_attr; type_attr|]


  let make_nodedef (node : Symbol.Shape.Type.attr Owl_graph.node) =
    let name = Owl_graph.name node in
    let attr = Owl_graph.attr node in
    let op_name = Symbol.op_to_str attr.op in
    let input = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents node)
    in
    let attr_pair_array = get_node_attr op_name in
    let extra_attrs = get_extra_attr attr in
    let new_attrs = match attr_pair_array with
    | Some a -> Array.append a extra_attrs
    | None   -> extra_attrs
    in
    let device = Some "cpu:0" in
    {
      name   = name;
      op     = op_name;
      input  = input;
      attr   = Some new_attrs;
      device = device;
    }


  let add_nodedef graphdef nodedef =
    graphdef.nodes <- Array.append graphdef.nodes [|nodedef|]


  let create () =
    let node = {
        name  = "";
        op    = "Noop";
        input = [|""|];
        attr  = Some [| make_attr_pair "EmptyATTRKV"|];
        device = None
      }
    in
    { nodes = [|node|] }


  let node_to_string (n : nodedef) =
    let attr_str = match n.attr with
    | Some attrs ->
        apply_and_combine_string (fun a ->
          let value_str = attrvalue_to_string a.value in
          Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {%s}}" a.key value_str
        ) attrs
    | None       -> ""
    in
    Printf.sprintf "node {\nname: \"%s\"\nop: \"%s\"\n%s\n}\n"
      n.name n.op attr_str


  let to_string graphdef =
    let node_arr = Array.map (fun n ->
      node_to_string n
    ) graphdef.nodes
    in
    let nodes_str = array_to_string (fun s -> s) node_arr in
    Printf.sprintf "graph_def {\n%s}\n" nodes_str

end
