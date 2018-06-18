(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_generated


(** {6 Platform module} *)

module Platform : sig

  type info = {
    profile    : string;
    version    : string;
    name       : string;
    vendor     : string;
    extensions : string;
  }
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_platform_id -> info
  (** Get the information of a given object. *)

  val to_string : cl_platform_id -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val get_platforms : unit -> cl_platform_id array
  (** Get an array of all the available platforms. *)

end


(** {6 Device module} *)

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
    double_fp_config      : int;
    extensions            : string;
    parent_device         : cl_device_id;
    platform              : cl_platform_id;
  }
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_device_id -> info
  (** Get the information of a given object. *)

  val to_string : cl_device_id -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val get_devices : cl_platform_id -> cl_device_id array
  (** Get an array of all the available devices on a given platform. *)

end


(** {6 Context module} *)

module Context : sig

  type info = {
    reference_count : int;
    num_devices     : int;
    devices         : cl_device_id array;
  }
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_context -> info
  (** Get the information of a given object. *)

  val to_string : cl_context -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val create : ?properties:(int * int) list -> cl_device_id array -> cl_context
  (** Create an object with the passed in parameters. *)

  val create_from_type : ?properties:(int * int) list -> int -> cl_context
  (** Create a context from a given type. *)

  val retain : cl_context -> unit
  (** Retain a resource by increasing its reference number by 1. *)

  val release : cl_context -> unit
  (** Release a resource by decreasing its reference number by 1. *)

end


(** {6 Program module} *)

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
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_program -> info
  (** Get the information of a given object. *)

  val to_string : cl_program -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val create_with_source : cl_context -> string array -> cl_program
  (** Create a program from its source string. *)

  val build : ?options:string -> cl_program -> cl_device_id array -> unit
  (** Build a program for the passed-in devices with the given parameters. *)

  val retain : cl_program -> unit
  (** Retain a resource by increasing its reference number by 1. *)

  val release : cl_program -> unit
  (** Release a resource by decreasing its reference number by 1. *)

end


(** {6 Kernel module} *)

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
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_kernel -> info
  (** Get the information of a given object. *)

  val to_string : cl_kernel -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val create : cl_program -> string -> cl_kernel
  (** Create an object with the passed in parameters. *)

  val set_arg : cl_kernel -> int -> int -> 'a Ctypes.ptr -> unit
  (** Set the arguments of a given kernel. *)

  val enqueue_task : ?wait_for:cl_event list -> cl_command_queue -> cl_kernel -> cl_event
  (** Enqueue a task into the associate command queue of a given kernel. *)

  val enqueue_ndrange : ?wait_for:cl_event list -> ?global_work_ofs:int list -> ?local_work_size:int list -> cl_command_queue -> cl_kernel -> int -> int list -> cl_event
  (** Enqueue a ndrange task into the associate command queue of a given kernel. *)

  val retain : cl_kernel -> unit
  (** Retain a resource by increasing its reference number by 1. *)

  val release : cl_kernel -> unit
  (** Release a resource by decreasing its reference number by 1. *)

end


(** {6 CommandQueue module} *)

module CommandQueue : sig

  type info = {
    context          : cl_context;
    device           : cl_device_id;
    reference_count  : int;
    queue_properties : Unsigned.ULong.t;
  }
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_command_queue -> info
  (** Get the information of a given object. *)

  val to_string : cl_command_queue -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val create : ?properties:int list -> cl_context -> cl_device_id -> cl_command_queue
  (** Create an object with the passed in parameters. *)

  val barrier : ?wait_for:cl_event list -> cl_command_queue -> cl_event
  (** Barrier function of the given command queue. *)

  val marker : ?wait_for:cl_event list -> cl_command_queue -> cl_event
  (** Marker function of the given command queue. *)

  val flush : cl_command_queue -> unit
  (** Flush the given command queue. *)

  val finish : cl_command_queue -> unit
  (** Finish the given command queue. *)

  val retain : cl_command_queue -> unit
  (** Retain a resource by increasing its reference number by 1. *)

  val release : cl_command_queue -> unit
  (** Release a resource by decreasing its reference number by 1. *)

end


(** {6 Event module} *)

module Event : sig

  type info = {
    command_type             : int;
    reference_count          : int;
    command_execution_status : int;
    command_queue            : cl_command_queue;
    context                  : cl_context;
  }
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_event -> info
  (** Get the information of a given object. *)

  val to_string : cl_event -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val create : cl_context -> cl_event
  (** Create an object with the passed in parameters. *)

  val set_status : cl_event -> int -> unit
  (** Set the status of a given event. *)

  val wait_for : cl_event list -> int32
  (** Wait for a list of events to finish. *)

  val retain : cl_event -> unit
  (** Retain a resource by increasing its reference number by 1. *)

  val release : cl_event -> unit
  (** Release a resource by decreasing its reference number by 1. *)

end



(** {6 Buffer module} *)

module Buffer : sig

  type info = {
    typ             : int;
    size            : int;
    reference_count : int;
  }
  (** ``info`` type contains the basic information of the object. *)

  val get_info : cl_mem -> info
  (** Get the information of a given object. *)

  val to_string : cl_mem -> string
  (** Get the string representation of a given object, often contains the object's basic information. *)

  val create : ?flags:int list -> cl_context -> int -> unit Ctypes.ptr -> cl_mem
  (** Create an object with the passed in void pointer. *)

  val create_bigarray : ?flags:int list -> cl_context -> ('a, 'b) Owl_dense_ndarray_generic.t -> cl_mem
  (** Create an object with the passed in bigarray. Refer to ``create`` for a more general function. *)

  val enqueue_read : ?blocking:bool -> ?wait_for:cl_event list -> cl_command_queue -> cl_mem -> int -> int -> unit Ctypes.ptr -> cl_event
  (** Enqueue a read operation on the given memory object to a command queue. *)

  val enqueue_write : ?blocking:bool -> ?wait_for:cl_event list -> cl_command_queue -> cl_mem -> int -> int -> unit Ctypes.ptr -> cl_event
  (** Enqueue a write operation on the given memory object to a command queue. *)

  val enqueue_map : ?blocking:bool -> ?wait_for:Owl_opencl_generated.cl_event list -> ?flags:int list -> cl_command_queue -> cl_mem -> int -> int -> 'a -> cl_event * unit Ctypes.ptr
  (** Enqueue a map operation on the given memory object to a command queue. *)

  val enqueue_unmap : ?wait_for:cl_event list -> cl_command_queue -> cl_mem -> unit Ctypes.ptr -> cl_event
  (** Enqueue a unmap operation on the given memory object to a command queue. *)

  val retain : cl_mem -> unit
  (** Retain a resource by increasing its reference number by 1. *)

  val release : cl_mem -> unit
  (** Release a resource by decreasing its reference number by 1. *)

end
