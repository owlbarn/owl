(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
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
    Owl_utils_array.to_string ~sep:"" (fun (k, v) ->
      let value_str = tfattrvalue_to_pbtxt v in
      Printf.sprintf "attr {\nkey: \"%s\"\nvalue: {\n%s}\n}\n" k value_str
    ) n.node_attr
  in

  let inputs_str =
    Owl_utils_array.to_string ~sep:"\n" (fun v ->
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
  let input_arg_arr = Owl_utils_array.to_string ~sep:""
    (argdef_to_pbtxt "input_arg") op.input_arg in
  let output_arg_arr = Owl_utils_array.to_string ~sep:""
    (argdef_to_pbtxt "output_arg") op.output_arg in
  let attr_string = Owl_utils_array.to_string ~sep:""
    tfop_attr_to_pbtxt op.attr in
  Printf.sprintf "op {\nname: \"%s\"\n%s%s%s}\n" op.name
    input_arg_arr output_arg_arr attr_string


module TFAbs = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Abs"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFNeg = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Neg"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFExp = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Exp"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFLog = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Log"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSquare = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Square"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSqrt = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Sqrt"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFRsqrt = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Rsqrt"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSin = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Sin"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFCos = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Cos"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFTan = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Tan"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSinh = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Sinh"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFCosh = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Cosh"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFTanh = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Tanh"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAsin = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Asin"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAcos = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Acos"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAtan = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "ATan"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAsinh = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Asinh"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAcosh = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Acosh"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAtanh = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Atanh"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSigmoid = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Sigmoid"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "x" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "y" |] in
    let attr = [| make_tfop_attr "T" "type" |] in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFMatMul = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable trans_a : bool;
    mutable trans_b : bool;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs out_shp trans_a trans_b =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      trans_a = trans_a;
      trans_b = trans_b;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("transpose_a", (ATTR_Bool n.trans_a));
      ("transpose_b", (ATTR_Bool n.trans_b));
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAdd = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device;
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSub = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      device  = device;
      dtype   = "DT_FLOAT";
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFMul = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      device  = device;
      dtype   = "DT_FLOAT";
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFDiv = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      device  = device;
      dtype   = "DT_FLOAT";
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFPow = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }

  let opname = "Pow"

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


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device;
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFMaximum = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }

  let opname = "Maximum"

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


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT";
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device;
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFConst = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable out_shp : int array;
    mutable value   : tfattrvalue;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(dtype="DT_STRING") ?(device="") name out_shp value =
    {
      name    = name;
      op_name = opname;
      out_shp = out_shp;
      value   = value;
      device  = device;
      dtype   = dtype;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("dtype", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("value", n.value);
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [||];
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let set_output_shape n s = n.out_shp <- s


  let get_inputs _n = [||]


  let set_inputs _n _i = ()


  (* NOTE: for now, we only need to get the "value" attribute of tfconst node;
   * to generalise it to all attributes of all nodes, though, it tricky.
   *)
  let get_const_value n = n.value


  let set_const_value n v = n.value <- v


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFPlaceholder = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name out_shp =
    {
      name    = name;
      op_name = opname;
      out_shp = out_shp;
      device  = device;
      dtype   = "DT_FLOAT";
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("dtype", (ATTR_Type n.dtype));
      ("shape", (ATTR_Shape n.out_shp));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [||];
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFRelu = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Relu"


  (* To update *)
  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "features";
    |]
    in
    let output_arg = [|
      make_argdef ~typ_attr:"T" "activations";
    |]
    in
    let attr = [|
      make_tfop_attr "T" "type";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", ATTR_Type "DT_FLOAT");
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFConv2D = struct

  type t = {
    mutable name        : string;
    mutable op_name     : string;
    mutable inputs      : string array;
    mutable out_shp     : int array;
    mutable strides     : int array;
    mutable padding     : string;
    mutable dilations   : int array;
    mutable data_format : string;
    mutable dtype       : string;
    mutable device      : string;
    mutable cls         : string array;
  }


  let opname = "Conv2D"


  (* To update *)
  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "input";
      make_argdef ~typ_attr:"T" "filter";
    |]
    in
    let output_arg = [|
      make_argdef ~typ_attr:"T" "output";
    |]
    in
    let attr = [|
      make_tfop_attr "T" "type";
      make_tfop_attr "strides" "list(int)";
      make_tfop_attr "padding" "string";
      make_tfop_attr "dilations" "list(int)";
      make_tfop_attr "data_format" "string";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp padding strides =
    let padding =
      match padding with
      | Owl_types_common.SAME  -> "SAME"
      | Owl_types_common.VALID -> "VALID"
    in
    {
      name        = name;
      op_name     = opname;
      inputs      = inputs;
      out_shp     = out_shp;
      strides     = strides;
      padding     = padding;
      dilations   = [|1;1;1;1|];
      data_format = "NHWC";
      dtype       = "DT_FLOAT";
      device      = device;
      cls         = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("strides", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.strides)));
      ("dilations", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.dilations)));
      ("padding", (ATTR_String n.padding));
      ("data_format", (ATTR_String n.data_format));
      ("T", (ATTR_Type "DT_FLOAT"));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

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
    mutable device   : string;
    mutable cls      : string array;
  }


  let opname = "MaxPool"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "input" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "T" "type";
      make_tfop_attr "strides" "list(int)";
      make_tfop_attr "ksize" "list(int)";
      make_tfop_attr "padding" "string";
      make_tfop_attr "data_format" "string";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp padding strides ksize =
    let padding =
      match padding with
      | Owl_types_common.SAME  -> "SAME"
      | Owl_types_common.VALID -> "VALID"
    in
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      strides = strides;
      padding = padding;
      ksize   = ksize;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("strides", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.strides)));
      ("ksize", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.ksize)));
      ("padding", (ATTR_String n.padding));
      ("T", (ATTR_Type "DT_FLOAT"));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFAvgPool = struct

  type t = {
    mutable name     : string;
    mutable op_name  : string;
    mutable inputs   : string array;
    mutable out_shp  : int array;
    mutable strides  : int array;
    mutable padding  : string;
    mutable ksize    : int array;
    mutable device   : string;
    mutable cls      : string array;
  }


  let opname = "AvgPool"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "input" |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "T" "type";
      make_tfop_attr "strides" "list(int)";
      make_tfop_attr "ksize" "list(int)";
      make_tfop_attr "padding" "string";
      make_tfop_attr "data_format" "string";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp padding strides ksize =
    let padding =
      match padding with
      | Owl_types_common.SAME  -> "SAME"
      | Owl_types_common.VALID -> "VALID"
    in
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      strides = strides;
      padding = padding;
      ksize   = ksize;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("strides", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.strides)));
      ("ksize", (ATTR_List (Array.map (fun n -> ATTR_Int n) n.ksize)));
      ("padding", (ATTR_String n.padding));
      ("T", (ATTR_Type "DT_FLOAT"));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

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
    mutable device         : string;
    mutable cls            : string array;
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


  let create ?(cls=[||]) ?(device="") ~refv ~value name out_shp dtype =
    {
      name           = name;
      op_name        = opname;
      out_shp        = out_shp;
      dtype          = dtype;
      refv           = refv;
      value          = value;
      use_locking    = true;
      validate_shape = true;
      device         = device;
      cls            = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      (* ("_class", (ATTR_List [|ATTR_String ("loc:@" ^ n.value)|])); *)
      ("use_locking", (ATTR_Bool n.use_locking));
      ("validate_shape", (ATTR_Bool n.validate_shape));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [|n.refv; n.value|];
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFIdentity = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs out_shp dtype =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = dtype;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_inputs n = n.inputs


  let get_output_shape n = n.out_shp


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSave = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtypes  : string array;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs dtypes =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      dtypes  = dtypes;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let dtypes = Array.map (fun x -> ATTR_Type x) n.dtypes in
    let node_attr = [|("dtypes", ATTR_List dtypes)|] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape _ = [||]


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d


  let get_dtypes n = n.dtypes


  let set_dtypes n t = n.dtypes <- t

end


module TFRestore = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtypes  : string array;
    mutable device  : string;
    mutable cls     : string array;
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


  let create ?(cls=[||]) ?(device="") name inputs dtypes =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      dtypes  = dtypes;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let dtypes = Array.map (fun x -> ATTR_Type x) n.dtypes in
    let node_attr = [|("dtypes", ATTR_List dtypes)|] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape _ = [||]


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d


  let get_dtypes n = n.dtypes


  let set_dtypes n t = n.dtypes <- t

end


module TFNoop = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable device  : string;
  }


  let opname = "NoOp"


  let opdef = make_opdef opname


  let create ?(device="") name inputs =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      device  = device;
    }


  let make_nodedef n =
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = [||];
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape _ = [||]


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

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
    mutable device         : string;
    mutable cls            : string array;
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


  let create ?(cls=[||]) ?(device="") name out_shp dtype =
    {
      name        = name;
      op_name     = opname;
      shape       = out_shp;
      dtype       = dtype;
      out_shp     = out_shp;
      container   = ""; (* tmp *)
      shared_name = ""; (* tmp *)
      device      = device;
      cls         = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("shape", (ATTR_Shape n.shape));
      ("dtype", (ATTR_Type n.dtype));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("container", (ATTR_String n.container));
      ("shared_name", (ATTR_String n.shared_name));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = [||];
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs _n = [||]


  let set_inputs _n _i = ()


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFSum = struct

  type t = {
    mutable name           : string;
    mutable op_name        : string;
    mutable inputs         : string array;
    mutable out_shp        : int array;
    mutable dtype          : string;
    mutable device         : string;
    mutable keepdims       : bool; (* keep_dims is deprecated *)
    mutable cls            : string array;
  }


  let opname = "Sum"


  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "input";
      make_argdef ~typ_attr:"Tidx" "reduction_indices"
    |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "keep_dims" "bool";
      make_tfop_attr "Tidx" "type";
      make_tfop_attr "T" "type";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(dtype="DT_FLOAT") ?(device="") ?(keepdims=true) name inputs out_shp =
    {
      name     = name;
      op_name  = opname;
      inputs   = inputs;
      out_shp  = out_shp;
      dtype    = dtype;
      device   = device;
      keepdims = keepdims;
      cls      = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type "DT_FLOAT"));
      ("Tidx", (ATTR_Type "DT_INT32"));
      ("keep_dims", (ATTR_Bool n.keepdims));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFMax = struct

  type t = {
    mutable name           : string;
    mutable op_name        : string;
    mutable inputs         : string array;
    mutable out_shp        : int array;
    mutable dtype          : string;
    mutable device         : string;
    mutable keepdims       : bool;
    mutable cls            : string array;
    (* NOTE: keep_dims is deprecated, so should be careful with versions *)
  }


  let opname = "Max"


  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "input";
      make_argdef ~typ_attr:"Tidx" "reduction_indices"
    |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "keep_dims" "bool";
      make_tfop_attr "Tidx" "type";
      make_tfop_attr "T" "type";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(dtype="DT_FLOAT") ?(device="") ?(keepdims=true) name inputs out_shp =
    {
      name     = name;
      op_name  = opname;
      inputs   = inputs;
      out_shp  = out_shp;
      dtype    = dtype;
      device   = device;
      keepdims = keepdims;
      cls      = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type "DT_FLOAT"));
      ("Tidx", (ATTR_Type "DT_INT32"));
      ("keep_dims", (ATTR_Bool n.keepdims));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFMin = struct

  type t = {
    mutable name           : string;
    mutable op_name        : string;
    mutable inputs         : string array;
    mutable out_shp        : int array;
    mutable dtype          : string;
    mutable device         : string;
    mutable keepdims       : bool;
    mutable cls            : string array;
    (* NOTE: keep_dims is deprecated, so should be careful with versions *)
  }


  let opname = "Min"


  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "input";
      make_argdef ~typ_attr:"Tidx" "reduction_indices"
    |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "keep_dims" "bool";
      make_tfop_attr "Tidx" "type";
      make_tfop_attr "T" "type";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(dtype="DT_FLOAT") ?(device="") ?(keepdims=true) name inputs out_shp =
    {
      name     = name;
      op_name  = opname;
      inputs   = inputs;
      out_shp  = out_shp;
      dtype    = dtype;
      device   = device;
      keepdims = keepdims;
      cls      = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type "DT_FLOAT"));
      ("Tidx", (ATTR_Type "DT_INT32"));
      ("keep_dims", (ATTR_Bool n.keepdims));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFPack = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable device  : string;
    mutable cls     : string array;
    mutable n       : int;
    mutable axis    : int;
  }


  (* Kepp the name to old version for now *)
  let opname = "Pack"


  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" ~num_attr:"N" "values";
    |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "T" "type";
      make_tfop_attr "N" "int"; (* N.minimum = 1 *)
      make_tfop_attr "axis" "int";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(device="") name inputs out_shp axis =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      device  = device;
      cls     = cls;
      n       = Array.length inputs;
      axis    = axis;
    }


    let make_nodedef n =
      let node_attr = [|
        ("N", (ATTR_Int n.n));
        ("T", (ATTR_Type "DT_FLOAT"));
        ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      |] in
      let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
      let node_attr = if (cls_attr = [||]) then node_attr else
        (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
      in
      {
        name      = n.name;
        op_name   = opname;
        input     = n.inputs;
        node_attr = node_attr;
        device    = n.device
      }


    let to_pbtxt n =
      make_nodedef n |> nodedef_to_pbtxt


    let get_name n = n.name


    let get_output_shape n = n.out_shp


    let get_inputs n = n.inputs


    let set_inputs n i = n.inputs <- i


    let get_device n = n.device


    let set_device n d = n.device <- d

end


(* OP: tf.Tensor.__getitem__. TO BE TESTED.*)
module TFStridedSlice = struct

  type t = {
    mutable name             : string;
    mutable op_name          : string;
    mutable inputs           : string array;
    mutable out_shp          : int array;
    mutable dtype            : string;
    mutable device           : string;
    mutable begin_mask       : int;
    mutable end_mask         : int;
    mutable ellipsis_mask    : int;
    mutable new_axis_mask    : int;
    mutable shrink_axis_mask : int;
    mutable cls              : string array;
  }


  let opname = "StridedSlice"


  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "input";
      make_argdef ~typ_attr:"Index" "begin";
      make_argdef ~typ_attr:"Index" "end";
      make_argdef ~typ_attr:"Index" "strides";
    |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "T" "type";
      make_tfop_attr "Index" "type";
      make_tfop_attr "begin_mask" "int";
      make_tfop_attr "end_mask" "int";
      make_tfop_attr "ellipsis_mask" "int";
      make_tfop_attr "new_axis_mask" "int";
      make_tfop_attr "shrink_axis_mask" "int";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(dtype="DT_FLOAT") ?(device="") name inputs out_shp bm em elm nam sam =
    {
      name             = name;
      op_name          = opname;
      inputs           = inputs;
      out_shp          = out_shp;
      dtype            = dtype;
      device           = device;
      begin_mask       = bm;
      end_mask         = em;
      ellipsis_mask    = elm;
      new_axis_mask    = nam;
      shrink_axis_mask = sam;
      cls              = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type "DT_FLOAT"));
      ("Index", (ATTR_Type "DT_INT32"));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("begin_mask", ATTR_Int n.begin_mask);
      ("end_mask", ATTR_Int n.end_mask);
      ("ellipsis_mask", ATTR_Int n.ellipsis_mask);
      ("new_axis_mask", ATTR_Int n.new_axis_mask);
      ("shrink_axis_mask", ATTR_Int n.shrink_axis_mask);
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFReshape = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable cls     : string array;
  }


  let opname = "Reshape"


  let opdef =
    let input_arg  = [|
      make_argdef ~typ_attr:"T" "tensor";
      make_argdef ~typ_attr:"Tshape" "shape";
    |] in
    let output_arg = [| make_argdef ~typ_attr:"T" "output" |] in
    let attr = [|
      make_tfop_attr "T" "type";
      make_tfop_attr "Tshape" "type";
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname


  let create ?(cls=[||]) ?(dtype="DT_FLOAT") ?(device="") name inputs out_shp =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = dtype;
      device  = device;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type "DT_FLOAT"));
      ("Tshape", (ATTR_Type "DT_INT32"));
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


module TFRandomUniform = struct

  type t = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable device  : string;
    mutable seed1   : int;
    mutable seed2   : int;
    mutable cls     : string array;
  }


  let opname = "RandomUniform"


  let opdef =
    let input_arg  = [| make_argdef ~typ_attr:"T" "shape"  |] in
    let output_arg = [| make_argdef ~typ_attr:"dtype" "output" |] in
    let attr = [|
      make_tfop_attr "seed" "int";
      make_tfop_attr "seed2" "int";
      make_tfop_attr "dtype" "type";
      make_tfop_attr "T" "type";
      (* is_stateful = true *)
    |]
    in
    make_opdef ~input_arg ~output_arg ~attr opname



  let create ?(cls=[||]) ?(dtype="DT_FLOAT") ?(device="") name inputs out_shp s1 s2 =
    {
      name    = name;
      op_name = opname;
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = dtype;
      device  = device;
      seed1   = s1;
      seed2   = s2;
      cls     = cls;
    }


  let make_nodedef n =
    let node_attr = [|
      ("T", (ATTR_Type "DT_INT32"));
      ("_class", (ATTR_List [| ATTR_String "loc@" |])); (* tmp *)
      ("_output_shapes", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("dtype", ATTR_Type n.dtype);
      ("seed", ATTR_Int n.seed1);
      ("seed2", ATTR_Int n.seed2);
    |] in
    let cls_attr = Array.map (fun c -> ATTR_String ("loc:@" ^ c)) n.cls in
    let node_attr = if (cls_attr = [||]) then node_attr else
      (Array.append node_attr [| ("_class", ATTR_List cls_attr) |])
    in
    {
      name      = n.name;
      op_name   = opname;
      input     = n.inputs;
      node_attr = node_attr;
      device    = n.device
    }


  let to_pbtxt n =
    make_nodedef n |> nodedef_to_pbtxt


  let get_name n = n.name


  let get_output_shape n = n.out_shp


  let get_inputs n = n.inputs


  let set_inputs n i = n.inputs <- i


  let get_device n = n.device


  let set_device n d = n.device <- d

end


type tfnode =
  | TFAbs           of TFAbs.t
  | TFNeg           of TFNeg.t
  | TFExp           of TFExp.t
  | TFLog           of TFLog.t
  | TFSquare        of TFSquare.t
  | TFSqrt          of TFSqrt.t
  | TFRsqrt         of TFRsqrt.t
  | TFSin           of TFSin.t
  | TFCos           of TFCos.t
  | TFTan           of TFTan.t
  | TFSinh          of TFSinh.t
  | TFCosh          of TFCosh.t
  | TFTanh          of TFTanh.t
  | TFAsin          of TFAsin.t
  | TFAcos          of TFAcos.t
  | TFAtan          of TFAtan.t
  | TFAsinh         of TFAsinh.t
  | TFAcosh         of TFAcosh.t
  | TFAtanh         of TFAtanh.t
  | TFSigmoid       of TFSigmoid.t
  | TFMatMul        of TFMatMul.t
  | TFAdd           of TFAdd.t
  | TFSub           of TFSub.t
  | TFMul           of TFMul.t
  | TFDiv           of TFDiv.t
  | TFPow           of TFPow.t
  | TFMaximum       of TFMaximum.t
  | TFRelu          of TFRelu.t
  | TFConv2D        of TFConv2D.t
  | TFMaxPool       of TFMaxPool.t
  | TFAvgPool       of TFAvgPool.t
  | TFConst         of TFConst.t
  | TFPlaceholder   of TFPlaceholder.t
  | TFAssign        of TFAssign.t
  | TFIdentity      of TFIdentity.t
  | TFSave          of TFSave.t
  | TFRestore       of TFRestore.t
  | TFVariable      of TFVariable.t
  | TFSum           of TFSum.t
  | TFMax           of TFMax.t
  | TFMin           of TFMin.t
  | TFPack          of TFPack.t
  | TFStridedSlice  of TFStridedSlice.t
  | TFReshape       of TFReshape.t
  | TFRandomUniform of TFRandomUniform.t
  | TFNoop          of TFNoop.t


let to_pbtxt = function
  | TFAbs           n -> TFAbs.to_pbtxt n
  | TFNeg           n -> TFNeg.to_pbtxt n
  | TFExp           n -> TFExp.to_pbtxt n
  | TFLog           n -> TFLog.to_pbtxt n
  | TFSquare        n -> TFSquare.to_pbtxt n
  | TFSqrt          n -> TFSqrt.to_pbtxt n
  | TFRsqrt         n -> TFRsqrt.to_pbtxt n
  | TFSin           n -> TFSin.to_pbtxt n
  | TFCos           n -> TFCos.to_pbtxt n
  | TFTan           n -> TFTan.to_pbtxt n
  | TFSinh          n -> TFSinh.to_pbtxt n
  | TFCosh          n -> TFCosh.to_pbtxt n
  | TFTanh          n -> TFTanh.to_pbtxt n
  | TFAsin          n -> TFAsin.to_pbtxt n
  | TFAcos          n -> TFAcos.to_pbtxt n
  | TFAtan          n -> TFAtan.to_pbtxt n
  | TFAsinh         n -> TFAsinh.to_pbtxt n
  | TFAcosh         n -> TFAcosh.to_pbtxt n
  | TFAtanh         n -> TFAtanh.to_pbtxt n
  | TFSigmoid       n -> TFSigmoid.to_pbtxt n
  | TFMatMul        n -> TFMatMul.to_pbtxt n
  | TFAdd           n -> TFAdd.to_pbtxt n
  | TFSub           n -> TFSub.to_pbtxt n
  | TFMul           n -> TFMul.to_pbtxt n
  | TFDiv           n -> TFDiv.to_pbtxt n
  | TFPow           n -> TFPow.to_pbtxt n
  | TFMaximum       n -> TFMaximum.to_pbtxt n
  | TFRelu          n -> TFRelu.to_pbtxt n
  | TFConv2D        n -> TFConv2D.to_pbtxt n
  | TFMaxPool       n -> TFMaxPool.to_pbtxt n
  | TFAvgPool       n -> TFAvgPool.to_pbtxt n
  | TFConst         n -> TFConst.to_pbtxt n
  | TFPlaceholder   n -> TFPlaceholder.to_pbtxt n
  | TFAssign        n -> TFAssign.to_pbtxt n
  | TFIdentity      n -> TFIdentity.to_pbtxt n
  | TFSave          n -> TFSave.to_pbtxt n
  | TFRestore       n -> TFRestore.to_pbtxt n
  | TFVariable      n -> TFVariable.to_pbtxt n
  | TFSum           n -> TFSum.to_pbtxt n
  | TFMax           n -> TFMax.to_pbtxt n
  | TFMin           n -> TFMin.to_pbtxt n
  | TFPack          n -> TFPack.to_pbtxt n
  | TFStridedSlice  n -> TFStridedSlice.to_pbtxt n
  | TFReshape       n -> TFReshape.to_pbtxt n
  | TFRandomUniform n -> TFRandomUniform.to_pbtxt n
  | TFNoop          n -> TFNoop.to_pbtxt n


let get_name = function
  | TFAbs           n -> TFAbs.get_name n
  | TFNeg           n -> TFNeg.get_name n
  | TFExp           n -> TFExp.get_name n
  | TFLog           n -> TFLog.get_name n
  | TFSquare        n -> TFSquare.get_name n
  | TFSqrt          n -> TFSqrt.get_name n
  | TFRsqrt         n -> TFRsqrt.get_name n
  | TFSin           n -> TFSin.get_name n
  | TFCos           n -> TFCos.get_name n
  | TFTan           n -> TFTan.get_name n
  | TFSinh          n -> TFSinh.get_name n
  | TFCosh          n -> TFCosh.get_name n
  | TFTanh          n -> TFTanh.get_name n
  | TFAsin          n -> TFAsin.get_name n
  | TFAcos          n -> TFAcos.get_name n
  | TFAtan          n -> TFAtan.get_name n
  | TFAsinh         n -> TFAsinh.get_name n
  | TFAcosh         n -> TFAcosh.get_name n
  | TFAtanh         n -> TFAtanh.get_name n
  | TFSigmoid       n -> TFSigmoid.get_name n
  | TFMatMul        n -> TFMatMul.get_name n
  | TFAdd           n -> TFAdd.get_name n
  | TFSub           n -> TFSub.get_name n
  | TFMul           n -> TFMul.get_name n
  | TFDiv           n -> TFDiv.get_name n
  | TFPow           n -> TFPow.get_name n
  | TFMaximum       n -> TFMaximum.get_name n
  | TFRelu          n -> TFRelu.get_name n
  | TFConv2D        n -> TFConv2D.get_name n
  | TFMaxPool       n -> TFMaxPool.get_name n
  | TFAvgPool       n -> TFAvgPool.get_name n
  | TFConst         n -> TFConst.get_name n
  | TFPlaceholder   n -> TFPlaceholder.get_name n
  | TFAssign        n -> TFAssign.get_name n
  | TFIdentity      n -> TFIdentity.get_name n
  | TFSave          n -> TFSave.get_name n
  | TFRestore       n -> TFRestore.get_name n
  | TFVariable      n -> TFVariable.get_name n
  | TFSum           n -> TFSum.get_name n
  | TFMax           n -> TFMax.get_name n
  | TFMin           n -> TFMin.get_name n
  | TFPack          n -> TFPack.get_name n
  | TFStridedSlice  n -> TFStridedSlice.get_name n
  | TFReshape       n -> TFReshape.get_name n
  | TFRandomUniform n -> TFRandomUniform.get_name n
  | TFNoop          n -> TFNoop.get_name n


let get_op_name = function
  | TFAbs           _ -> TFAbs.opname
  | TFNeg           _ -> TFNeg.opname
  | TFExp           _ -> TFExp.opname
  | TFLog           _ -> TFLog.opname
  | TFSquare        _ -> TFSquare.opname
  | TFSqrt          _ -> TFSqrt.opname
  | TFRsqrt         _ -> TFRsqrt.opname
  | TFSin           _ -> TFSin.opname
  | TFCos           _ -> TFCos.opname
  | TFTan           _ -> TFTan.opname
  | TFSinh          _ -> TFSinh.opname
  | TFCosh          _ -> TFCosh.opname
  | TFTanh          _ -> TFTanh.opname
  | TFAsin          _ -> TFAsin.opname
  | TFAcos          _ -> TFAcos.opname
  | TFAtan          _ -> TFAtan.opname
  | TFAsinh         _ -> TFAsinh.opname
  | TFAcosh         _ -> TFAcosh.opname
  | TFAtanh         _ -> TFAtanh.opname
  | TFSigmoid       _ -> TFSigmoid.opname
  | TFMatMul        _ -> TFMatMul.opname
  | TFAdd           _ -> TFAdd.opname
  | TFSub           _ -> TFSub.opname
  | TFMul           _ -> TFMul.opname
  | TFDiv           _ -> TFDiv.opname
  | TFPow           _ -> TFPow.opname
  | TFMaximum       _ -> TFMaximum.opname
  | TFRelu          _ -> TFRelu.opname
  | TFConv2D        _ -> TFConv2D.opname
  | TFMaxPool       _ -> TFMaxPool.opname
  | TFAvgPool       _ -> TFAvgPool.opname
  | TFConst         _ -> TFConst.opname
  | TFPlaceholder   _ -> TFPlaceholder.opname
  | TFAssign        _ -> TFAssign.opname
  | TFIdentity      _ -> TFIdentity.opname
  | TFSave          _ -> TFSave.opname
  | TFRestore       _ -> TFRestore.opname
  | TFVariable      _ -> TFVariable.opname
  | TFSum           _ -> TFSum.opname
  | TFMax           _ -> TFMax.opname
  | TFMin           _ -> TFMin.opname
  | TFPack          _ -> TFPack.opname
  | TFStridedSlice  _ -> TFStridedSlice.opname
  | TFReshape       _ -> TFReshape.opname
  | TFRandomUniform _ -> TFRandomUniform.opname
  | TFNoop          _ -> TFNoop.opname


let get_opdef = function
  | TFAbs           _ -> TFAbs.opdef
  | TFNeg           _ -> TFNeg.opdef
  | TFExp           _ -> TFExp.opdef
  | TFLog           _ -> TFLog.opdef
  | TFSquare        _ -> TFSquare.opdef
  | TFSqrt          _ -> TFSqrt.opdef
  | TFRsqrt         _ -> TFRsqrt.opdef
  | TFSin           _ -> TFSin.opdef
  | TFCos           _ -> TFCos.opdef
  | TFTan           _ -> TFTan.opdef
  | TFSinh          _ -> TFSinh.opdef
  | TFCosh          _ -> TFCosh.opdef
  | TFTanh          _ -> TFTanh.opdef
  | TFAsin          _ -> TFAsin.opdef
  | TFAcos          _ -> TFAcos.opdef
  | TFAtan          _ -> TFAtan.opdef
  | TFAsinh         _ -> TFAsinh.opdef
  | TFAcosh         _ -> TFAcosh.opdef
  | TFAtanh         _ -> TFAtanh.opdef
  | TFSigmoid       _ -> TFSigmoid.opdef
  | TFMatMul        _ -> TFMatMul.opdef
  | TFAdd           _ -> TFAdd.opdef
  | TFSub           _ -> TFSub.opdef
  | TFMul           _ -> TFMul.opdef
  | TFDiv           _ -> TFDiv.opdef
  | TFPow           _ -> TFPow.opdef
  | TFMaximum       _ -> TFMaximum.opdef
  | TFRelu          _ -> TFRelu.opdef
  | TFConv2D        _ -> TFConv2D.opdef
  | TFMaxPool       _ -> TFMaxPool.opdef
  | TFAvgPool       _ -> TFAvgPool.opdef
  | TFConst         _ -> TFConst.opdef
  | TFPlaceholder   _ -> TFPlaceholder.opdef
  | TFAssign        _ -> TFAssign.opdef
  | TFIdentity      _ -> TFIdentity.opdef
  | TFSave          _ -> TFSave.opdef
  | TFRestore       _ -> TFRestore.opdef
  | TFVariable      _ -> TFVariable.opdef
  | TFSum           _ -> TFSum.opdef
  | TFMax           _ -> TFMax.opdef
  | TFMin           _ -> TFMin.opdef
  | TFPack          _ -> TFPack.opdef
  | TFStridedSlice  _ -> TFStridedSlice.opdef
  | TFReshape       _ -> TFReshape.opdef
  | TFRandomUniform _ -> TFRandomUniform.opdef
  | TFNoop          _ -> TFNoop.opdef


let get_output_shape = function
  | TFAbs           n -> TFAbs.get_output_shape n
  | TFNeg           n -> TFNeg.get_output_shape n
  | TFExp           n -> TFExp.get_output_shape n
  | TFLog           n -> TFLog.get_output_shape n
  | TFSquare        n -> TFSquare.get_output_shape n
  | TFSqrt          n -> TFSqrt.get_output_shape n
  | TFRsqrt         n -> TFRsqrt.get_output_shape n
  | TFSin           n -> TFSin.get_output_shape n
  | TFCos           n -> TFCos.get_output_shape n
  | TFTan           n -> TFTan.get_output_shape n
  | TFSinh          n -> TFSinh.get_output_shape n
  | TFCosh          n -> TFCosh.get_output_shape n
  | TFTanh          n -> TFTanh.get_output_shape n
  | TFAsin          n -> TFAsin.get_output_shape n
  | TFAcos          n -> TFAcos.get_output_shape n
  | TFAtan          n -> TFAtan.get_output_shape n
  | TFAsinh         n -> TFAsinh.get_output_shape n
  | TFAcosh         n -> TFAcosh.get_output_shape n
  | TFAtanh         n -> TFAtanh.get_output_shape n
  | TFSigmoid       n -> TFSigmoid.get_output_shape n
  | TFMatMul        n -> TFMatMul.get_output_shape n
  | TFAdd           n -> TFAdd.get_output_shape n
  | TFSub           n -> TFSub.get_output_shape n
  | TFMul           n -> TFMul.get_output_shape n
  | TFDiv           n -> TFDiv.get_output_shape n
  | TFPow           n -> TFPow.get_output_shape n
  | TFMaximum       n -> TFMaximum.get_output_shape n
  | TFRelu          n -> TFRelu.get_output_shape n
  | TFConv2D        n -> TFConv2D.get_output_shape n
  | TFMaxPool       n -> TFMaxPool.get_output_shape n
  | TFAvgPool       n -> TFAvgPool.get_output_shape n
  | TFConst         n -> TFConst.get_output_shape n
  | TFPlaceholder   n -> TFPlaceholder.get_output_shape n
  | TFAssign        n -> TFAssign.get_output_shape n
  | TFIdentity      n -> TFIdentity.get_output_shape n
  | TFSave          n -> TFSave.get_output_shape n
  | TFRestore       n -> TFRestore.get_output_shape n
  | TFVariable      n -> TFVariable.get_output_shape n
  | TFSum           n -> TFSum.get_output_shape n
  | TFMax           n -> TFMax.get_output_shape n
  | TFMin           n -> TFMin.get_output_shape n
  | TFPack          n -> TFPack.get_output_shape n
  | TFStridedSlice  n -> TFStridedSlice.get_output_shape n
  | TFReshape       n -> TFReshape.get_output_shape n
  | TFRandomUniform n -> TFRandomUniform.get_output_shape n
  | TFNoop          n -> TFNoop.get_output_shape n


let set_output_shape = function
  | TFConst         n -> TFConst.set_output_shape n
  | _                 -> failwith "unsupported operation: set_output_shape"


let get_inputs = function
  | TFAbs           n -> TFAbs.get_inputs n
  | TFNeg           n -> TFNeg.get_inputs n
  | TFExp           n -> TFExp.get_inputs n
  | TFLog           n -> TFLog.get_inputs n
  | TFSquare        n -> TFSquare.get_inputs n
  | TFSqrt          n -> TFSqrt.get_inputs n
  | TFRsqrt         n -> TFRsqrt.get_inputs n
  | TFSin           n -> TFSin.get_inputs n
  | TFCos           n -> TFCos.get_inputs n
  | TFTan           n -> TFTan.get_inputs n
  | TFSinh          n -> TFSinh.get_inputs n
  | TFCosh          n -> TFCosh.get_inputs n
  | TFTanh          n -> TFTanh.get_inputs n
  | TFAsin          n -> TFAsin.get_inputs n
  | TFAcos          n -> TFAcos.get_inputs n
  | TFAtan          n -> TFAtan.get_inputs n
  | TFAsinh         n -> TFAsinh.get_inputs n
  | TFAcosh         n -> TFAcosh.get_inputs n
  | TFAtanh         n -> TFAtanh.get_inputs n
  | TFSigmoid       n -> TFSigmoid.get_inputs n
  | TFMatMul        n -> TFMatMul.get_inputs n
  | TFAdd           n -> TFAdd.get_inputs n
  | TFSub           n -> TFSub.get_inputs n
  | TFMul           n -> TFMul.get_inputs n
  | TFDiv           n -> TFDiv.get_inputs n
  | TFPow           n -> TFPow.get_inputs n
  | TFMaximum       n -> TFMaximum.get_inputs n
  | TFRelu          n -> TFRelu.get_inputs n
  | TFConv2D        n -> TFConv2D.get_inputs n
  | TFMaxPool       n -> TFMaxPool.get_inputs n
  | TFAvgPool       n -> TFAvgPool.get_inputs n
  | TFConst         n -> TFConst.get_inputs n
  | TFPlaceholder   n -> TFPlaceholder.get_inputs n
  | TFAssign        n -> TFAssign.get_inputs n
  | TFIdentity      n -> TFIdentity.get_inputs n
  | TFSave          n -> TFSave.get_inputs n
  | TFRestore       n -> TFRestore.get_inputs n
  | TFNoop          n -> TFNoop.get_inputs n
  | TFSum           n -> TFSum.get_inputs n
  | TFMax           n -> TFMax.get_inputs n
  | TFMin           n -> TFMin.get_inputs n
  | TFPack          n -> TFPack.get_inputs n
  | TFStridedSlice  n -> TFStridedSlice.get_inputs n
  | TFReshape       n -> TFReshape.get_inputs n
  | TFRandomUniform n -> TFRandomUniform.get_inputs n
  | _                 -> [||]


let set_inputs = function
  | TFAbs           n -> TFAbs.set_inputs n
  | TFNeg           n -> TFNeg.set_inputs n
  | TFExp           n -> TFExp.set_inputs n
  | TFLog           n -> TFLog.set_inputs n
  | TFSquare        n -> TFSquare.set_inputs n
  | TFSqrt          n -> TFSqrt.set_inputs n
  | TFRsqrt         n -> TFRsqrt.set_inputs n
  | TFSin           n -> TFSin.set_inputs n
  | TFCos           n -> TFCos.set_inputs n
  | TFTan           n -> TFTan.set_inputs n
  | TFSinh          n -> TFSinh.set_inputs n
  | TFCosh          n -> TFCosh.set_inputs n
  | TFTanh          n -> TFTanh.set_inputs n
  | TFAsin          n -> TFAsin.set_inputs n
  | TFAcos          n -> TFAcos.set_inputs n
  | TFAtan          n -> TFAtan.set_inputs n
  | TFAsinh         n -> TFAsinh.set_inputs n
  | TFAcosh         n -> TFAcosh.set_inputs n
  | TFAtanh         n -> TFAtanh.set_inputs n
  | TFSigmoid       n -> TFSigmoid.set_inputs n
  | TFMatMul        n -> TFMatMul.set_inputs n
  | TFAdd           n -> TFAdd.set_inputs n
  | TFSub           n -> TFSub.set_inputs n
  | TFMul           n -> TFMul.set_inputs n
  | TFDiv           n -> TFDiv.set_inputs n
  | TFPow           n -> TFPow.set_inputs n
  | TFMaximum       n -> TFMaximum.set_inputs n
  | TFRelu          n -> TFRelu.set_inputs n
  | TFConv2D        n -> TFConv2D.set_inputs n
  | TFMaxPool       n -> TFMaxPool.set_inputs n
  | TFAvgPool       n -> TFAvgPool.set_inputs n
  | TFConst         n -> TFConst.set_inputs n
  | TFPlaceholder   n -> TFPlaceholder.set_inputs n
  | TFAssign        n -> TFAssign.set_inputs n
  | TFIdentity      n -> TFIdentity.set_inputs n
  | TFSave          n -> TFSave.set_inputs n
  | TFRestore       n -> TFRestore.set_inputs n
  | TFNoop          n -> TFNoop.set_inputs n
  | TFSum           n -> TFSum.set_inputs n
  | TFMax           n -> TFMax.set_inputs n
  | TFMin           n -> TFMin.set_inputs n
  | TFPack          n -> TFPack.set_inputs n
  | TFStridedSlice  n -> TFStridedSlice.set_inputs n
  | TFReshape       n -> TFReshape.set_inputs n
  | TFRandomUniform n -> TFRandomUniform.set_inputs n
  | _                 -> fun _ -> ()


let get_device = function
  | TFAbs           n -> TFAbs.get_device n
  | TFNeg           n -> TFNeg.get_device n
  | TFExp           n -> TFExp.get_device n
  | TFLog           n -> TFLog.get_device n
  | TFSquare        n -> TFSquare.get_device n
  | TFSqrt          n -> TFSqrt.get_device n
  | TFRsqrt         n -> TFRsqrt.get_device n
  | TFSin           n -> TFSin.get_device n
  | TFCos           n -> TFCos.get_device n
  | TFTan           n -> TFTan.get_device n
  | TFSinh          n -> TFSinh.get_device n
  | TFCosh          n -> TFCosh.get_device n
  | TFTanh          n -> TFTanh.get_device n
  | TFAsin          n -> TFAsin.get_device n
  | TFAcos          n -> TFAcos.get_device n
  | TFAtan          n -> TFAtan.get_device n
  | TFAsinh         n -> TFAsinh.get_device n
  | TFAcosh         n -> TFAcosh.get_device n
  | TFAtanh         n -> TFAtanh.get_device n
  | TFSigmoid       n -> TFSigmoid.get_device n
  | TFMatMul        n -> TFMatMul.get_device n
  | TFAdd           n -> TFAdd.get_device n
  | TFSub           n -> TFSub.get_device n
  | TFMul           n -> TFMul.get_device n
  | TFDiv           n -> TFDiv.get_device n
  | TFPow           n -> TFPow.get_device n
  | TFMaximum       n -> TFMaximum.get_device n
  | TFRelu          n -> TFRelu.get_device n
  | TFConv2D        n -> TFConv2D.get_device n
  | TFMaxPool       n -> TFMaxPool.get_device n
  | TFAvgPool       n -> TFAvgPool.get_device n
  | TFConst         n -> TFConst.get_device n
  | TFPlaceholder   n -> TFPlaceholder.get_device n
  | TFAssign        n -> TFAssign.get_device n
  | TFIdentity      n -> TFIdentity.get_device n
  | TFSave          n -> TFSave.get_device n
  | TFRestore       n -> TFRestore.get_device n
  | TFVariable      n -> TFVariable.get_device n
  | TFSum           n -> TFSum.get_device n
  | TFMax           n -> TFMax.get_device n
  | TFMin           n -> TFMin.get_device n
  | TFPack          n -> TFPack.get_device n
  | TFStridedSlice  n -> TFStridedSlice.get_device n
  | TFReshape       n -> TFReshape.get_device n
  | TFRandomUniform n -> TFRandomUniform.get_device n
  | TFNoop          n -> TFNoop.get_device n


let set_device = function
  | TFAbs           n -> TFAbs.set_device n
  | TFNeg           n -> TFNeg.set_device n
  | TFExp           n -> TFExp.set_device n
  | TFLog           n -> TFLog.set_device n
  | TFSquare        n -> TFSquare.set_device n
  | TFSqrt          n -> TFSqrt.set_device n
  | TFRsqrt         n -> TFRsqrt.set_device n
  | TFSin           n -> TFSin.set_device n
  | TFCos           n -> TFCos.set_device n
  | TFTan           n -> TFTan.set_device n
  | TFSinh          n -> TFSinh.set_device n
  | TFCosh          n -> TFCosh.set_device n
  | TFTanh          n -> TFTanh.set_device n
  | TFAsin          n -> TFAsin.set_device n
  | TFAcos          n -> TFAcos.set_device n
  | TFAtan          n -> TFAtan.set_device n
  | TFAsinh         n -> TFAsinh.set_device n
  | TFAcosh         n -> TFAcosh.set_device n
  | TFAtanh         n -> TFAtanh.set_device n
  | TFSigmoid       n -> TFSigmoid.set_device n
  | TFMatMul        n -> TFMatMul.set_device n
  | TFAdd           n -> TFAdd.set_device n
  | TFSub           n -> TFSub.set_device n
  | TFMul           n -> TFMul.set_device n
  | TFDiv           n -> TFDiv.set_device n
  | TFPow           n -> TFPow.set_device n
  | TFMaximum       n -> TFMaximum.set_device n
  | TFRelu          n -> TFRelu.set_device n
  | TFConv2D        n -> TFConv2D.set_device n
  | TFMaxPool       n -> TFMaxPool.set_device n
  | TFAvgPool       n -> TFAvgPool.set_device n
  | TFConst         n -> TFConst.set_device n
  | TFPlaceholder   n -> TFPlaceholder.set_device n
  | TFAssign        n -> TFAssign.set_device n
  | TFIdentity      n -> TFIdentity.set_device n
  | TFSave          n -> TFSave.set_device n
  | TFRestore       n -> TFRestore.set_device n
  | TFVariable      n -> TFVariable.set_device n
  | TFSum           n -> TFSum.set_device n
  | TFMax           n -> TFMax.set_device n
  | TFMin           n -> TFMin.set_device n
  | TFPack          n -> TFPack.set_device n
  | TFStridedSlice  n -> TFStridedSlice.set_device  n
  | TFReshape       n -> TFReshape.set_device n
  | TFRandomUniform n -> TFRandomUniform.set_device n
  | TFNoop          n -> TFNoop.set_device n


let get_value = function
  | TFConst n -> TFConst.get_const_value n
  | _         -> failwith "unsupported operation: get_value"


let set_value = function
  | TFConst n -> TFConst.set_const_value n
  | _         -> failwith "unsupported operation: set_value"


let get_dtypes = function
  | TFSave    n -> TFSave.get_dtypes n
  | TFRestore n -> TFRestore.get_dtypes n
  | _           -> failwith "unsupported operation: get_dtypes"


let set_dtypes = function
  | TFSave    n -> TFSave.set_dtypes n
  | TFRestore n -> TFRestore.set_dtypes n
  | _           -> failwith "unsupported operation: set_dtypes"
