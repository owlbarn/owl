(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types


module OwlDot = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable trans_a : bool;
    mutable trans_b : bool;
    mutable dtype   : string;
  }


  let create name inputs out_shp trans_a trans_b =
    {
      name    = name;
      op_name = "Matmul";
      inputs  = inputs;
      out_shp = out_shp;
      trans_a = trans_a;
      trans_b = trans_b;
      dtype   = "DT_FLOAT" (* Data Type fixed to float; wrong *)
    }


  let make_tfnodes n =
    let node_attr = [|
      ("transpose_a", (ATTR_Bool n.trans_a));
      ("transpose_b", (ATTR_Bool n.trans_b));
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module OwlAddScalar = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Add";
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_tfnodes n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module OwlScalarMul = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Mul";
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_tfnodes n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]))
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module OwlOnes = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable shape   : int array;
    mutable dtype   : string;
  }


  let create name inputs out_shp shape =
    {
      name    = name;
      op_name = "Ones";
      inputs  = inputs;
      out_shp = out_shp;
      shape   = shape;
      dtype   = "DT_FLOAT"
    }


  let make_tfnodes n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("shape", (ATTR_Shape n.shape));
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module OwlConst = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable out_shp : int array;
    mutable value   : tfattrvalue;
    mutable dtype   : string;
  }


  let create name out_shp value =
    {
      name    = name;
      op_name = "Const";
      out_shp = out_shp;
      value   = value;
      dtype   = "DT_STRING"
    }


  let make_tfnodes n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("value", n.value);
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = [||];
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


(* Note: You DEFINITLY need to add more nodes and update the nodes
 * name in Var!!! Here is just a compilable template.
 *)
module OwlVar = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
  }


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "VariableV2";
      inputs  = inputs;
      out_shp = out_shp;
      dtype   = "DT_FLOAT"
    }


  let make_tfnodes n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end

(*
module Assign = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array option;
    mutable dtype   : string;

    mutable ref     : tensor;
    mutable value   : tensor;
    mutable use_locking : bool;
    mutable validate_shape : bool;
    mutable cls     : string;
  }

end
*)

module Identity = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array;
    mutable dtype   : string;
    mutable cls     : string;
  }


  let create name inputs dtype cls =
    {
      name    = name;
      op_name = "Identity";
      inputs  = inputs;
      out_shp = [||];
      dtype   = dtype;
      cls     = cls;
    }


  let make_tfnodes n =
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape n.out_shp)|]));
      ("_class", ATTR_List [|ATTR_String ("loc:@" ^ n.cls)|]);
    |] in
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = node_attr;
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module Save = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtype   : string;
  }


  let create ?(dtype="DT_STRING") name inputs =
    {
      name = name;
      op_name = "SaveV2";
      inputs = inputs;
      dtype = dtype
    }


  let make_tfnodes n =
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = [|("T", ATTR_Type n.dtype)|];
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module Restore = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable dtype   : string;
  }


  let create name inputs dtype =
    {
      name = name;
      op_name = "RestoreV2";
      inputs = inputs;
      dtype = dtype
    }


  let make_tfnodes n =
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = [|("T", ATTR_Type n.dtype)|];
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


module Noop = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
  }


  let create name inputs =
    {
      name = name;
      op_name = "NoOp";
      inputs = inputs;
    }


  let make_tfnodes n =
    let tfnode =
      {
        name      = n.name;
        op_name   = n.op_name;
        input     = n.inputs;
        node_attr = [|("noop", ATTR_Nil)|];
        device    = "CPU:0"
      }
    in
    ([|tfnode|], (n.name, n.name))


  let get_name n = n.name

end


type owl_node =
  | OwlDot       of OwlDot.node_typ
  | OwlAddScalar of OwlAddScalar.node_typ
  | OwlScalarMul of OwlScalarMul.node_typ
  | OwlOnes      of OwlOnes.node_typ
  | OwlConst     of OwlConst.node_typ
  | OwlVar       of OwlVar.node_typ
  (* | Assign       of Assign.node_typ *)
  | Identity     of Identity.node_typ
  | Save         of Save.node_typ
  | Restore      of Restore.node_typ
  | Noop         of Noop.node_typ


let make_tfnodes = function
  | OwlDot       n -> OwlDot.make_tfnodes n
  | OwlAddScalar n -> OwlAddScalar.make_tfnodes n
  | OwlScalarMul n -> OwlScalarMul.make_tfnodes n
  | OwlOnes      n -> OwlOnes.make_tfnodes n
  | OwlConst     n -> OwlConst.make_tfnodes n
  | OwlVar       n -> OwlVar.make_tfnodes n
  (* | Assign       n -> Assign.make_tfnodes n *)
  | Identity     n -> Identity.make_tfnodes n
  | Save         n -> Save.make_tfnodes n
  | Restore      n -> Restore.make_tfnodes n
  | Noop         n -> Noop.make_tfnodes n


let get_name = function
  | OwlDot       n -> OwlDot.get_name n
  | OwlAddScalar n -> OwlAddScalar.get_name n
  | OwlScalarMul n -> OwlScalarMul.get_name n
  | OwlOnes      n -> OwlOnes.get_name n
  | OwlConst     n -> OwlConst.get_name n
  | OwlVar       n -> OwlVar.get_name n
  (* | Assign       n -> Assign.get_name n *)
  | Identity     n -> Identity.get_name n
  | Save         n -> Save.get_name n
  | Restore      n -> Restore.get_name n
  | Noop         n -> Noop.get_name n


let update_name _n = ()


let update_inputs _n = ()


let update_attr _n = ()


let update_device _n = ()
