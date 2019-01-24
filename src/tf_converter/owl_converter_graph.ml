open Owl_converter_types
open Owl_converter_attr
open Owl_converter_utils

(*

Should DT_TYPE be part of the def?


type dim = {
  size : int;
  name : string
}

type tensor = {
  dtype : string; (* datatype actually *)
  tensor_shape : dim array;
  float_val : float;
  string_val : string;
}


type attrvalue =
  | ATTR_String  of string
  | ATTR_Int     of int
  | ATTR_Float   of float
  | ATTR_Bool    of bool
  | ATTR_Tensor  of tensor
  | ATTR_AttrLst of attrvalue array


type attr_pair = {
  key   : string;
  value : attrvalue
}

type node = {
  name      : string;
  op        : string;
  input     : string array;
  attr      : attr_pair array;
  device    : string option
}

type graphdef = {
  mutable nodes : node array
}
*)

let default_tensor = {
  dtype = "DT_FLOAT";
  tensor_shape = [|{size = 1; name="h"}; {size = 1; name="w"}|];
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


  let make_nodedef node =
    let name = Owl_graph.name node in
    let attr : Symbol.Shape.Type.attr  = Owl_graph.attr node in
    let op_name = Symbol.op_to_str attr.op in
    let input = Array.map (fun n ->
      Owl_graph.name n
    ) (Owl_graph.parents node)
    in
    let attr_pair_array = get_node_attr op_name in
    let device = Some "cpu:0" in
    {
      name   = name;
      op     = op_name;
      input  = input;
      attr   = attr_pair_array;
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


  let add_node_attr n attr_array =
    let new_attr = match n.attr with
    | Some a -> Array.append a attr_array
    | None   -> attr_array
    in
    n.attr <- Some new_attr


  let node_to_string (n : nodedef) =
    let output_shape = ATTR_String "dummy_shape" in
    let output_attr  = make_attr_pair ~value:output_shape "_output_shape" in
    let type_attr    = make_attr_pair ~value:(ATTR_String "DT_FLOAT") "dtype" in
    add_node_attr n [|output_attr; type_attr|];

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
    Printf.sprintf "graph_def {%s}" nodes_str

end
