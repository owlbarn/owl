(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition} *)

type t
(** Abstract dataframe type. *)

type series
(** Abstract series type. *)

type elt =
  | Bool   of bool
  | Int    of int
  | Float  of float
  | String of string
  | Any
(** Type of the elements in a series. *)


(** {6 Pakcking & unpacking element} *)

val pack_bool : bool -> elt
(** Pack the boolean value to ``elt`` type. *)

val pack_int : int -> elt
(** Pack the int value to ``elt`` type. *)

val pack_float : float -> elt
(** Pack the float value to ``elt`` type. *)

val pack_string : string -> elt
(** Pack the string value to ``elt`` type. *)

val unpack_bool : elt -> bool
(** Unpack ``elt`` type to boolean value. *)

val unpack_int : elt -> int
(** Unpack ``elt`` type to int value. *)

val unpack_float : elt -> float
(** Unpack ``elt`` type to float value. *)

val unpack_string : elt -> string
(** Unpack ``elt`` type to string value. *)


(** {6 Pakcking & unpacking series} *)

val pack_bool_series : bool array -> series
(** Pack boolean array to ``series`` type. *)

val pack_int_series : int array -> series
(** Pack int array to ``series`` type. *)

val pack_float_series : float array -> series
(** Pack float array to ``series`` type. *)

val pack_string_series : string array -> series
(** Pack string array to ``series`` type. *)

val unpack_bool_series : series -> bool array
(** Unpack ``series`` type to boolean array. *)

val unpack_int_series : series -> int array
(** Unpack ``series`` type to int array. *)

val unpack_float_series : series -> float array
(** Unpack ``series`` type to float array. *)

val unpack_string_series : series -> string array
(** Unpack ``series`` type to string array. *)


(** {6 Obtain properties} *)

val row_num : t -> int
(** ``row_num x`` returns the number of rows in ``x``. *)

val col_num : t -> int
(** ``col_num x`` returns the number of columns in ``x``. *)

val shape : t -> int * int
(** ``shape x`` returns the shape of ``x``, i.e. ``(row numnber, column number)``. *)

val numel : t -> int
(** ``numel x`` returns the number of elements in ``x``. *)

val types : t -> string array
(** ``types x`` returns the string representation of column types. *)

val get_heads : t -> string array
(** ``get_heads x`` returns the column names of ``x``. *)

val set_heads : t -> string array -> unit
(** ``set_heads x head_names`` sets ``head_names`` as the column names of ``x``. *)

val id_to_head : t -> int -> string
(** ``id_to_head head_name`` converts head name to its corresponding column index. *)

val head_to_id : t -> string -> int
(** ``head_to_id i`` converts column index ``i`` to its corresponding head name. *)


(** {6 Basic get and set functions} *)

val get : t -> int -> int -> elt
(** ``get x i j`` returns the element at ``(i,j)``. *)

val set : t -> int -> int -> elt -> unit
(** ``set x i j v`` sets the value of element at ``(i,j)`` to ``v``. *)

val get_by_name : t -> int -> string -> elt
(** ``get_by_name x i head_name`` is similar to ``get`` but uses column name. *)

val set_by_name : t -> int -> string -> elt -> unit
(** ``set_by_name x i head_name`` is similar to ``set`` but uses column name. *)

val get_row : t -> int -> elt array
(** ``get_row x i`` returns the ith row in ``x``. *)

val get_col : t -> int -> series
(** ``get_col x i`` returns the ith column in ``x``. *)

val get_rows : t -> int array -> elt array array
(** ``get_rows x a`` returns the rows of ``x`` specified in ``a``. *)

val get_cols : t -> int array -> series array
(** ``get_cols x a`` returns the columns of ``x`` specified in ``a``. *)

val get_col_by_name : t -> string -> series
(** ``get_col_by_name`` is similar to ``get_col`` but uses column name. *)

val get_cols_by_name : t -> string array -> series array
(** ``get_cols_by_name`` is similar to ``get_cols`` but uses column names. *)

val get_slice : int list list -> t -> t
(**
``get_slice s x`` returns a slice of ``x`` defined by ``s``. For more details,
please refer to :doc:`owl_dense_ndarray_generic`.
 *)

val get_slice_by_name : int list * string list -> t -> t
(** ``get_slice_by_name`` is similar to ``get_slice`` but uses column name. *)

val head : int -> t -> t
(** ``head n x`` returns top ``n`` rows of ``x``. *)

val tail : int -> t -> t
(** ``tail n x`` returns bottom ``n`` rows of ``x``. *)


(** {6 Core operations} *)

val make : ?data:series array -> string array -> t
(**
``make ~data head_names`` creates a dataframe with an array of series data
and corresponding column names. If data is not passed in, the function will
return an empty dataframe.
 *)

val copy : t -> t
(** ``copy x`` returns a copy of dataframe ``x``. *)

val copy_struct : t -> t
(** ``copy_struct x`` only copies the structure of ``x`` with empty series. *)

val reset : t -> unit
(**
``reset x`` resets the dataframe ``x`` by setting all the time series to empty.
 *)

val sort : ?inc:bool -> t -> int -> t
(**
``sort`` is simiar to ``sort_by_name`` but using the column index rather than
the column name.
 *)

val sort_by_name : ?inc:bool -> t -> string -> t
(**
``sort ~inc x head`` sorts the entries in the dataframe ``x`` according to the
specified column by head name ``head``. By default, ``inc`` equals ``true``,
indicating increasing order.
 *)

val append_row : t -> elt array -> unit
(** ``append_row x row`` appends a row to the dataframe ``x``. *)

val append_col : t -> series -> string -> unit
(** ``append_col x col`` appends a column to the dataframe ``x``. *)

val insert_row : t -> int -> elt array -> unit
(**
``insert_row x i row`` inserts one ``row`` with at position ``i`` into
dataframe ``x``.
 *)

val insert_col : t -> int -> string -> series -> unit
(**
``insert_col x j col_head s`` inserts series ``s`` with column head ``col_head``
at position ``j`` into dataframe ``x``.
 *)

val remove_row : t -> int -> unit
(**
``remove_row x i`` removes the ``ith`` row of ``x``. Negative index is
accepted.
 *)

val remove_col : t -> int -> unit
(**
``remove_col x i`` removes the ``ith`` column of ``x``. Negative index is
accepted.
 *)

val concat_horizontal : t -> t -> t
(**
``concat_horizontal x y`` merges two dataframes ``x`` and ``y``. Note that
``x`` and ``y`` must have the same number of rows, and each column name should
be unique.
 *)

val concat_vertical : t -> t -> t
(**
``concat_vertical x y`` concatenates two dataframes by appending ``y`` to
``x``. The two dataframes ``x`` and ``y`` must have the same number of columns
and the same column names.
 *)


(** {6 Iteration functions} *)

val iteri_row : (int -> elt array -> unit) -> t -> unit
(** ``iteri_row f x`` iterates the rows of ``x`` and applies ``f``. *)

val iter_row :  (elt array -> unit) -> t -> unit
(** ``iter_row`` is simiar to ``iteri_row`` without passing in row indices. *)

val mapi_row : (int -> elt array -> elt array) -> t -> t
(**
``mapi_row f x`` transforms current dataframe ``x`` to a new dataframe by
applying function ``f``. Note that the returned value of ``f`` must be
consistent with ``x`` w.r.t to its length and type, otherwise runtime error
will occur.
 *)

val map_row : (elt array -> elt array) -> t -> t
(** ``map_row`` is simiar to ``mapi_row`` but without passing in row indices. *)

val filteri_row : (int -> elt array -> bool) -> t -> t
(**
``filteri_row`` creates a new dataframe from ``x`` by filtering out those rows
which satisfy the condition ``f``.
 *)

val filter_row : (elt array -> bool) -> t -> t
(** ``filter_row`` is similar to ``filteri_row`` without passing in row indices. *)

val filter_mapi_row : (int -> elt array -> elt array option) -> t -> t
(**
``filter_map_row f x`` creates a new dataframe from ``x`` by applying ``f`` to
each row. If ``f`` returns ``None`` then the row is excluded in the returned
dataframe; if ``f`` returns ``Some row`` then the row is included.
 *)

val filter_map_row : (elt array -> elt array option) -> t -> t
(** ``filter_map_row`` is similar to ``filter_mapi_row`` without passing in row indices. *)


(** {6 Extended indexing operators} *)

val ( .%( ) ) : t -> int * string -> elt
(** Extended indexing operator associated with ``get_by_name`` function. *)

val ( .%( )<- ) : t -> int * string -> elt -> unit
(** Extended indexing operator associated with ``set_by_name`` function. *)

val ( .?( ) ) : t -> (elt array -> bool) -> t
(** Extended indexing operator associated with ``filter_row`` function. *)

val ( .?( )<- ) : t -> (elt array -> bool) -> (elt array -> elt array) -> t
(**
Extended indexing operator associated with ``filter_map_row`` function.
Given a dataframe ``x``, ``f`` is used for filtering and ``g`` is used for
transforming. In other words, ``x.?(f) <- g`` means that if ``f row`` is
``true`` then ``g row`` is included in the returned dataframe.
 *)

val ( .$( ) ) : t -> int list * string list -> t
(** Extended indexing operator associated with ``get_slice_by_name`` function. *)


(** {6 IO & helper functions} *)

val of_csv : ?sep:char -> ?head:string array -> ?types:string array -> string -> t
(**
``of_csv ~sep ~head ~types fname`` creates a dataframe by reading the data in
a CSV file with the name ``fname``. Currently, the function supports four data
types: ``b`` for boolean; ``i`` for int; ``f`` for float; ``s`` for string.

Note if ``types`` parameter is ignored, then all the elements will be parsed
as string element by default.

Parameters:
  * ``sep``: delimiter, the default one is tab.
  * ``head``: column names, if not passed in, the first line of CSV file will be used.
  * ``types``: data type of each column, must be consistent with head.
 *)

val to_csv : ?sep:char -> t -> string -> unit
(**
``to_csv ~sep x fname`` converts a dataframe to CSV file of name ``fname``. The
delimiter is specified by ``sep``.
 *)

val to_rows : t -> elt array array
(** ``to_rows x`` returns an array of rows in ``x``. *)

val to_cols : t -> series array
(** ``to_cols x`` returns an arrays of columns in ``x``. *)

(* val print : t -> unit *)
(** ``print x`` pretty prints a dataframe on the terminal. *)

val elt_to_str : elt -> string
(** ``elt_to_str x`` converts element ``x`` to its string representation. *)
