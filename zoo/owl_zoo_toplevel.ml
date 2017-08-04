(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let deploy_new_gist dir gist =
  if Sys.file_exists dir = true then (
    Log.info "owl_zoo: %s cached" gist
  )
  else (
    Log.info "owl_zoo: %s missing" gist;
    Log.info "owl_zoo: %s downloading" gist;
    let cmd = Printf.sprintf "owl_download_gist.sh %s" gist in
    Sys.command cmd |> ignore
  )


let _dir_zoo_caml dir =
  Sys.readdir (dir)
  |> Array.to_list
  |> List.filter (fun s -> Filename.check_suffix s "ml")
  |> List.iter (fun l ->
      let f = Printf.sprintf "%s/%s" dir l in
      Toploop.mod_use_file Format.std_formatter f
      |> ignore
    )

(* TODO: support other types of network *)
let _dir_zoo_json dir =
  Sys.readdir (dir)
  |> Array.to_list
  |> List.filter (fun s -> Filename.check_suffix s "json")
  |> List.iter (fun l ->
      let json_f = Printf.sprintf "%s/%s" dir l in
      let prefix = ".json"
        |> Filename.(chop_suffix (basename json_f))
        |> String.uppercase_ascii
      in
      let nn_f = Filename.temp_file prefix ".ml" in
      let s =
        Printf.sprintf "module %s = struct\n" prefix ^
        Printf.sprintf "  let load () =\n" ^
        Printf.sprintf "    let s0 = Owl.Utils.read_file \"%s\" in\n" json_f ^
        Printf.sprintf "    let s1 = Array.fold_left (fun a s -> a ^ s ^ \"\\n\") \"\" s0 in\n" ^
        Printf.sprintf "    Owl_zoo_specs_neural.Feedforward.of_json s1\n" ^
        Printf.sprintf "end\n"
      in
      Owl_utils.write_file nn_f s;
      (* print_endline s; *)
      Toploop.use_file Format.std_formatter nn_f |> ignore
    )


let process_dir_zoo gist =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ gist in
  deploy_new_gist dir gist;
  (* include only ml & json files *)
  _dir_zoo_caml dir;
  _dir_zoo_json dir



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
