type argdef = {
  name : string;
  type_attr : string; (* "DT_BFLOAT16" | "DT_HALF" | ... *)
  (* typ  : string;
  num_attr  : string;
  type_list_attr : string;
  is_ref : bool *)
}

type dim = {
  size : int;
  name : string
}

(* https://github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/attr_value.proto*)


type tensor = {
  dtype        : string; (* datatype actually *)
  tensor_shape : dim array;
  float_val    : float array option;
  string_val   : string array option;
}

type shape = {
  shape : dim array
}


type attrvalue =
  | ATTR_String  of string
  | ATTR_Int     of int
  | ATTR_Float   of float
  | ATTR_Bool    of bool
  | ATTR_Tensor  of tensor
  | ATTR_List    of attrvalue array
  (*ATTR_Shape*)


type attrdef = {
  name           : string;
  typ            : string;
  default_value  : attrvalue option;
  allowed_values : attrvalue option;
  has_minimum    : bool option;
  minimum        : int option;
}


type op = {
  name      : string;
  input_arg : argdef array;
  output_arg: argdef array;
  attr      : attrdef array;
  (* some other *)
}


type metainfo = {
  mutable stripped_op_list   : op array;
  mutable tensorflow_version : string;
  mutable op_names           : string array (* internal use *)
}


type attr_pair = {
  key   : string;
  value : attrvalue
}

type nodedef = {
  mutable name      : string;
  mutable op        : string;
  mutable input     : string array;
  mutable attr      : attr_pair array option;
  mutable device    : string option
}

type graphdef = {
  mutable nodes : nodedef array
}


type saver = {
	filename_tensor_name          : string;
	save_tensor_name              : string;
	restore_op_name               : string;
	max_to_keep                   : int;
	sharded                       : bool;
	keep_checkpoint_every_n_hours : float
	(* version : "V2" *)
}


type collection =
  | Nodelist   of string array
  | Byteslist  of bytes array
  | Floatlist  of float array


type collection_pair = {
  col_key: string;
  col_value: collection
}


type metagraph = {
  mutable meta_info : metainfo;
  mutable graph_def : graphdef;
  mutable saver_def : saver;
  mutable collections : collection_pair array
}
