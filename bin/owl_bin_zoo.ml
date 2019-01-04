(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_zoo_cmd


(* main entrance of the program *)

let main args =
  (* initialise logger *)
  Owl_log.set_color true;
  Owl_log.(set_level DEBUG);
  (* add zoo directive *)
  Owl_zoo_dir.add_dir_zoo ();

  if Array.length args < 2 then
    start_toplevel ()
  else if args.(1) = "-upload" then
    upload_gist args.(2) |> ignore
  else if args.(1) = "-download" then
    if Array.length args <= 3 then
      download_gist args.(2)
    else
      download_gist ~vid:(args.(3)) args.(2)
  else if args.(1) = "-remove" then
    remove_gist args.(2)
  else if args.(1) = "-info" then
    show_info args.(2)
  else if args.(1) = "-run" then
    run_gist args.(2)
  else if args.(1) = "-list" then
    if Array.length args >= 3 then
      list_gist args.(2)
    else list_gist ""
  else if args.(1) = "-help" then
    print_info ()
  else if args.(1) = "-update" then (
    let len = Array.length args in
    let args = Array.sub args 2 (len - 2) in
    update_gist args
  )
  else (
    let len = Array.length args in
    let script = args.(len - 1) in
    run args script |> ignore
  )


let _ = main Sys.argv
