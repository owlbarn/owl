#!/usr/bin/env owl
(* This example demonstrates the use of lazy evaluation in Owl *)

open Owl

module M = Lazy.Make (Owl_algodiff_primal_ops.D)


(* an example for lazy evaluation using computation graph *)
let lazy_eval x () =
  let a = M.var_arr "a" in
  let z = M.(add a a |> log |> sin |> neg |> cos |> abs |> sinh |> round |> atan) in
  M.assign_arr a x;
  M.eval_arr [| z |]


(* an example for eager evaluation *)
let eager_eval x () =
  ignore Arr.(add x x |> log |> sin |> neg |> cos |> abs |> sinh |> round |> atan)

(* test incremental computation by changing part of inputs *)
let incremental x =
  let a = M.var_arr "a" in
  let b = M.var_elt "b" in
  let c = M.(a |> sin |> cos |> abs |> log |> sum' |> mul_scalar a |> scalar_add b) in
  M.assign_arr a x;
  M.assign_elt b 5.;
  Printf.printf "Incremental#0:\t%.3f ms\n" (Utils.time (fun () -> M.eval_arr [| c |]));
  M.assign_elt b 6.;
  Printf.printf "Incremental#1:\t%.3f ms\n" (Utils.time (fun () -> M.eval_arr [| c |]));
  M.assign_elt b 7.;
  Printf.printf "Incremental#2:\t%.3f ms\n" (Utils.time (fun () -> M.eval_arr [| c |]))

(* generate computation graph, you need to install graphviz *)
let print_graph input =
  let x = M.var_arr "x" in
  let y = M.var_arr "y" in
  let z = M.(add x y |> dot x |> sin |> abs |> sum' |> add_scalar x |> log |> atan2 y |> neg |> relu) in
  print_endline "visualise computation graph to dot file ...";
  let inputs = [|M.arr_to_node x; M.arr_to_node y|] in
  let outputs = [|M.arr_to_node z|] in
  let graph = M.make_graph inputs  outputs "graph" in
  M.assign_arr x input;
  M.assign_arr y input;
  M.graph_to_dot graph |> Owl_io.write_file "plot_lazy.dot";
  Sys.command "dot -Tpdf plot_lazy.dot -o plot_lazy.pdf"


let _ =
  let x = Arr.uniform [|2000; 2000|] in
  Printf.printf "Lazy eval:\t%.3f ms\n" (Utils.time (lazy_eval x));
  Printf.printf "Eager eval:\t%.3f ms\n" (Utils.time (eager_eval x));
  incremental x;
  print_graph x
