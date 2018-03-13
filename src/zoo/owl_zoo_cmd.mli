(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Manipulate gists} *)

val remove_gist : string -> unit
(** Remove a local gist of given id. *)

val upload_gist : string -> string
(** Upload a zoo bundle of given path to the gist server and return a gist id. *)

val download_gist : ?vid:string -> string -> unit
(** Download the gist of given id and version; if a version id is not given, the latest version id will be used. *)

val list_gist : string -> unit
(** ``list_gist ""`` lists all the local gists; ``list_gist gist`` lists all the local versions of a gist. *)

val update_gist : string array -> unit
(** Update the zoo gist bundles of an array of gist ids. *)

val show_info : string -> unit
(** Show the gist's detail information of given gist id. *)


(** {6 Execute gists} *)

val load_file : string -> string -> string
(** Load a zoo file with the given gist name and file name, the file path is relative to the default zoo folder. *)

val eval : string -> unit
(** Evaluate an OCaml expression in toplevel. *)

val preprocess : string -> string
(** Preprocess the zoo scripts, inject the necessary directives, functions, and modules. *)

val run : string array -> string -> unit
(** ``run args script`` executes the zoo script with the given arguments. *)

val run_gist : string -> unit
(** ``run_gist gist`` runs a zoo gist with the given ``id``. *)


(** {6 Helper functions} *)

val print_info : unit -> unit
(** Print out help information of ``owl`` command line. *)

val start_toplevel : unit -> unit
(** Start the toplevel system tailored for Owl's zoo system. *)
