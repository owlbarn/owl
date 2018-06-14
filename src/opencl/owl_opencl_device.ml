(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_opencl_generated


(* This module is for OpenCL-based devices *)

module Make (A : Ndarray_Basic) = struct


  type device = OpenCL

  type cpu_mem = ArrVal of A.arr | EltVal of A.elt

  type value = {
    mutable cpu_mem : cpu_mem array;
    mutable gpu_mem : cl_mem array;
    mutable kernel  : cl_kernel array;
    mutable events  : cl_event array;
  }


  let make_device () = OpenCL


  let make_value cpu_mem gpu_mem kernel events =
    { cpu_mem; gpu_mem; kernel; events }


  let copy_cpu_gpu_mem x_val =
    let cpu_mem = Array.copy x_val.cpu_mem in
    let gpu_mem = Array.copy x_val.gpu_mem in
    let kernel = [| |] in
    let events = [| |] in
    make_value cpu_mem gpu_mem kernel events


  let arr_to_value x =
    let cpu_mem = [| ArrVal x |] in
    let gpu_mem = [| |] in
    let kernel  = [| |] in
    let events  = [| |] in
    { cpu_mem; gpu_mem; kernel; events }


  let value_to_arr x =
    match x.cpu_mem.(0) with
    | ArrVal v -> v
    | _        -> failwith "value_to_arr: unsupported type"


  let elt_to_value x =
    let cpu_mem = [| EltVal x |] in
    let gpu_mem = [| |] in
    let kernel  = [| |] in
    let events  = [| |] in
    { cpu_mem; gpu_mem; kernel; events }


  let value_to_elt x =
    match x.cpu_mem.(0) with
    | EltVal v -> v
    | _        -> failwith "value_to_elt: unsupported type"


  let value_to_float x = A.elt_to_float (value_to_elt x)


  let set_events x_val events = x_val.events <- events


  let reset_events x_val = x_val.events <- [||]


  let append_events x_val events =
    x_val.events <- Array.(append x_val.events events)


end
