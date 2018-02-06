(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


val printers : string list
(** List of registered pretty printers for Owl. *)

val install_printers : string list -> unit
(** Install all the registered pretty printers. *)
