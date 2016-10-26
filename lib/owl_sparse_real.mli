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
(** [binary m n] creates an [m] by [n] random matrix where 10% ~ 15% elements are 1. *)

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
(** [numel x] returns the number of elements in matrix [x]. It is equivalent
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

val get : spmat -> int -> int -> float
(** [get x i j] returns the value of element [(i,j)] of [x]. *)

val set : spmat -> int -> int -> float -> unit
(** [set x i j a] sets the element [(i,j)] of [x] to value [a]. *)

val reset : spmat -> unit
(** [reset x] resets all the elements in [x] to [0]. *)

val clone : spmat -> spmat
(** [clone x] makes an exact copy of matrix [x]. Note that the clone becomes
  mutable no matter [w] is mutable or not. This is expecially useful if you
  want to modify certain elements in an immutable matrix from math operations.
 *)

val transpose : spmat -> spmat
(** [transpose x] transposes an [m] by [n] matrix to [n] by [m] one. *)

val diag : spmat -> spmat
(** [diag x] returns the diagonal elements of [x]. *)

val trace : spmat -> float
(** [trace x] returns the sum of diagonal elements in [x]. *)

val row : spmat -> int -> spmat
(** [row x i] returns the row [i] of [x]. *)

val col : spmat -> int -> spmat
(** [col x j] returns the column [j] of [x]. *)

val rows : spmat -> int array -> spmat
(** [rows x a] returns the rows (defined in an int array [a]) of [x]. The
  returned rows will be combined into a new sparse matrix. The order of rows in
  the new matrix is the same as that in the array [a].
 *)

val cols : spmat -> int array -> spmat
(** Similar to [rows], [cols x a] returns the columns (specified in array [a])
  of x in a new sparse matrix.
 *)


(** {6 Iterate elements, columns, and rows} *)

val iteri : (int -> int -> float -> 'a) -> spmat -> unit
(** [iteri f x] iterates all the elements in [x] and applies the user defined
  function [f : int -> int -> float -> 'a]. [f i j v] takes three parameters,
  [i] and [j] are the coordinates of current element, and [v] is its value.
  *)

val iter : (float -> 'a) -> spmat -> unit
(** [iter f x] is the same as as [iteri f x] except the coordinates of the
  current element is not passed to the function [f : float -> 'a]
 *)

val mapi : (int -> int -> float -> float) -> spmat -> spmat
(** [mapi f x] maps each element in [x] to a new value by applying
  [f : int -> int -> float -> float]. The first two parameters are the
  coordinates of the element, and the third parameter is the value.
 *)

val map : (float -> float) -> spmat -> spmat
(** [map f x] is similar to [mapi f x] except the coordinates of the
  current element is not passed to the function [f : float -> float]
 *)

val fold : ('a -> float -> 'a) -> 'a -> spmat -> 'a
(** [fold f a x] folds all the elements in [x] with the function
  [f : 'a -> float -> 'a]. For an [m] by [n] matrix [x], the order of folding
  is from [(0,0)] to [(m-1,n-1)], row by row.
 *)

val filteri : (int -> int -> float -> bool) -> spmat -> (int * int) array
(** [filteri f x] uses [f : int -> int -> float -> bool] to filter out certain
  elements in [x]. An element will be included if [f] returns [true]. The
  returned result is a list of coordinates of the selected elements.
 *)

val filter : (float -> bool) -> spmat -> (int * int) array
(** Similar to [filteri], but the coordinates of the elements are not passed to
  the function [f : float -> bool].
 *)

val iteri_rows : (int -> spmat -> unit) -> spmat -> unit
(** [iteri_rows f x] iterates every row in [x] and applies function
  [f : int -> spmat -> unit] to each of them.
 *)

val iter_rows : (spmat -> unit) -> spmat -> unit
(** Similar to [iteri_rows] except row number is not passed to [f]. *)

val iteri_cols : (int -> spmat -> unit) -> spmat -> unit
(** [iteri_cols f x] iterates every column in [x] and applies function
  [f : int -> spmat -> unit] to each of them. Column number is passed to [f] as
  the first parameter.
 *)

val iter_cols : (spmat -> unit) -> spmat -> unit
(** Similar to [iteri_cols] except col number is not passed to [f]. *)

val mapi_rows : (int -> spmat -> 'a) -> spmat -> 'a array
(** [mapi_rows f x] maps every row in [x] to a type ['a] value by applying
  function [f : int -> spmat -> 'a] to each of them. The results is an array of
  all the returned values.
 *)

val map_rows : (spmat -> 'a) -> spmat -> 'a array
(** Similar to [mapi_rows] except row number is not passed to [f]. *)

val mapi_cols : (int -> spmat -> 'a) -> spmat -> 'a array
(** [mapi_cols f x] maps every column in [x] to a type ['a] value by applying
  function [f : int -> spmat -> 'a].
 *)

val map_cols : (spmat -> 'a) -> spmat -> 'a array
(** Similar to [mapi_cols] except column number is not passed to [f]. *)

val fold_rows : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a
(** [fold_rows f a x] folds all the rows in [x] using function [f]. The order
  of folding is from the first row to the last one.
 *)

val fold_cols : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a
(** [fold_cols f a x] folds all the columns in [x] using function [f]. The
  order of folding is from the first column to the last one.
 *)

val iteri_nz : (int -> int -> float -> 'a) -> spmat -> unit
(** [iteri_nz f x] iterates all the non-zero elements in [x] by applying the
  function [f : int -> int -> float -> 'a]. It is much faster than [iteri].
 *)

val iter_nz : (float -> 'a) -> spmat -> unit
(** Similar to [iter_nz] except the coordinates of elements are not passed to [f]. *)

val mapi_nz : (int -> int -> float -> float) -> spmat -> spmat
(** [mapi_nz f x] is similar to [mapi f x] but only applies [f] to non-zero
  elements in [x]. The zeros in [x] will remain the same in the new matrix.
 *)

val map_nz : (float -> float) -> spmat -> spmat
(** Similar to [mapi_nz] except the coordinates of elements are not passed to [f]. *)

val fold_nz : ('a -> float -> 'a) -> 'a -> spmat -> 'a
(** [fold_nz f a x] is similar to [fold f a x] but only applies to non-zero
  rows in [x]. zero rows will be simply skipped in folding.
 *)

val filteri_nz : (int -> int -> float -> bool) -> spmat -> (int * int) array
(** [filteri_nz f x] is similar to [filter f x] but only applies [f] to
  non-zero elements in [x].
 *)

val filter_nz : (float -> bool) -> spmat -> (int * int) array
(** [filter_nz f x] is similar to [filteri_nz] except that the coordinates of
  matrix elements are not passed to [f].
 *)

val iteri_rows_nz : (int -> spmat -> unit) -> spmat -> unit
(** [iteri_rows_nz f x] is similar to [iteri_rows] but only applies [f] to
  non-zero rows in [x].
 *)

val iter_rows_nz : (spmat -> unit) -> spmat -> unit
(** Similar to [iteri_rows_nz] except that row numbers are not passed to [f].
 *)

val iteri_cols_nz : (int -> spmat -> unit) -> spmat -> unit
(** [iteri_cols_nz f x] is similar to [iteri_cols] but only applies [f] to
  non-zero columns in [x].
 *)

val iter_cols_nz : (spmat -> unit) -> spmat -> unit
(** Similar to [iteri_cols_nz] except that column numbers are not passed to [f]. *)

val mapi_rows_nz : (int -> spmat -> 'a) -> spmat -> 'a array
(** [mapi_rows_nz f x] applies [f] only to the non-zero rows in [x]. *)

val map_rows_nz : (spmat -> 'a) -> spmat -> 'a array
(** Similar to [mapi_rows_nz], but row numbers are not passed to [f]. *)

val mapi_cols_nz : (int -> spmat -> 'a) -> spmat -> 'a array
(** [mapi_cols_nz f x] applies [f] only to the non-zero columns in [x]. *)

val map_cols_nz : (spmat -> 'a) -> spmat -> 'a array
(** Similar to [mapi_cols_nz], but columns numbers are not passed to [f]. *)

val fold_rows_nz : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a
(** [fold_rows_nz f a x] is similar to [fold_rows] but only folds non-zero
  rows in [x] using function [f]. Zero rows will be dropped in iterating [x].
 *)

val fold_cols_nz : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a
(** [fold_cols_nz f a x] is similar to [fold_cols] but only folds non-zero
  columns in [x] using function [f]. Zero columns will be dropped in iterating [x].
 *)


(** {6 Examine the elements in a matrix} *)

val exists : (float -> bool) -> spmat -> bool
(** [exists f x] checks all the elements in [x] using [f]. If at least one
  element satisfies [f] then the function returns [true] otherwise [false].
 *)

val not_exists : (float -> bool) -> spmat -> bool
(** [not_exists f x] checks all the elements in [x], the function returns
  [true] only if all the elements fail to satisfy [f : float -> bool].
 *)

val for_all : (float -> bool) -> spmat -> bool
(** [for_all f x] checks all the elements in [x], the function returns [true]
  if and only if all the elements pass the check of function [f].
 *)

val exists_nz : (float -> bool) -> spmat -> bool
(** [exists_nz f x] is similar to [exists] but only checks non-zero elements. *)

val not_exists_nz : (float -> bool) -> spmat -> bool
(** [not_exists_nz f x] is similar to [not_exists] but only checks non-zero elements. *)

val for_all_nz :  (float -> bool) -> spmat -> bool
(** [for_all_nz f x] is similar to [for_all_nz] but only checks non-zero elements. *)


(** {6 Basic mathematical operations of matrices} *)

val mul_scalar : spmat -> float -> spmat
(** [mul_scalar x a] multiplies every element in [x] by a constant factor [a]. *)

val div_scalar : spmat -> float -> spmat
(** [div_scalar x a] divides every element in [x] by a constant factor [a]. *)

val add : spmat -> spmat -> spmat
(** [add x y] adds two matrices [x] and [y]. Both must have the same dimensions. *)

val sub : spmat -> spmat -> spmat
(** [sub x y] subtracts the matrix [x] from [y]. Both must have the same dimensions. *)

val mul : spmat -> spmat -> spmat
(** [mul x y] performs an element-wise multiplication, so both [x] and [y]
  must have the same dimensions.
 *)

val div : spmat -> spmat -> spmat
(** [div x y] performs an element-wise division, so both [x] and [y]
  must have the same dimensions.
 *)

val dot : spmat -> spmat -> spmat
(** [dot x y] calculates the dot product of an [m] by [n] matrix [x] and
  another [n] by [p] matrix [y].
 *)

val abs : spmat -> spmat
(** [abs x] returns a new matrix where each element has the absolute value of
  that in the original matrix [x].
 *)

val neg : spmat -> spmat
(** [neg x] returns a new matrix where each element has the negative value of
  that in the original matrix [x].
 *)

val sum : spmat -> float
(** [sum x] returns the summation of all the elements in [x]. *)

val average : spmat -> float
(** [average x] returns the average value of all the elements in [x]. It is
  equivalent to calculate [sum x] divided by [numel x]
 *)

val power : spmat -> float -> spmat
(** [power x a] calculates the power of [a] of each element in [x]. *)

val is_zero : spmat -> bool
(** [is_zero x] returns [true] if all the elements in [x] are zeros. *)

val is_positive : spmat -> bool
(** [is_positive x] returns [true] if all the elements in [x] are positive. *)

val is_negative : spmat -> bool
(** [is_negative x] returns [true] if all the elements in [x] are negative. *)

val is_nonnegative : spmat -> bool
(** [is_nonnegative] returns [true] if all the elements in [x] are non-negative. *)

val min : spmat -> float
(** [min x] returns the minimum value of all elements in [x]. *)

val max : spmat -> float
(** [max x] returns the maximum value of all elements in [x]. *)

val minmax : spmat -> float * float
(** [minmax x] returns both the minimum and minimum values in [x]. *)

val sum_rows : spmat -> spmat
(** [sum_rows x] returns the summation of all the row vectors in [x]. *)

val sum_cols : spmat -> spmat
(** [sum_cols] returns the summation of all the column vectors in [x]. *)

val average_rows : spmat -> spmat
(** [average_rows x] returns the average value of all row vectors in [x]. It is
  equivalent to [div_scalar (sum_rows x) (float_of_int (row_num x))].
 *)

val average_cols : spmat -> spmat
(** [average_cols x] returns the average value of all column vectors in [x].
  It is equivalent to [div_scalar (sum_cols x) (float_of_int (col_num x))].
 *)


(** {6 Compare two matrices} *)

val is_equal : spmat -> spmat -> bool
(** [is_equal x y] returns [true] if two matrices [x] and [y] are equal. *)

val is_unequal : spmat -> spmat -> bool
(** [is_unequal x y] returns [true] if there is at least one element in [x] is
  not equal to that in [y].
 *)

val is_greater : spmat -> spmat -> bool
(** [is_greater x y] returns [true] if all the elements in [x] are greater than
  the corresponding elements in [y].
 *)

val is_smaller : spmat -> spmat -> bool
(** [is_smaller x y] returns [true] if all the elements in [x] are smaller than
  the corresponding elements in [y].
 *)

val equal_or_greater : spmat -> spmat -> bool
(** [equal_or_greater x y] returns [true] if all the elements in [x] are not
  smaller than the corresponding elements in [y].
 *)

val equal_or_smaller : spmat -> spmat -> bool
(** [equal_or_smaller x y] returns [true] if all the elements in [x] are not
  greater than the corresponding elements in [y].
 *)


(** {6 Randomisation functions} *)

val permutation_matrix : int -> spmat
(** [permutation_matrix m] returns an [m] by [m] permutation matrix. *)

val draw_rows : ?replacement:bool -> spmat -> int -> spmat * int array
(** [draw_rows x m] draws [m] rows randomly from [x]. The row indices are also
  returned in an int array along with the selected rows. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val draw_cols : ?replacement:bool -> spmat -> int -> spmat * int array
(** [draw_cols x m] draws [m] cols randomly from [x]. The column indices are
  also returned in an int array along with the selected columns. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val shuffle_rows : spmat -> spmat
(** [shuffle_rows x] shuffles all the rows in matrix [x]. *)

val shuffle_cols : spmat -> spmat
(** [shuffle_cols x] shuffles all the columns in matrix [x]. *)

val shuffle : spmat -> spmat
(** [shuffle x] shuffles all the elements in [x] by first shuffling along the
  rows then shuffling along columns. It is equivalent to [shuffle_cols (shuffle_rows x)].
 *)


(** {6 Input/Output and helper functions} *)

val to_dense : spmat -> Owl_dense_real.mat
(** [to_dense x] converts [x] into a dense matrix. *)

val of_dense : Owl_dense_real.mat -> spmat
(** [of_dense x] returns a sparse matrix from the dense matrix [x]. *)

val print : spmat -> unit
(** [print x] pretty prints matrix [x] without headings. *)

val pp_spmat : spmat -> unit
(** [pp_spmat x] pretty prints matrix [x] with headings. Toplevel uses this
  function to print out the matrices.
 *)

val save : spmat -> string -> unit
(** [save x f] saves the matrix [x] to a file with the name [f]. The format
  is binary by using [Marshal] module to serialise the matrix.
 *)

val load : string -> spmat
(** [load f] loads a sparse matrix from file [f]. The file must be previously
  saved by using [save] function.
 *)


(** {6 Shorhand infix operators} *)

val ( +@ ) : spmat -> spmat -> spmat
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : spmat -> spmat -> spmat
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : spmat -> spmat -> spmat
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : spmat -> spmat -> spmat
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( $@ ) : spmat -> spmat -> spmat
(** Shorthand for [dot x y], i.e., [x $@ y] *)

val ( **@ ) : spmat -> float -> spmat
(** Shorthand for [power x a], i.e., [x **@ a] *)

val ( *$ ) : spmat -> float -> spmat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : spmat -> float -> spmat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $* ) : float -> spmat -> spmat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : float -> spmat -> spmat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( =@ ) : spmat -> spmat -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : spmat -> spmat -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : spmat -> spmat -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : spmat -> spmat -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : spmat -> spmat -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : spmat -> spmat -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

(* val ( @@ ) : (float -> float) -> dsmat -> dsmat *)
