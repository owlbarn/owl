(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Sparse matrix module *)

type spmat
(** Type of sparse matrices. It is defined in [types.ml] as record type. *)


(** {6 Create sparse matrices} *)

val zeros : int -> int -> spmat
(** [zeros m n] creates an [m] by [n] matrix where all the elements are zeros.
  This operation is very fast since it only allocates a small amount of memory.
  The memory will grow automatically as more elements are inserted.
 *)

val ones : int -> int -> spmat
(** [ones m n] creates an [m] by [n] matrix where all the elements are ones.
  This operation can be very slow if matrix size is big. You might consider to
  use dense matrix for better performance in this case.
 *)

val eye : int -> spmat
(** [eye m] creates an [m] by [m] identity matrix. *)

val binary : int -> int -> spmat

val uniform : ?scale:float -> int -> int -> spmat
(** [uniform m n] creates an [m] by [n] matrix where 10% ~ 15% elements
  follow a uniform distribution in [(0,1)] interval. [uniform ~scale:a m n]
  adjusts the interval to [(0,a)].
 *)

val uniform_int : ?a:int -> ?b:int -> int -> int -> spmat
(** [uniform ~a ~b m n] creates an [m] by [n] matrix where 10% ~ 15% elements
  follow a uniform distribution in [[a, b]] interval. By default, [a = 0] and
  [b = 100].
 *)

val linspace : float -> float -> int -> spmat
(** [linspace a b n] linearly divides the interval [[a,b]] into [n] pieces by
  creating an [m] by [1] row vector. E.g., [linspace 0. 5. 5] will create a
  row vector [[0;1;2;3;4;5]].
 *)


(** {6 Obtain the basic properties of a matrix} *)

val shape : spmat -> int * int
(** If [x] is an [m] by [n] matrix, [shape x] returns [(m,n)], i.e., the size
  of two dimensions of [x].
 *)

val row_num : spmat -> int
(** [row_num x] returns the number of rows in matrix [x]. *)

val col_num : spmat -> int
(** [col_num x] returns the number of columns in matrix [x]. *)

val row_num_nz : spmat -> int
(** [row_num_nz x] returns the number of non-zero rows in matrix [x]. *)

val col_num_nz : spmat -> int
(** [col_num_nz x] returns the number of non-zero columns in matrix [x]. *)

val numel : spmat -> int
(** [row_num_nz x] returns the number of elements in matrix [x]. It is equivalent
  to [(row_num x) * (col_num x)].
 *)

val nnz : spmat -> int
(** [nnz x] returns the number of non-zero elements in matrix [x]. *)

val nnz_rows : spmat -> int array
(** [nnz_rows x] returns the number of non-zero rows in matrix [x]. A non-zero
  row means there is at least one non-zero element in that row.
 *)

val nnz_cols : spmat -> int array
(** [nnz_cols x] returns the number of non-zero cols in matrix [x]. *)

val density : spmat -> float
(** [density x] returns the density of non-zero element. This operation is
  equivalent to [nnz x] divided by [numel x].
 *)

(** {6 Manipulate a matrix} *)

val set : spmat -> int -> int -> float -> unit
(** [set x i j a] sets the element [(i,j)] of [x] to value [a]. *)

val get : spmat -> int -> int -> float
(** [get x i j] returns the value of element [(i,j)] of [x]. *)

val reset : spmat -> unit

val clone : spmat -> spmat

val transpose : spmat -> spmat

val diag : spmat -> spmat

val trace : spmat -> float

val row : spmat -> int -> spmat

val col : spmat -> int -> spmat

val rows : spmat -> int array -> spmat

val cols : spmat -> int array -> spmat


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> float -> 'a) -> spmat -> unit

val iter : (float -> 'a) -> spmat -> unit

val mapi : (int -> int -> float -> float) -> spmat -> spmat

val map : (float -> float) -> spmat -> spmat

val fold : ('a -> float -> 'a) -> 'a -> spmat -> 'a

val filteri : (int -> int -> float -> bool) -> spmat -> (int * int) array

val filter : (float -> bool) -> spmat -> (int * int) array

val iteri_rows : (int -> spmat -> unit) -> spmat -> unit

val iter_rows : (spmat -> unit) -> spmat -> unit

val iteri_cols : (int -> spmat -> unit) -> spmat -> unit

val iter_cols : (spmat -> unit) -> spmat -> unit

val map_rows : (spmat -> 'a) -> spmat -> 'a array

val mapi_rows : (int -> spmat -> 'a) -> spmat -> 'a array

val map_cols : (spmat -> 'a) -> spmat -> 'a array

val mapi_cols : (int -> spmat -> 'a) -> spmat -> 'a array

val fold_rows : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a

val fold_cols : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a

val iteri_nz : (int -> int -> float -> 'a) -> spmat -> unit

val iter_nz : (float -> 'a) -> spmat -> unit

val mapi_nz : (int -> int -> float -> float) -> spmat -> spmat

val map_nz : (float -> float) -> spmat -> spmat

val fold_nz : ('a -> float -> 'a) -> 'a -> spmat -> 'a

val filteri_nz : (int -> int -> float -> bool) -> spmat -> (int * int) array

val filter_nz : (float -> bool) -> spmat -> (int * int) array

val iter_rows_nz : (spmat -> unit) -> spmat -> unit

val iteri_rows_nz : (int -> spmat -> unit) -> spmat -> unit

val iter_cols_nz : (spmat -> unit) -> spmat -> unit

val iteri_cols_nz : (int -> spmat -> unit) -> spmat -> unit

val map_rows_nz : (spmat -> 'a) -> spmat -> 'a array

val map_cols_nz : (spmat -> 'a) -> spmat -> 'a array

val mapi_rows_nz : (int -> spmat -> 'a) -> spmat -> 'a array

val mapi_cols_nz : (int -> spmat -> 'a) -> spmat -> 'a array

val fold_rows_nz : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a

val fold_cols_nz : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a


(** {6 Examine the elements in a matrix} *)

val exists : (float -> bool) -> spmat -> bool

val not_exists : (float -> bool) -> spmat -> bool

val for_all : (float -> bool) -> spmat -> bool

val exists_nz : (float -> bool) -> spmat -> bool

val not_exists_nz : (float -> bool) -> spmat -> bool

val for_all_nz :  (float -> bool) -> spmat -> bool


(** {6 Basic mathematical operations of matrices} *)

val mul_scalar : spmat -> float -> spmat

val div_scalar : spmat -> float -> spmat

val add : spmat -> spmat -> spmat

val sub : spmat -> spmat -> spmat

val dot : spmat -> spmat -> spmat

val mul : spmat -> spmat -> spmat

val div : spmat -> spmat -> spmat

val abs : spmat -> spmat

val neg : spmat -> spmat

val sum : spmat -> float

val average : spmat -> float

val is_zero : spmat -> bool

val is_positive : spmat -> bool

val is_negative : spmat -> bool

val is_nonnegative : spmat -> bool

val min : spmat -> float

val max : spmat -> float

val minmax : spmat -> float * float

val sum_rows : spmat -> spmat

val sum_cols : spmat -> spmat

val average_rows : spmat -> spmat

val average_cols : spmat -> spmat


(** {6 Compare two matrices} *)

val is_equal : spmat -> spmat -> bool

val is_unequal : spmat -> spmat -> bool

val is_greater : spmat -> spmat -> bool

val is_smaller : spmat -> spmat -> bool

val equal_or_greater : spmat -> spmat -> bool

val equal_or_smaller : spmat -> spmat -> bool


(** {6 Randomisation functions} *)

val permutation_matrix : int -> spmat

val draw_rows : ?replacement:bool -> spmat -> int -> spmat * int array

val draw_cols : ?replacement:bool -> spmat -> int -> spmat * int array

val shuffle_rows : spmat -> spmat

val shuffle_cols : spmat -> spmat

val shuffle : spmat -> spmat


(** {6 Input/Output and helper functions} *)

val to_dense : spmat -> Dense.dsmat

val of_dense : Dense.dsmat -> spmat

val print : spmat -> unit

val pp_spmat : spmat -> unit

val save : spmat -> string -> unit

val load : string -> spmat


(** {6 Shorhand infix operators} *)

val ( +@ ) : spmat -> spmat -> spmat

val ( -@ ) : spmat -> spmat -> spmat

val ( *@ ) : spmat -> spmat -> spmat

val ( /@ ) : spmat -> spmat -> spmat

val ( $@ ) : spmat -> spmat -> spmat

val ( **@ ) : spmat -> float -> spmat

val ( *$ ) : spmat -> float -> spmat

val ( /$ ) : spmat -> float -> spmat

val ( $* ) : float -> spmat -> spmat

val ( $/ ) : float -> spmat -> spmat

val ( =@ ) : spmat -> spmat -> bool

val ( >@ ) : spmat -> spmat -> bool

val ( <@ ) : spmat -> spmat -> bool

val ( <>@ ) : spmat -> spmat -> bool

val ( >=@ ) : spmat -> spmat -> bool

val ( <=@ ) : spmat -> spmat -> bool

(* val ( @@ ) : (float -> float) -> dsmat -> dsmat *)
