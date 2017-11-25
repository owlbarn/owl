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

let test_incremental x =
  let a = M.variable () in
  let b = M.variable () in
  let c = M.(a |> sin |> cos |> abs |> log |> sum' |> mul_scalar a |> scalar_add b) in
  M.assign_arr a x;
  M.assign_elt b 5.;
  Printf.printf "Incremental#0:\t%.3f ms\n" (Utils.time (fun () -> M.eval c));
  M.assign_elt b 6.;
  Printf.printf "Incremental#1:\t%.3f ms\n" (Utils.time (fun () -> M.eval c));
  M.assign_elt b 7.;
  Printf.printf "Incremental#2:\t%.3f ms\n" (Utils.time (fun () -> M.eval c))


let () =
  let x = Arr.uniform [|2000; 2000|] in
  Printf.printf "Lazy eval:\t%.3f ms\n" (Utils.time (test_lazy x));
  Printf.printf "Eager eval:\t%.3f ms\n" (Utils.time (test_eager x));
  test_incremental x
