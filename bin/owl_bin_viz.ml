(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

open Owl_computation


(* FIXME: This is a hack at the moment *)
module CGraph = Owl_computation_graph.Make (Dense.Ndarray.S) (Owl_computation_device)


let print_help () =
  let info = Printf.sprintf "
Owl's Computation Graph Visualiser

Usage
  owlviz -pdf [file]     generate a PDF file from a graph dump
  owlviz -help           print out help information
  "
  in
  print_endline info


let dump_dot_file fname =
  let graph_dump = Owl_io.marshal_from_file fname in
  let dot_string = CGraph.graph_to_dot graph_dump in
  let dot_fname = fname ^ ".dot" in
  Owl_io.write_file dot_fname dot_string


let dump_pdf_file fname =
  dump_dot_file fname;
  let dot_fname = fname ^ ".dot" in
  let pdf_fname = fname ^ ".pdf" in
  let cmd_str = Printf.sprintf "dot -Tpdf %s -o %s" dot_fname pdf_fname in
  Sys.command cmd_str |> ignore


let _ =
  if Array.length Sys.argv < 2 then
    print_help ()
  else if Sys.argv.(1) = "-help" then
    print_help ()
  else if Sys.argv.(1) = "-pdf" then
    dump_pdf_file Sys.argv.(2)
  else
    Owl_log.error "cannot recognise the command."
