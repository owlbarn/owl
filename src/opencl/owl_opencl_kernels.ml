(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_opencl_base

open Owl_opencl_generated


type context = {
  context       : cl_context;
  program       : cl_program;
  command_queue : cl_command_queue;
}


(* let kernel_tbl = Hashtbl.create 512 *)

let compile_kernels () =
  let ctx = Context.create_from_type cl_DEVICE_TYPE_GPU in
  let gpu = Context.((get_info ctx).devices).(0) in
  let cmdq = CommandQueue.create ctx gpu in
  let prog_s = Owl.Utils.read_file_string "/Users/liang/code/owl/src/opencl/owl_opencl_kernels.cl" in
  let prog = Program.create_with_source ctx [|prog_s|] in
  Owl_opencl_base.Program.build prog [|gpu|];
  {
    context       = ctx;
    program       = prog;
    command_queue = cmdq;
  }


let default = compile_kernels ()


module Default = struct

  let init () = ()

  

end



(* end here *)
