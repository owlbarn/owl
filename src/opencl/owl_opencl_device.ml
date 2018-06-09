(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* This module is for OpenCL-based devices *)

module Make (A : Ndarray_Basic) = struct


  type device = OpenCL

  type value = ArrVal of A.arr | EltVal of A.elt


  let make_device () = OpenCL


  let arr_to_value x = ArrVal x


  let value_to_arr = function
    | ArrVal x -> x
    | _        -> failwith "Owl_opencl_device: value_to_arr"


  let elt_to_value x = EltVal x


  let value_to_elt = function
    | EltVal x -> x
    | _        -> failwith "Owl_opencl_device: value_to_elt"


  let value_to_float x = A.elt_to_float (value_to_elt x)


end
