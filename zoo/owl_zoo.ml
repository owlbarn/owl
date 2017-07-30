(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h


let preprocess script =
  let prefix = "." ^ (Filename.basename script) in
  let tmp_script = Filename.temp_file prefix "ml" in
  let content =
    "#require \"owl\"\n" ^
    "#require \"owl_zoo\"\n" ^
    Printf.sprintf "#use \"%s\"\n" script
  in
  write_file tmp_script content;
  tmp_script


let remove_gist gist =
  Log.info "owl_zoo: %s removed" gist;
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ gist in
  let cmd = Printf.sprintf "rm -rf %s" dir in
  Sys.command cmd |> ignore


let upload_gist gist =
  Log.info "owl_zoo: %s uploading" gist;
  let cmd = Printf.sprintf "owl_upload_gist.sh %s" gist in
  Sys.command cmd |> ignore


let download_gist gist =
  Log.info "owl_zoo: %s downloading" gist;
  let cmd = Printf.sprintf "owl_download_gist.sh %s" gist in
  Sys.command cmd |> ignore


let run args script =
  let new_script = preprocess script in
  let cmd = Printf.sprintf "utop %s %s" args new_script in
  Sys.command cmd


let print_info () =
  let info =
    "Owl's Zoo System\n\n" ^
    "Usage: \n" ^
    "\towl [toplevel options] [script-file]\n" ^
    "\towl -upload [gist-directory]\n" ^
    "\towl -download [gist-id]\n" ^
    "\towl -remove [gist-id]\n"
  in
  print_endline info


let _ =
  if Array.length Sys.argv < 2 then
    print_info ()
  else (
    let len = Array.length Sys.argv in
    let script = Sys.argv.(len - 1) in
    let args = Array.sub Sys.argv 1 (len - 2)
      |> Array.fold_left (fun a s -> a ^ s ^ " ") ""
    in
    run args script |> ignore
  )


(*
let read_file f =
  let h = open_in f in
  let s = Utils.Stack.make () in
  (
    try while true do
      let l = input_line h |> String.trim in
      Utils.Stack.push s l;
    done with End_of_file -> ()
  );
  close_in h;
  Utils.Stack.to_array s

*)
