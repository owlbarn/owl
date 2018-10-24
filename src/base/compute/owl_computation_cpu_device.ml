(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making CPU devices *)

module Make (A : Ndarray_Mutable) = struct

  module A = A

  type device = {
    device_type : device_type;
    initialised : bool;
  }

  type value = ArrVal of A.arr | EltVal of A.elt


  let make_device () = {
    device_type = CPU;
    initialised = false;
  }


  let arr_to_value x = ArrVal x


  let value_to_arr = function
    | ArrVal x -> x
    | _        -> failwith "Owl_computation_device: value_to_arr"


  let elt_to_value x = EltVal x


  let value_to_elt = function
    | EltVal x -> x
    | _        -> failwith "Owl_computation_device: value_to_elt"


  let value_to_float x = A.elt_to_float (value_to_elt x)


  let is_arr = function
    | ArrVal _ -> true
    | EltVal _ -> false


  let is_elt = function
    | ArrVal _ -> false
    | EltVal _ -> true


end
