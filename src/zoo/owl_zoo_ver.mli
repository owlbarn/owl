(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


val exist : string -> string -> bool
(** ``check_log gid vid`` checks if version `vid` of a gist `gid` exists in the
zoo repository. *)

val update : string -> string -> unit
(** ``update_log gid vid`` adds version `vid` of a gist `gid` to the record of
local zoo repository. *)

val remove : string -> unit
(** ``update_log gid`` removes all versions of a gist `gid` from local zoo
repository. *)

val get_remote_vid : string -> string
(** ``get_remote_vid`` gets the newest version of a gist of given id on Gist
server. *)

val get_timestamp : string -> float
(** ``get_timestamp`` gets the timestamp of the latest version of a gist. *)

val parse_gist_string : string -> string * string * float * bool
(** ``parse_gist_string`` accepts a full gist name scheme string and returns a
gist id, a version id, a float value indicating the time tolerance for this
gist, and a bool flag indicating if `pin` is set to true in the gist name. *)
