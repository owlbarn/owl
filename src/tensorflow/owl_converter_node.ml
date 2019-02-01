(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr

module U = Owl_converter_utils


type nodedef = {
  mutable name      : string;
  mutable op_name   : string;
  mutable input     : string array;
  mutable node_attr : (string * tfattrvalue) array;
  mutable device    : string
  (* mutable out_shp   : int array option; *)
}


let nodedef_to_pbtxt n =
  let attr_str = U.map_then_combine_string (fun (k, v) ->
    let value_str = tfattrvalue_to_string v in
    Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {%s}}\n" k value_str
  ) n.node_attr
  in
  let inputs_str = U.map_then_combine_string (fun v ->
    Printf.sprintf "input : %s\n" v
  ) n.input
  in
  Printf.sprintf "node {\nname: \"%s\"\nop: \"%s\"\n%s\n%s\n}\n"
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


let opdef_to_string op =
  let input_arg_arr = U.map_then_combine_string ~sep:"\n"
    (argdef_to_string "input_arg") op.input_arg in
  let output_arg_arr = U.map_then_combine_string ~sep:"\n"
    (argdef_to_string "output_arg") op.output_arg in
  let attr_string = U.map_then_combine_string ~sep:"\n"
    tfop_attr_to_string op.attr in
  Printf.sprintf "op {\nname: %s\n%s%s%s}\n" op.name
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
    make_opdef ~input_arg ~output_arg ~attr "MatMul"


  let create name inputs out_shp trans_a trans_b =
    {
      name    = name;
      op_name = "Matmul";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
    make_opdef ~input_arg ~output_arg ~attr "Add"


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Add";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
    make_opdef ~input_arg ~output_arg ~attr "Sub"


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Sub";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
    make_opdef ~input_arg ~output_arg ~attr "Mul"


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Mul";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
    make_opdef ~input_arg ~output_arg ~attr "Div"


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Div";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
    make_opdef ~output_arg ~attr "Const"


  let create name out_shp value =
    {
      name    = name;
      op_name = "Const";
      out_shp = out_shp;
      value   = value;
      dtype   = "DT_STRING"
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("value", n.value);
    |]
    in
    {
      name      = n.name;
      op_name   = n.op_name;
      input     = [||];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


  let get_inputs _n = [||]


  let set_inputs _n _i = ()

end



module TFPlaceholder = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


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
    make_opdef ~output_arg ~attr "Placeholder"


  let create name out_shp =
    {
      name    = name;
      op_name = "Placeholder";
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("shape", (ATTR_Shape n.out_shp));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    {
      name      = n.name;
      op_name   = n.op_name;
      input     = [||];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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


  (* To update *)
  let opdef = nil_def


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Relu";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
      op_name  = "Conv2D";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
      op_name  = "MaxPool";
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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


  let create name refv value out_shp dtype =
    {
      name           = name;
      op_name        = "Assign";
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
      op_name   = "Assign";
      input     = [|n.refv; n.value|];
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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


  let create name inputs dtype cls =
    {
      name    = name;
      op_name = "Identity";
      inputs  = inputs;
      out_shp = [||];
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
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = node_attr;
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFSave = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtype   : string;
  }


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
    make_opdef ~input_arg ~attr "SaveV2"


  let create ?(dtype="DT_STRING") name inputs =
    {
      name    = name;
      op_name = "SaveV2";
      inputs  = inputs;
      dtype   = dtype
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = [|("T", ATTR_Type n.dtype)|];
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


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
    make_opdef ~input_arg ~output_arg ~attr "RestoreV2"


  let create name inputs dtype =
    {
      name    = name;
      op_name = "RestoreV2";
      inputs  = inputs;
      dtype   = dtype
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = [|("T", ATTR_Type n.dtype)|];
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

end


module TFNoop = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
  }


  let opdef = make_opdef "NoOp"


  let create name inputs =
    {
      name    = name;
      op_name = "NoOp";
      inputs  = inputs;
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = n.op_name;
      input     = n.inputs;
      node_attr = [|("noop", ATTR_Nil)|];
      device    = "CPU:0"
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_op_name n = n.op_name


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i

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
  | TFNoop        n -> TFNoop.get_name n


let get_op_name = function
  | TFMatMul      n -> TFMatMul.get_op_name n
  | TFAdd         n -> TFAdd.get_op_name n
  | TFSub         n -> TFSub.get_op_name n
  | TFMul         n -> TFMul.get_op_name n
  | TFDiv         n -> TFDiv.get_op_name n
  | TFRelu        n -> TFRelu.get_op_name n
  | TFConv2D      n -> TFConv2D.get_op_name n
  | TFMaxPool     n -> TFMaxPool.get_op_name n
  | TFConst       n -> TFConst.get_op_name n
  | TFPlaceholder n -> TFPlaceholder.get_op_name n
  | TFAssign      n -> TFAssign.get_op_name n
  | TFIdentity    n -> TFIdentity.get_op_name n
  | TFSave        n -> TFSave.get_op_name n
  | TFRestore     n -> TFRestore.get_op_name n
  | TFNoop        n -> TFNoop.get_op_name n


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
  | TFNoop        _ -> TFNoop.opdef



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
