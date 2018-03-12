(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


val check_log : string -> string -> bool
(** ``check_log gid vid`` checks if version `vid` of a gist `gid` exists in the zoo repository. *)

val update_log : string -> string -> unit
(** ``update_log gid vid`` adds version `vid` of a gist `gid` to the record of  local zoo repository. *)

val remove_log : string -> unit
(** ``update_log gid`` removes all versions of a gist `gid` from local zoo repository. *)

val get_latest_vid_remote : string -> string
(** Find the most recently downloaded version of a gist of given id on local machine. *)

val get_latest_vid_local : string -> string
(** Find the most up-to-date version of a gist of given id on remote gist server.*)

val get_timestamp : string -> float
(** Get the timestamp of the latest version of a gist. *)

val parse_gist_string : string -> string * string * bool * bool
(** Parse a full gist name scheme string and return a gist id, a version id, and a bool value to indicate if `pin` flag is set in the gist name. *)
