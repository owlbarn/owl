#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl-opencl"
open Owl

module G = Owl_opencl_dense_ndarray_eager
module L = Owl_opencl_dense_ndarray


let loop_gpu x =
  let n = 1_000_000 in
  Log.info "gpu %i times ..." n;
  let f () =
    for i = 0 to n do
      G.sin x |> ignore;
      if i mod 1000 = 0 then (
        Log.info "gpu iter #%i ..." i;
        (* TODO: need a better way to release resource *)
        Gc.major ();
      )
    done;
  in
  Log.info "time used: %g ms" (Utils.time f)


let loop_cpu x =
  let n = 1_000_000 in
  Log.info "cpu %i times ..." n;
  let f () =
    for i = 0 to n do
      Dense.Ndarray.S.sin x |> ignore;
      if i mod 1000 = 0 then
        Log.info "cpu iter #%i ..." i;
    done;
  in
  Log.info "time used: %g ms" (Utils.time f)


let loop_lazy x =
  let n = 80_000 in
  Log.info "lazy gpu %i times ..." n;
  let y = ref (L.of_ndarray x) in
  for i = 0 to n do
    y := L.sin !y;
    if i mod 1000 = 0 then
      Log.info "lazy gpu iter #%i ..." i;
  done;
  let f () = L.to_ndarray Bigarray.float32 !y |> ignore in
  Log.info "time used: %g ms" (Utils.time f)


let _ =
  let x = Dense.Ndarray.S.uniform [|1000; 1000|] in
  loop_lazy x
