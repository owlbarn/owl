(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition} *)

type t
(** TODO *)

type series
(** TODO *)

type elt =
  | Int'    of int
  | Float'  of float
  | String' of string
  | Any'
(** TODO *)


(** {6 Pakcking & unpacking functions} *)

val pack_int : int -> elt
(** TODO *)

val pack_float : float -> elt
(** TODO *)

val pack_string : string -> elt
(** TODO *)

val unpack_int : elt -> int
(** TODO *)

val unpack_float : elt -> float
(** TODO *)

val unpack_string : elt -> string
(** TODO *)

val pack_int_series : int array -> series
(** TODO *)

val pack_float_series : float array -> series
(** TODO *)

val pack_string_series : string array -> series
(** TODO *)

val unpack_int_series : series -> int array
(** TODO *)

val unpack_float_series : series -> float array
(** TODO *)

val unpack_string_series : series -> string array
(** TODO *)


(** {6 Obtain properties} *)

val row_num : t -> int
(** TODO *)

val col_num : t -> int
(** TODO *)

val shape : t -> int * int
(** TODO *)

val numel : t -> int
(** TODO *)

val get_heads : t -> string array
(** TODO *)

val set_heads : t -> string array -> unit
(** TODO *)

val get_head : t -> int -> string
(** TODO *)


(** {6 Basic get and set functions} *)

val get : t -> int -> int -> elt
(** TODO *)

val set : t -> int -> int -> elt -> unit
(** TODO *)

val get_by_name : t -> int -> string -> elt
(** TODO *)

val set_by_name : t -> int -> string -> elt -> unit
(** TODO *)

val get_row : t -> int -> elt array
(** TODO *)

val get_col : t -> int -> series
(** TODO *)

val get_rows : t -> int array -> elt array array
(** TODO *)

val get_cols : t -> int array -> series array
(** TODO *)

val get_col_by_name : t -> string -> series
(** TODO *)

val get_cols_by_name : t -> string array -> series array
(** TODO *)


(** {6 Core operations} *)

val make : string array -> t
(** TODO *)

val copy : t -> t
(** TODO *)

val append : t -> elt array -> unit
(** TODO *)

val concat_horizontal : t -> t -> t
(** TODO *)

val concat_vertical : t -> t -> t
(** TODO *)


(** {6 Math operators} *)



(** {6 Iteration functions} *)



(** {6 Extended indexing operators} *)

val ( .%( ) ) : t -> int * string -> elt
(** TODO *)

val ( .%( )<- ) : t -> int * string -> elt -> unit
(** TODO *)


(** {6 IO & helper functions} *)

val load : ?sep:char -> string array -> string -> t
(** TODO *)

val save : ?sep:char -> t -> string -> unit
(** TODO *)

val to_cols : t -> series array
(** TODO *)

val elt_to_str : elt -> string
(** TODO *)
