(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_generated


(** {6 Platform definition} *)

module Platform : sig

  type info = {
    profile    : string;
    version    : string;
    name       : string;
    vendor     : string;
    extensions : string;
  }

  val get_info : cl_platform_id -> info

  val to_string : cl_platform_id -> string

  val get_platforms : unit -> cl_platform_id array

end


(** {6 Device definition} *)

module Device : sig

  type info = {
    name                  : string;
    profile               : string;
    vendor                : string;
    version               : string;
    driver_version        : string;
    opencl_c_version      : string;
    build_in_kernels      : string;
    typ                   : int;
    address_bits          : int;
    available             : bool;
    compiler_available    : bool;
    linker_available      : bool;
    global_mem_cache_size : int;
    global_mem_size       : int;
    max_clock_frequency   : int;
    max_compute_units     : int;
    max_work_group_size   : int;
    max_parameter_size    : int;
    max_samplers          : int;
    reference_count       : int;
    extensions            : string;
    parent_device         : cl_device_id;
    platform              : cl_platform_id;
  }

  val get_info : cl_device_id -> info

  val to_string : cl_device_id -> string

  val get_devices : cl_platform_id -> cl_device_id array

end


(** {6 Context definition} *)

module Context : sig

  type info = {
    reference_count : int;
    num_devices     : int;
    devices         : cl_device_id array;
  }

  val get_info : cl_context -> info

  val to_string : cl_context -> string

  val create : ?properties:(int * int) list -> cl_device_id array -> cl_context

  val create_from_type : ?properties:(int * int) list -> int -> cl_context

  val retain : cl_context -> unit

  val release : cl_context -> unit

end


(** {6 Program definition} *)

module Program : sig

  type info = {
    reference_count : int;
    context         : cl_context;
    num_devices     : int;
    devices         : cl_device_id array;
    source          : string;
    binary_sizes    : int array;
    binaries        : Cstubs_internals.voidp array;
    num_kernels     : int;
    kernel_names    : string array;
  }

  val get_info : cl_program -> info

  val to_string : cl_program -> string

  val create_with_source : cl_context -> string array -> cl_program

  val build : ?options:string -> cl_program -> cl_device_id array -> unit

  val retain : cl_program -> unit

  val release : cl_program -> unit

end


(** {6 Kernel definition} *)

module Kernel : sig

  type info = {
    function_name   : string;
    num_args        : int;
    attributes      : int;
    reference_count : int;
    context         : cl_context;
    program         : cl_program;
    work_group_size : (cl_device_id * int) array;
  }

  val get_info : cl_kernel -> info

  val to_string : cl_kernel -> string

  val create : cl_program -> string -> cl_kernel

  val set_arg : cl_kernel -> int -> int -> 'a Ctypes.ptr -> unit

  val enqueue_task : ?wait_for:cl_event list -> cl_command_queue -> cl_kernel -> cl_event

  val enqueue_ndrange : ?wait_for:cl_event list -> ?global_work_ofs:int list -> ?local_work_size:int list -> cl_command_queue -> cl_kernel -> int -> int list -> cl_event

  val retain : cl_kernel -> unit

  val release : cl_kernel -> unit

end


(** {6 CommandQueue definition} *)

module CommandQueue : sig

  type info = {
    context          : cl_context;
    device           : cl_device_id;
    reference_count  : int;
    queue_properties : Unsigned.ULong.t;
  }

  val get_info : cl_command_queue -> info

  val to_string : cl_command_queue -> string

  val create : ?properties:int list -> cl_context -> cl_device_id -> cl_command_queue

  val barrier : ?wait_for:cl_event list -> cl_command_queue -> cl_event

  val marker : ?wait_for:cl_event list -> cl_command_queue -> cl_event

  val flush : cl_command_queue -> unit

  val finish : cl_command_queue -> unit

  val retain : cl_command_queue -> unit

  val release : cl_command_queue -> unit

end


(** {6 Event definition} *)

module Event : sig

  type info = {
    command_type             : int;
    reference_count          : int;
    command_execution_status : int;
    command_queue            : cl_command_queue;
    context                  : cl_context;
  }

  val get_info : cl_event -> info

  val to_string : cl_event -> string

  val create : cl_context -> cl_event

  val set_status : cl_event -> int -> unit

  val wait_for : cl_event list -> int32

  val retain : cl_event -> unit

  val release : cl_event -> unit

end



(** {6 Buffer definition} *)

module Buffer : sig

  type info = {
    typ             : int;
    size            : int;
    reference_count : int;
  }

  val get_info : cl_mem -> info

  val to_string : cl_mem -> string

  val create : ?flags:int list -> cl_context -> ('a, 'b) Owl_dense_ndarray_generic.t -> cl_mem

  val enqueue_read : ?blocking:bool -> ?wait_for:cl_event list -> cl_command_queue -> cl_mem -> int -> int -> unit Ctypes.ptr -> cl_event

  val enqueue_write : ?blocking:bool -> ?wait_for:cl_event list -> cl_command_queue -> cl_mem -> int -> int -> unit Ctypes.ptr -> cl_event

  val enqueue_map : ?blocking:bool -> ?wait_for:Owl_opencl_generated.cl_event list -> ?flags:int list -> cl_command_queue -> cl_mem -> int -> int -> 'a -> cl_event * unit Ctypes.ptr

  val enqueue_unmap : ?wait_for:cl_event list -> cl_command_queue -> cl_mem -> unit Ctypes.ptr -> cl_event

  val retain : cl_mem -> unit

  val release : cl_mem -> unit

end
