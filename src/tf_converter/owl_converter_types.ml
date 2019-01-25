(* many properties are ignored for simplicity *)

type tensordef = {
  dtype        : string;
  tensor_shape : int array;
}


type attrvalue =
  | ATTR_String  of string
  | ATTR_Int     of int
  | ATTR_Float   of float
  | ATTR_Bool    of bool
  | ATTR_Tensor  of tensordef
  | ATTR_Shape   of int array
  | ATTR_List    of attrvalue array


type opattr = {
  mutable name : string;
  mutable typ  : string;
}


type argdef = {
  name : string;
  type_attr : string; (* "DT_BFLOAT16" | "DT_HALF" | ... *)
}


type opdef = {
  name       : string;
  input_arg  : argdef array;
  output_arg : argdef array;
  attr       : opattr array;
}


type metadef = {
  mutable stripped_op_list   : opdef array;
  mutable tensorflow_version : string;
  mutable op_names           : string array (* internal use *)
}


type nodedef = {
  mutable name      : string;
  mutable op_name   : string;
  mutable input     : string array;
  mutable node_attr : (string * attrvalue) array option;
  mutable device    : string option
}


type graphdef = {
  mutable nodes : nodedef array
}


type saverdef = {
	filename_tensor_name          : string;
	save_tensor_name              : string;
	restore_op_name               : string;
	max_to_keep                   : int;
	sharded                       : bool;
	keep_checkpoint_every_n_hours : float
}


type collection =
  | Nodelist   of string array
  | Byteslist  of bytes array
  | Floatlist  of float array


type metagraph = {
  mutable meta_def  : metadef;
  mutable graph_def : graphdef;
  mutable saver_def : saverdef;
  mutable coll_def  : (string * collection) array
}
