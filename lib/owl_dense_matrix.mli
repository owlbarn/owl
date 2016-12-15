(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type ('a, 'b) mat = ('a, 'b, Bigarray.c_layout) Bigarray.Array2.t
type ('a, 'b) kind = ('a, 'b) Bigarray.kind
type mat_d = (float, Bigarray.float64_elt) mat

(** {6 Create dense matrices} *)

val empty : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val create : ('a, 'b) kind -> int -> int -> 'a -> ('a, 'b) mat

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val eye : ('a, 'b) kind -> int -> ('a, 'b) mat

val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val uniform : ?scale:float -> (float, 'b) kind -> int -> int -> (float, 'b) mat

val gaussian : ?sigma:float -> (float, 'b) kind -> int -> int -> (float, 'b) mat

(* val semidef : (float, 'b) kind -> int -> (float, 'b) mat *)


(** {7 Dense vectors and meshgrids} *)

val vector : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_zeros : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_ones : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_uniform : (float, 'b) kind -> int -> (float, 'b) mat

val linspace : float -> float -> int -> mat_d

val meshgrid : float -> float -> float -> float -> int -> int -> mat_d * mat_d

val meshup : mat_d -> mat_d -> mat_d * mat_d


(** {6 Obtain the basic properties of a matrix} *)

val shape : ('a, 'b) mat -> int * int

val row_num : ('a, 'b) mat -> int

val col_num : ('a, 'b) mat -> int

val numel : ('a, 'b) mat -> int

val same_shape : ('a, 'b) mat -> ('a, 'b) mat -> bool

val reshape : int -> int -> ('a, 'b) mat -> ('a, 'b) mat


(** {6 Manipulate a matrix} *)

val get : ('a, 'b) mat -> int -> int -> 'a

val set : ('a, 'b) mat -> int -> int -> 'a -> unit

val row : ('a, 'b) mat -> int -> ('a, 'b) mat

val col : ('a, 'b) mat -> int -> ('a, 'b) mat

val rows : ('a, 'b) mat -> int array -> ('a, 'b) mat

val cols : ('a, 'b) mat -> int array -> ('a, 'b) mat

val fill : ('a, 'b) mat -> 'a -> unit

val clone : ('a, 'b) mat -> ('a, 'b) mat

val copy_to : ('a, 'b) mat -> ('a, 'b) mat -> unit

val copy_row_to : ('a, 'b) mat -> ('a, 'b) mat -> int -> unit

val copy_col_to : ('a, 'b) mat -> ('a, 'b) mat -> int -> unit

val concat_vertical : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val concat_horizontal : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val transpose : ('a, 'b) mat -> ('a, 'b) mat

val diag : ('a, 'b) mat -> ('a, 'b) mat

val trace : ('a, 'b) mat -> 'a

val add_diag : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val replace_row : ('a, 'b) mat -> ('a, 'b) mat -> int -> ('a, 'b) mat

val replace_col : ('a, 'b) mat -> ('a, 'b) mat -> int -> ('a, 'b) mat

val swap_rows : ('a, 'b) mat -> int -> int -> ('a, 'b) mat

val swap_cols : ('a, 'b) mat -> int -> int -> ('a, 'b) mat


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> 'a -> unit) -> ('a, 'b) mat -> unit

val iter : ('a -> unit) -> ('a, 'b) mat -> unit

val mapi : (int -> int -> 'a -> 'a) -> ('a, 'b) mat -> ('a, 'b) mat

val map : ('a -> 'a) -> ('a, 'b) mat -> ('a, 'b) mat

val fold : ('c -> 'a -> 'c) -> 'c -> ('a, 'b) mat -> 'c

val filteri : (int -> int -> 'a -> bool) -> ('a, 'b) mat -> (int * int) array

val filter : ('a -> bool) -> ('a, 'b) mat -> (int * int) array

val iteri_rows : (int -> ('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val iter_rows : (('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val iteri_cols : (int -> ('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val iter_cols : (('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val filteri_rows : (int -> ('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val filter_rows : (('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val filteri_cols : (int -> ('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val filter_cols : (('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val fold_rows : ('c -> ('a, 'b) mat -> 'c) -> 'c -> ('a, 'b) mat -> 'c

val fold_cols : ('c -> ('a, 'b) mat -> 'c) -> 'c -> ('a, 'b) mat -> 'c

val mapi_rows : (int -> ('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val map_rows : (('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val mapi_cols : (int -> ('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val map_cols : (('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val mapi_by_row : int -> (int -> ('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val map_by_row : int -> (('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val mapi_by_col : int -> (int -> ('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val map_by_col : int -> (('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val mapi_at_row : (int -> int -> 'a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat

val map_at_row : ('a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat

val mapi_at_col : (int -> int -> 'a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat

val map_at_col : ('a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat


(** {6 Examine the elements in a matrix} *)

val exists : ('a -> bool) -> ('a, 'b) mat -> bool

val not_exists : ('a -> bool) -> ('a, 'b) mat -> bool

val for_all : ('a -> bool) -> ('a, 'b) mat -> bool


(** {6 Compare two matrices} *)

val is_equal : ('a, 'b) mat -> ('a, 'b) mat -> bool

val is_unequal : ('a, 'b) mat -> ('a, 'b) mat -> bool

val is_greater : ('a, 'b) mat -> ('a, 'b) mat -> bool

val is_smaller : ('a, 'b) mat -> ('a, 'b) mat -> bool

val equal_or_greater : ('a, 'b) mat -> ('a, 'b) mat -> bool

val equal_or_smaller : ('a, 'b) mat -> ('a, 'b) mat -> bool


(** {6 Basic mathematical operations of matrices} *)

val add : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val sub : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val mul : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val div : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

(* val dot : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat *)

val abs : ('a, 'b) mat -> ('a, 'b) mat

val neg : ('a, 'b) mat -> ('a, 'b) mat

val add_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val sub_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val mul_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val div_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val sum : ('a, 'b) mat -> 'a

val average : (float, 'b) mat -> float

val min : (float, 'b) mat -> float

val min_i : (float, 'b) mat -> float * int * int

val max : (float, 'b) mat -> float

val max_i : (float, 'b) mat -> float * int * int

val minmax : (float, 'b) mat -> float * float * int * int * int * int

val is_zero : ('a, 'b) mat -> bool

val is_positive : ('a, 'b) mat -> bool

val is_negative : ('a, 'b) mat -> bool

val is_nonpositive : ('a, 'b) mat -> bool

val is_nonnegative : ('a, 'b) mat -> bool

val log : ('a, 'b) mat -> ('a, 'b) mat

val log10 : ('a, 'b) mat -> ('a, 'b) mat

val exp : ('a, 'b) mat -> ('a, 'b) mat

val sigmoid : mat_d -> mat_d

val sum_rows : mat_d -> mat_d

val sum_cols : mat_d -> mat_d

val average_rows : mat_d -> mat_d

val average_cols : mat_d -> mat_d

val min_rows : (float, 'b) mat -> (float * int * int) array

val min_cols : (float, 'b) mat -> (float * int * int) array

val max_rows : (float, 'b) mat -> (float * int * int) array

val max_cols : (float, 'b) mat -> (float * int * int) array


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> ('a, 'b) mat -> int -> ('a, 'b) mat * int array

val draw_cols : ?replacement:bool -> ('a, 'b) mat -> int -> ('a, 'b) mat * int array

val shuffle_rows : ('a, 'b) mat -> ('a, 'b) mat

val shuffle_cols : ('a, 'b) mat -> ('a, 'b) mat

val shuffle: ('a, 'b) mat -> ('a, 'b) mat


(** {6 Input/Output and helper functions} *)

val to_array : mat_d -> float array

val of_array : float array -> int -> int -> mat_d

val to_arrays : mat_d -> float array array

val of_arrays : float array array -> mat_d

val to_ndarray : ('a, 'b) mat -> ('a, 'b) Owl_dense_ndarray.t

val of_ndarray : ('a, 'b) Owl_dense_ndarray.t -> ('a, 'b) mat

val print : (float, 'b) mat -> unit

val pp_dsmat : (float, 'b) mat -> unit

val save : (float, 'b) mat -> string -> unit

val load : string -> (float, 'b) mat

val save_txt : mat_d -> string -> unit

val load_txt : string -> mat_d


(** {6 Shorhand infix operators} *)

val ( >> ) : ('a, 'b) mat -> ('a, 'b) mat -> unit
(** Shorthand for [copy_to x y], i.e., x >> y *)

val ( << ) : ('a, 'b) mat -> ('a, 'b) mat -> unit
(** Shorthand for [copy_to y x], i.e., x << y *)

val ( @= ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [concat_vertical x y], i.e., x @= y *)

val ( @|| ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [concat_horizontal x y], i.e., x @|| y *)

val ( +@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( +$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [add_scalar x a], i.e., [x +$ a] *)

val ( -$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [sub_scalar x a], i.e., [x -$ a] *)

val ( *$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $+ ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [add_scalar x a], i.e., [a $+ x] *)

val ( $- ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [sub_scalar x a], i.e., [a -$ x] *)

val ( $* ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( =@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

val ( @@ ) : ('a -> 'a) -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [map f x], i.e., f @@ x *)
