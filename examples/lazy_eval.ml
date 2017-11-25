#!/usr/bin/env owl
(* This example demonstrates the use of lazy evaluation in Owl *)

open Owl

module M = Lazy.Make (Arr)


let lazy_eval x () =
  let a = M.variable () in
  let z = M.(add a a |> log |> sin |> neg |> cos |> abs |> sinh |> round |> atan) in
  M.assign_arr a x;
  M.eval z


let eager_eval x () =
  Arr.(add x x |> log |> sin |> neg |> cos |> abs |> sinh |> round |> atan)


let incremental x =
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


let print_trace a =
  let x = M.variable () in
  let y = M.variable () in
  let z = M.(add x y |> sin |> abs |> log) in
  M.assign_arr x a;
  M.assign_arr y a;
  M.eval z;
  M.to_trace [z] |> print_endline


let () =
  let x = Arr.uniform [|2000; 2000|] in
  Printf.printf "Lazy eval:\t%.3f ms\n" (Utils.time (lazy_eval x));
  Printf.printf "Eager eval:\t%.3f ms\n" (Utils.time (eager_eval x));
  incremental x;
  print_trace x
