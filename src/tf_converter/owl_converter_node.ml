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
    mutable out_shp : int array option;
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
    let out_shp =
      match n.out_shp with
      | Some o -> o
      | None   -> [||]
    in
    let node_attr = [|
      ("transpose_a", (ATTR_Bool n.trans_a));
      ("transpose_b", (ATTR_Bool n.trans_b));
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape out_shp)|]))
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

end


module OwlAddScalar = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array option;
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
    let out_shp =
      match n.out_shp with
      | Some o -> o
      | None   -> [||]
    in
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape out_shp)|]))
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

end


module OwlScalarMul = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array option;
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
    let out_shp =
      match n.out_shp with
      | Some o -> o
      | None   -> [||]
    in
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape out_shp)|]))
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

end


module OwlOnes = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array option;
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
    let out_shp =
      match n.out_shp with
      | Some o -> o
      | None   -> [||]
    in
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape out_shp)|]));
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

end


module OwlConst = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array option;
    mutable value   : string; (* This should allow other types *)
    mutable dtype   : string;
  }


  let create name inputs out_shp =
    {
      name    = name;
      op_name = "Const";
      inputs  = inputs;
      out_shp = out_shp;
      value   = "dummy";
      dtype   = "DT_FLOAT"
    }


  let make_tfnodes n =
    let out_shp =
      match n.out_shp with
      | Some o -> o
      | None   -> [||]
    in
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape out_shp)|]));
      ("value", (ATTR_String n.value));
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

end


(* Note: You DEFINITLY need to add more nodes and update the nodes
 * name in Var!!! Here is just a compilable template.
 *)
module OwlVar = struct

  type node_typ = {
    mutable name    : string;
    mutable op_name : string;
    mutable inputs  : string array;
    mutable out_shp : int array option;
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
    let out_shp =
      match n.out_shp with
      | Some o -> o
      | None   -> [||]
    in
    let node_attr = [|
      ("T", (ATTR_Type n.dtype));
      ("_output_shape", (ATTR_List [|(ATTR_Shape out_shp)|]));
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

end


type owl_node =
  | OwlDot       of OwlDot.node_typ
  | OwlAddScalar of OwlAddScalar.node_typ
  | OwlScalarMul of OwlScalarMul.node_typ
  | OwlOnes      of OwlOnes.node_typ
  | OwlConst     of OwlConst.node_typ
  | OwlVar       of OwlVar.node_typ

  (*
  To add: Assign, SaverV2, RestoreV2, Identity, NoOp.
  *)


let make_tfnodes = function
  | OwlDot       n -> OwlDot.make_tfnodes n
  | OwlAddScalar n -> OwlAddScalar.make_tfnodes n
  | OwlScalarMul n -> OwlScalarMul.make_tfnodes n
  | OwlOnes      n -> OwlOnes.make_tfnodes n
  | OwlConst     n -> OwlConst.make_tfnodes n
  | OwlVar       n -> OwlVar.make_tfnodes n
