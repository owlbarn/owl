(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_opencl_base

open Owl_opencl_generated


type context = {
  context       : cl_context;
  program       : cl_program;
  command_queue : cl_command_queue;
}


(* let kernel_tbl = Hashtbl.create 512 *)

(* FIXME: hardcoded path *)
let compile_kernels () =
  let ctx = Context.create_from_type cl_DEVICE_TYPE_GPU in
  let gpu = Context.((get_info ctx).devices).(0) in
  let cmdq = CommandQueue.create ctx gpu in
  let prog_s = Owl.Utils.read_file_string "/Users/liang/code/owl/src/opencl/owl_opencl_kernel.cl" in
  let prog = Program.create_with_source ctx [|prog_s|] in
  Owl_opencl_base.Program.build prog [|gpu|];
  {
    context       = ctx;
    program       = prog;
    command_queue = cmdq;
  }


let default = compile_kernels ()


let mk_kernel
  : type a b. (a, b) kind -> string -> cl_program -> cl_kernel
  = fun kind fun_name program ->
  let kernel_name =
    match kind with
    | Float32 -> "owl_opencl_float32_" ^ fun_name
    | Float64 -> "owl_opencl_float64_" ^ fun_name
    | _       -> failwith "owl_opencl_context:mk_kernel"
  in
  Kernel.create program kernel_name


module Default = struct

  let init () = ()



end



(* end here *)
