(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Core functions} *)

val printers : string list
(** List of registered pretty printers for Owl. *)

val install_printers : string list -> unit
(** Install all the registered pretty printers. *)
