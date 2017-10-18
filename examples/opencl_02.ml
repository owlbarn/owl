#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl_opencl"
open Owl

let test () =
  let x = Dense.Ndarray.S.uniform [|1000; 1000|] in
  let x = Owl_opencl_dense.of_ndarray x in
  let x = Owl_opencl_dense.(add x x |> sin |> cos |> sin |> neg) in
  let x = Owl_opencl_dense.to_ndarray float32 x in
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter x

let _ = Printf.printf "\nTime: %f ms\n" (Utils.time test)
