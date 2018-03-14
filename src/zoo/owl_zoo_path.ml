(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

 let dir = Sys.getenv "HOME" ^ "/.owl/zoo"
 let htb = dir ^ "/" ^ "zoo_ver.htb"

(* Used internally *)
 let gist_path gid vid =
   dir  ^ "/" ^ gid ^ "/" ^ vid

(* Used by script creators *)
let extend_zoo_path ?(gid="") ?(vid="") filepath =
  match gid, vid with
  | "", "" -> filepath
  | g, v   -> ((gist_path g v) ^ "/" ^ filepath)
