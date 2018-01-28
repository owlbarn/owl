(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

(** Log module provides logging functionality. *)


(** {6 Type definition} *)

type level = DEBUG | INFO | WARN | ERROR | FATAL
(** type definition of log levels, priority is from low to high. *)


(** {6 Configuration functions} *)

val set_level : level -> unit

val set_output : out_channel -> unit

val set_color : bool -> unit


(** {6 Log functions} *)

val debug : ('a, out_channel, unit) format -> 'a

val info : ('a, out_channel, unit) format -> 'a

val warn : ('a, out_channel, unit) format -> 'a

val error : ('a, out_channel, unit) format -> 'a

val fatal : ('a, out_channel, unit) format -> 'a
