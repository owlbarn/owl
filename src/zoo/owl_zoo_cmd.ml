(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

let dir = Owl_zoo_config.dir

let eval cmd = cmd
  |> Lexing.from_string
  |> !Toploop.parse_toplevel_phrase
  |> Toploop.execute_phrase true Format.err_formatter
  |> ignore


let preprocess script =
  let prefix = "." ^ (Filename.basename script) in
  let tmp_script = Filename.temp_file prefix ".ml" in
  let content =
    "#!/usr/bin/env owl\n" ^
    "#use \"topfind\"\n" ^
    "#require \"owl\"\n" ^
    "#require \"owl_zoo\"\n" ^
    "let load_file = Owl_zoo_cmd.load_file;;\n" ^
    Printf.sprintf "#use \"%s\"\n" script
  in
  Utils.write_file tmp_script content;
  tmp_script


let remove_gist gid =
  let dir = dir ^ "/" ^ gid ^ "/" in
  let cmd = Printf.sprintf "rm -rf %s" dir in
  let ret = Sys.command cmd in
  if ret = 0 then (
    Owl_zoo_log.remove_log gid;
    Owl_log.debug "owl_zoo: %s removed" gid
  )
  else Owl_log.debug "owl_zoo: Error remvoing gist %s" gid


let upload_gist gid =
  Owl_log.debug "owl_zoo: %s uploading" gid;
  let cmd = Printf.sprintf "owl_upload_gist.sh %s" gid in
  Sys.command cmd |> ignore


let download_gist gist =
  let gid, vid, _ = Owl_zoo_dir.parse_gist_string gist in
  Owl_log.debug "owl_zoo: %s (ver. %s) downloading" gid vid;
  let cmd = Printf.sprintf "owl_download_gist.sh %s %s" gid vid in
  let ret = Sys.command cmd in
  if ret = 0 then (Owl_zoo_log.update_log gid vid)
  else (Owl_log.debug "owl_zoo: Error downloading gist %s" gid)


let list_gist gid =
  let path = dir ^ "/" ^ gid in
  Owl_log.debug "owl_zoo: %s" path;
  let cmd = Printf.sprintf "owl_list_gist.sh %s" path in
  Sys.command cmd |> ignore


let update_gist gists =
  let gists =
    if Array.length gists = 0 then Sys.readdir dir
    else gists
  in
  Owl_log.debug "owl_zoo: updating %i gists" Array.(length gists);
  let download_remote gid =
    let v = Owl_zoo_log.find_latest_vid_remote gid in
    download_gist (gid ^ "/" ^ v)
  in
  Array.iter download_remote gists


let show_info gist =
  let gid, vid, _ = Owl_zoo_dir.parse_gist_string gist in
  let dir = dir ^ "/" ^ gid ^ "/" ^ vid in
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


let load_file gist f =
  let gid, vid, _ = Owl_zoo_dir.parse_gist_string gist in
  let path = Printf.sprintf "%s/%s" (Owl_zoo_config.extend_dir gid vid) f in
  Owl_utils.read_file_string path


let run args script =
  let new_script = preprocess script in
  Toploop.initialize_toplevel_env ();
  Toploop.run_script Format.std_formatter new_script args
  |> ignore


let run_gist gist =
  let tmp_script = Filename.temp_file gist ".ml" in
  let content = Printf.sprintf "\n#zoo \"%s\"\n" gist in
  Utils.write_file tmp_script content;
  run [|""|] tmp_script |> ignore


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
    "  owl -info [gist-id]\t\t\tshow the basic information of a gist\n" ^
    "  owl -list [gist-id]\t\t\tlist all cached versions of a gist; all the cached gists if not specified\n" ^
    "  owl -help\t\t\t\tprint out help information\n"
  in
  print_endline info


let start_toplevel () =
  print_info ();
  Toploop.initialize_toplevel_env ();
  eval "#use \"topfind\";;";
  eval "Topfind.don't_load_deeply [\"compiler-libs.toplevel\"];;";
  eval "#require \"owl\";;";
  eval "#require \"owl_zoo\";;";
  eval "#require \"owl_top\";;";
  Toploop.loop Format.std_formatter
