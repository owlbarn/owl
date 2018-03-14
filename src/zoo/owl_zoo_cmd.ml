(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl


let dir = Owl_zoo_path.dir


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
  let path = dir ^ "/" ^ gid ^ "/" in
  let cmd = Printf.sprintf "rm -rf %s" path in
  let ret = Sys.command cmd in
  if ret = 0 then (
    Owl_zoo_ver.remove gid;
    Owl_log.debug "owl_zoo: %s removed" gid
  )
  else Owl_log.debug "owl_zoo: Error remvoing gist %s" gid


let upload_gist gist_dir =
  Owl_log.debug "owl_zoo: %s uploading" gist_dir;
  let cmd = Printf.sprintf "owl_upload_gist.sh %s" gist_dir in
  Sys.command cmd |> ignore;
  let gist_arr = Owl_utils.read_file (gist_dir ^ "/gist.id") in
  gist_arr.(0)


let download_gist ?vid gid =
  let vid = match vid with
  | Some a -> a
  | None   -> Owl_zoo_ver.get_remote_vid gid
  in
  if (Owl_zoo_ver.exist gid vid) = true then
    Owl_log.info "owl_zoo: %s/%s cached" gid vid
  else (
    Owl_log.debug "owl_zoo: %s/%s missing; downloading" gid vid;
    let cmd = Printf.sprintf "owl_download_gist.sh %s %s" gid vid in
    let ret = Sys.command cmd in
    if ret = 0 then (Owl_zoo_ver.update gid vid)
    else Owl_log.debug "owl_zoo: Error downloading gist %s%s" gid vid
  )


let list_gist gid =
  let path = dir ^ "/" ^ gid in
  Owl_log.debug "owl_zoo: %s" path;
  let cmd = Printf.sprintf "owl_list_gist.sh %s" path in
  Sys.command cmd |> ignore


let update_gist gids =
  let gids =
    if Array.length gids = 0 then Sys.readdir dir
    else gids
  in
  Owl_log.debug "owl_zoo: updating %i gists" Array.(length gids);
  Array.iter download_gist gids


let show_info gist =
  let gid, vid, _, _ = Owl_zoo_ver.parse_gist_string gist in
  let dir = Owl_zoo_path.gist_path gid vid in
  let files = Sys.readdir dir
    |> Array.fold_left (fun a s -> a ^ s ^ " ") ""
  in
  let readme = dir ^ "/#readme.md" in
  let info_s =
    if Sys.file_exists readme then (
      Owl_utils.read_file readme
      |> Array.fold_left (fun a s -> a ^ s ^ "\n") ""
    )
    else "missing #readme.md"
  in
  let info =
    Printf.sprintf "[gid]   %s\n" gid ^
    Printf.sprintf "[vid]   %s\n" vid ^
    Printf.sprintf "[path]  %s\n" dir ^
    Printf.sprintf "[url]   %s\n" ("https://gist.github.com/" ^
      gid ^ "/" ^ vid) ^
    Printf.sprintf "[files] %s\n" files ^
    Printf.sprintf "[info]  %s" info_s
  in
  print_endline info


(* f is a file name in the gist, e.g., #readme.md *)
let load_file gist f =
  let gid, vid, _, _ = Owl_zoo_ver.parse_gist_string gist in
  let path = Printf.sprintf "%s/%s" (Owl_zoo_path.gist_path gid vid) f in
  Owl_utils.read_file_string path


let run args script =
  let new_script = preprocess script in
  Toploop.initialize_toplevel_env ();
  Toploop.run_script Format.std_formatter new_script args
  |> ignore


let run_gist gist =
  let tmp_script = Filename.temp_file "zoo_tmp" ".ml" in
  let content = Printf.sprintf "\n#zoo \"%s\"\n" gist in
  Utils.write_file tmp_script content;
  run [|""|] tmp_script |> ignore


let print_info () =
  let info =
    "Owl's Zoo System\n\n" ^
    "Usage: \n" ^
    "  owl [utop options] [script-file]\texecute an Owl script\n" ^
    "  owl -upload [gist-directory]\t\tupload code snippet to gist\n" ^
    "  owl -download [gist-id] [ver-id]\tdownload code snippet from gist; download the latest version if ver-id not specified\n" ^
    "  owl -remove [gist-id]\t\t\tremove a cached gist\n" ^
    "  owl -update [gist-ids]\t\tupdate (all if not specified) gists\n" ^
    "  owl -run [gist-name]\t\t\trun a self-contained gist\n" ^
    "  owl -info [gist-name]\t\t\tshow the basic information of a gist\n" ^
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
