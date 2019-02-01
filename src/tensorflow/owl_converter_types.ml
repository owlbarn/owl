(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type dtype =
  DT_HALF | DT_FLOAT | DT_DOUBLE | DT_UINT8 |
  DT_INT8 | DT_INT16 | DT_INT32  | DT_INT64 |
  DT_COMPLEX64 | DT_COMPLEX128   | DT_STRING


type tftensor = {
  dtype        : string;
  tensor_shape : int array;
  string_val   : string array option; (* array or not? *)
  float_val    : float array option;
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
  name : string;
  typ  : string;
  (* allowed_values : tfattrvalue
   * default_value :  tfattrvalue
   * has_minimum : bool;
   * minimum : int
   *)
}


type argdef = {
  name          : string;
  typ           : string option;
  typ_attr      : string option;
  num_attr      : string option;
  typ_list_attr : string option;
  is_ref        : bool option;
}


type tfop = {
  name       : string;
  input_arg  : argdef array;
  output_arg : argdef array;
  attr       : tfop_attr array;
  (* allows_uninitialized_input : bool
   * is_commutative : bool
   * is_stateful : bool
   *)
}


type tfmeta = {
  mutable stripped_op_list   : tfop array;
  mutable tensorflow_version : string;
  mutable op_names           : string array (* internal use *)
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


(*
type tf_cgraph = {
  mutable tfmeta  : tfmeta;
  mutable tfgraph : tfgraph;
  mutable tfsaver : tfsaver;
  mutable tfcolls : tfcolls
}
*)
