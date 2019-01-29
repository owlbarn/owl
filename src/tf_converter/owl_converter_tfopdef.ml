(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_converter_types
open Owl_converter_attr


(* There should a unified naming rules, so that it's "Add", not "aDd" or something else. Also, TF nodes might also need to be typed later. *)


let make_op_def ?input_arg ?output_arg ?attr name =
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


let nil_def =
  make_op_def "Nil"


let noop_def =
  make_op_def "NoOp"


let add_def =
  let input_arg = [|
    make_argdef ~typ_attr:"T" "x";
    make_argdef ~typ_attr:"T" "y";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_attr:"T" "z";
  |]
  in
  let attr = [|
    make_tfop_attr "T" "type"
  |]
  in
  make_op_def ~input_arg ~output_arg ~attr "Add"


let assign_def =
  let input_arg = [|
    make_argdef ~typ_attr:"T" ~is_ref:true "ref";
    make_argdef ~typ_attr:"T" "value";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_attr:"T" ~is_ref:true "output_ref";
  |]
  in
  let attr = [|
    make_tfop_attr "T" "type";
    make_tfop_attr "validate_shape" "bool";
    make_tfop_attr "use_locking" "bool";
  |]
  in
  make_op_def ~input_arg ~output_arg ~attr "Assign"


let const_def =
  let output_arg = [|
    make_argdef ~typ_attr:"dtype" "output"
  |]
  in
  let attr = [|
    make_tfop_attr "value" "tensor";
    make_tfop_attr "dtype" "type";
  |]
  in
  make_op_def ~output_arg ~attr "Const"


let identity_def =
  let input_arg = [|
    make_argdef ~typ_attr:"T" "input";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_attr:"T" "output";
  |]
  in
  let attr = [|
    make_tfop_attr "T" "type";
  |]
  in
  make_op_def ~input_arg ~output_arg ~attr "Identity"


let matmul_def =
  let input_arg = [|
    make_argdef ~typ_attr:"T" "a";
    make_argdef ~typ_attr:"T" "b";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_attr:"T" "product";
  |]
  in
  let attr = [|
    make_tfop_attr "T" "type";
    make_tfop_attr "transpose_a" "bool";
    make_tfop_attr "transpose_b" "bool";
  |]
  in
  make_op_def ~input_arg ~output_arg ~attr "MatMul"


let mul_def =
  let input_arg = [|
    make_argdef ~typ_attr:"T" "x";
    make_argdef ~typ_attr:"T" "y";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_attr:"T" "z";
  |]
  in
  let attr = [|
    make_tfop_attr "T" "type";
  |]
  in
  make_op_def ~input_arg ~output_arg ~attr "Mul"


let placeholder_def =
  let output_arg = [|
    make_argdef ~typ_attr:"dtype" "type";
  |]
  in
  let attr = [|
    make_tfop_attr "dtype" "type";
    make_tfop_attr "shape" "shape";
  |]
  in
  make_op_def ~output_arg ~attr "Placeholder"


let restore_def =
  let input_arg = [|
    make_argdef ~typ:"DT_STRING" "prefix";
    make_argdef ~typ:"DT_STRING" "tensor_names";
    make_argdef ~typ:"DT_STRING" "shape_and_slices";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_list_attr:"dtypes" "tensors";
  |]
  in
  let attr = [|
    make_tfop_attr "dtypes" "list(type)"; (* has_minimum : true *)
  |]
  in
  make_op_def ~input_arg ~output_arg ~attr "RestoreV2"


let save_def =
  let input_arg = [|
    make_argdef ~typ:"DT_STRING" "prefix";
    make_argdef ~typ:"DT_STRING" "tensor_names";
    make_argdef ~typ:"DT_STRING" "shape_and_slices";
    make_argdef ~typ_list_attr:"dtypes" "tensors";
  |]
  in
  let attr = [|
    make_tfop_attr "dtypes" "list(type)"; (* has_minimum : true *)
  |]
  in
  make_op_def ~input_arg ~attr "RestoreV2"


let variable_def =
  let output_arg = [|
    make_argdef ~typ_attr:"dtype" "ref";
  |]
  in
  let attr = [|
    make_tfop_attr "shape" "shape";
    make_tfop_attr "dtype" "type";
    make_tfop_attr "container" "string";
    make_tfop_attr "shared_name" "string";
  |]
  in
  (* let is_stateful = true in *)
  make_op_def ~output_arg ~attr "VariableV2"


let get_tfop = function
  | "Add"         -> add_def
  | "Assign"      -> assign_def
  | "Const"       -> const_def
  | "Identity"    -> identity_def
  | "MatMul"      -> matmul_def
  | "Mul"         -> mul_def
  | "NoOp"        -> noop_def
  | "Placeholder" -> placeholder_def
  | "RestoreV2"   -> restore_def
  | "SaveV2"      -> save_def
  | "VariableV2"  -> variable_def
  | _             -> nil_def
