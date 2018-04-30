(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Pretty print the n-dimensional array *)


(** {6 Ndarray pretty printer} *)

val pp_dsnda : Format.formatter -> ('a, 'b, 'c) Bigarray.Genarray.t -> unit
(** ``pp_dsnda`` is the pretty printer for n-dimensional arrays. *)

val dsnda_to_string :  ?header:bool -> ?max_row:int -> ?max_col:int -> ?elt_to_str_fun:('a -> string) -> ('a, 'b, Bigarray.c_layout) Bigarray.Genarray.t -> string
(** ``dsnda_to_string x`` converts ``x`` into a string for pretty printing *)

val print : ?header:bool -> ?max_row:int -> ?max_col:int -> ?elt_to_str_fun:('a -> string) -> ?formatter:Format.formatter -> ('a, 'b, Bigarray.c_layout) Bigarray.Genarray.t -> unit
(**
``print`` provides the better control of pretty printing function of owl's
n-dimensional array. [max_row] and [max_col] specify the maximum number of
rows and columns to display. [header] specifies whether or not to print out
the headers. [fmt] is the function to format every element into string.
 *)


(** {6 Dataframe pretty printer} *)

val pp_dataframe : Format.formatter -> Owl_dataframe.t -> unit
(** ``pp_dataframe`` is the pretty printer for dataframe. *)

val dataframe_to_string : ?header:bool -> ?names:string array -> ?max_row:int -> ?max_col:int -> ?elt_to_str_fun:(Owl_dataframe.elt -> string) -> Owl_dataframe.t -> string
(** ``dataframe_to_string x`` converts ``x`` into a string for pretty printing *)

val print_dataframe : ?header:bool -> ?names:string array -> ?max_row:int -> ?max_col:int -> ?elt_to_str_fun:(Owl_dataframe.elt -> string) -> Format.formatter -> Owl_dataframe.t -> unit
(** ``print_dataframe x`` converts ``x`` into a string for pretty printing *)
