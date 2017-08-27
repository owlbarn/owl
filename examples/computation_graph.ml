#!/usr/bin/env owl
(* This example shows how to visualise the computation graph generated in
   Algodiff. To run this exmaple, you need to have Graphviz installed on your
   computer. Or you can use other visualisation tools for the generated dot file.
 *)

open Owl
open Algodiff.D


let f x y = Maths.((x * sin (x + x) + ( F 1. * sqrt x) / F 7.) * (relu y) |> sum)


let print_to_terminal () =
  let t = tag () in
  let x = make_reverse (F 5.) t in
  let y = make_reverse (Mat.uniform 3 4) t in
  let z = f x y in
  to_trace [z]


let print_to_dotfile () =
  let t = tag () in
  let x = make_reverse (F 5.) t in
  let y = make_reverse (Mat.uniform 3 4) t in
  let z = f x y in
  to_dot [z]


let _ =
  Log.info "write computation graph to terminal ...";
  print_to_terminal () |> print_endline;
  Log.info "write to dot file and visualise ...";
  print_to_dotfile () |> Owl_utils.write_file "plot_algodiff_graph.dot";
  Sys.command "dot -Tps plot_algodiff_graph.dot -o plot_algodiff_graph.ps"
