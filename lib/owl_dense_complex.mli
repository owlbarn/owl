(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Complex dense matrix module *)

type mat = Gsl.Matrix_complex.matrix

type elt = Complex.t


(** {6 Create dense matrices} *)

val empty : int -> int -> mat

val create : int -> int -> elt -> mat

val zeros : int -> int -> mat

val ones : int -> int -> mat

val eye : int -> mat

val sequential : int -> int -> mat


(** {7 Dense vectors and meshgrids} *)

val vector : int -> mat

val vector_zeros : int -> mat

val vector_ones : int -> mat


(** {6 Obtain the basic properties of a matrix} *)

val shape : mat -> int * int

val row_num : mat -> int

val col_num : mat -> int

val numel : mat -> int

val same_shape : mat -> mat -> bool


(** {6 Manipulate a matrix} *)

val get : mat -> int -> int -> elt

val set : mat -> int -> int -> elt -> unit

val row : mat -> int -> mat

val col : mat -> int -> mat

val rows : mat -> int array -> mat

val cols : mat -> int array -> mat

val clone : mat -> mat

val copy_to : mat -> mat -> unit

val copy_row_to : mat -> mat -> int -> unit

val copy_col_to : mat -> mat -> int -> unit

val concat_vertical : mat -> mat -> mat

val concat_horizontal : mat -> mat -> mat

val transpose : mat -> mat


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> elt -> 'a) -> mat -> unit

val iter : (elt -> 'a) -> mat -> unit

val mapi : (int -> int -> elt -> elt) -> mat -> mat

val map : (elt -> elt) -> mat -> mat

val fold : ('a -> elt -> 'a) -> 'a -> mat -> 'a

val filteri : (int -> int -> elt -> bool) -> mat -> (int * int) array

val filter : (elt -> bool) -> mat -> (int * int) array

val iteri_rows : (int -> mat -> 'a) -> mat -> unit

val iter_rows : (mat -> 'a) -> mat -> unit

val iteri_cols : (int -> mat -> 'a) -> mat -> unit

val iter_cols : (mat -> 'a) -> mat -> unit

val filteri_rows : (int -> mat -> bool) -> mat -> int array

val filter_rows : (mat -> bool) -> mat -> int array

val filteri_cols : (int -> mat -> bool) -> mat -> int array

val filter_cols : (mat -> bool) -> mat -> int array

val fold_rows : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val fold_cols : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val mapi_rows : (int -> mat -> 'a) -> mat -> 'a array

val map_rows : (mat -> 'a) -> mat -> 'a array

val mapi_cols : (int -> mat -> 'a) -> mat -> 'a array

val map_cols : (mat -> 'a) -> mat -> 'a array

val mapi_by_row : ?d:int -> (int -> mat -> mat) -> mat -> mat

val map_by_row : ?d:int -> (mat -> mat) -> mat -> mat

val mapi_by_col : ?d:int -> (int -> mat -> mat) -> mat -> mat

val map_by_col : ?d:int -> (mat -> mat) -> mat -> mat

val mapi_at_row : (int -> int -> elt -> elt) -> mat -> int -> mat

val map_at_row : (elt -> elt) -> mat -> int -> mat

val mapi_at_col : (int -> int -> elt -> elt) -> mat -> int -> mat

val map_at_col : (elt -> elt) -> mat -> int -> mat


(** {6 Examine the elements in a matrix} *)

val exists : (elt -> bool) -> mat -> bool

val not_exists : (elt -> bool) -> mat -> bool

val for_all : (elt -> bool) -> mat -> bool


(** {6 Basic mathematical operations of matrices} *)

val add : mat -> mat -> mat

val sub : mat -> mat -> mat

val mul : mat -> mat -> mat

val div : mat -> mat -> mat

val dot : mat -> mat -> mat

val abs : mat -> mat

val neg : mat -> mat

val power : mat -> elt -> mat

val add_scalar : mat -> elt -> mat

val sub_scalar : mat -> elt -> mat

val mul_scalar : mat -> elt -> mat

val div_scalar : mat -> elt -> mat

val sum : mat -> elt

val average : mat -> elt

val sum_rows : mat -> mat

val sum_cols : mat -> mat

val average_rows : mat -> mat

val average_cols : mat -> mat


(** {6 Shorhand infix operators} *)

val ( +@ ) : mat -> mat -> mat
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : mat -> mat -> mat
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : mat -> mat -> mat
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : mat -> mat -> mat
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( $@ ) : mat -> mat -> mat
(** Shorthand for [dot x y], i.e., [x $@ y] *)

val ( **@ ) : mat -> elt -> mat
(** Shorthand for [power x a], i.e., [x **@ a] *)

val ( +$ ) : mat -> elt -> mat
(** Shorthand for [add_scalar x a], i.e., [x +$ a] *)

val ( -$ ) : mat -> elt -> mat
(** Shorthand for [sub_scalar x a], i.e., [x -$ a] *)

val ( *$ ) : mat -> elt -> mat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : mat -> elt -> mat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $+ ) : elt -> mat -> mat
(** Shorthand for [add_scalar x a], i.e., [a $+ x] *)

val ( $- ) : elt -> mat -> mat
(** Shorthand for [sub_scalar x a], i.e., [a -$ x] *)

val ( $* ) : elt -> mat -> mat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : elt -> mat -> mat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)


val pp_dsmat_complex : mat -> unit
