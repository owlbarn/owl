(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

 let dir = Sys.getenv "HOME" ^ "/.owl/zoo"
 let log = dir ^ "/" ^ "zoo_ver.htb"

 let extend_dir gid vid =
   dir  ^ "/" ^ gid ^ "/" ^ vid
