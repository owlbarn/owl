(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) t
type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(** {6 Create sparse matrices} *)

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val eye : ('a, 'b) kind -> int -> ('a, 'b) t

val binary : ('a, 'b) kind -> int -> int -> ('a, 'b) t


(** {6 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int

val row_num : ('a, 'b) t -> int

val col_num : ('a, 'b) t -> int

val row_num_nz : ('a, 'b) t -> int

val col_num_nz : ('a, 'b) t -> int

val numel : ('a, 'b) t -> int

val nnz : ('a, 'b) t -> int

val nnz_rows : ('a, 'b) t -> int array

val nnz_cols : ('a, 'b) t -> int array

val density : ('a, 'b) t -> float


(** {6 Manipulate a matrix} *)

val set : ('a, 'b) t -> int -> int -> 'a -> unit

val get : ('a, 'b) t -> int -> int -> 'a

val reset : ('a, 'b) t -> unit

val fill : ('a, 'b) t -> 'a -> unit

val clone : ('a, 'b) t -> ('a, 'b) t

(* val transpose : ('a, 'b) t -> ('a, 'b) t *)

val diag : ('a, 'b) t -> ('a, 'b) t

val trace : ('a, 'b) t -> 'a

val row : ('a, 'b) t -> int -> ('a, 'b) t

val col : ('a, 'b) t -> int -> ('a, 'b) t

val rows : ('a, 'b) t -> int array -> ('a, 'b) t

val cols : ('a, 'b) t -> int array -> ('a, 'b) t


(** {6 Iterate elements, columns, and rows} *)

val iteri : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit

val iter : ('a -> unit) -> ('a, 'b) t -> unit

val mapi : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val fold : ('a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> 'a

val filteri : (int -> int -> 'a -> bool) -> ('a, 'b) t -> (int * int) array

val filter : ('a -> bool) -> ('a, 'b) t -> (int * int) array

val iteri_rows : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_rows : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iteri_cols : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_cols : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val mapi_rows : (int -> ('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val map_rows : (('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val mapi_cols : (int -> ('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val map_cols : (('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val fold_rows : ('a -> ('a, 'b) t -> 'a) -> 'a -> ('a, 'b) t -> 'a

val fold_cols : ('a -> ('a, 'b) t -> 'a) -> 'a -> ('a, 'b) t -> 'a

val iteri_nz : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit

val iter_nz : ('a -> unit) -> ('a, 'b) t -> unit

val mapi_nz : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map_nz : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val fold_nz : ('a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> 'a

val filteri_nz : (int -> int -> 'a -> bool) -> ('a, 'b) t -> (int * int) array

val filter_nz : ('a -> bool) -> ('a, 'b) t -> (int * int) array

val iteri_rows_nz : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_rows_nz : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iteri_cols_nz : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_cols_nz : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val mapi_rows_nz : (int -> ('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val map_rows_nz : (('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val mapi_cols_nz : (int -> ('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val map_cols_nz : (('a, 'b) t -> 'a) -> ('a, 'b) t -> 'a array

val fold_rows_nz : ('a -> ('a, 'b) t -> 'a) -> 'a -> ('a, 'b) t -> 'a

val fold_cols_nz : ('a -> ('a, 'b) t -> 'a) -> 'a -> ('a, 'b) t -> 'a


(** {6 Examin elements and compare two matrices} *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool

val for_all : ('a -> bool) -> ('a, 'b) t -> bool

val exists_nz : ('a -> bool) -> ('a, 'b) t -> bool

val not_exists_nz : ('a -> bool) -> ('a, 'b) t -> bool

val for_all_nz :  ('a -> bool) -> ('a, 'b) t -> bool

val is_zero : ('a, 'b) t -> bool

val is_positive : ('a, 'b) t -> bool

val is_negative : ('a, 'b) t -> bool

val is_nonpositive : ('a, 'b) t -> bool

val is_nonnegative : ('a, 'b) t -> bool

val is_equal : ('a, 'b) t -> ('a, 'b) t -> bool

val is_unequal : ('a, 'b) t -> ('a, 'b) t -> bool

val is_greater : ('a, 'b) t -> ('a, 'b) t -> bool

val is_smaller : ('a, 'b) t -> ('a, 'b) t -> bool

val equal_or_greater : ('a, 'b) t -> ('a, 'b) t -> bool

val equal_or_smaller : ('a, 'b) t -> ('a, 'b) t -> bool


(** {6 Basic mathematical operations of matrices} *)

val add : ('a, 'b) t ->('a, 'b) t ->('a, 'b) t

val sub : ('a, 'b) t ->('a, 'b) t ->('a, 'b) t

val mul : ('a, 'b) t ->('a, 'b) t ->('a, 'b) t

val div : ('a, 'b) t ->('a, 'b) t ->('a, 'b) t

val add_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val sub_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val mul_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val div_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val dot : ('a, 'b) t ->('a, 'b) t ->('a, 'b) t

val abs : ('a, 'b) t ->('a, 'b) t

val neg : ('a, 'b) t ->('a, 'b) t

val sum : ('a, 'b) t -> 'a

(* average : ('a, 'b) t -> 'a *)

(* val power : ('a, 'b) t -> 'a ->('a, 'b) t *)

(* val min : ('a, 'b) t -> 'a *)

(* val max : ('a, 'b) t -> 'a *)

(* val minmax : ('a, 'b) t -> 'a * 'a *)

(* val sum_rows : ('a, 'b) t ->('a, 'b) t *)

(* val sum_cols : ('a, 'b) t ->('a, 'b) t *)

(* val average_rows : ('a, 'b) t ->('a, 'b) t *)

(* val average_cols : ('a, 'b) t ->('a, 'b) t *)


(** {6 Randomisation functions} *)

val permutation_matrix : ('a, 'b) kind -> int -> ('a, 'b) t

val draw_rows : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array

val draw_cols : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array

val shuffle_rows : ('a, 'b) t -> ('a, 'b) t

val shuffle_cols : ('a, 'b) t -> ('a, 'b) t

val shuffle : ('a, 'b) t -> ('a, 'b) t


(** {6 Input/Output and helper functions} *)

val to_arrays : ('a, 'b) t -> 'a array array

val of_arrays : ('a, 'b) kind -> 'a array array -> ('a, 'b) t

val to_dense : ('a, 'b) t -> ('a, 'b) Owl_dense_matrix.t

val of_dense : ('a, 'b) Owl_dense_matrix.t -> ('a, 'b) t

val print : ('a, 'b) t -> unit

val pp_spmat : ('a, 'b) t -> unit

val save : ('a, 'b) t -> string -> unit

val load : string -> ('a, 'b) t
