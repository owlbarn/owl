(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let dir = Owl_zoo_config.dir

let parse_gist_string gist =
  let strip_string s =
    Str.global_replace (Str.regexp "[\r\n\t ]") "" s
  in
  let validate_len s len info =
    if ((String.length s) = len) then s
    else failwith ("Zoo error: invalid " ^ info ^ ":" ^ s)
  in

  let regex = Str.regexp "/" in
  let lst = Str.split_delim regex gist
    |> List.map strip_string in

  let gid, vid =
    match lst with
    | gid :: [] -> gid, Owl_zoo_log.find_latest_vid_remote gid
    | gid :: vid :: _ ->
      gid,
      (match vid with
      | "remote" -> Owl_zoo_log.find_latest_vid_remote gid
      | "latest" -> Owl_zoo_log.find_latest_vid_local  gid
      | _        -> vid)
    | _ -> failwith "Zoo error: Illegal parameters numbers"
  in
  let pin =
    match lst with
    | a :: b :: ["pin"] -> true
    | _ -> false
  in

  (validate_len gid 32 "gist id"), (validate_len vid 40 "version id"), pin


let _download_gist gid vid =
  if (Owl_zoo_log.check_log gid vid) = true then
    Owl_log.info "owl_zoo: %s / %s cached" gid vid
  else (
    Owl_log.info "owl_zoo: %s / %s missing" gid vid;
    Owl_log.debug "owl_zoo: %s (ver. %s) downloading" gid vid;
    let cmd = Printf.sprintf "owl_download_gist.sh %s %s" gid vid in
    let ret = Sys.command cmd in
    if ret = 0 then (Owl_zoo_log.update_log gid vid)
    else Owl_log.debug "owl_zoo: Error downloading gist %s" gid
  )


let rec _extract_zoo_gist f root =
  let s = Owl.Utils.read_file_string f in
  let regex = Str.regexp "^#zoo \"\\([0-9A-Za-z /]+\\)\"" in
  try
    let pos = ref 0 in
    while true do
      pos := Str.search_forward regex s !pos;
      let gist = Str.matched_group 1 s in
      pos := !pos + (String.length gist);
      let sub_root = process_dir_zoo gist in
      Owl_graph.connect [|root|] [|sub_root|]
    done;
  with Not_found -> ()


and _dir_zoo_ocaml gid vid root =
  let dir_gist = dir ^ "/" ^ gid ^ "/" ^ vid in
  Sys.readdir (dir_gist)
    |> Array.to_list
    |> List.filter (fun s -> Filename.check_suffix s "ml")
    |> List.iter (fun l ->
        let f = Printf.sprintf "%s/%s" dir_gist l in
        _extract_zoo_gist f root;
        Toploop.mod_use_file Format.std_formatter f
        |> ignore
      )

and process_dir_zoo gist =
  let gid, vid, pin = parse_gist_string gist in
  let dagfile = gid ^ "_" ^ vid ^ ".dag" in
  let flag  = if (Sys.file_exists dagfile) then pin else false in
  let groot =
    if flag then (Owl_utils.marshal_from_file dagfile)
    else (
      let root = Owl_graph.node (gid, vid) in
      _download_gist gid vid;
      _dir_zoo_ocaml gid vid root;
      root
    )
  in
  if pin then (Owl_utils.marshal_to_file groot dagfile);
  groot


and zoo_fun gist =
  process_dir_zoo gist |> ignore


and add_dir_zoo () =
  let section = "owl" in
  let doc =
    "owl's zoo system\n" ^
    "ditribute code snippet via gist\n"
  in
  let info = Toploop.({ section; doc }) in
  let dir_fun = Toploop.Directive_string zoo_fun in
  Toploop.add_directive "zoo" dir_fun info
