#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl-opencl"
open Owl

module M = Owl_computation_opencl_engine.Make (Dense.Ndarray.S)


let loop_gpu a =
  let x = M.var_arr "x" in
  M.assign_arr x a;
  let y = ref x in
  for i = 1 to 5000 do
    y := M.sin !y
  done;
  M.eval_arr ~dev_id:0 [|!y|];
  !y


let _ =
  let a = Dense.Ndarray.S.uniform [|2000; 2000|] in
  let f () = ignore @@ loop_gpu a in
  let t = Utils.time f in
  Owl_log.info "loop_gpu takes %g ms" t
