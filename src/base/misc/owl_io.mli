(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Read and write operations} *)

val read_file : ?trim:bool -> string -> string array

val read_file_string : string -> string

val write_file : string -> string -> unit

val marshal_from_file : string -> 'a

val marshal_to_file : 'a -> string -> unit


(** {6 Iteration functions} *)

val iteri_lines_of_file : ?verbose:bool -> (int -> string -> unit) -> string -> unit

val mapi_lines_of_file : (int -> string -> 'a) -> string -> 'a array

val iteri_lines_of_marshal : ?verbose:bool -> (int -> 'a -> 'b) -> string -> unit

val mapi_lines_of_marshal : (int -> 'a -> 'b) -> string -> 'b array
