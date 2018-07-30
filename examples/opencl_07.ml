#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl-opencl"
open Owl

module M = Owl_computation_opencl_engine.Make (Dense.Ndarray.S);;


let test_01 a =
  let x = M.var_elt "x" in
  let y = M.const_elt "y" 1. in
  M.assign_elt x a;
  let w = M.Scalar.sin x in
  let z = M.Scalar.add w y in
  M.eval_elt ~dev_id:1 [|z|];
  M.unpack_elt z


let _ =
  Owl_log.(set_level DEBUG);
  let a = 2. in
  let b = test_01 a in
  Owl_log.info "b = %g" b
