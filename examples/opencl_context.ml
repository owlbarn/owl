#!/usr/bin/env owl
(* This example demonstrates how to use Context module to run raw OpenCL code *)

#require "owl-opencl"
open Owl


(* example for ``f : arr -> unit`` *)
let run_raw_opencl_01 dev_id =
  let code = "
    __kernel void add_one(__global float *a) {
      int gid = get_global_id(0);
      a[gid] = a[gid] + 1;
    }
  "
  in
  Owl_opencl.Context.(add_kernels default [|code|]);
  let x = Dense.Ndarray.S.uniform [|20;10|] in
  Owl_opencl.Context.eval ~dev_id ~param:[|F32 x|] "add_one";
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x


(* example for ``f : arr -> arr -> unit`` *)
let run_raw_opencl_02 dev_id =
  let code = "
    __kernel void add_xy(__global float *a, __global float *b) {
      int gid = get_global_id(0);
      a[gid] = a[gid] + b[gid];
    }
  "
  in
  Owl_opencl.Context.(add_kernels default [|code|]);
  let x = Dense.Ndarray.S.uniform [|20;10|] in
  let y = Dense.Ndarray.S.sequential [|20;10|] in
  Owl_opencl.Context.eval ~dev_id ~param:[|F32 x; F32 y|] "add_xy";
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x


(* example for ``f : arr -> float -> unit`` *)
let run_raw_opencl_03 dev_id =
  let code = "
    __kernel void add_x_b(__global float *a, float b) {
      int gid = get_global_id(0);
      a[gid] = a[gid] + b;
    }
  "
  in
  Owl_opencl.Context.(add_kernels default [|code|]);
  let x = Dense.Ndarray.S.uniform [|20;10|] in
  Owl_opencl.Context.eval ~dev_id ~param:[|F32 x; F 5.|] "add_x_b";
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x


let _ =
  let dev_id = 0 in
  run_raw_opencl_01 dev_id;
  run_raw_opencl_02 dev_id;
  run_raw_opencl_03 dev_id
