#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl_opencl"
open Owl

let test_gpu x () =
  let x = Owl_opencl_dense.of_ndarray x in
  let x = Owl_opencl_dense.(mul x x |> sin |> cos |> tan |> neg) in
  let x = Owl_opencl_dense.to_ndarray float32 x in
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x

let test_cpu x () =
  ignore Dense.Ndarray.S.(mul x x |> sin |> cos |> tan |> neg)

let _ =
  let x = Dense.Ndarray.S.uniform [|1000; 1000|] in
  Printf.printf "\nGPU time: %.3f ms  " (Utils.time (test_gpu x));
  Printf.printf "\nCPU time: %.3f ms\n" (Utils.time (test_cpu x));
