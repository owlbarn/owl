(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr


type nodedef = {
  mutable name      : string;
  mutable op_name   : string;
  mutable input     : string array;
  mutable node_attr : (string * tfattrvalue) array;
  mutable device    : string
  (* mutable out_shp   : int array option; *)
}


let nodedef_to_pbtxt n =
  let attr_str =
    Owl_converter_utils.map_then_combine_string ~sep:"" (fun (k, v) ->
      let value_str = tfattrvalue_to_string v in
      Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {\n%s}\n}\n" k value_str
    ) n.node_attr
  in

  let inputs_str =
    Owl_converter_utils.map_then_combine_string ~sep:"\n" (fun v ->
      Printf.sprintf "input: \"%s\"" v
    ) n.input
  in

  Printf.sprintf "node {\nname: \"%s\"\nop: \"%s\"\n%s\n%s}\n"
    n.name n.op_name inputs_str attr_str


let make_opdef ?input_arg ?output_arg ?attr name =
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


let nil_def = make_opdef "Nil"


let opdef_to_pbtxt op =
  let input_arg_arr = Owl_converter_utils.map_then_combine_string ~sep:"\n"
    (argdef_to_string "input_arg") op.input_arg in
  let output_arg_arr = Owl_converter_utils.map_then_combine_string ~sep:"\n"
    (argdef_to_string "output_arg") op.output_arg in
  let attr_string = Owl_converter_utils.map_then_combine_string ~sep:"\n"
    tfop_attr_to_string op.attr in
  Printf.sprintf "op {\nname: \"%s\"\n%s%s%s}\n" op.name
    input_arg_arr output_arg_arr attr_string


module TFMatMul = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable trans_a : bool;
    mutable trans_b : bool;
    mutable dtype   : string;
  }


  let opname = "MatMul"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr opname


  let create name inputs out_shp trans_a trans_b =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      trans_a = trans_a;
      trans_b = trans_b;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("transpose_a", (ATTR_Bool n.trans_a));
      ("transpose_b", (ATTR_Bool n.trans_b));
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFAdd = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }

  let opname = "Add"

  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr opname


  let create name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFSub = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let opname = "Sub"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr opname


  let create name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFMul = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let opname = "Mul"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr opname


  let create name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFDiv = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let opname = "Div"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr opname


  let create name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFConst = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable out_shp : int array;
    mutable value   : tfattrvalue;
    mutable dtype   : string;
  }


  let opname = "Const"


  let opdef =
    let output_arg = [|
      make_argdef ~typ_attr:"dtype" "output"
    |]
    in
    let attr = [|
      make_tfop_attr "value" "tensor";
      make_tfop_attr "dtype" "type";
    |]
    in
    make_opdef ~output_arg ~attr opname


  let create ?(dtype="DT_STRING") name out_shp value =
    (*let dtype =
      match dtype with
      | Some t -> t
      | None   -> expr2 *)
    {
      name    = name;
      op_name = opname;
      out_shp = out_shp;
      value   = value;
      dtype   = dtype
    }


  let make_nodedef n =
    let node_attr = [|
      ("dtype", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("value", n.value);
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [||];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()


  (* NOTE: for now, we only need to get the "value" attribute of tfconst node;
   * to generalise it to all attributes of all nodes, though, it tricky.
   *)
  let get_const_value n = n.value


  let set_const_value n v = n.value <- v

end


module TFPlaceholder = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let opname = "Placeholder"


  let opdef =
    let output_arg = [|
      make_argdef ~typ_attr:"dtype" "type";
    |]
    in
    let attr = [|
      make_tfop_attr "dtype" "type";
      make_tfop_attr "shape" "shape";
    |]
    in
    make_opdef ~output_arg ~attr opname


  let create name out_shp =
    {
      name    = name;
      op_name = opname;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("dtype", (ATTR_Type n.dtype));
      ("shape", (ATTR_Shape n.out_shp));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    {
      name      = n.name;
      op_name   = opname;
      input     = [||];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()

end


module TFRelu = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
  }


  let opname = "Relu"


  (* To update *)
  let opdef = nil_def


  let create name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
    }


  let make_nodedef n =
    let node_attr = [|
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFConv2D = struct

  type t = {
    mutable name     : string;
    mutable op_name  : string;
    mutable inputs   : string array;
    mutable out_shp  : int array;
    mutable strides  : int array;
    mutable padding  : string;
    mutable dilation : int array;
  }


  let opname = "Conv2D"


  (* To update *)
  let opdef = nil_def


  let create name inputs out_shp padding strides =
    let padding =
      match padding with
      | Owl_types_common.SAME  -> "Same"
      | Owl_types_common.VALID -> "Valid"
    in
    {
      name     = name;
      op_name  = opname;
      inputs   = inputs;
      out_shp  = out_shp;
      strides  = strides;
      padding  = padding;
      dilation = [|1;1;1;1|];
    }


  let make_nodedef n =
    let node_attr = [|
      ("strides", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.strides)));
      ("dilation", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.dilation)));
      ("padding", (ATTR_String n.padding));
      ("T", (ATTR_Type "DT_FLOAT"));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFMaxPool = struct

  type t = {
    mutable name     : string;
    mutable op_name  : string;
    mutable inputs   : string array;
    mutable out_shp  : int array;
    mutable strides  : int array;
    mutable padding  : string;
    mutable ksize    : int array;
  }


  let opname = "MaxPool"


  (* To update *)
  let opdef = nil_def


  let create name inputs out_shp padding strides ksize =
    let padding =
      match padding with
      | Owl_types_common.SAME  -> "Same"
      | Owl_types_common.VALID -> "Valid"
    in
    {
      name     = name;
      op_name  = opname;
      inputs   = inputs;
      out_shp  = out_shp;
      strides  = strides;
      padding  = padding;
      ksize    = ksize;
    }


  let make_nodedef n =
    let node_attr = [|
      ("strides", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.strides)));
      ("ksize", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.ksize)));
      ("padding", (ATTR_String n.padding));
      ("T", (ATTR_Type "DT_FLOAT"));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFAssign = struct

  type t = {
    mutable name           : string;
    mutable op_name        : string;
    mutable out_shp        : int array;
    mutable dtype          : string;
    mutable refv           : string;
    mutable value          : string;
    mutable use_locking    : bool;
    mutable validate_shape : bool;
  }


  let opname = "Assign"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr "Assign"


  let create ~refv ~value name out_shp dtype =
    {
      name           = name;
      op_name        = opname;
      out_shp        = out_shp;
      dtype          = dtype;
      refv           = refv;
      value          = value;
      use_locking    = true;
      validate_shape = true;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("_class", (ATTR_List [|ATTR_String ("loc:@" ^ n.value)|]));
      ("use_locking", (ATTR_Bool n.use_locking));
      ("validate_shape", (ATTR_Bool n.validate_shape));
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [|n.refv; n.value|];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()

end


module TFIdentity = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable cls     : string;
  }


  let opname = "Identity"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr "Identity"


  let create name inputs out_shp dtype cls =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = dtype;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("_class", ATTR_List [|ATTR_String ("loc:@" ^ n.cls)|]);
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_inputs n = n.inputs


  let get_output_shape n = n.out_shp


  let set_inputs n i = n.inputs <- i

end


module TFSave = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtype   : string;
  }


  let opname = "SaveV2"


  let opdef =
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
    make_opdef ~input_arg ~attr opname


  let create ?(dtype="DT_STRING") name inputs =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      dtype   = dtype
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = [|("dtypes", ATTR_List [|ATTR_Type n.dtype|])|];
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape _ = [||]


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFRestore = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtype   : string;
  }


  let opname = "RestoreV2"


  let opdef =
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
    make_opdef ~input_arg ~output_arg ~attr opname


  let create name inputs dtype =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      dtype   = dtype
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = [|("dtypes", ATTR_List [|ATTR_Type n.dtype|])|];
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape _ = [||]


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFNoop = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
  }


  let opname = "NoOp"


  let opdef = make_opdef opname


  let create name inputs =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = [||];
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape _ = [||]


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFVariable = struct

  type t = {
    mutable name           : string;
    mutable op_name        : string;
    mutable dtype          : string;
    mutable shape          : int array;
    mutable out_shp        : int array;
    mutable shared_name    : string;
    mutable container      : string; (* should be of type ATTR_kv *)
  }


  let opname = "VariableV2"


  let opdef =
    let output_arg = [|
      make_argdef ~typ_attr:"dtype" ~is_ref:true "ref";
    |]
    in
    let attr = [|
      make_tfop_attr "shape" "shape";
      make_tfop_attr "dtype" "type";
      make_tfop_attr "container" "string";
      make_tfop_attr "shared_name" "string";
    |]
    in
    (* is_stateful = true in*)
    make_opdef ~output_arg ~attr opname


  let create name out_shp dtype =
    {
      name           = name;
      op_name        = opname;
      shape          = out_shp;
      dtype          = dtype;
      out_shp        = out_shp;
      container      = ""; (* tmp *)
      shared_name    = ""; (* tmp *)
    }


  let make_nodedef n =
    let node_attr = [|
      ("shape", (ATTR_Shape n.shape));
      ("dtype", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("container", (ATTR_String n.container));
      ("shared_name", (ATTR_String n.shared_name));
    |]
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [||];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()


end


type tfnode =
  | TFMatMul      of TFMatMul.t
  | TFAdd         of TFAdd.t
  | TFSub         of TFSub.t
  | TFMul         of TFMul.t
  | TFDiv         of TFDiv.t
  | TFRelu        of TFRelu.t
  | TFConv2D      of TFConv2D.t
  | TFMaxPool     of TFMaxPool.t
  | TFConst       of TFConst.t
  | TFPlaceholder of TFPlaceholder.t
  | TFAssign      of TFAssign.t
  | TFIdentity    of TFIdentity.t
  | TFSave        of TFSave.t
  | TFRestore     of TFRestore.t
  | TFVariable    of TFVariable.t
  | TFNoop        of TFNoop.t


let to_pbtxt = function
  | TFMatMul      n -> TFMatMul.to_pbtxt n
  | TFAdd         n -> TFAdd.to_pbtxt n
  | TFSub         n -> TFSub.to_pbtxt n
  | TFMul         n -> TFMul.to_pbtxt n
  | TFDiv         n -> TFDiv.to_pbtxt n
  | TFRelu        n -> TFRelu.to_pbtxt n
  | TFConv2D      n -> TFConv2D.to_pbtxt n
  | TFMaxPool     n -> TFMaxPool.to_pbtxt n
  | TFConst       n -> TFConst.to_pbtxt n
  | TFPlaceholder n -> TFPlaceholder.to_pbtxt n
  | TFAssign      n -> TFAssign.to_pbtxt n
  | TFIdentity    n -> TFIdentity.to_pbtxt n
  | TFSave        n -> TFSave.to_pbtxt n
  | TFRestore     n -> TFRestore.to_pbtxt n
  | TFVariable    n -> TFVariable.to_pbtxt n
  | TFNoop        n -> TFNoop.to_pbtxt n


let get_name = function
  | TFMatMul      n -> TFMatMul.get_name n
  | TFAdd         n -> TFAdd.get_name n
  | TFSub         n -> TFSub.get_name n
  | TFMul         n -> TFMul.get_name n
  | TFDiv         n -> TFDiv.get_name n
  | TFRelu        n -> TFRelu.get_name n
  | TFConv2D      n -> TFConv2D.get_name n
  | TFMaxPool     n -> TFMaxPool.get_name n
  | TFConst       n -> TFConst.get_name n
  | TFPlaceholder n -> TFPlaceholder.get_name n
  | TFAssign      n -> TFAssign.get_name n
  | TFIdentity    n -> TFIdentity.get_name n
  | TFSave        n -> TFSave.get_name n
  | TFRestore     n -> TFRestore.get_name n
  | TFVariable    n -> TFVariable.get_name n
  | TFNoop        n -> TFNoop.get_name n


let get_op_name = function
  | TFMatMul      _ -> TFMatMul.opname
  | TFAdd         _ -> TFAdd.opname
  | TFSub         _ -> TFSub.opname
  | TFMul         _ -> TFMul.opname
  | TFDiv         _ -> TFDiv.opname
  | TFRelu        _ -> TFRelu.opname
  | TFConv2D      _ -> TFConv2D.opname
  | TFMaxPool     _ -> TFMaxPool.opname
  | TFConst       _ -> TFConst.opname
  | TFPlaceholder _ -> TFPlaceholder.opname
  | TFAssign      _ -> TFAssign.opname
  | TFIdentity    _ -> TFIdentity.opname
  | TFSave        _ -> TFSave.opname
  | TFRestore     _ -> TFRestore.opname
  | TFVariable    _ -> TFVariable.opname
  | TFNoop        _ -> TFNoop.opname


let get_opdef = function
  | TFMatMul      _ -> TFMatMul.opdef
  | TFAdd         _ -> TFAdd.opdef
  | TFSub         _ -> TFSub.opdef
  | TFMul         _ -> TFMul.opdef
  | TFDiv         _ -> TFDiv.opdef
  | TFRelu        _ -> TFRelu.opdef
  | TFConv2D      _ -> TFConv2D.opdef
  | TFMaxPool     _ -> TFMaxPool.opdef
  | TFConst       _ -> TFConst.opdef
  | TFPlaceholder _ -> TFPlaceholder.opdef
  | TFAssign      _ -> TFAssign.opdef
  | TFIdentity    _ -> TFIdentity.opdef
  | TFSave        _ -> TFSave.opdef
  | TFRestore     _ -> TFRestore.opdef
  | TFVariable    _ -> TFVariable.opdef
  | TFNoop        _ -> TFNoop.opdef


let get_output_shape = function
  | TFMatMul      n -> TFMatMul.get_output_shape n
  | TFAdd         n -> TFAdd.get_output_shape n
  | TFSub         n -> TFSub.get_output_shape n
  | TFMul         n -> TFMul.get_output_shape n
  | TFDiv         n -> TFDiv.get_output_shape n
  | TFRelu        n -> TFRelu.get_output_shape n
  | TFConv2D      n -> TFConv2D.get_output_shape n
  | TFMaxPool     n -> TFMaxPool.get_output_shape n
  | TFConst       n -> TFConst.get_output_shape n
  | TFPlaceholder n -> TFPlaceholder.get_output_shape n
  | TFAssign      n -> TFAssign.get_output_shape n
  | TFIdentity    n -> TFIdentity.get_output_shape n
  | TFSave        n -> TFSave.get_output_shape n
  | TFRestore     n -> TFRestore.get_output_shape n
  | TFVariable    n -> TFVariable.get_output_shape n
  | TFNoop        n -> TFNoop.get_output_shape n


let get_inputs = function
  | TFMatMul      n -> TFMatMul.get_inputs n
  | TFAdd         n -> TFAdd.get_inputs n
  | TFSub         n -> TFSub.get_inputs n
  | TFMul         n -> TFMul.get_inputs n
  | TFDiv         n -> TFDiv.get_inputs n
  | TFRelu        n -> TFRelu.get_inputs n
  | TFConv2D      n -> TFConv2D.get_inputs n
  | TFMaxPool     n -> TFMaxPool.get_inputs n
  | TFConst       n -> TFConst.get_inputs n
  | TFPlaceholder n -> TFPlaceholder.get_inputs n
  | TFAssign      n -> TFAssign.get_inputs n
  | TFIdentity    n -> TFIdentity.get_inputs n
  | TFSave        n -> TFSave.get_inputs n
  | TFRestore     n -> TFRestore.get_inputs n
  | TFNoop        n -> TFNoop.get_inputs n
  | _               -> [||]


let set_inputs = function
  | TFMatMul      n -> TFMatMul.set_inputs n
  | TFAdd         n -> TFAdd.set_inputs n
  | TFSub         n -> TFSub.set_inputs n
  | TFMul         n -> TFMul.set_inputs n
  | TFDiv         n -> TFDiv.set_inputs n
  | TFRelu        n -> TFRelu.set_inputs n
  | TFConv2D      n -> TFConv2D.set_inputs n
  | TFMaxPool     n -> TFMaxPool.set_inputs n
  | TFConst       n -> TFConst.set_inputs n
  | TFPlaceholder n -> TFPlaceholder.set_inputs n
  | TFAssign      n -> TFAssign.set_inputs n
  | TFIdentity    n -> TFIdentity.set_inputs n
  | TFSave        n -> TFSave.set_inputs n
  | TFRestore     n -> TFRestore.set_inputs n
  | TFNoop        n -> TFNoop.set_inputs n
  | _               -> fun _ -> ()


let get_value = function
  | TFConst n -> TFConst.get_const_value n
  | _         -> failwith "unsupported operation"


let set_value = function
  | TFConst n -> TFConst.set_const_value n
  | _         -> failwith "unsupported operation"
