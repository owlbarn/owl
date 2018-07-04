(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

open Owl_computation


(* all supported modules by computation graph *)

module CGraph_S = Owl_computation_graph.Make (Dense.Ndarray.S) (Owl_computation_cpu_device)

module CGraph_D = Owl_computation_graph.Make (Dense.Ndarray.S) (Owl_computation_cpu_device)


(* core functions *)

let change_cgd_suffix fname suffix =
  if Filename.check_suffix fname "cgd" then
    (Filename.chop_suffix fname "cgd") ^ suffix
  else
    fname ^ "." ^ suffix


let print_help () =
  let info = Printf.sprintf "
Owl's Computation Graph Visualiser

Usage
  owlviz [files]           generate both dot files and PDF figures
  owlviz -pdf [file]       generate the PDF figure from a graph dump
  owlviz -dot [file]       generate the dot file from a graph dump
  owlviz -trace [file]     generate the trace file from a graph dump
  owlviz -help             print out help information
  "
  in
  print_endline info


let make_trace_file fname =
  let graph_dump, number = Owl_io.marshal_from_file fname in
  let trace_string =
    match number with
    | F32 -> CGraph_S.graph_to_trace graph_dump
    | F64 -> CGraph_D.graph_to_trace graph_dump
    | _   -> "owlviz: make_trace_file"
  in
  let dot_fname = change_cgd_suffix fname "trace" in
  Owl_io.write_file dot_fname trace_string


let make_dot_file ?oname iname =
  let graph_dump, number = Owl_io.marshal_from_file iname in
  let dot_string =
    match number with
    | F32 -> CGraph_S.graph_to_dot graph_dump
    | F64 -> CGraph_D.graph_to_dot graph_dump
    | _   -> "owlviz: make_dot_file"
  in
  let dot_name =
    match oname with
    | Some s -> s
    | None   -> change_cgd_suffix iname "dot"
  in
  Owl_io.write_file dot_name dot_string


let make_pdf_file ?dot_name iname =
  let pdf_name = change_cgd_suffix iname "pdf" in
  let dot_name =
    match dot_name with
    | Some s -> s
    | None   -> Filename.temp_file "" ""
  in
  make_dot_file ~oname:dot_name iname;
  let cmd_str = Printf.sprintf "dot -Tpdf %s -o %s" dot_name pdf_name in
  Sys.command cmd_str |> ignore


let process_dumps fnames =
  Array.iter (fun fname ->
    try (
      Owl_log.info "processing %s ..." fname;
      let dot_name = change_cgd_suffix fname "dot" in
      make_pdf_file ~dot_name fname
    )
    with exn ->
      Owl_log.error "fail to process %s" fname
  ) fnames


(* main entrance of the program *)

let main args =
  if Array.length args < 2 then
    (* nothing, so print out help info *)
    print_help ()
  else (
    (* well-defined switches *)
    if args.(1).[0] = '-' then (
      if args.(1) = "-help" then
        print_help ()
      else if args.(1) = "-dot" then
        make_dot_file args.(2)
      else if args.(1) = "-pdf" then
        make_pdf_file args.(2)
      else if args.(1) = "-trace" then
        make_trace_file args.(2)
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
