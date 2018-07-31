#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl-opencl"
open Owl

module M = Owl_computation_opencl_engine.Make (Dense.Ndarray.S);;


let test_01 a =
  let x = M.uniform [|100; 100|] in
  M.eval_arr ~dev_id:1 [|x|];
  M.unpack_arr x


let test_02 a =
  let x = M.uniform [|100; 100|] in
  let y = M.cos x in
  M.eval_arr ~dev_id:1 [|y|];
  M.unpack_arr y


let test_03 a =
  Owl_log.(set_level INFO);
  let x = M.uniform [|2000; 2000|] in
  let f () =
    M.(arr_to_node x |> invalidate);
    M.eval_arr ~dev_id:1 [|x|]
  in
  Owl_log.info "PRNG uniform ...";
  Owl_log.info "PRNG #1: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #2: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #3: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #4: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #5: %.g ms" (Utils.time f);
  M.unpack_arr x


let test_04 a =
  let a = Dense.Ndarray.S.sequential [|10; 10|] in
  let x = M.var_arr "x" in
  M.assign_arr x a;
  let y = M.min ~axis:1 x in
  M.eval_arr ~dev_id:1 [|y|];
  M.unpack_arr y


let test_05 a =
  Owl_log.(set_level INFO);
  let x = M.var_arr "x" in
  M.assign_arr x a;
  let y = M.sum ~axis:0 x in
  let f () =
    M.(arr_to_node y |> invalidate);
    M.eval_arr ~dev_id:1 [|y|]
  in
  Owl_log.info "PRNG #1: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #2: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #3: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #4: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #5: %.g ms" (Utils.time f);
  M.unpack_arr y


let test_06 a =
  Owl_log.(set_level INFO);
  let mu = M.const_elt "mu" 10. in
  let x = M.gaussian ~mu [|2000; 2000|] in
  let f () =
    M.(arr_to_node x |> invalidate);
    M.eval_arr ~dev_id:1 [|x|]
  in
  Owl_log.info "PRNG gaussian ...";
  Owl_log.info "PRNG #1: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #2: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #3: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #4: %.g ms" (Utils.time f);
  Owl_log.info "PRNG #5: %.g ms" (Utils.time f);
  M.unpack_arr x


let _ =
  Owl_log.(set_level DEBUG);
  let a = Dense.Ndarray.S.ones [|2000; 2000|] in
  let b = test_06 a in
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter b
