(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* Root of Zoo System *)
let dir = Sys.getenv "HOME" ^ "/.owl/zoo"


(* Path of Zoo version database *)
let htb = dir ^ "/" ^ "zoo_ver.htb"


(* Used internally *)
let gist_path gid vid = dir  ^ "/" ^ gid ^ "/" ^ vid


(* Used by script developers *)
let extend_zoo_path ?(gid="") ?(vid="") filepath =
  match gid, vid with
  | "", "" -> filepath
  | g, v   -> ((gist_path g v) ^ "/" ^ filepath)


(* Make temporary directory *)
let mk_temp_dir ?(mode=0o700) ?dir pat =
  let dir = match dir with
    | Some d -> d
    | None   -> Filename.get_temp_dir_name ()
  in
  let rand_digits () =
    let rand = Random.State.(bits (make_self_init ()) land 0xFFFFFF) in
    Printf.sprintf "%06x" rand
  in
  let raise_err msg = raise (Sys_error ("mk_temp_dir: " ^ msg)) in
  let rec loop count =
    if count < 0 then raise_err "too many failing attemps" else
    let dir = Printf.sprintf "%s/%s%s" dir pat (rand_digits ()) in
    try (Unix.mkdir dir mode; dir) with
      | Unix.Unix_error (Unix.EEXIST, _, _) -> loop (count - 1)
      | Unix.Unix_error (Unix.EINTR, _, _)  -> loop count
      | Unix.Unix_error (e, _, _)           -> raise_err (Unix.error_message e)
  in
  loop 1000
