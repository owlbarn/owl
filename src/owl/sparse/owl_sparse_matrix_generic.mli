(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Sparse matrix module *)


type ('a, 'b) t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(** Type of sparse matrices. It is defined in [types.ml] as record type. *)


(** {6 Create sparse matrices} *)

val zeros : ?density:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [zeros m n] creates an [m] by [n] matrix where all the elements are zeros.
  This operation is very fast since it only allocates a small amount of memory.
  The memory will grow automatically as more elements are inserted.
 *)

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [ones m n] creates an [m] by [n] matrix where all the elements are ones.
  This operation can be very slow if matrix size is big. You might consider to
  use dense matrix for better performance in this case.
 *)

val eye : ('a, 'b) kind -> int -> ('a, 'b) t
(** [eye m] creates an [m] by [m] identity matrix. *)

val binary : ?density:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [binary m n] creates an [m] by [n] random matrix where 10% ~ 15% elements are 1. *)

val uniform : ?density:float -> ?scale:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [uniform m n] creates an [m] by [n] matrix where 10% ~ 15% elements
  follow a uniform distribution in [(0,1)] interval. [uniform ~scale:a m n]
  adjusts the interval to [(0,a)].
 *)

val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) t


(** {6 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int
(** If [x] is an [m] by [n] matrix, [shape x] returns [(m,n)], i.e., the size
  of two dimensions of [x].
 *)

val row_num : ('a, 'b) t -> int
(** [row_num x] returns the number of rows in matrix [x]. *)

val col_num : ('a, 'b) t -> int
(** [col_num x] returns the number of columns in matrix [x]. *)

val row_num_nz : ('a, 'b) t -> int
(** [row_num_nz x] returns the number of non-zero rows in matrix [x]. *)

val col_num_nz : ('a, 'b) t -> int
(** [col_num_nz x] returns the number of non-zero columns in matrix [x]. *)

val numel : ('a, 'b) t -> int
(** [numel x] returns the number of elements in matrix [x]. It is equivalent
  to [(row_num x) * (col_num x)].
 *)

val nnz : ('a, 'b) t -> int
(** [nnz x] returns the number of non-zero elements in matrix [x]. *)

val nnz_rows : ('a, 'b) t -> int array
(** [nnz_rows x] returns the number of non-zero rows in matrix [x]. A non-zero
  row means there is at least one non-zero element in that row.
 *)

val nnz_cols : ('a, 'b) t -> int array
(** [nnz_cols x] returns the number of non-zero cols in matrix [x]. *)

val density : ('a, 'b) t -> float
(** [density x] returns the density of non-zero element. This operation is
  equivalent to [nnz x] divided by [numel x].
 *)

val kind : ('a, 'b) t -> ('a, 'b) kind


(** {6 Manipulate a matrix} *)

val get : ('a, 'b) t -> int -> int -> 'a
(** [set x i j a] sets the element [(i,j)] of [x] to value [a]. *)

val set : ('a, 'b) t -> int -> int -> 'a -> unit
(** [get x i j] returns the value of element [(i,j)] of [x]. *)

val insert : ('a, 'b) t -> int -> int -> 'a -> unit

val reset : ('a, 'b) t -> unit
(** [reset x] resets all the elements in [x] to [0]. *)

val fill : ('a, 'b) t -> 'a -> unit

val copy : ('a, 'b) t -> ('a, 'b) t
(** [copy x] makes an exact copy of matrix [x]. Note that the copy becomes
  mutable no matter [w] is mutable or not. This is expecially useful if you
  want to modify certain elements in an immutable matrix from math operations.
 *)

val transpose : ('a, 'b) t -> ('a, 'b) t
(** [transpose x] transposes an [m] by [n] matrix to [n] by [m] one. *)

val diag : ('a, 'b) t -> ('a, 'b) t
(** [diag x] returns the diagonal elements of [x]. *)

val row : ('a, 'b) t -> int -> ('a, 'b) t
(** [row x i] returns the row [i] of [x]. *)

val col : ('a, 'b) t -> int -> ('a, 'b) t
(** [col x j] returns the column [j] of [x]. *)

val rows : ('a, 'b) t -> int array -> ('a, 'b) t
(** [rows x a] returns the rows (defined in an int array [a]) of [x]. The
  returned rows will be combined into a new sparse matrix. The order of rows in
  the new matrix is the same as that in the array [a].
 *)

val cols : ('a, 'b) t -> int array -> ('a, 'b) t
(** Similar to [rows], [cols x a] returns the columns (specified in array [a])
  of x in a new sparse matrix.
 *)

val prune : ('a, 'b) t -> 'a -> float -> unit
(** [prune x ...] *)

val concat_vertical : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [concat_vertical x y] not implemented yet *)

val concat_horizontal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [concat_horizontal x y] not implemented yet *)


(** {6 Iterate elements, columns, and rows} *)

val iteri : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit
(** [iteri f x] iterates all the elements in [x] and applies the user defined
  function [f : int -> int -> float -> 'a]. [f i j v] takes three parameters,
  [i] and [j] are the coordinates of current element, and [v] is its value.
 *)

val iter : ('a -> unit) -> ('a, 'b) t -> unit
(** [iter f x] is the same as as [iteri f x] except the coordinates of the
  current element is not passed to the function [f : float -> 'a]
 *)

val mapi : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [mapi f x] maps each element in [x] to a new value by applying
  [f : int -> int -> float -> float]. The first two parameters are the
  coordinates of the element, and the third parameter is the value.
 *)

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [map f x] is similar to [mapi f x] except the coordinates of the
  current element is not passed to the function [f : float -> float]
 *)

val foldi : (int -> int -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val fold : ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold f a x] folds all the elements in [x] with the function
  [f : 'a -> float -> 'a]. For an [m] by [n] matrix [x], the order of folding
  is from [(0,0)] to [(m-1,n-1)], row by row.
 *)

val filteri : (int -> int -> 'a -> bool) -> ('a, 'b) t -> (int * int) array
(** [filteri f x] uses [f : int -> int -> float -> bool] to filter out certain
  elements in [x]. An element will be included if [f] returns [true]. The
  returned result is a list of coordinates of the selected elements.
 *)

val filter : ('a -> bool) -> ('a, 'b) t -> (int * int) array
(** Similar to [filteri], but the coordinates of the elements are not passed to
  the function [f : float -> bool].
 *)

val iteri_rows : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** [iteri_rows f x] iterates every row in [x] and applies function
  [f : int -> mat -> unit] to each of them.
 *)

val iter_rows : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** Similar to [iteri_rows] except row number is not passed to [f]. *)

val iteri_cols : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** [iteri_cols f x] iterates every column in [x] and applies function
  [f : int -> mat -> unit] to each of them. Column number is passed to [f] as
  the first parameter.
 *)

val iter_cols : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** Similar to [iteri_cols] except col number is not passed to [f]. *)

val mapi_rows : (int -> ('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** [mapi_rows f x] maps every row in [x] to a type ['a] value by applying
  function [f : int -> mat -> 'a] to each of them. The results is an array of
  all the returned values.
 *)

val map_rows : (('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** Similar to [mapi_rows] except row number is not passed to [f]. *)

val mapi_cols : (int -> ('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** [mapi_cols f x] maps every column in [x] to a type ['a] value by applying
  function [f : int -> mat -> 'a].
 *)

val map_cols : (('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** Similar to [mapi_cols] except column number is not passed to [f]. *)

val fold_rows : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_rows f a x] folds all the rows in [x] using function [f]. The order
  of folding is from the first row to the last one.
 *)

val fold_cols : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_cols f a x] folds all the columns in [x] using function [f]. The
  order of folding is from the first column to the last one.
 *)

val iteri_nz : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit
(** [iteri_nz f x] iterates all the non-zero elements in [x] by applying the
  function [f : int -> int -> float -> 'a]. It is much faster than [iteri].
 *)

val iter_nz : ('a -> unit) -> ('a, 'b) t -> unit
(** Similar to [iter_nz] except the coordinates of elements are not passed to [f]. *)

val mapi_nz : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [mapi_nz f x] is similar to [mapi f x] but only applies [f] to non-zero
  elements in [x]. The zeros in [x] will remain the same in the new matrix.
 *)

val map_nz : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Similar to [mapi_nz] except the coordinates of elements are not passed to [f]. *)

val foldi_nz : (int -> int -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val fold_nz : ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_nz f a x] is similar to [fold f a x] but only applies to non-zero
  rows in [x]. zero rows will be simply skipped in folding.
 *)

val filteri_nz : (int -> int -> 'a -> bool) -> ('a, 'b) t -> (int * int) array
(** [filteri_nz f x] is similar to [filter f x] but only applies [f] to
  non-zero elements in [x].
 *)

val filter_nz : ('a -> bool) -> ('a, 'b) t -> (int * int) array
(** [filter_nz f x] is similar to [filteri_nz] except that the coordinates of
  matrix elements are not passed to [f].
 *)

val iteri_rows_nz : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** [iteri_rows_nz f x] is similar to [iteri_rows] but only applies [f] to
  non-zero rows in [x].
 *)

val iter_rows_nz : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** Similar to [iteri_rows_nz] except that row numbers are not passed to [f]. *)

val iteri_cols_nz : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** [iteri_cols_nz f x] is similar to [iteri_cols] but only applies [f] to
  non-zero columns in [x].
 *)

val iter_cols_nz : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** Similar to [iteri_cols_nz] except that column numbers are not passed to [f]. *)

val mapi_rows_nz : (int -> ('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** [mapi_rows_nz f x] applies [f] only to the non-zero rows in [x]. *)

val map_rows_nz : (('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** Similar to [mapi_rows_nz], but row numbers are not passed to [f]. *)

val mapi_cols_nz : (int -> ('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** [mapi_cols_nz f x] applies [f] only to the non-zero columns in [x]. *)

val map_cols_nz : (('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array
(** Similar to [mapi_cols_nz], but columns numbers are not passed to [f]. *)

val fold_rows_nz : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_rows_nz f a x] is similar to [fold_rows] but only folds non-zero
  rows in [x] using function [f]. Zero rows will be dropped in iterating [x].
 *)

val fold_cols_nz : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_cols_nz f a x] is similar to [fold_cols] but only folds non-zero
  columns in [x] using function [f]. Zero columns will be dropped in iterating [x].
 *)


(** {6 Examin elements and compare two matrices} *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool
(** [exists f x] checks all the elements in [x] using [f]. If at least one
  element satisfies [f] then the function returns [true] otherwise [false].
 *)

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool
(** [not_exists f x] checks all the elements in [x], the function returns
  [true] only if all the elements fail to satisfy [f : float -> bool].
 *)

val for_all : ('a -> bool) -> ('a, 'b) t -> bool
(** [for_all f x] checks all the elements in [x], the function returns [true]
  if and only if all the elements pass the check of function [f].
 *)

val exists_nz : ('a -> bool) -> ('a, 'b) t -> bool
(** [exists_nz f x] is similar to [exists] but only checks non-zero elements. *)

val not_exists_nz : ('a -> bool) -> ('a, 'b) t -> bool
(** [not_exists_nz f x] is similar to [not_exists] but only checks non-zero elements. *)

val for_all_nz :  ('a -> bool) -> ('a, 'b) t -> bool
(** [for_all_nz f x] is similar to [for_all_nz] but only checks non-zero elements. *)

val is_zero : ('a, 'b) t -> bool
(** [is_zero x] returns [true] if all the elements in [x] are zeros. *)

val is_positive : ('a, 'b) t -> bool
(** [is_positive x] returns [true] if all the elements in [x] are positive. *)

val is_negative : ('a, 'b) t -> bool
(** [is_negative x] returns [true] if all the elements in [x] are negative. *)

val is_nonpositive : ('a, 'b) t -> bool
(** [is_nonpositive] returns [true] if all the elements in [x] are non-positive. *)

val is_nonnegative : ('a, 'b) t -> bool
(** [is_nonnegative] returns [true] if all the elements in [x] are non-negative. *)

val equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** [equal x y] returns [true] if two matrices [x] and [y] are equal. *)

val not_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** [not_equal x y] returns [true] if there is at least one element in [x] is
  not equal to that in [y].
 *)

val greater : ('a, 'b) t -> ('a, 'b) t -> bool
(** [greater x y] returns [true] if all the elements in [x] are greater than
  the corresponding elements in [y].
 *)

val less : ('a, 'b) t -> ('a, 'b) t -> bool
(** [less x y] returns [true] if all the elements in [x] are smaller than
  the corresponding elements in [y].
 *)

val greater_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** [greater_equal x y] returns [true] if all the elements in [x] are not
  smaller than the corresponding elements in [y].
 *)

val less_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** [less_equal x y] returns [true] if all the elements in [x] are not
  greater than the corresponding elements in [y].
 *)


(** {6 Randomisation functions} *)

val permutation_matrix : ('a, 'b) kind -> int -> ('a, 'b) t
(** [permutation_matrix m] returns an [m] by [m] permutation matrix. *)

val draw_rows : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** [draw_rows x m] draws [m] rows randomly from [x]. The row indices are also
  returned in an int array along with the selected rows. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val draw_cols : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** [draw_cols x m] draws [m] cols randomly from [x]. The column indices are
  also returned in an int array along with the selected columns. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val shuffle_rows : ('a, 'b) t -> ('a, 'b) t
(** [shuffle_rows x] shuffles all the rows in matrix [x]. *)

val shuffle_cols : ('a, 'b) t -> ('a, 'b) t
(** [shuffle_cols x] shuffles all the columns in matrix [x]. *)

val shuffle : ('a, 'b) t -> ('a, 'b) t
(** [shuffle x] shuffles all the elements in [x] by first shuffling along the
  rows then shuffling along columns. It is equivalent to [shuffle_cols (shuffle_rows x)].
 *)


(** {6 Input/Output and helper functions} *)

val to_array : ('a, 'b) t -> (int array * 'a) array

val of_array : ('a, 'b) kind -> int -> int -> (int array * 'a) array -> ('a, 'b) t

val to_dense : ('a, 'b) t -> ('a, 'b) Owl_dense_matrix_generic.t
(** [to_dense x] converts [x] into a dense matrix. *)

val of_dense : ('a, 'b) Owl_dense_matrix_generic.t -> ('a, 'b) t
(** [of_dense x] returns a sparse matrix from the dense matrix [x]. *)

val print : ('a, 'b) t -> unit
(** [print x] pretty prints matrix [x] without headings. *)

val pp_spmat : ('a, 'b) t -> unit
(** [pp_spmat x] pretty prints matrix [x] with headings. Toplevel uses this
  function to print out the matrices.
 *)

val save : ('a, 'b) t -> string -> unit
(** [save x f] saves the matrix [x] to a file with the name [f]. The format
  is binary by using [Marshal] module to serialise the matrix.
 *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** [load k f] loads a sparse matrix from file [f]. The file must be previously
  saved by using [save] function.
 *)


(** {6 Unary mathematical operations } *)

val min : (float, 'a) t -> float
(** [min x] returns the minimum value of all elements in [x]. *)

val max : (float, 'a) t -> float
(** [max x] returns the maximum value of all elements in [x]. *)

val minmax : (float, 'a) t -> float * float
(** [minmax x] returns both the minimum and minimum values in [x]. *)

val trace : ('a, 'b) t -> 'a
(** [trace x] returns the sum of diagonal elements in [x]. *)

val sum : ('a, 'b) t -> 'a
(** [sum x] returns the summation of all the elements in [x]. *)

val mean : ('a, 'b) t -> 'a
(** [mean x] returns the mean value of all the elements in [x]. It is
  equivalent to calculate [sum x] divided by [numel x]
 *)

val sum_rows : ('a, 'b) t -> ('a, 'b) t
(** [sum_rows x] returns the summation of all the row vectors in [x]. *)

val sum_cols : ('a, 'b) t -> ('a, 'b) t
(** [sum_cols] returns the summation of all the column vectors in [x]. *)

val mean_rows : ('a, 'b) t ->('a, 'b) t
(** [mean_rows x] returns the mean value of all row vectors in [x]. It is
  equivalent to [div_scalar (sum_rows x) (float_of_int (row_num x))].
 *)

val mean_cols : ('a, 'b) t ->('a, 'b) t
(** [mean_cols x] returns the mean value of all column vectors in [x].
  It is equivalent to [div_scalar (sum_cols x) (float_of_int (col_num x))].
 *)

val abs : (float, 'a) t ->(float, 'a) t
(** [abs x] returns a new matrix where each element has the absolute value of
  that in the original matrix [x].
 *)

val neg : ('a, 'b) t ->('a, 'b) t
(** [neg x] returns a new matrix where each element has the negative value of
  that in the original matrix [x].
 *)

val l1norm : (float, 'b) t -> float

val l2norm : (float, 'b) t -> float


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [add x y] adds two matrices [x] and [y]. Both must have the same dimensions. *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [sub x y] subtracts the matrix [x] from [y]. Both must have the same dimensions. *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [mul x y] performs an element-wise multiplication, so both [x] and [y]
  must have the same dimensions.
 *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [div x y] performs an element-wise division, so both [x] and [y]
  must have the same dimensions.
 *)

val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [dot x y] calculates the dot product of an [m] by [n] matrix [x] and
  another [n] by [p] matrix [y].
 *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [add_scalar] only applies to non-zero elements .*)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [sub_scalar] only applies to non-zero elements .*)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [mul_scalar x a] multiplies every element in [x] by a constant factor [a]. *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [div_scalar x a] divides every element in [x] by a constant factor [a]. *)

val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t

val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t

val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t

val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t

val power_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [power x a] calculates the power of [a] of each element in [x]. *)
