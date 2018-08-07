(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_opencl_generated


module type Sig = sig


  module A : Owl_types_ndarray_mutable.Sig

  (** {6 Type definition} *)

  type device
  (** TODO *)

  type cpu_mem = A.arr
  (** TODO *)

  type value = {
    mutable cpu_mem : A.arr array;
    mutable gpu_mem : cl_mem array;
    mutable kernel  : cl_kernel array;
    mutable events  : cl_event array;
  }
  (** TODO *)


  (** {6 Core functions} *)

  val make_device : unit -> device
  (** TODO *)

  val arr_to_value : A.arr -> value
  (** TODO *)

  val value_to_arr : value -> A.arr
  (** TODO *)

  val elt_to_value : A.elt -> value
  (** TODO *)

  val value_to_elt : value -> A.elt
  (** TODO *)

  val value_to_float : value -> float
  (** TODO *)


  (** {6 OpenCL functions} *)

  val make_value : cpu_mem array -> cl_mem array -> cl_kernel array -> cl_event array -> value
  (** TODO *)

  val refer_value : value -> value
  (** TODO *)

  val get_events : value -> cl_event array
  (** TODO *)

  val set_events : value -> cl_event array -> unit
  (** TODO *)

  val reset_events : value -> unit
  (** TODO *)

  val append_events : value -> cl_event array -> unit
  (** TODO *)

  val get_kernel : value -> cl_kernel
  (** TODO *)

  val set_kernel : value -> cl_kernel -> unit
  (** TODO *)

  val get_cpu_ptr : value -> unit Ctypes.ptr
  (** TODO *)

  val get_gpu_ptr : value -> cl_mem Ctypes.ptr
  (** TODO *)

  val get_cpu_mem : value -> cpu_mem
  (** TODO *)

  val get_gpu_mem : value -> cl_mem
  (** TODO *)


end
