(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let log = Owl_zoo_path.log


(* Record structure: gid --> timestamp * version list *)
let _create_log () =
  let tb = Hashtbl.create 128 in
  Hashtbl.add tb "" ([|""|], 0.);
  Owl_utils.marshal_to_file tb log


(* Try to get the content of key `gid`; if not found,
 * return default values with a `true` flag *)
let get_gid_content (gid : string) =
  if not (Sys.file_exists log) then _create_log ();
  let tb = Owl_utils.marshal_from_file log in
  if (gid = "") then ([|""|], 0., tb, true)
  else try
    let v, ts = Hashtbl.find tb gid in
    v, ts, tb, false
  with Not_found ->  [|""|], 0., tb, true


(* Get the most up-to-date gist version from Gist server;
 * returns "" if the gid is not found or network error *)
let get_latest_vid_remote (gid : string) =
  let cmd = "curl https://api.github.com/gists/" ^ gid ^
    " | grep '\"version\"' | head -n1 | grep -o -E '[0-9A-Za-z]+' | grep -v 'version'"
  in
  Owl_utils.syscall cmd |> String.trim


(* Get the latest version downloaded on local machine;
 * if the local version is not found, then get the newst vid from Gist server *)
let get_latest_vid_local (gid : string) =
  let v, _, _, miss_flag = get_gid_content gid in
  if (miss_flag == false) then (
    assert (Array.length v > 0);
    Array.get v (Array.length v - 1)
  ) else (
    Owl_log.info "Gist %s does not exist on local cache; fetching vid from server." gid;
    get_latest_vid_remote gid
  )


(**  Parse a full gist name scheme string and return a gist id, a version id, and a bool value to indicate if `pin` flag is set in the gist name. *)
let parse_gist_string gist =
  let strip_string s =
    Str.global_replace (Str.regexp "[\r\n\t ]") "" s
  in
  let validate_len s len info =
    if ((String.length s) = len) then s
    else failwith ("Zoo error: Invalid " ^ info ^ ": " ^ s)
  in

  let regex = Str.regexp "/" in
  let lst = Str.split_delim regex gist
    |> List.map strip_string in

  if (List.length lst > 3) then
  failwith "Zoo error: Illegal parameters numbers";

  let latest_flag = ref false in
  let gid, vid =
    match lst with
    | gid :: [] ->
      latest_flag := true;
      gid, get_latest_vid_local gid
    | gid :: vid :: _ ->
      gid,
      (match vid with
      | "latest" ->
        latest_flag := true; get_latest_vid_local gid
      | _        -> vid)
    | _ -> failwith "Zoo error: Illegal parameters numbers"
  in
  let pin_flag =
    match lst with
    | a :: b :: ["pin"] -> true
    | _ -> false
  in

  if (!latest_flag && pin_flag == true) then
  failwith "Zoo error: Need a specific version id for pinning";

  (validate_len gid 32 "gist id"), (validate_len vid 40 "version id"),
   !latest_flag, pin_flag


(** Check if a specific version of a gist exists on the record *)
let check_log (gid : string) (vid : string) =
  let v, _, _, miss_flag = get_gid_content gid in
  if (miss_flag == false) then
    Array.mem vid v
  else false


(* Add a specific version of a gist to the record;
 * if this version already exists, do nothing;
 * if this gist does not exist, create a new item. *)
let update_log (gid : string) (vid : string) =
  let v, _, tb, miss_flag = get_gid_content gid in
  if (miss_flag = false) then (
    if not (Array.mem vid v) then (
      let v' = Array.append v [|vid|] in
      let ts = Unix.time () in
      Hashtbl.replace tb gid (v', ts);
      Owl_utils.marshal_to_file tb log;
    ) else (
      Owl_log.info "Gist %s/%s already exists" gid vid
    )
  ) else (
    let v = [|vid|] in
    let ts = Unix.time () in
    Hashtbl.add tb gid (v, ts);
    Owl_utils.marshal_to_file tb log;
  )


(* Remove a gist's record *)
let remove_log (gid : string)  =
  let _, _, tb, miss_flag = get_gid_content gid in
  if (miss_flag == false) then (
    Hashtbl.remove tb gid;
    Owl_utils.marshal_to_file tb log;
  ) else (
    Owl_log.info "Remove_log: Gist id not found"
  )


(** Get the timestamp of the latest version of a gist;
  * return 0. if the gist does not exist *)
let get_timestamp (gid : string) =
  let _, ts, _, miss_flag = get_gid_content gid in
  if (miss_flag == false) then ts else 0.
