(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_generated

type num =
  | F of float
  | F32 of (float, Bigarray.float32_elt) Owl_dense_ndarray_generic.t
  | F64 of (float, Bigarray.float64_elt) Owl_dense_ndarray_generic.t

type t = {
  mutable device : cl_device_id array;
  mutable context : cl_context;
  mutable program : cl_program;
  mutable progsrc : string array;
  mutable command_queue : (cl_device_id, cl_command_queue) Hashtbl.t;
}

val default : t

val platforms : unit -> cl_platform_id array
val devices : unit -> cl_device_id array
val cpu_devices : unit -> cl_device_id array
val gpu_devices : unit -> cl_device_id array
val accelerators : unit -> cl_device_id array
val kernels : t -> string array
val add_kernels : t -> string array -> unit
val make_kernel : t -> string -> cl_kernel
val ba_kernel : ('a, 'b) Owl_sparse_ndarray_generic.kind -> string -> cl_program -> cl_kernel
val create : cl_device_id array -> string array -> t
val get_opencl_ctx : t -> cl_context
val get_program : t -> cl_program
val get_dev : t -> int -> cl_device_id
val get_cmdq : t -> cl_device_id -> cl_command_queue
val eval : ?param:num array -> ?ctx:t -> ?dev_id:int -> string -> unit
