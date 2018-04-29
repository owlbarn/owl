(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Read and write operations} *)

val read_file : ?trim:bool -> string -> string array
(** TODO *)

val read_file_string : string -> string
(** TODO *)

val write_file : string -> string -> unit
(** TODO *)

val marshal_from_file : string -> 'a
(** TODO *)

val marshal_to_file : 'a -> string -> unit
(** TODO *)

val read_csv : ?sep:char -> string -> string array array
(** TODO *)


(** {6 Iteration functions} *)

val iteri_lines_of_file : ?verbose:bool -> (int -> string -> unit) -> string -> unit
(** TODO *)

val mapi_lines_of_file : (int -> string -> 'a) -> string -> 'a array
(** TODO *)

val iteri_lines_of_marshal : ?verbose:bool -> (int -> 'a -> 'b) -> string -> unit
(** TODO *)

val mapi_lines_of_marshal : (int -> 'a -> 'b) -> string -> 'b array
(** TODO *)

val iteri_csv : ?sep:char -> (int -> string array -> unit) -> string -> unit
(** TODO *)


(** {6 Helper functions} *)

val head : int -> string -> string array
(** TODO *)
