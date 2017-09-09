(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let _deploy_gist dir gist =
  if Sys.file_exists (dir ^ gist) = true then (
    Log.info "owl_zoo: %s cached" gist
  )
  else (
    Log.info "owl_zoo: %s missing" gist;
    Owl_top_cmd.download_gist gist
  )


let _dir_zoo_ocaml dir gist =
  let dir_gist = dir ^ gist in
  Sys.readdir (dir_gist)
  |> Array.to_list
  |> List.filter (fun s -> Filename.check_suffix s "ml")
  |> List.iter (fun l ->
      let f = Printf.sprintf "%s/%s" dir_gist l in
      Toploop.mod_use_file Format.std_formatter f
      |> ignore
    )


let process_dir_zoo gist =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" in
  _deploy_gist dir gist;
  _dir_zoo_ocaml dir gist


let add_dir_zoo () =
  let section = "owl" in
  let doc =
    "owl's zoo system\n" ^
    "ditribute code snippet via gist\n"
  in
  let info = Toploop.({ section; doc }) in
  let dir_fun = Toploop.Directive_string process_dir_zoo in
  Toploop.add_directive "zoo" dir_fun info


(* register zoo directive *)
let _ = add_dir_zoo ()
