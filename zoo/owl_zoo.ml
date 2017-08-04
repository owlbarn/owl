(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl


let preprocess script =
  let prefix = "." ^ (Filename.basename script) in
  let tmp_script = Filename.temp_file prefix ".ml" in
  let content =
    "#require \"owl\"\n" ^
    "#require \"owl_zoo\"\n" ^
    "let _owl_zoo_files = Owl_zoo_toplevel._owl_zoo_files;;\n" ^
    "let _zoo_load = Owl_zoo_toplevel._zoo_load;;\n" ^
    Printf.sprintf "#use \"%s\"\n" script
  in
  Utils.write_file tmp_script content;
  tmp_script


let remove_gist gist =
  Log.debug "owl_zoo: %s removed" gist;
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ gist in
  let cmd = Printf.sprintf "rm -rf %s" dir in
  Sys.command cmd |> ignore


let upload_gist gist =
  Log.debug "owl_zoo: %s uploading" gist;
  let cmd = Printf.sprintf "owl_upload_gist.sh %s" gist in
  Sys.command cmd |> ignore


let download_gist gist =
  Log.debug "owl_zoo: %s downloading" gist;
  let cmd = Printf.sprintf "owl_download_gist.sh %s" gist in
  Sys.command cmd |> ignore


let list_gist () =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" in
  Log.debug "owl_zoo: %s" dir;
  let cmd = Printf.sprintf "owl_list_gist.sh" in
  Sys.command cmd |> ignore


let update_gist gists =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" in
  let gists =
    if Array.length gists = 0 then Sys.readdir dir
    else gists
  in
  Log.debug "owl_zoo: updating %i gists" Array.(length gists);
  Array.iter (fun gist ->
    let cmd = Printf.sprintf "owl_download_gist.sh %s" gist in
    Sys.command cmd |> ignore
  ) gists


let show_info gist =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ gist in
  let files = Sys.readdir dir
    |> Array.fold_left (fun a s -> a ^ s ^ " ") ""
  in
  let readme = dir ^ "/readme.md" in
  let info_s =
    if Sys.file_exists readme then (
      Utils.read_file readme
      |> Array.fold_left (fun a s -> a ^ s ^ "\n") ""
    )
    else "missing readme.md"
  in
  let info =
    Printf.sprintf "[id]    %s\n" gist ^
    Printf.sprintf "[path]  %s\n" dir ^
    Printf.sprintf "[url]   %s\n" ("https://gist.github.com/" ^ gist) ^
    Printf.sprintf "[files] %s\n" files ^
    Printf.sprintf "[info]  %s" info_s
  in
  print_endline info


let run args script =
  let new_script = preprocess script in
  let cmd = Printf.sprintf "utop %s %s" args new_script in
  Sys.command cmd


let run_gist gist =
  let tmp_script = Filename.temp_file gist ".ml" in
  let content = Printf.sprintf "#zoo \"%s\"\n" gist in
  Utils.write_file tmp_script content;
  run "" tmp_script |> ignore


let print_info () =
  let info =
    "Owl's Zoo System\n\n" ^
    "Usage: \n" ^
    "  owl [utop options] [script-file]\texecute an Owl script\n" ^
    "  owl -upload [gist-directory]\t\tupload code snippet to gist\n" ^
    "  owl -download [gist-id]\t\tdownload code snippet from gist\n" ^
    "  owl -remove [gist-id]\t\t\tremove a cached gist\n" ^
    "  owl -update [gist-ids]\t\tupdate (all if not specified) gists\n" ^
    "  owl -run [gist-id]\t\t\trun a self-contained gist\n" ^
    "  owl -info [gist-ids]\t\t\tshow the basic information of a gist\n" ^
    "  owl -list\t\t\t\tlist all the cached gists\n" ^
    "  owl -help\t\t\t\tprint out help information\n"
  in
  print_endline info


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
