(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
(* open Owl_converter_graph *)


let create () =
  {
    filename_tensor_name = "save";
    save_tensor_name = "control_dependency:0";
    restore_op_name = "restore_all";
    max_to_keep = 5;
    sharded = false;
    keep_checkpoint_every_n_hours = 10000.0
  }


(*
 * link it to saver node; create an assign node to tfgraph
 * and connect to this varv2, restorev2, and restore_all
 *)
let add_link _tfsaver _tfgraph _tfnode = ()


(*
 * add saver nodes to tfgraph:
 * saverv2 and three nodes; control_dep and const;
 * restore and three nodes;
 * a restore_all node;
 *)
let add_savernodes _tfsaver _tfgraph = ()


let to_string saver =
  Printf.sprintf "saver_def { %s }" saver.filename_tensor_name
