(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

open Owl_computation


module CGraph_S = Owl_computation_graph.Make (Dense.Ndarray.S) (Owl_computation_device)

module CGraph_D = Owl_computation_graph.Make (Dense.Ndarray.S) (Owl_computation_device)


let print_help () =
  let info = Printf.sprintf "
Owl's Computation Graph Visualiser

Usage
  owlviz -pdf [file]       generate the PDF figure from a graph dump
  owlviz -dot [file]       generate the dot file from a graph dump
  owlviz -trace [file]     print out trace of a graph dump on the terminal
  owlviz -help             print out help information
  "
  in
  print_endline info


let print_trace fname =
  let graph_dump, number = Owl_io.marshal_from_file fname in
  let trace_string = "print_trace: not implemented" in
  print_endline trace_string


let dump_dot_file fname =
  let graph_dump, number = Owl_io.marshal_from_file fname in
  let dot_string =
    match number with
    | F32 -> CGraph_S.graph_to_dot graph_dump
    | F64 -> CGraph_D.graph_to_dot graph_dump
  in
  let dot_fname = fname ^ ".dot" in
  Owl_io.write_file dot_fname dot_string


let dump_pdf_file fname =
  dump_dot_file fname;
  let dot_fname = fname ^ ".dot" in
  let pdf_fname = fname ^ ".pdf" in
  let cmd_str = Printf.sprintf "dot -Tpdf %s -o %s" dot_fname pdf_fname in
  Sys.command cmd_str |> ignore


let process_dumps fnames =
  Array.iter (fun fname ->
    Owl_log.info "processing %s ..." fname;
    dump_pdf_file fname
  ) fnames


let main args =
  if Array.length args < 2 then
    (* nothing, so print out help info *)
    print_help ()
  else (
    (* well-defined switches *)
    if args.(1).[0] = '-' then (
      if args.(1) = "-help" then
        print_help ()
      else if args.(1) = "-pdf" then
        dump_pdf_file args.(2)
      else if args.(1) = "-trace" then
        print_trace args.(2)
      else
        Owl_log.error "cannot recognise the command."
    )
    else (
      (* process a list of graph dumps *)
      let num_files = Array.length args - 1 in
      let file_lists = Array.sub args 1 num_files in
      process_dumps file_lists
    )
  )


let _ = main Sys.argv
