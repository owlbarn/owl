(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type elt = float
type mat = (float, Bigarray.float64_elt) Owl_sparse_matrix_generic.t


(** {6 Create sparse matrices} *)

val zeros : int -> int -> mat

val ones : int -> int -> mat

val eye : int -> mat

val binary : int -> int -> mat

val uniform : ?scale:float -> int -> int -> mat

val uniform_int : ?a:int -> ?b:int -> int -> int -> mat

val sequential : int -> int -> mat

val linspace : elt -> elt -> int -> mat


(** {6 Obtain the basic properties of a matrix} *)

val shape : mat -> int * int

val row_num : mat -> int

val col_num : mat -> int

val row_num_nz : mat -> int

val col_num_nz : mat -> int

val numel : mat -> int

val nnz : mat -> int

val nnz_rows : mat -> int array

val nnz_cols : mat -> int array

val density : mat -> float


(** {6 Manipulate a matrix} *)

val insert : mat -> int -> int -> elt -> unit

val get : mat -> int -> int -> elt

val set : mat -> int -> int -> elt -> unit

val reset : mat -> unit

val fill : mat -> elt -> unit

val clone : mat -> mat

val transpose : mat -> mat

val diag : mat -> mat

val row : mat -> int -> mat

val col : mat -> int -> mat

val rows : mat -> int array -> mat

val cols : mat -> int array -> mat

val prune : mat -> elt -> float -> unit


(** {6 Iterate elements, columns, and rows} *)

val iteri : (int -> int -> elt -> unit) -> mat -> unit

val iter : (elt -> unit) -> mat -> unit

val mapi : (int -> int -> elt -> elt) -> mat -> mat

val map : (elt -> elt) -> mat -> mat

val foldi : (int -> int -> 'a -> elt -> 'a) -> 'a -> mat -> 'a

val fold : ('a -> elt -> 'a) -> 'a -> mat -> 'a

val filteri : (int -> int -> elt -> bool) -> mat -> (int * int) array

val filter : (elt -> bool) -> mat -> (int * int) array

val iteri_rows : (int -> mat -> unit) -> mat -> unit

val iter_rows : (mat -> unit) -> mat -> unit

val iteri_cols : (int -> mat -> unit) -> mat -> unit

val iter_cols : (mat -> unit) -> mat -> unit

val mapi_rows : (int -> mat -> 'a) -> mat -> 'a array

val map_rows : (mat -> 'a) -> mat -> 'a array

val mapi_cols : (int -> mat -> 'a) -> mat -> 'a array

val map_cols : (mat -> 'a) -> mat -> 'a array

val fold_rows : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val fold_cols : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val iteri_nz : (int -> int -> elt -> unit) -> mat -> unit

val iter_nz : (elt -> unit) -> mat -> unit

val mapi_nz : (int -> int -> elt -> elt) -> mat -> mat

val map_nz : (elt -> elt) -> mat -> mat

val foldi_nz : (int -> int -> 'a -> elt -> 'a) -> 'a -> mat -> 'a

val fold_nz : ('a -> elt -> 'a) -> 'a -> mat -> 'a

val filteri_nz : (int -> int -> elt -> bool) -> mat -> (int * int) array

val filter_nz : (elt -> bool) -> mat -> (int * int) array

val iteri_rows_nz : (int -> mat -> unit) -> mat -> unit

val iter_rows_nz : (mat -> unit) -> mat -> unit

val iteri_cols_nz : (int -> mat -> unit) -> mat -> unit

val iter_cols_nz : (mat -> unit) -> mat -> unit

val mapi_rows_nz : (int -> mat -> 'a) -> mat -> 'a array

val map_rows_nz : (mat -> 'a) -> mat -> 'a array

val mapi_cols_nz : (int -> mat -> 'a) -> mat -> 'a array

val map_cols_nz : (mat -> 'a) -> mat -> 'a array

val fold_rows_nz : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val fold_cols_nz : ('a -> mat -> 'a) -> 'a -> mat -> 'a


(** {6 Examin elements and compare two matrices} *)

val exists : (elt -> bool) -> mat -> bool

val not_exists : (elt -> bool) -> mat -> bool

val for_all : (elt -> bool) -> mat -> bool

val exists_nz : (elt -> bool) -> mat -> bool

val not_exists_nz : (elt -> bool) -> mat -> bool

val for_all_nz :  (elt -> bool) -> mat -> bool

val is_zero : mat -> bool

val is_positive : mat -> bool

val is_negative : mat -> bool

val is_nonnegative : mat -> bool

val is_equal : mat -> mat -> bool

val is_unequal : mat -> mat -> bool

val is_greater : mat -> mat -> bool

val is_smaller : mat -> mat -> bool

val equal_or_greater : mat -> mat -> bool

val equal_or_smaller : mat -> mat -> bool


(** {6 Randomisation functions} *)

val permutation_matrix : int -> mat

val draw_rows : ?replacement:bool -> mat -> int -> mat * int array

val draw_cols : ?replacement:bool -> mat -> int -> mat * int array

val shuffle_rows : mat -> mat

val shuffle_cols : mat -> mat

val shuffle : mat -> mat


(** {6 Input/Output and helper functions} *)

val to_array : mat -> (int array * elt) array

val of_array : int -> int -> (int array * elt) array -> mat

val to_dense : mat -> Owl_dense_matrix_d.mat

val of_dense : Owl_dense_matrix_d.mat -> mat

val print : mat -> unit

val save : mat -> string -> unit

val load : string -> mat


(** {6 Unary mathematical operations } *)

val min : mat -> elt

val max : mat -> elt

val minmax : mat -> elt * elt

val trace : mat -> elt

val sum : mat -> elt

val average : mat -> elt

val sum_rows : mat -> mat

val sum_cols : mat -> mat

val average_rows : mat -> mat

val average_cols : mat -> mat

val abs : mat -> mat

val neg : mat -> mat


(** {6 Binary mathematical operations } *)

val add : mat -> mat -> mat

val sub : mat -> mat -> mat

val mul : mat -> mat -> mat

val div : mat -> mat -> mat

val dot : mat -> mat -> mat

val add_scalar : mat -> elt -> mat

val sub_scalar : mat -> elt -> mat

val mul_scalar : mat -> elt -> mat

val div_scalar : mat -> elt -> mat

val power_scalar : mat -> elt -> mat
