(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_attr
open Owl_converter_types


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
  with Not_found -> None


let default_tensor = make_tensordef "Nil" [|1|]


let node_database : (string, (string * attrvalue) array option) Hashtbl.t =
  let h = Hashtbl.create 10 in

  (* for dot in Owl *)
  let k = "MatMul" in
  let v = [|
    ("transpose_a", (ATTR_Bool false));
    ("transpose_b", (ATTR_Bool false))
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
    ("dtype", (ATTR_String "DT_FLOAT"));
    ("value", (ATTR_Float 0.));
  |]
  in
  Hashtbl.add h k (Some v);

  (* for ScalarMul *)
  let k = "Mul" in
  let v = [|
    ("x", (ATTR_Tensor default_tensor));
    ("y", (ATTR_Tensor default_tensor))
  |]
  in
  Hashtbl.add h k (Some v);

  h


let get_node_attr op_name =
  try
    Hashtbl.find node_database op_name
  with Not_found -> None
