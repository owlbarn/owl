(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* many properties are ignored for simplicity *)

type dtype =
  DT_STRING | DT_FLOAT32 | DT_FLOAT64   |
  DT_INT32  | DT_INT64   | DT_COMPLEX32 |
  DT_COMPLEX64


type tftensor = {
  dtype        : string;
  tensor_shape : int array;
  string_val   : string option;
  float_val    : float option;
}


type tfattrvalue =
  | ATTR_Nil
  | ATTR_Int     of int
  | ATTR_Bool    of bool
  | ATTR_Type    of string
  | ATTR_Float   of float
  | ATTR_Shape   of int array
  | ATTR_String  of string
  | ATTR_Tensor  of tftensor
  | ATTR_List    of tfattrvalue array


type tfop_attr = {
  mutable name : string;
  mutable typ  : string;
}


type argdef = {
  name      : string;
  type_attr : string; (* "DT_BFLOAT16" | "DT_HALF" | ... *)
}


type tfop = {
  name       : string;
  input_arg  : argdef array;
  output_arg : argdef array;
  attr       : tfop_attr array;
}


type tfmeta = {
  mutable stripped_op_list   : tfop array;
  mutable tensorflow_version : string;
  mutable op_names           : string array (* internal use *)
}


type tfnode = {
  mutable name      : string;
  mutable op_name   : string;
  mutable input     : string array;
  mutable node_attr : (string * tfattrvalue) array;
  (* mutable out_shp   : int array option; *)
  mutable device    : string
}


type tfgraph = {
  mutable nodes   : tfnode array;
  mutable nametbl : (string, string) Hashtbl.t
}


type tfsaver = {
	filename_tensor_name          : string;
	save_tensor_name              : string;
	restore_op_name               : string;
	max_to_keep                   : int;
	sharded                       : bool;
	keep_checkpoint_every_n_hours : float
}


type tfcollection =
  | Nodelist   of string array
  | Byteslist  of bytes array
  | Floatlist  of float array


type tfcolls = (string, tfcollection) Hashtbl.t


type tf_cgraph = {
  mutable tfmeta  : tfmeta;
  mutable tfgraph : tfgraph;
  mutable tfsaver : tfsaver;
  mutable tfcolls : tfcolls
}
