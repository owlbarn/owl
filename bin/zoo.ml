(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_zoo_cmd


let _ =
  (* initialise logger *)
  Owl_log.set_color true;
  Owl_log.(set_level DEBUG);
  (* add zoo directive *)
  Owl_zoo_dir.add_dir_zoo ();

  if Array.length Sys.argv < 2 then
    start_toplevel ()
  else if Sys.argv.(1) = "-upload" then
    upload_gist Sys.argv.(2) |> ignore
  else if Sys.argv.(1) = "-download" then
    if Array.length Sys.argv <= 3 then
      download_gist Sys.argv.(2)
    else
      download_gist ~vid:(Sys.argv.(3)) Sys.argv.(2)
  else if Sys.argv.(1) = "-remove" then
    remove_gist Sys.argv.(2)
  else if Sys.argv.(1) = "-info" then
    show_info Sys.argv.(2)
  else if Sys.argv.(1) = "-run" then
    run_gist Sys.argv.(2)
  else if Sys.argv.(1) = "-list" then
    if Array.length Sys.argv >= 3 then
      list_gist Sys.argv.(2)
    else list_gist ""
  else if Sys.argv.(1) = "-help" then
    print_info ()
  else if Sys.argv.(1) = "-update" then (
    let len = Array.length Sys.argv in
    let args = Array.sub Sys.argv 2 (len - 2) in
    update_gist args
  )
  else (
    let len = Array.length Sys.argv in
    let script = Sys.argv.(len - 1) in
    run Sys.argv script |> ignore
  )
