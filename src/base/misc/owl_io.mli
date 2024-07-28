(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** {5 Read and write operations} *)

val read_file : ?trim:bool -> string -> string array
(** 
    [read_file ?trim filename] reads the contents of the file specified by [filename] and returns an array of strings, where each string represents a line from the file.
    - [trim]: If set to true, leading and trailing whitespace from each line is removed.
*)

val read_file_string : string -> string
(** 
    [read_file_string filename] reads the entire contents of the file specified by [filename] into a single string.
    Returns the contents of the file as a string.
*)

val write_file : ?_flag:open_flag -> string -> string -> unit
(** 
    [write_file ?_flag filename content] writes the [content] to the file specified by [filename].
    - [_flag]: Optional file opening flag, such as [Open_append] or [Open_trunc].
    The default behavior is to overwrite the file if it exists.
*)

val marshal_from_file : string -> 'a
(** 
    [marshal_from_file filename] deserializes data from the file specified by [filename] using OCaml's Marshal module.
    Returns the deserialized data.
*)

val marshal_to_file : ?flags:Marshal.extern_flags list -> 'a -> string -> unit
(** 
    [marshal_to_file ?flags data filename] serializes the [data] and writes it to the file specified by [filename] using OCaml's Marshal module.
    - [flags]: Optional flags for controlling the serialization behavior.
*)

val read_csv : ?sep:char -> string -> string array array
(** 
    [read_csv ?sep filename] reads a CSV file specified by [filename] and returns a 2D array of strings, where each sub-array represents a row.
    - [sep]: The character used to separate fields. The default separator is a comma (',').
*)

val write_csv : ?sep:char -> string array array -> string -> unit
(** 
    [write_csv ?sep data filename] writes the 2D array of strings [data] to the file specified by [filename] in CSV format.
    - [sep]: The character used to separate fields. The default separator is a comma (',').
*)

val read_csv_proc : ?sep:char -> (int -> string array -> unit) -> string -> unit
(** 
    [read_csv_proc ?sep f filename] processes each row of the CSV file specified by [filename] using the function [f].
    - [sep]: The character used to separate fields. The default separator is a comma (',').
    The function [f] takes an index and a row (as a string array) as input.
*)

val write_csv_proc : ?sep:char -> 'a array array -> ('a -> string) -> string -> unit
(** 
    [write_csv_proc ?sep data to_string filename] writes the 2D array of data [data] to the file specified by [filename] in CSV format.
    - [sep]: The character used to separate fields. The default separator is a comma (',').
    The function [to_string] is used to convert each element to a string.
*)

(** {5 Iteration functions} *)

val iteri_lines_of_file : ?verbose:bool -> (int -> string -> unit) -> string -> unit
(** 
    [iteri_lines_of_file ?verbose f filename] iterates over each line of the file specified by [filename], applying the function [f] to each line.
    - [verbose]: If true, prints progress information. The default is false.
    The function [f] takes the line index and the line content as input.
*)

val mapi_lines_of_file : (int -> string -> 'a) -> string -> 'a array
(** 
    [mapi_lines_of_file f filename] maps the function [f] over each line of the file specified by [filename], returning an array of results.
    The function [f] takes the line index and the line content as input and returns a value of type ['a].
*)

val iteri_lines_of_marshal : ?verbose:bool -> (int -> 'a -> unit) -> string -> unit
(** 
    [iteri_lines_of_marshal ?verbose f filename] iterates over each line of serialized data in the file specified by [filename], deserializing it and applying the function [f].
    - [verbose]: If true, prints progress information. The default is false.
    The function [f] takes the line index and the deserialized data as input.
*)

val mapi_lines_of_marshal : (int -> 'a -> 'b) -> string -> 'b array
(** 
    [mapi_lines_of_marshal f filename] maps the function [f] over each line of serialized data in the file specified by [filename], deserializing it and returning an array of results.
    The function [f] takes the line index and the deserialized data as input and returns a value of type ['b].
*)

(** {5 Helper functions} *)

val head : int -> string -> string array
(** 
    [head n filename] reads the first [n] lines of the file specified by [filename] and returns them as an array of strings.
*)

val csv_head : ?sep:char -> int -> string -> string array
(** 
    [csv_head ?sep n filename] reads the first [n] lines of the CSV file specified by [filename] and returns them as an array of strings.
    - [sep]: The character used to separate fields. The default separator is a comma (',').
*)
