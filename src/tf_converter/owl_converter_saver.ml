(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr
open Owl_converter_node

let ckpt_file_name = "owl_model"
let save_name = "save/SaveV2"
let restore_name = "save/SaveV2"
let save_tensor_names = "save/SaveV2/tensor_names"
let save_shape_slices = "save/SaveV2/shape_and_slices"
let restore_tensor_names = "save/RestoreV2/tensor_names"
let restore_shape_slices= "save/RestoreV2/shape_and_slices"

module Make
  (G : Owl_computation_graph_sig.Sig)
  = struct

  module TFgraph = Owl_converter_graph.Make (G)


  let create () =
    {
      filename_tensor_name = "save/Const";
      save_tensor_name = "save/control_dependency";
      restore_op_name = "save/restore_all";
      max_to_keep = 5;
      sharded = false;
      keep_checkpoint_every_n_hours = 10000.0
    }


  let add_savernodes tfsaver tfgraph =

    let filename_tensor_name = make_tftensor
      ~string_val:(Some ckpt_file_name) "DT_STRING" [|1|] in
    let save_const = OwlConst (OwlConst.create tfsaver.filename_tensor_name
      [|1|] (ATTR_Tensor filename_tensor_name))
    in

    let save_tensor_name = make_tftensor
      ~string_val:(Some "") "DT_STRING" [|1|] in
    let save_tensor_name = OwlConst (OwlConst.create save_tensor_names
      [|1|] (ATTR_Tensor save_tensor_name))
    in

    let save_shape = make_tftensor
      ~string_val:(Some "") "DT_STRING" [|1|] in
    let save_shape = OwlConst (OwlConst.create save_shape_slices
      [|1|] (ATTR_Tensor save_shape))
    in

    let save = Save (Save.create save_name
      [|(get_name save_const);
        (get_name save_tensor_name);
        (get_name save_shape)|])
    in
    let control_dep = Identity (Identity.create
      tfsaver.save_tensor_name
      [|(get_name save_const); ("^" ^ (get_name save))|]
      "DT_STRING"
      tfsaver.filename_tensor_name
    )
    in

    let restore_tensor_name = make_tftensor
      ~string_val:(Some "") "DT_STRING" [|1|] in
    let restore_tensor_name = OwlConst (OwlConst.create restore_tensor_names
      [|1|] (ATTR_Tensor restore_tensor_name))
    in

    let restore_shape = make_tftensor
      ~string_val:(Some "") "DT_STRING" [|1|] in
    let restore_shape = OwlConst (OwlConst.create restore_shape_slices
      [|1|] (ATTR_Tensor restore_shape))
    in

    let restore = Restore (Restore.create restore_name
      [|(get_name save_const);
        (get_name restore_tensor_name);
        (get_name restore_shape)|]
      "DT_FLOAT")
    in

    let restore_all = Noop (Noop.create tfsaver.restore_op_name [||]) in

    let nodes = [|
      save_const; save_tensor_name; save_shape; save; control_dep;
      restore_tensor_name; restore_shape; restore; restore_all
    |] in

    Array.iter (fun n ->
      let n, p = make_tfnodes n in
      TFgraph.add_tfnodes tfgraph n p
    ) nodes


  let add_link tfsaver tfgraph var_name =
    (* note this name... you need different id *)
    let name = var_name ^ "/Assign" in
    (* let out_shp = get_outputshape var_name ! *)
    let out_shp = [||] in
    let assign_node = Assign (Assign.create name var_name
      tfsaver.restore_op_name out_shp "DT_FLOAT")
    in

    let restore_all = TFgraph.get_tfnode tfgraph tfsaver.restore_op_name in
    let inp = TFgraph.get_tfnode_input restore_all in
    TFgraph.set_tfnode_input restore_all (Array.append inp [|name|]);

    let save = TFgraph.get_tfnode tfgraph save_name in
    let inp = TFgraph.get_tfnode_input save in
    TFgraph.set_tfnode_input save (Array.append inp [|var_name|]);

    let n, p = make_tfnodes assign_node in
    TFgraph.add_tfnodes tfgraph n p


  let to_string saver =
    let saver_str =
      (Printf.sprintf "filename_tensor_name : %s\n" saver.filename_tensor_name) ^
      (Printf.sprintf "save_tensor_name : %s\n" saver.save_tensor_name) ^
      (Printf.sprintf "restore_op_name : %s\n" saver.restore_op_name) ^
      (Printf.sprintf "max_to_keep : %d\n" saver.max_to_keep) ^
      (Printf.sprintf "sharded: %b\n" saver.sharded) ^
      (Printf.sprintf "keep_checkpoint_every_n_hours: %f\n" saver.keep_checkpoint_every_n_hours) ^
      (Printf.sprintf "version: V2\n")
    in
    Printf.sprintf "saver_def {\n%s}\n" saver_str


end
