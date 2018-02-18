(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let dir = Sys.getenv "HOME" ^ "/.owl/zoo/"
let log = dir ^ "log.htb"

let _syscall cmd =
  let ic, oc = Unix.open_process cmd in
  let buf = Buffer.create 50 in
  (try
     while true do
       Buffer.add_channel buf ic 1
     done
   with End_of_file -> ());
  Unix.close_process (ic, oc);
  Buffer.contents buf

let _create_log () =
  let tb = Hashtbl.create 128 in
  Hashtbl.add tb "" [|""|];
  Owl_utils.marshal_to_file tb log

let check_log (gid : string) (vid : string) =
  if not (Sys.file_exists log) then _create_log ();
  let tb = Owl_utils.marshal_from_file log in
  try
    let v = Hashtbl.find tb gid in
    Array.mem vid v
  with Not_found -> false

let update_log (gid : string) (vid : string) =
  if not (Sys.file_exists log) then _create_log ();
  let tb = Owl_utils.marshal_from_file log in
  try
    let v  = Hashtbl.find tb gid in
    let v' = Array.append v [|vid|] in
    Hashtbl.replace tb gid v';
    Owl_utils.marshal_to_file tb log
  with Not_found -> (
    let v = [|vid|] in
    Hashtbl.add tb gid v;
    Owl_utils.marshal_to_file tb log
  )

(* only the vid of remove function can be "" *)
let remove_log (gid : string) (vid : string) =
  if not (Sys.file_exists log) then _create_log ()
  else (
    let tb = Owl_utils.marshal_from_file log in
    try
      let v = Hashtbl.find tb gid in
      if not (vid = "") then (
        let v' = v
        |> Array.to_list
        (* remove vid from list *)
        |> List.filter (fun x -> not (x = vid))
        |> Array.of_list
        in
        Hashtbl.replace tb gid v'
      )
      else Hashtbl.remove tb gid;
      Owl_utils.marshal_to_file tb log
    (* gid not found *)
    with Not_found -> ()
  )

let find_latest_vid_remote (gid : string) =
  let cmd = "curl https://api.github.com/gists/" ^ gid ^
    " | grep '\"version\"' | head -n1 | grep -o -E '[0-9A-Za-z]+' | grep -v 'version'"
  in
  let ret = _syscall cmd in
  if ret = "" then "" else
  String.sub ret 0 ((String.length ret) - 1)

let find_latest_vid_local (gid : string) =
  if not (Sys.file_exists log) then _create_log ();
  let tb = Owl_utils.marshal_from_file log in
  if (Hashtbl.mem tb gid) then (
    let v = Hashtbl.find tb gid in
    assert (Array.length v > 0);
    Array.get v (Array.length v - 1)
  )
  else find_latest_vid_remote gid
