(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_opencl_generated


(** {6 Type definition} *)

type num =
  | F of float
  | F32 of (float, float32_elt) Owl_dense_ndarray_generic.t
  | F64 of (float, float64_elt) Owl_dense_ndarray_generic.t
(** Type of supported number types in the `param` of `eval` function. *)

type t = {
  mutable device : cl_device_id array;
  mutable context : cl_context;
  mutable program : cl_program;
  mutable progsrc : string array;
  mutable command_queue : (cl_device_id, cl_command_queue) Hashtbl.t;
}
(** Type of context. Note this is different from OpenCL's context object. *)

val default : t
(** Default context, with all GPU devices included and pre-compiled core kernels. *)


(** {6 Query platform} *)

val platforms : unit -> cl_platform_id array
(** List all the platforms on this computer. *)

val devices : unit -> cl_device_id array
(** List all the devices (including CPUs, GPUs, accelerators, etc.) on*)

val cpu_devices : unit -> cl_device_id array
(** List all the CPU devices on this computer. *)

val gpu_devices : unit -> cl_device_id array
(** List all the GPU devices on this computer. *)

val accelerators : unit -> cl_device_id array
(** List all the accelerators on this computer. *)


(** {6 Manipulate context} *)

val create : cl_device_id array -> string array -> t
(** Create a context with the given devices. The corresponding command queues are created and core kernels are compiled. *)

val get_opencl_ctx : t -> cl_context
(** Return the OpenCL context object. Note this is different from Owl's context. *)

val get_program : t -> cl_program
(** Return the program associated with the context. *)

val get_dev : t -> int -> cl_device_id
(** Return the ith device object associated with the context. *)

val get_cmdq : t -> cl_device_id -> cl_command_queue
(** Return the corresponding command queue object of the given device object and its associated with the context. *)


(** {6 Manipulate kernels} *)

val kernels : t -> string array
(** List all the installed kernels in the given context. *)

val add_kernels : t -> string array -> unit
(**
``add_kernels ctx code`` adds list of kernels to the existing context.
``src`` contains the source code of all the kernels. Note this function call
also causes all the existing kernels in the current context to be recompiled
with the passed in ones.
*)

val make_kernel : t -> string -> cl_kernel
(** ``make_kernel ctx fun_name`` makes a kernel object from passed in context with the given function name. *)

val ba_kernel : ('a, 'b) kind -> string -> cl_program -> cl_kernel
(** This function is similar to ``make_kernel`` but specifically for making Bigarray function. *)


(** {6 Evaluate kernels} *)

val eval : ?param:num array -> ?ctx:t -> ?dev_id:int -> ?work_dim:int -> ?work_size:int array -> string -> unit
(**
``eval fun_name`` evaluates a kernel function in the given context, by calling
``Kernel.enqueue_ndrange`` function.

Parameters:
  * ``param``: an arrray of ``num`` type elements which are passed into kernel function. Note the order of array elements is the same as the order of parameters of kernel function.
  * ``ctx``: the context for running the kernel function, ``default`` is used if this parameter is not specified.
  * ``dev_id``: the device that the kernel function will run on. The default value is ``0``.
  * ``work_dim``: The number of dimensions used to specify the global work-items and work-items in the work-group. work_dim must be greater than zero and less than or equal to three.
  * ``work_size``: Global work size, if not specified the number of elements of the first ndarray in ``param`` is used.
  * ``fun_name``: the name of the kernel function. It is either a function in the recompiled kernels, or those added by calling ``add_kernels`` function before.

Refer to the ``global_work_size`` in `OpenCL Document on clEnqueueNDRangeKernel <https://www.khronos.org/registry/OpenCL/sdk/1.0/docs/man/xhtml/clEnqueueNDRangeKernel.html>`_
 *)
