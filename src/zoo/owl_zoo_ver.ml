(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let htb = Owl_zoo_path.htb


(** run system command and return the result as string *)
let syscall cmd =
  let ic, oc = Unix.open_process cmd in
  let buf = Buffer.create 50 in
  (try
     while true do
       Buffer.add_channel buf ic 1
     done
   with End_of_file -> ());
  Unix.close_process (ic, oc) |> ignore;
  Buffer.contents buf


(** Version information of gists is saved as key-value pairs in Hash table:
key: gid; value: (version list, timestamp). *)
let create_htb () =
  let tb = Hashtbl.create 128 in
  Hashtbl.add tb "" ([|""|], 0.);
  Owl_io.marshal_to_file tb htb


(** Try to get the value of key `gid`; if not found, return default values with
a `true` flag. *)
let get_value (gid : string) =
  if not (Sys.file_exists htb) then create_htb ();
  let tb = Owl_io.marshal_from_file htb in
  if (gid = "") then ([|""|], 0., tb, true)
  else try
    let v, ts = Hashtbl.find tb gid in
    v, ts, tb, false
  with Not_found ->  [|""|], 0., tb, true


(** Get the timestamp of the latest version of a gist; return 0. if the gist
does not exist. *)
let get_timestamp (gid : string) =
  let _, ts, _, miss_flag = get_value gid in
  if (miss_flag == false) then ts else 0.


(** Get the most up-to-date gist version from Gist server; return "" if the gid
is not found or network error happens. *)
let get_remote_vid (gid : string) =
  let cmd = "curl https://api.github.com/gists/" ^ gid in
  let s = syscall cmd in
  let r = Str.regexp "\"version\":[ \n\r\t]+\"\\([0-9a-z]+\\)\"" in
  try
    let _ = Str.search_forward r s 0 in
    Str.matched_group 1 s
  with Not_found -> ""


(** Get the latest version downloaded on local machine; if the local version is
not found on record, get the newest vid from Gist server. *)
let get_latest_vid (gid : string) =
  let v, _, _, miss_flag = get_value gid in
  if (miss_flag == false) then (
    assert (Array.length v > 0);
    Array.get v (Array.length v - 1)
  ) else (
    Owl_log.debug "owl-zoo: Gist %s does not exist on local cache; fetching vid from server" gid;
    get_remote_vid gid
  )


(** Check if a specific version of a gist exists on the record. *)
let exist (gid : string) (vid : string) =
  let v, _, _, miss_flag = get_value gid in
  if (miss_flag == false) then
    Array.mem vid v
  else false


(** Add a specific version of a gist to the record; if this version already
exists, do nothing; if this gist does not exist, create a new item. *)
let update (gid : string) (vid : string) =
  let v, _, tb, miss_flag = get_value gid in
  if (miss_flag = false) then (
    if not (Array.mem vid v) then (
      let v' = Array.append v [|vid|] in
      let ts = Unix.time () in
      Hashtbl.replace tb gid (v', ts);
      Owl_io.marshal_to_file tb htb;
    ) else (
      Owl_log.debug "owl-zoo: Gist %s/%s already exists in the record" gid vid
    )
  ) else (
    let v = [|vid|] in
    let ts = Unix.time () in
    Hashtbl.add tb gid (v, ts);
    Owl_io.marshal_to_file tb htb;
  )


(** Remove a gist's record. *)
let remove (gid : string)  =
  let _, _, tb, miss_flag = get_value gid in
  if (miss_flag == false) then (
    Hashtbl.remove tb gid;
    Owl_io.marshal_to_file tb htb;
  ) else (
    Owl_log.debug "owl-zoo: Gist %s not found in the record" gid
  )


(** Parse a full gist name scheme string and return a gist id, a version id, a
bool flag to indicate if the "latest" keyword is used as vid, and a bool flag
to indicate if `pin` is set in the gist name. *)
let parse_gist_string gist =
  let strip_string s =
    Str.global_replace (Str.regexp "[\r\n\t ]") "" s
  in
  let validate_len s len =
    if ((String.length s) = len) then s
    else raise Owl_exception.ZOO_ILLEGAL_GIST_NAME
  in

  let regex = Str.regexp "/" in
  let lst = Str.split_delim regex gist
    |> List.map strip_string in

  if (List.length lst > 3) then
  raise Owl_exception.ZOO_ILLEGAL_GIST_NAME;

  let latest_flag = ref false in
  let gid, vid =
    match lst with
    | gid :: [] ->
      latest_flag := true;
      gid, get_latest_vid gid
    | gid :: vid :: _ ->
      gid,
      (match vid with
      | "latest" ->
        latest_flag := true; get_latest_vid gid
      | _        -> vid)
    | _ -> raise Owl_exception.ZOO_ILLEGAL_GIST_NAME
  in
  let pin_flag =
    match lst with
    | a :: b :: ["pin"] -> true
    | _ -> false
  in

  if (!latest_flag && pin_flag == true) then
  raise Owl_exception.ZOO_ILLEGAL_GIST_NAME;

  (validate_len gid 32), (validate_len vid 40),
   !latest_flag, pin_flag
