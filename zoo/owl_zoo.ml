(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_top.Owl_top_cmd


let _ =
  Log.color_on (); Log.(set_log_level DEBUG);

  if Array.length Sys.argv < 2 then
    print_info ()
  else if Sys.argv.(1) = "-upload" then
    upload_gist Sys.argv.(2)
  else if Sys.argv.(1) = "-download" then
    download_gist Sys.argv.(2)
  else if Sys.argv.(1) = "-remove" then
    remove_gist Sys.argv.(2)
  else if Sys.argv.(1) = "-info" then
    show_info Sys.argv.(2)
  else if Sys.argv.(1) = "-run" then
    run_gist Sys.argv.(2)
  else if Sys.argv.(1) = "-list" then
    list_gist ()
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
    let args = Array.sub Sys.argv 1 (len - 2)
      |> Array.fold_left (fun a s -> a ^ s ^ " ") ""
    in
    run args script |> ignore
  )
