(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_zoo_cmd


let raise_info_and_exit () =
  Owl_log.info "Please input the gist id.";
  exit(0)


(* main entrance of the program *)

let main args =
  (* initialise logger *)
  Owl_log.set_color true;
  Owl_log.(set_level DEBUG);

  (* initialise owl zoo working environment *)
  (* set up owl's folder *)
  let home = Sys.getenv "HOME" ^ "/.owl" in
  let dir_zoo = home ^ "/zoo" in
  (* Note: use of Sys.file_exist is racy *)
  (try Unix.mkdir home 0o755 with Unix.Unix_error(Unix.EEXIST, _, _) -> ());
  (try Unix.mkdir dir_zoo 0o755 with Unix.Unix_error(Unix.EEXIST, _, _) -> ());

  (* add zoo directive *)
  Owl_zoo_dir.add_dir_zoo ();

  if Array.length args < 2 then
    start_toplevel ()
  else if args.(1) = "-upload" then (
    if Array.length args = 2 then raise_info_and_exit ();
    upload_gist args.(2) |> ignore
  )
  else if args.(1) = "-download" then
    if Array.length args <= 3 then
      download_gist args.(2)
    else
      download_gist ~vid:(args.(3)) args.(2)
  else if args.(1) = "-remove" then (
    if Array.length args = 2 then raise_info_and_exit ();
    remove_gist args.(2)
  )
  else if args.(1) = "-info" then (
    if Array.length args = 2 then raise_info_and_exit ();
    show_info args.(2)
  )
  else if args.(1) = "-run" then (
    if Array.length args = 2 then raise_info_and_exit ();
    let len = Array.length args - 2 in
    (* use gist name as the first argument *)
    let arg = Array.sub args 2 len in
    run_gist args.(2) arg
  )
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
