(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** {5 Core functions} *)

val printers : string list
(** List of registered pretty printers for Owl. *)

val install_printers : string list -> unit
(** Install all the registered pretty printers. *)
