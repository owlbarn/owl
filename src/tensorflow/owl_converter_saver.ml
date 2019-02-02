(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_attr
open Owl_converter_node


(* Listed here only for setting some rules for naming; should not be exposed globally. *)
let ckpt_file_name = "owl_model"
let save_name = "save/SaveV2"
let restore_name = "save/RestoreV2"
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
      ~string_val:[|ckpt_file_name|] "DT_STRING" [||] in
    let save_const = TFConst (TFConst.create tfsaver.filename_tensor_name
      [|1|] (ATTR_Tensor filename_tensor_name))
    in

    let save_tensor_name = make_tftensor
      ~string_val:[|""|] "DT_STRING" [|1|] in
    let save_tensor_name = TFConst (TFConst.create save_tensor_names
      [|1|] (ATTR_Tensor save_tensor_name))
    in

    let save_shape = make_tftensor
      ~string_val:[|""|] "DT_STRING" [|1|] in
    let save_shape = TFConst (TFConst.create save_shape_slices
      [|1|] (ATTR_Tensor save_shape))
    in

    let save = TFSave (TFSave.create save_name
      [|(get_name save_const);
        (get_name save_tensor_name);
        (get_name save_shape)|])
    in
    let control_dep = TFIdentity (TFIdentity.create
      tfsaver.save_tensor_name
      [|(get_name save_const); ("^" ^ (get_name save))|]
      [||] (* tmp *)
      "DT_STRING"
      tfsaver.filename_tensor_name
    )
    in

    let restore_tensor_name = make_tftensor
      ~string_val:[|""|] "DT_STRING" [|1|] in
    let restore_tensor_name = TFConst (TFConst.create restore_tensor_names
      [|1|] (ATTR_Tensor restore_tensor_name))
    in

    let restore_shape = make_tftensor
      ~string_val:[|""|] "DT_STRING" [|1|] in
    let restore_shape = TFConst (TFConst.create restore_shape_slices
      [|1|] (ATTR_Tensor restore_shape))
    in

    let restore = TFRestore (TFRestore.create restore_name
      [|(get_name save_const);
        (get_name restore_tensor_name);
        (get_name restore_shape)|]
      "DT_FLOAT")
    in

    let restore_all = TFNoop (TFNoop.create tfsaver.restore_op_name [||]) in

    let nodes = [|
      save_const; save_tensor_name; save_shape; save; control_dep;
      restore_tensor_name; restore_shape; restore; restore_all
    |] in

    Array.iter (fun n ->
      TFgraph.add_tfnodes tfgraph [|n|] ("", "")
    ) nodes


  let add_link tfsaver tfgraph tfnode =
    (* note this name... you need different id *)
    let nname = get_name tfnode in
    let out_shp = get_output_shape tfnode in
    let name = nname ^ "/Assign" in
    let assign_node = TFAssign (TFAssign.create ~refv:nname
      ~value:restore_name name out_shp "DT_FLOAT")
    in

    let restore_all = TFgraph.get_tfnode tfgraph tfsaver.restore_op_name in
    let inp = get_inputs restore_all in
    set_inputs restore_all (Array.append inp [|("^" ^ name)|]);

    let snames = TFgraph.get_tfnode tfgraph save_tensor_names in
    let inp = get_inputs snames in
    set_inputs snames (Array.append inp [|name|]);

    let rnames = TFgraph.get_tfnode tfgraph restore_tensor_names in
    let inp = get_inputs rnames in
    set_inputs rnames (Array.append inp [|nname|]);

    TFgraph.add_tfnodes tfgraph [|assign_node|] ("", "")


  let to_pbtxt saver =
    let saver_str =
      (Printf.sprintf "filename_tensor_name : \"%s\"\n" saver.filename_tensor_name) ^
      (Printf.sprintf "save_tensor_name : \"%s\"\n" saver.save_tensor_name) ^
      (Printf.sprintf "restore_op_name : \"%s\"\n" saver.restore_op_name) ^
      (Printf.sprintf "max_to_keep : %d\n" saver.max_to_keep) ^
      (Printf.sprintf "sharded: %b\n" saver.sharded) ^
      (Printf.sprintf "keep_checkpoint_every_n_hours: %f\n" saver.keep_checkpoint_every_n_hours) ^
      (Printf.sprintf "version: V2\n")
    in
    Printf.sprintf "saver_def {\n%s}\n" saver_str

end
