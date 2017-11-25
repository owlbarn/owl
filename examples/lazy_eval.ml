#!/usr/bin/env owl
(* This example demonstrates the use of lazy evaluation in Owl *)

open Owl

module M = Lazy.Make (Arr)

let test_lazy x () =
  let a = M.variable () in
  let z = M.(add a a |> log |> sin |> neg |> cos |> abs |> sinh |> round |> atan) in
  M.assign_arr a x;
  M.eval z

let test_eager x () =
  Arr.(add x x |> log |> sin |> neg |> cos |> abs |> sinh |> round |> atan)

let () =
  let x = Arr.uniform [|1000; 1000|] in
  Printf.printf "Lazy eval:  %.3f ms  " (Utils.time (test_lazy x));
  Printf.printf "\nEager eval: %.3f ms\n" (Utils.time (test_eager x));
