(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


val parse_gist_string : string -> string * string * bool
(**  Parse a full gist name scheme string and return a gist id, a version id, and a bool value to indicate if `pin` flag is set in the gist name. *)

val add_dir_zoo : unit -> unit
(** Add directive "zoo" to OCaml toploop. *)
