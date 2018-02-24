#!/usr/bin/env owl
(* This example demonstrates how to use Context module to run raw OpenCL code *)

#require "owl_opencl"
open Owl


let run_raw_opencl_01 () =
  let code = "
    __kernel void add_one(__global float *a) {
      int gid = get_global_id(0);
      a[gid] = a[gid] + 1;
    }
  "
  in
  Owl_opencl.Context.(add_kernels default [|code|]);
  let x = Dense.Ndarray.S.uniform [|20;10|] in
  Owl_opencl.Context.eval ~param:[|F32 x|] "add_one";
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x


let run_raw_opencl_02 () =
  let code = "
    __kernel void add_scalar(__global float *a, float *b) {
      int gid = get_global_id(0);
      a[gid] = a[gid] + *b;
    }
  "
  in
  Owl_opencl.Context.(add_kernels default [|code|]);
  let x = Dense.Ndarray.S.uniform [|20;10|] in
  Owl_opencl.Context.eval ~param:[|F32 x; F 5.|] "add_scalar";
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x


let _ =
  run_raw_opencl_01 ();
  run_raw_opencl_0 ()
