(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Log module provides logging functionality. *)


(** {6 Type definition} *)

type level = DEBUG | INFO | WARN | ERROR | FATAL
(**
Type definition of log levels, priority is from low to high. Using ``set_level``
function to set global logging level to high one can mask the output from low
level loggging.
*)


(** {6 Configuration functions} *)

val set_level : level -> unit
(**
This function sets the global logging level. Low level logging will be omitted.
*)

val set_output : out_channel -> unit
(**
This function sets the channel for the logging output. The default one is the
standard output.
*)

val set_color : bool -> unit
(**
``set_color true`` turns on the colour; ``set_color false`` turns it off.
*)


(** {6 Log functions} *)

val debug : ('a, out_channel, unit) format -> 'a
(** This function outputs log at ``DEBUG`` level. *)

val info : ('a, out_channel, unit) format -> 'a
(** This function outputs log at ``INFO`` level. *)

val warn : ('a, out_channel, unit) format -> 'a
(** This function outputs log at ``WARN`` level. *)

val error : ('a, out_channel, unit) format -> 'a
(** This function outputs log at ``ERROR`` level. *)

val fatal : ('a, out_channel, unit) format -> 'a
(** This function outputs log at ``FATAL`` level. *)
