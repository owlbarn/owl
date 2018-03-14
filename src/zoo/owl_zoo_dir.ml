(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let rec _extract_zoo_gist f added =
  let s = Owl_utils.read_file_string f in
  let regex = Str.regexp "^#zoo \"\\([0-9A-Za-z]+\\)\"" in
  try
    let pos = ref 0 in
    while true do
      pos := Str.search_forward regex s !pos;
      let gist = Str.matched_group 1 s in
      pos := !pos + (String.length gist);
      process_dir_zoo ~added gist
    done
  with Not_found -> ()


and _download_gist gid vid =
  if (Owl_zoo_ver.exist gid vid) = true then
    Owl_log.info "owl_zoo: %s/%s cached" gid vid
  else (
    Owl_log.info "owl_zoo: %s/%s missing; downloading" gid vid;
    let cmd = Printf.sprintf "owl_download_gist.sh %s %s" gid vid in
    let ret = Sys.command cmd in
    if ret = 0 then Owl_zoo_ver.update gid vid
    else Owl_log.debug "owl_zoo: Error downloading gist %s/%s" gid vid
  )


and _dir_zoo_ocaml gid vid added =
  let dir_gist = Owl_zoo_path.gist_path gid vid in
  Sys.readdir (dir_gist)
  |> Array.to_list
  |> List.filter (fun s -> Filename.check_suffix s "ml")
  |> List.iter (fun l ->
      let f = Printf.sprintf "%s/%s" dir_gist l in

      (* extend file path in a script *)
      let f' = "/tmp/" ^ l in
      Sys.command (Printf.sprintf "cp %s %s" f f') |> ignore;
      let cmd = Printf.sprintf
        "sed -i 's/extend_zoo_path/extend_zoo_path ~gid:\"%s\" ~vid:\"%s\"/g' %s"
        gid vid f' in
      Sys.command cmd |> ignore;

      _extract_zoo_gist f' added;
      Toploop.mod_use_file Format.std_formatter f'
      |> ignore
    )


and process_dir_zoo ?added gist =
  let gid, vid, _, _ = Owl_zoo_ver.parse_gist_string gist in
  let gist' = Printf.sprintf "%s/%s" gid vid in

  let added = match added with
    | Some h -> h
    | None   -> Hashtbl.create 128
  in
  if Hashtbl.mem added gist' = false then (
    Hashtbl.add added gist' gist';
    _download_gist gid vid;
    _dir_zoo_ocaml gid vid added
  )


and add_dir_zoo () =
  let section = "owl" in
  let doc =
    "owl's zoo system\n" ^
    "ditribute code snippet via gist\n"
  in
  let info = Toploop.({ section; doc }) in
  let dir_fun = Toploop.Directive_string process_dir_zoo in
  Toploop.add_directive "zoo" dir_fun info
