(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_opencl_generated


(* This module is for OpenCL-based devices *)

module Make (A : Ndarray_Mutable) = struct

  module A = A

  type device = {
    device_type : device_type;
    initialised : bool;
  }

  type cpu_mem = A.arr

  type value = {
    mutable cpu_mem : cpu_mem array;
    mutable gpu_mem : cl_mem array;
    mutable kernel  : cl_kernel array;
    mutable events  : cl_event array;
  }


  let make_device () = {
    device_type = OpenCL;
    initialised = false;
  }


  let arr_to_value x =
    let cpu_mem = [| x |] in
    let gpu_mem = [| |] in
    let kernel  = [| |] in
    let events  = [| |] in
    { cpu_mem; gpu_mem; kernel; events }


  let value_to_arr x =
    if Array.length x.cpu_mem > 0 then
      x.cpu_mem.(0)
    else
      failwith "value_to_arr: not evaluated yet"


  let elt_to_value x =
    let cpu_mem = [| A.create [| |] x |] in
    let gpu_mem = [| |] in
    let kernel  = [| |] in
    let events  = [| |] in
    { cpu_mem; gpu_mem; kernel; events }


  let value_to_elt x =
    if Array.length x.cpu_mem > 0 then
      A.get x.cpu_mem.(0) [| |]
    else
      failwith "value_to_elt: not evaluated yet"


  let value_to_float x = A.elt_to_float (value_to_elt x)


  let make_value cpu_mem gpu_mem kernel events =
    { cpu_mem; gpu_mem; kernel; events }


  let refer_value x_val =
    let cpu_mem = Array.copy x_val.cpu_mem in
    let gpu_mem = Array.copy x_val.gpu_mem in
    let kernel = [| |] in
    let events = [| |] in
    make_value cpu_mem gpu_mem kernel events


  let get_events x_val = x_val.events


  let set_events x_val events = x_val.events <- events


  let reset_events x_val = x_val.events <- [||]


  let append_events x_val events =
    x_val.events <- Array.(append x_val.events events)


  let get_kernel x_val = x_val.kernel.(0)


  let set_kernel x_val kernel = x_val.kernel <- [| kernel |]


  let get_cpu_ptr x_val =
    let cpu_mem = value_to_arr x_val in
    Ctypes.(bigarray_start genarray (Obj.magic cpu_mem))
    |> Ctypes.to_voidp


  let get_gpu_ptr x_val =
    let gpu_mem = x_val.gpu_mem.(0) in
    Ctypes.allocate cl_mem gpu_mem


  let get_cpu_mem x_val = x_val.cpu_mem.(0)


  let get_gpu_mem x_val = x_val.gpu_mem.(0)


end
