(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let deploy_new_gist gist = ()


let process_dir_zoo gist =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ gist in
  (* only include ml files *)
  Sys.readdir (dir)
  |> Array.to_list
  |> List.filter (fun s -> Filename.check_suffix s "ml")
  |> List.iter (fun l ->
      let f = Printf.sprintf "%s/%s" dir l in
      Toploop.mod_use_file Format.std_formatter f
      |> ignore
    )


let add_dir_zoo () =
  let section = "owl" in
  let doc =
    "owl's zoo system\n" ^
    "ditribute code snippet via gist\n"
  in
  let info = Toploop.({ section; doc }) in
  let dir_fun = Toploop.Directive_string process_dir_zoo in
  Toploop.add_directive "zoo" dir_fun info


let _ = add_dir_zoo ()
