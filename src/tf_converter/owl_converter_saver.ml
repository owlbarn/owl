open Owl_converter_types


let create () = {
  filename_tensor_name = "save";
  save_tensor_name = "control_dependency:0";
  restore_op_name = "restore_all";
  max_to_keep = 5;
  sharded = false;
  keep_checkpoint_every_n_hours = 10000.0
}


let to_string saver =
  Printf.sprintf "saver_def { %s }" saver.filename_tensor_name
