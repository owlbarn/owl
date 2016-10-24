(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Dense matrix module *)

type mat = Gsl.Matrix.matrix
(** Type of dense matrices. It is defined as [Gsl.Matrix.matrix] which is
  essentially a two dimensional array in [Bigarray] module. *)


(** {6 Create dense matrices} *)

val empty : int -> int -> mat
(** [empty m n] creates an [m] by [n] matrix without initialising the values of
  elements in [x].
 *)

val create : int -> int -> float -> mat
(** [create m n a] creates an [m] by [n] matrix and all the elements of [x] are
  initialised with the value [a].
 *)

val zeros : int -> int -> mat
(** [zeros m n] creates an [m] by [n] matrix where all the elements are
  initialised to zeros.
 *)

val ones : int -> int -> mat
(** [ones m n] creates an [m] by [n] matrix where all the elements are ones. *)

val eye : int -> mat
(** [eye m] creates an [m] by [m] identity matrix. *)

val sequential : int -> int -> mat
(** [sequential m n] creates an [m] by [n] matrix. The elements in [x] are
  initialised sequentiallly from [0] to [(m * n - 1)].
 *)

val uniform_int : ?a:int -> ?b:int -> int -> int -> mat
(** [uniform ~a ~b m n] creates an [m] by [n] matrix where all the elements
  follow a uniform distribution in [[a, b]] interval. By default, [a = 0] and
  [b = 100].
 *)

val uniform : ?scale:float -> int -> int -> mat
(** [uniform m n] creates an [m] by [n] matrix where all the elements
  follow a uniform distribution in [(0,1)] interval. [uniform ~scale:a m n]
  adjusts the interval to [(0,a)].
 *)

val gaussian : ?sigma:float -> int -> int -> mat
(** [gaussian m n] creates an [m] by [n] matrix where all the elements in [x]
  follow a Gaussian distribution with specified sigma. By default [sigma = 1].
 *)

val semidef : int -> mat
(** [ semidef n ] returns an random [n] by [n] positive semi-definite matrix. *)


(** {7 Dense vectors and meshgrids} *)

val vector : int -> mat
(** [vector m] returns an [1] by [m] row vector [x] without initialising the
  values in [x].
 *)

val vector_zeros : int -> mat
(** [vector_zeros m] returns an [1] by [m] row vector [x] by initialising the
  all values in [x] to zeros.
 *)

val vector_ones : int -> mat
(** [vector_ones m] returns an [1] by [m] row vector [x] by initialising the
  all values in [x] to ones.
 *)

val vector_uniform : int -> mat
(** [vector_zeros m] returns an [1] by [m] row vector [x] and the values are
  drawn from the interval [(0,1)] with a uniform distribution.
 *)

val linspace : float -> float -> int -> mat
(** [linspace a b n] linearly divides the interval [[a,b]] into [n] pieces by
  creating an [m] by [1] row vector. E.g., [linspace 0. 5. 5] will create a
  row vector [[0;1;2;3;4;5]].
 *)

val meshgrid : float -> float -> float -> float -> int -> int -> mat * mat
(** [meshgrid a1 b1 a2 b2 n1 n2] is similar to the [meshgrid] function in
  Matlab. It returns two matrices [x] and [y] where the row vectors in [x] are
  linearly spaced between [[a1,b1]] by [n1] whilst the column vectors in [y]
  are linearly spaced between [(a2,b2)] by [n2].
 *)

val meshup : mat -> mat -> mat * mat
(** [meshup x y] creates mesh grids by using two row vectors [x] and [y]. *)


(** {6 Obtain the basic properties of a matrix} *)

val shape : mat -> int * int
(** If [x] is an [m] by [n] matrix, [shape x] returns [(m,n)], i.e., the size
  of two dimensions of [x].
 *)

val row_num : mat -> int
(** [row_num x] returns the number of rows in matrix [x]. *)

val col_num : mat -> int
(** [col_num x] returns the number of columns in matrix [x]. *)

val numel : mat -> int
(** [numel x] returns the number of elements in matrix [x]. It is equivalent
  to [(row_num x) * (col_num x)].
 *)

val same_shape : mat -> mat -> bool
(** [same_shape x y] returns [true] if two matrics have the same shape. *)

val reshape : int -> int -> mat -> mat
(** [reshape m n x] creates a new [m] by [n] matrix from the [m'] by [n']
  matrix [x]. Note that [(m * n)] must be equal to [(m' * n')].
 *)


(** {6 Manipulate a matrix} *)

val get : mat -> int -> int -> float
(** [get x i j] returns the value of element [(i,j)] of [x]. The shorthand
  for [get x i j] is [x.{i,j}]
 *)

val set : mat -> int -> int -> float -> unit
(** [set x i j a] sets the element [(i,j)] of [x] to value [a]. The shorthand
  for [set x i j a] is [x.{i,j} <- a]
 *)

val row : mat -> int -> mat
(** [row x i] returns the row [i] of [x]. *)

val col : mat -> int -> mat
(** [col x j] returns the column [j] of [x]. *)

val rows : mat -> int array -> mat
(** [rows x a] returns the rows (defined in an int array [a]) of [x]. The
  returned rows will be combined into a new sparse matrix. The order of rows in
  the new matrix is the same as that in the array [a].
 *)

val cols : mat -> int array -> mat
(** Similar to [rows], [cols x a] returns the columns (specified in array [a])
  of x in a new sparse matrix.
 *)

val clone : mat -> mat
(** [clone x] returns a copy of matrix [x]. *)

val copy_to : mat -> mat -> unit
(** [copy_to x y] copies the elements of [x] to [y]. [x] and [y] must have
  the same demensions.
 *)

val copy_row_to : mat -> mat -> int -> unit
(** [copy_row_to v x i] copies an [1] by [n] row vector [v] to the [i]th row
  in an [m] by [n] matrix [x].
 *)

val copy_col_to : mat -> mat -> int -> unit
(** [copy_col_to v x j] copies an [1] by [n] column vector [v] to the [j]th
  column in an [m] by [n] matrix [x].
 *)

val concat_vertical : mat -> mat -> mat
(** [concat_vertical x y] concats two matrices [x] and [y] vertically,
  therefore their column numbers must be the same.
  *)

val concat_horizontal : mat -> mat -> mat
(** [concat_horizontal x y] concats two matrices [x] and [y] horizontally,
  therefore their row numbers must be the same.
  *)

val transpose : mat -> mat
(** [transpose x] transposes an [m] by [n] matrix to [n] by [m] one. *)

val diag : mat -> mat
(** [diag x] returns the diagonal elements of [x]. *)

val trace : mat -> float
(** [trace x] returns the sum of diagonal elements in [x]. *)

val add_diag : mat -> float -> mat
(** [add_diag x a] adds a constant [a] to all the diagonal elements in [x]. *)

val replace_row : mat -> mat -> int -> mat
(** [replace_row v x i] uses the row vector [v] to replace the [i]th row in
  the matrix [x].
 *)

val replace_col : mat -> mat -> int -> mat
(** [replace_col v x j] uses the column vector [v] to replace the [j]th column
  in the matrix [x].
 *)


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> float -> 'a) -> mat -> unit
(** [iteri f x] iterates all the elements in [x] and applies the user defined
  function [f : int -> int -> float -> 'a]. [f i j v] takes three parameters,
  [i] and [j] are the coordinates of current element, and [v] is its value.
  *)

val iter : (float -> 'a) -> mat -> unit
(** [iter f x] is the same as as [iteri f x] except the coordinates of the
  current element is not passed to the function [f : float -> 'a]
 *)

val mapi : (int -> int -> float -> float) -> mat -> mat
(** [mapi f x] maps each element in [x] to a new value by applying
  [f : int -> int -> float -> float]. The first two parameters are the
  coordinates of the element, and the third parameter is the value.
 *)

val map : (float -> float) -> mat -> mat
(** [map f x] is similar to [mapi f x] except the coordinates of the
  current element is not passed to the function [f : float -> float]
 *)

val fold : ('a -> float -> 'a) -> 'a -> mat -> 'a
(** [fold f a x] folds all the elements in [x] with the function
  [f : 'a -> float -> 'a]. For an [m] by [n] matrix [x], the order of folding
  is from [(0,0)] to [(m-1,n-1)], row by row.
 *)

val filteri : (int -> int -> float -> bool) -> mat -> (int * int) array
(** [filteri f x] uses [f : int -> int -> float -> bool] to filter out certain
  elements in [x]. An element will be included if [f] returns [true]. The
  returned result is a list of coordinates of the selected elements.
 *)

val filter : (float -> bool) -> mat -> (int * int) array
(** Similar to [filteri], but the coordinates of the elements are not passed to
  the function [f : float -> bool].
 *)

val iteri_rows : (int -> mat -> 'a) -> mat -> unit
(** [iteri_rows f x] iterates every row in [x] and applies function
  [f : int -> mat -> unit] to each of them.
 *)

val iter_rows : (mat -> 'a) -> mat -> unit
(** Similar to [iteri_rows] except row number is not passed to [f]. *)

val iteri_cols : (int -> mat -> 'a) -> mat -> unit
(** [iteri_cols f x] iterates every column in [x] and applies function
  [f : int -> mat -> unit] to each of them. Column number is passed to [f] as
  the first parameter.
 *)

val iter_cols : (mat -> 'a) -> mat -> unit
(** Similar to [iteri_cols] except col number is not passed to [f]. *)

val filteri_rows : (int -> mat -> bool) -> mat -> int array
(** [filteri_rows f x] uses function [f : int -> mat -> bool] to check each
  row in [x], then returns an int array containing the indices of those rows
  which satisfy the function [f].
 *)

val filter_rows : (mat -> bool) -> mat -> int array
(** Similar to [filteri_rows] except that the row indices are not passed to [f]. *)

val filteri_cols : (int -> mat -> bool) -> mat -> int array
(** [filteri_cols f x] uses function [f : int -> mat -> bool] to check each
  column in [x], then returns an int array containing the indices of those
  columns which satisfy the function [f].
 *)

val filter_cols : (mat -> bool) -> mat -> int array
(** Similar to [filteri_cols] except that the column indices are not passed to [f]. *)

val fold_rows : ('a -> mat -> 'a) -> 'a -> mat -> 'a
(** [fold_rows f a x] folds all the rows in [x] using function [f]. The order
  of folding is from the first row to the last one.
 *)

val fold_cols : ('a -> mat -> 'a) -> 'a -> mat -> 'a
(** [fold_cols f a x] folds all the columns in [x] using function [f]. The
  order of folding is from the first column to the last one.
 *)

val mapi_rows : (int -> mat -> 'a) -> mat -> 'a array
(** [mapi_rows f x] maps every row in [x] to a type ['a] value by applying
  function [f : int -> mat -> 'a] to each of them. The results is an array of
  all the returned values.
 *)

val map_rows : (mat -> 'a) -> mat -> 'a array
(** Similar to [mapi_rows] except row number is not passed to [f]. *)

val mapi_cols : (int -> mat -> 'a) -> mat -> 'a array
(** [mapi_cols f x] maps every column in [x] to a type ['a] value by applying
  function [f : int -> mat -> 'a].
 *)

val map_cols : (mat -> 'a) -> mat -> 'a array
(** Similar to [mapi_cols] except column number is not passed to [f]. *)

val mapi_by_row : ?d:int -> (int -> mat -> mat) -> mat -> mat
(** [mapi_by_row f x] applies [f] to each row of [x], then uses the returned
  row vectors to assemble a new matrix.
 *)

val map_by_row : ?d:int -> (mat -> mat) -> mat -> mat
(** [map_by_row f x i] is similar to [mapi_by_row] except that the row indices
  are not passed to [f].
 *)

val mapi_by_col : ?d:int -> (int -> mat -> mat) -> mat -> mat
(** [mapi_by_col f x] applies [f] to each column of [x], then uses the returned
  column vectors to assemble a new matrix.
 *)

val map_by_col : ?d:int -> (mat -> mat) -> mat -> mat
(** [map_by_col f x i] is similar to [mapi_by_col] except that the column
  indices are not passed to [f].
 *)

val mapi_at_row : (int -> int -> float -> float) -> mat -> int -> mat
(** [mapi_at_row f x i] creates a new matrix by applying function [f] only to
  the [i]th row in matrix [x].
 *)

val map_at_row : (float -> float) -> mat -> int -> mat
(** [map_at_row f x i] is similar to [mapi_at_row] except that the coordinates
  of an element is not passed to [f].
 *)

val mapi_at_col : (int -> int -> float -> float) -> mat -> int -> mat
(** [mapi_at_col f x j] creates a new matrix by applying function [f] only to
  the [j]th column in matrix [x].
 *)

val map_at_col : (float -> float) -> mat -> int -> mat
(** [map_at_col f x i] is similar to [mapi_at_col] except that the coordinates
  of an element is not passed to [f].
 *)


(** {6 Examine the elements in a matrix} *)

val exists : (float -> bool) -> mat -> bool
(** [exists f x] checks all the elements in [x] using [f]. If at least one
  element satisfies [f] then the function returns [true] otherwise [false].
 *)

val not_exists : (float -> bool) -> mat -> bool
(** [not_exists f x] checks all the elements in [x], the function returns
  [true] only if all the elements fail to satisfy [f : float -> bool].
 *)

val for_all : (float -> bool) -> mat -> bool
(** [for_all f x] checks all the elements in [x], the function returns [true]
  if and only if all the elements pass the check of function [f].
 *)


(** {6 Compare two matrices} *)

val is_equal : mat -> mat -> bool
(** [is_equal x y] returns [true] if two matrices [x] and [y] are equal. *)

val is_unequal : mat -> mat -> bool
(** [is_unequal x y] returns [true] if there is at least one element in [x] is
  not equal to that in [y].
 *)

val is_greater : mat -> mat -> bool
(** [is_greater x y] returns [true] if all the elements in [x] are greater than
  the corresponding elements in [y].
 *)

val is_smaller : mat -> mat -> bool
(** [is_smaller x y] returns [true] if all the elements in [x] are smaller than
  the corresponding elements in [y].
 *)

val equal_or_greater : mat -> mat -> bool
(** [equal_or_greater x y] returns [true] if all the elements in [x] are not
  smaller than the corresponding elements in [y].
 *)

val equal_or_smaller : mat -> mat -> bool
(** [equal_or_smaller x y] returns [true] if all the elements in [x] are not
  greater than the corresponding elements in [y].
 *)


(** {6 Basic mathematical operations of matrices} *)

val add : mat -> mat -> mat
(** [add x y] adds two matrices [x] and [y]. Both must have the same dimensions. *)

val sub : mat -> mat -> mat
(** [sub x y] subtracts the matrix [x] from [y]. Both must have the same dimensions. *)

val mul : mat -> mat -> mat
(** [mul x y] performs an element-wise multiplication, so both [x] and [y]
  must have the same dimensions.
 *)

val div : mat -> mat -> mat
(** [div x y] performs an element-wise division, so both [x] and [y]
  must have the same dimensions.
 *)

val dot : mat -> mat -> mat
(** [dot x y] calculates the dot product of an [m] by [n] matrix [x] and
  another [n] by [p] matrix [y].
 *)

val abs : mat -> mat
(** [abs x] returns a new matrix where each element has the absolute value of
  that in the original matrix [x].
 *)

val neg : mat -> mat
(** [neg x] returns a new matrix where each element has the negative value of
  that in the original matrix [x].
 *)

val power : mat -> float -> mat
(** [power x a] calculates the power of [a] of each element in [x]. *)

val add_scalar : mat -> float -> mat
(** [add_scalar x a] adds every element in [x] by a constant factor [a]. *)

val sub_scalar : mat -> float -> mat
(** [sub_scalar x a] subtracts every element in [x] by a constant factor [a]. *)

val mul_scalar : mat -> float -> mat
(** [mul_scalar x a] multiplies every element in [x] by a constant factor [a]. *)

val div_scalar : mat -> float -> mat
(** [div_scalar x a] divides every element in [x] by a constant factor [a]. *)

val sum : mat -> float
(** [sum x] returns the summation of all the elements in [x]. *)

val average : mat -> float
(** [average x] returns the average value of all the elements in [x]. It is
  equivalent to calculate [sum x] divided by [numel x]
 *)

val min : mat -> float * int * int
(** [min x] returns the minimum value of all elements in [x]. *)

val max : mat -> float * int * int
(** [max x] returns the maximum value of all elements in [x]. *)

val minmax : mat -> float * float * int * int * int * int
(** [minmax x] returns both the minimum and minimum values in [x]. *)

val is_zero : mat -> bool
(** [is_zero x] returns [true] if all the elements in [x] are zeros. *)

val is_positive : mat -> bool
(** [is_positive x] returns [true] if all the elements in [x] are positive. *)

val is_negative : mat -> bool
(** [is_negative x] returns [true] if all the elements in [x] are negative. *)

val is_nonnegative : mat -> bool
(** [is_nonnegative] returns [true] if all the elements in [x] are non-negative. *)

val log : mat -> mat
(** [log x] applies [log] function to each element in matrix [x]. *)

val log10 : mat -> mat
(** [log10 x] applies [log10] function to each element in matrix [x]. *)

val exp : mat -> mat
(** [exp x] applies [exp] function to each element in matrix [x]. *)

val sigmoid : mat -> mat
(** [sigmoid x] applies [sigmoid] function to each element in matrix [x]. *)

val sum_rows : mat -> mat
(** [sum_rows x] returns the summation of all the row vectors in [x]. *)

val sum_cols : mat -> mat
(** [sum_cols] returns the summation of all the column vectors in [x]. *)

val average_rows : mat -> mat
(** [average_rows x] returns the average value of all row vectors in [x]. It is
  equivalent to [div_scalar (sum_rows x) (float_of_int (row_num x))].
 *)

val average_cols : mat -> mat
(** [average_cols x] returns the average value of all column vectors in [x].
  It is equivalent to [div_scalar (sum_cols x) (float_of_int (col_num x))].
 *)

val min_rows : mat -> (float * int * int) array
(** [min_rows x] returns the minimum value in each row along with their coordinates. *)

val min_cols : mat -> (float * int * int) array
(** [min_cols x] returns the minimum value in each column along with their coordinates. *)

val max_rows : mat -> (float * int * int) array
(** [max_rows x] returns the maximum value in each row along with their coordinates. *)

val max_cols : mat -> (float * int * int) array
(** [min_cols x] returns the minimum value in each column along with their coordinates. *)


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> mat -> int -> mat * int array
(** [draw_rows x m] draws [m] rows randomly from [x]. The row indices are also
  returned in an int array along with the selected rows. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val draw_cols : ?replacement:bool -> mat -> int -> mat * int array
(** [draw_cols x m] draws [m] cols randomly from [x]. The column indices are
  also returned in an int array along with the selected columns. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val shuffle_rows : mat -> mat
(** [shuffle_rows x] shuffles all the rows in matrix [x]. *)

val shuffle_cols : mat -> mat
(** [shuffle_cols x] shuffles all the columns in matrix [x]. *)

val shuffle: mat -> mat
(** [shuffle x] shuffles all the elements in [x] by first shuffling along the
  rows then shuffling along columns. It is equivalent to [shuffle_cols (shuffle_rows x)].
 *)


(** {6 Input/Output and helper functions} *)

val to_array : mat -> float array
(** [to_array x] flattens an [m] by [n] matrix [x] then returns [x] as an
  float array of length [(numel x)].
 *)

val to_arrays : mat -> float array array
(** [to arrays x] returns an array of float arrays, wherein each row in [x]
  becomes an array in the result.
 *)

val of_array : float array -> int -> int -> mat
(** [of_array x m n] converts a float array [x] into an [m] by [n] matrix. Note the
  length of [x] must be equal to [(m * n)].
 *)

val of_arrays : float array array -> mat
(** [of_arrays x] converts an array of [m] float arrays (of length [n]) in to
  an [m] by [n] matrix.
 *)

val print : mat -> unit
(** [print x] pretty prints matrix [x] without headings. *)

val pp_dsmat : mat -> unit
(** [pp_spmat x] pretty prints matrix [x] with headings. Toplevel uses this
  function to print out the matrices.
 *)

val save : mat -> string -> unit
(** [save x f] saves the matrix [x] to a file with the name [f]. The format
  is binary by using [Marshal] module to serialise the matrix.
 *)

val load : string -> mat
(** [load f] loads a sparse matrix from file [f]. The file must be previously
  saved by using [save] function.
 *)

val save_txt : mat -> string -> unit
(** [save_txt x f] save the matrix [x] into a text file [f]. The operation can
  be very time consuming.
 *)

val load_txt : string -> mat
(** [load_txt f] load a text file [f] into a matrix. *)


(** {6 Shorhand infix operators} *)

val ( >> ) : mat -> mat -> unit
(** Shorthand for [copy_to x y], i.e., x >> y *)

val ( << ) : mat -> mat -> unit
(** Shorthand for [copy_to y x], i.e., x << y *)

val ( @= ) : mat -> mat -> mat
(** Shorthand for [concat_vertical x y], i.e., x @= y *)

val ( @|| ) : mat -> mat -> mat
(** Shorthand for [concat_horizontal x y], i.e., x @|| y *)

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

val ( **@ ) : mat -> float -> mat
(** Shorthand for [power x a], i.e., [x **@ a] *)

val ( +$ ) : mat -> float -> mat
(** Shorthand for [add_scalar x a], i.e., [x +$ a] *)

val ( -$ ) : mat -> float -> mat
(** Shorthand for [sub_scalar x a], i.e., [x -$ a] *)

val ( *$ ) : mat -> float -> mat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : mat -> float -> mat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $+ ) : float -> mat -> mat
(** Shorthand for [add_scalar x a], i.e., [a $+ x] *)

val ( $- ) : float -> mat -> mat
(** Shorthand for [sub_scalar x a], i.e., [a -$ x] *)

val ( $* ) : float -> mat -> mat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : float -> mat -> mat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( =@ ) : mat -> mat -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : mat -> mat -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : mat -> mat -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : mat -> mat -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : mat -> mat -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : mat -> mat -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

val ( @@ ) : (float -> float) -> mat -> mat
(** Shorthand for [map f x], i.e., f @@ x *)

(* TODO: for debug purpose *)

val gsl_col : mat -> int -> mat
