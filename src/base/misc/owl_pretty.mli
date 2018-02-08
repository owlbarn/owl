(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Pretty print the n-dimensional array *)


(** {6 Basic functions} *)

val pp_dsnda : Format.formatter -> ('a, 'b, 'c) Bigarray.Genarray.t -> unit
(** [pp_dsnda] is the pretty printer for n-dimensional arrays. *)

val print : ?header:bool -> ?max_row:int -> ?max_col:int -> ?elt_to_str_fun:('a -> string) -> ?formatter:Format.formatter -> ('a, 'b, Bigarray.c_layout) Bigarray.Genarray.t -> unit
(**
[print] provides the better control of pretty printing function of owl's
n-dimensional array. [max_row] and [max_col] specify the maximum number of
rows and columns to display. [header] specifies whether or not to print out
the headers. [fmt] is the function to format every element into string.
 *)
