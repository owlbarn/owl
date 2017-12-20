(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

(** Log module provides logging functionality. *)


(** {6 Type definition} *)

type level =
  | DEBUG
  | INFO
  | WARN
  | ERROR
(** type definition of log levels *)


(** {6 Configuration functions} *)

val set_level : level -> unit

val set_output : out_channel -> unit

val color_on : unit -> unit

val color_off : unit -> unit


(** {6 Log functions} *)

val debug : ('a, out_channel, unit) format -> 'a

val info : ('a, out_channel, unit) format -> 'a

val warn : ('a, out_channel, unit) format -> 'a

val error : ('a, out_channel, unit) format -> 'a
