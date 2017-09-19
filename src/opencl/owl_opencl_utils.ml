(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** This module contains constants and helper functions used in Owl OpenCL. *)

open Ctypes

open Owl_opencl_generated


(** constant definition *)

let magic_null = Obj.magic null

let uint32_0 = Unsigned.UInt32.zero

let uint32_1 = Unsigned.UInt32.one

let size_0 = Unsigned.Size_t.zero

let size_1 = Unsigned.Size_t.one

let intptr_0 = Intptr.zero

let intptr_1 = Intptr.one


(** coerce from type a to type b *)

let char_ptr_to_uint32_ptr x = coerce (ptr char) (ptr uint32_t) x

let char_ptr_to_size_t_ptr x = coerce (ptr char) (ptr size_t) x

let char_ptr_to_ulong_ptr x = coerce (ptr char) (ptr ulong) x

let char_ptr_to_cl_device_id_ptr x = coerce (ptr char) (ptr cl_device_id) x

let char_ptr_to_cl_platform_id_ptr x = coerce (ptr char) (ptr cl_platform_id) x

let cl_platform_id_to_intptr x =
  let _x = allocate cl_platform_id x in
  let _y = coerce (ptr cl_platform_id) (ptr intptr_t) _x in
  !@_y


(* ends here *)
