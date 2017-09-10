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


(* format "gist/file", e.g., d7bdd62b355f906ed059f00b1270b79c/readme.md *)
let load_file f =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" in
  let gist = Filename.dirname f in
  let file = Filename.basename f in
  let path = Printf.sprintf "%s%s/%s" dir gist file in
  Utils.read_file_string path


let run args script =
  let new_script = preprocess script in
  let cmd = Printf.sprintf "utop %s %s" args new_script in
  Sys.command cmd
  (* Topmain.main () *)


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
