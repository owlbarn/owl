#!/usr/bin/env owl
(* This example demonstrates the use of lazy evaluation in Owl *)

open Owl

module M = Lazy.Make (Arr)

let test_lazy x () =
  M.(add x x |> log |> sin |> neg |> cos |> abs |> sinh |> round)
  |> M.to_ndarray

let test_eager x () =
  Arr.(add x x |> log |> sin |> neg |> cos |> abs |> sinh |> round)

let () =
  let x = Arr.uniform [|1000; 1000|] in
  let y = Arr.copy x |> M.of_ndarray in
  Printf.printf "Lazy eval:  %.3f ms  " (Utils.time (test_lazy y));
  Printf.printf "\nEager eval: %.3f ms\n" (Utils.time (test_eager x));
