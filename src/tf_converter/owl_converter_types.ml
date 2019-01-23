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


type attrdef = {
  name           : string;
  typ            : string;
  default_value  : attrvalue;
  allowed_values : attrvalue;
  has_minimum    : bool;
  minimum        : int
}


type op = {
  input_arg : argdef array;
  output_arg: argdef array;
  attr      : attrdef array;
  (* some other *)
}


type metainfo = {
  stripped_op_list   : op array;
  tensorflow_version : string
}


type attr_pair = {
  key   : string;
  value : attrvalue
}

type node = {
  name  : string;
  op    : string;
  input : string array;
  attr  : attr_pair array
  (* device: "/device:CPU:0" *)
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
  mutable graph_def : node array;
  mutable saver_def : saver;
  mutable collections : collection_pair array
}
