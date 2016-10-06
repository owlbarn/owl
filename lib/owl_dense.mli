(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Dense matrix module *)

type dsmat = Gsl.Matrix.matrix
(** Type of dense matrices. It is defined as [Gsl.Matrix.matrix] which is
  essentially a two dimensional array in [Bigarray] module. *)


(** {6 Create dense matrices} *)

val empty : int -> int -> dsmat
(** [empty m n] creates an [m] by [n] matrix without initialising the values of
  elements in [x].
 *)

val create : int -> int -> float -> dsmat
(** [create m n a] creates an [m] by [n] matrix and all the elements of [x] are
  initialised with the value [a].
 *)

val zeros : int -> int -> dsmat
(** [zeros m n] creates an [m] by [n] matrix where all the elements are
  initialised to zeros.
 *)

val ones : int -> int -> dsmat
(** [ones m n] creates an [m] by [n] matrix where all the elements are ones. *)

val eye : int -> dsmat
(** [eye m] creates an [m] by [m] identity matrix. *)

val sequential : int -> int -> dsmat
(** [sequential m n] creates an [m] by [n] matrix. The elements in [x] are
  initialised sequentiallly from [0] to [(m * n - 1)].
 *)

val uniform_int : ?a:int -> ?b:int -> int -> int -> dsmat
(** [uniform ~a ~b m n] creates an [m] by [n] matrix where all the elements
  follow a uniform distribution in [[a, b]] interval. By default, [a = 0] and
  [b = 100].
 *)

val uniform : ?scale:float -> int -> int -> dsmat
(** [uniform m n] creates an [m] by [n] matrix where all the elements
  follow a uniform distribution in [(0,1)] interval. [uniform ~scale:a m n]
  adjusts the interval to [(0,a)].
 *)

val gaussian : ?sigma:float -> int -> int -> dsmat
(** [gaussian m n] creates an [m] by [n] matrix where all the elements in [x]
  follow a Gaussian distribution with specified sigma. By default [sigma = 1].
 *)

val semidef : int -> dsmat
(** [ semidef n ] returns an random [n] by [n] positive semi-definite matrix. *)


(** {7 Dense vectors and meshgrids} *)

val vector : int -> dsmat
(** [vector m] returns an [1] by [m] row vector [x] without initialising the
  values in [x].
 *)

val vector_zeros : int -> dsmat
(** [vector_zeros m] returns an [1] by [m] row vector [x] by initialising the
  all values in [x] to zeros.
 *)

val vector_ones : int -> dsmat
(** [vector_ones m] returns an [1] by [m] row vector [x] by initialising the
  all values in [x] to ones.
 *)

val vector_uniform : int -> dsmat
(** [vector_zeros m] returns an [1] by [m] row vector [x] and the values are
  drawn from the interval [(0,1)] with a uniform distribution.
 *)

val linspace : float -> float -> int -> dsmat
(** [linspace a b n] linearly divides the interval [[a,b]] into [n] pieces by
  creating an [m] by [1] row vector. E.g., [linspace 0. 5. 5] will create a
  row vector [[0;1;2;3;4;5]].
 *)

val meshgrid : float -> float -> float -> float -> int -> int -> dsmat * dsmat
(** [meshgrid a1 b1 a2 b2 n1 n2] is similar to the [meshgrid] function in
  Matlab. It returns two matrices [x] and [y] where the row vectors in [x] are
  linearly spaced between [[a1,b1]] by [n1] whilst the column vectors in [y]
  are linearly spaced between [(a2,b2)] by [n2].
 *)

val meshup : dsmat -> dsmat -> dsmat * dsmat
(** [meshup x y] creates mesh grids by using two row vectors [x] and [y]. *)


(** {6 Obtain the basic properties of a matrix} *)

val shape : dsmat -> int * int
(** If [x] is an [m] by [n] matrix, [shape x] returns [(m,n)], i.e., the size
  of two dimensions of [x].
 *)

val row_num : dsmat -> int
(** [row_num x] returns the number of rows in matrix [x]. *)

val col_num : dsmat -> int
(** [col_num x] returns the number of columns in matrix [x]. *)

val numel : dsmat -> int
(** [numel x] returns the number of elements in matrix [x]. It is equivalent
  to [(row_num x) * (col_num x)].
 *)

val same_shape : dsmat -> dsmat -> bool
(** [same_shape x y] returns [true] if two matrics have the same shape. *)

val reshape : int -> int -> dsmat -> dsmat
(** [reshape m n x] creates a new [m] by [n] matrix from the [m'] by [n']
  matrix [x]. Note that [(m * n)] must be equal to [(m' * n')].
 *)


(** {6 Manipulate a matrix} *)

val get : dsmat -> int -> int -> float
(** [get x i j] returns the value of element [(i,j)] of [x]. The shorthand
  for [get x i j] is [x.{i,j}]
 *)

val set : dsmat -> int -> int -> float -> unit
(** [set x i j a] sets the element [(i,j)] of [x] to value [a]. The shorthand
  for [set x i j a] is [x.{i,j} <- a]
 *)

val row : dsmat -> int -> dsmat
(** [row x i] returns the row [i] of [x]. *)

val col : dsmat -> int -> dsmat
(** [col x j] returns the column [j] of [x]. *)

val rows : dsmat -> int array -> dsmat
(** [rows x a] returns the rows (defined in an int array [a]) of [x]. The
  returned rows will be combined into a new sparse matrix. The order of rows in
  the new matrix is the same as that in the array [a].
 *)

val cols : dsmat -> int array -> dsmat
(** Similar to [rows], [cols x a] returns the columns (specified in array [a])
  of x in a new sparse matrix.
 *)

val clone : dsmat -> dsmat
(** [clone x] returns a copy of matrix [x]. *)

val copy_to : dsmat -> dsmat -> unit
(** [copy_to x y] copies the elements of [x] to [y]. [x] and [y] must have
  the same demensions.
 *)

val copy_row_to : dsmat -> dsmat -> int -> unit
(** [copy_row_to v x i] copies an [1] by [n] row vector [v] to the [i]th row
  in an [m] by [n] matrix [x].
 *)

val copy_col_to : dsmat -> dsmat -> int -> unit
(** [copy_col_to v x j] copies an [1] by [n] column vector [v] to the [j]th
  column in an [m] by [n] matrix [x].
 *)

val concat_vertical : dsmat -> dsmat -> dsmat
(** [concat_vertical x y] concats two matrices [x] and [y] vertically,
  therefore their column numbers must be the same.
  *)

val concat_horizontal : dsmat -> dsmat -> dsmat
(** [concat_horizontal x y] concats two matrices [x] and [y] horizontally,
  therefore their row numbers must be the same.
  *)

val transpose : dsmat -> dsmat
(** [transpose x] transposes an [m] by [n] matrix to [n] by [m] one. *)

val diag : dsmat -> dsmat
(** [diag x] returns the diagonal elements of [x]. *)

val trace : dsmat -> float
(** [trace x] returns the sum of diagonal elements in [x]. *)

val add_diag : dsmat -> float -> dsmat
(** [add_diag x a] adds a constant [a] to all the diagonal elements in [x]. *)

val replace_row : dsmat -> dsmat -> int -> dsmat
(** [replace_row v x i] uses the row vector [v] to replace the [i]th row in
  the matrix [x].
 *)

val replace_col : dsmat -> dsmat -> int -> dsmat
(** [replace_col v x j] uses the column vector [v] to replace the [j]th column
  in the matrix [x].
 *)


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> float -> 'a) -> dsmat -> unit
(** [iteri f x] iterates all the elements in [x] and applies the user defined
  function [f : int -> int -> float -> 'a]. [f i j v] takes three parameters,
  [i] and [j] are the coordinates of current element, and [v] is its value.
  *)

val iter : (float -> 'a) -> dsmat -> unit
(** [iter f x] is the same as as [iteri f x] except the coordinates of the
  current element is not passed to the function [f : float -> 'a]
 *)

val mapi : (int -> int -> float -> float) -> dsmat -> dsmat
(** [mapi f x] maps each element in [x] to a new value by applying
  [f : int -> int -> float -> float]. The first two parameters are the
  coordinates of the element, and the third parameter is the value.
 *)

val map : (float -> float) -> dsmat -> dsmat
(** [map f x] is similar to [mapi f x] except the coordinates of the
  current element is not passed to the function [f : float -> float]
 *)

val fold : ('a -> float -> 'a) -> 'a -> dsmat -> 'a
(** [fold f a x] folds all the elements in [x] with the function
  [f : 'a -> float -> 'a]. For an [m] by [n] matrix [x], the order of folding
  is from [(0,0)] to [(m-1,n-1)], row by row.
 *)

val filteri : (int -> int -> float -> bool) -> dsmat -> (int * int) array
(** [filteri f x] uses [f : int -> int -> float -> bool] to filter out certain
  elements in [x]. An element will be included if [f] returns [true]. The
  returned result is a list of coordinates of the selected elements.
 *)

val filter : (float -> bool) -> dsmat -> (int * int) array
(** Similar to [filteri], but the coordinates of the elements are not passed to
  the function [f : float -> bool].
 *)

val iteri_rows : (int -> dsmat -> 'a) -> dsmat -> unit
(** [iteri_rows f x] iterates every row in [x] and applies function
  [f : int -> dsmat -> unit] to each of them.
 *)

val iter_rows : (dsmat -> 'a) -> dsmat -> unit
(** Similar to [iteri_rows] except row number is not passed to [f]. *)

val iteri_cols : (int -> dsmat -> 'a) -> dsmat -> unit
(** [iteri_cols f x] iterates every column in [x] and applies function
  [f : int -> dsmat -> unit] to each of them. Column number is passed to [f] as
  the first parameter.
 *)

val iter_cols : (dsmat -> 'a) -> dsmat -> unit
(** Similar to [iteri_cols] except col number is not passed to [f]. *)

val filteri_rows : (int -> dsmat -> bool) -> dsmat -> int array
(** [filteri_rows f x] uses function [f : int -> dsmat -> bool] to check each
  row in [x], then returns an int array containing the indices of those rows
  which satisfy the function [f].
 *)

val filter_rows : (dsmat -> bool) -> dsmat -> int array
(** Similar to [filteri_rows] except that the row indices are not passed to [f]. *)

val filteri_cols : (int -> dsmat -> bool) -> dsmat -> int array
(** [filteri_cols f x] uses function [f : int -> dsmat -> bool] to check each
  column in [x], then returns an int array containing the indices of those
  columns which satisfy the function [f].
 *)

val filter_cols : (dsmat -> bool) -> dsmat -> int array
(** Similar to [filteri_cols] except that the column indices are not passed to [f]. *)

val fold_rows : ('a -> dsmat -> 'a) -> 'a -> dsmat -> 'a
(** [fold_rows f a x] folds all the rows in [x] using function [f]. The order
  of folding is from the first row to the last one.
 *)

val fold_cols : ('a -> dsmat -> 'a) -> 'a -> dsmat -> 'a
(** [fold_cols f a x] folds all the columns in [x] using function [f]. The
  order of folding is from the first column to the last one.
 *)

val mapi_rows : (int -> dsmat -> 'a) -> dsmat -> 'a array
(** [mapi_rows f x] maps every row in [x] to a type ['a] value by applying
  function [f : int -> dsmat -> 'a] to each of them. The results is an array of
  all the returned values.
 *)

val map_rows : (dsmat -> 'a) -> dsmat -> 'a array
(** Similar to [mapi_rows] except row number is not passed to [f]. *)

val mapi_cols : (int -> dsmat -> 'a) -> dsmat -> 'a array
(** [mapi_cols f x] maps every column in [x] to a type ['a] value by applying
  function [f : int -> dsmat -> 'a].
 *)

val map_cols : (dsmat -> 'a) -> dsmat -> 'a array
(** Similar to [mapi_cols] except column number is not passed to [f]. *)

val mapi_by_row : ?d:int -> (int -> dsmat -> dsmat) -> dsmat -> dsmat
(** [mapi_by_row f x] applies [f] to each row of [x], then uses the returned
  row vectors to assemble a new matrix.
 *)

val map_by_row : ?d:int -> (dsmat -> dsmat) -> dsmat -> dsmat
(** [map_by_row f x i] is similar to [mapi_by_row] except that the row indices
  are not passed to [f].
 *)

val mapi_by_col : ?d:int -> (int -> dsmat -> dsmat) -> dsmat -> dsmat
(** [mapi_by_col f x] applies [f] to each column of [x], then uses the returned
  column vectors to assemble a new matrix.
 *)

val map_by_col : ?d:int -> (dsmat -> dsmat) -> dsmat -> dsmat
(** [map_by_col f x i] is similar to [mapi_by_col] except that the column
  indices are not passed to [f].
 *)

val mapi_at_row : (int -> int -> float -> float) -> dsmat -> int -> dsmat
(** [mapi_at_row f x i] creates a new matrix by applying function [f] only to
  the [i]th row in matrix [x].
 *)

val map_at_row : (float -> float) -> dsmat -> int -> dsmat
(** [map_at_row f x i] is similar to [mapi_at_row] except that the coordinates
  of an element is not passed to [f].
 *)

val mapi_at_col : (int -> int -> float -> float) -> dsmat -> int -> dsmat
(** [mapi_at_col f x j] creates a new matrix by applying function [f] only to
  the [j]th column in matrix [x].
 *)

val map_at_col : (float -> float) -> dsmat -> int -> dsmat
(** [map_at_col f x i] is similar to [mapi_at_col] except that the coordinates
  of an element is not passed to [f].
 *)


(** {6 Examine the elements in a matrix} *)

val exists : (float -> bool) -> dsmat -> bool
(** [exists f x] checks all the elements in [x] using [f]. If at least one
  element satisfies [f] then the function returns [true] otherwise [false].
 *)

val not_exists : (float -> bool) -> dsmat -> bool
(** [not_exists f x] checks all the elements in [x], the function returns
  [true] only if all the elements fail to satisfy [f : float -> bool].
 *)

val for_all : (float -> bool) -> dsmat -> bool
(** [for_all f x] checks all the elements in [x], the function returns [true]
  if and only if all the elements pass the check of function [f].
 *)


(** {6 Compare two matrices} *)

val is_equal : dsmat -> dsmat -> bool
(** [is_equal x y] returns [true] if two matrices [x] and [y] are equal. *)

val is_unequal : dsmat -> dsmat -> bool
(** [is_unequal x y] returns [true] if there is at least one element in [x] is
  not equal to that in [y].
 *)

val is_greater : dsmat -> dsmat -> bool
(** [is_greater x y] returns [true] if all the elements in [x] are greater than
  the corresponding elements in [y].
 *)

val is_smaller : dsmat -> dsmat -> bool
(** [is_smaller x y] returns [true] if all the elements in [x] are smaller than
  the corresponding elements in [y].
 *)

val equal_or_greater : dsmat -> dsmat -> bool
(** [equal_or_greater x y] returns [true] if all the elements in [x] are not
  smaller than the corresponding elements in [y].
 *)

val equal_or_smaller : dsmat -> dsmat -> bool
(** [equal_or_smaller x y] returns [true] if all the elements in [x] are not
  greater than the corresponding elements in [y].
 *)


(** {6 Basic mathematical operations of matrices} *)

val add : dsmat -> dsmat -> dsmat
(** [add x y] adds two matrices [x] and [y]. Both must have the same dimensions. *)

val sub : dsmat -> dsmat -> dsmat
(** [sub x y] subtracts the matrix [x] from [y]. Both must have the same dimensions. *)

val mul : dsmat -> dsmat -> dsmat
(** [mul x y] performs an element-wise multiplication, so both [x] and [y]
  must have the same dimensions.
 *)

val div : dsmat -> dsmat -> dsmat
(** [div x y] performs an element-wise division, so both [x] and [y]
  must have the same dimensions.
 *)

val dot : dsmat -> dsmat -> dsmat
(** [dot x y] calculates the dot product of an [m] by [n] matrix [x] and
  another [n] by [p] matrix [y].
 *)

val abs : dsmat -> dsmat
(** [abs x] returns a new matrix where each element has the absolute value of
  that in the original matrix [x].
 *)

val neg : dsmat -> dsmat
(** [neg x] returns a new matrix where each element has the negative value of
  that in the original matrix [x].
 *)

val power : dsmat -> float -> dsmat
(** [power x a] calculates the power of [a] of each element in [x]. *)

val add_scalar : dsmat -> float -> dsmat
(** [add_scalar x a] adds every element in [x] by a constant factor [a]. *)

val sub_scalar : dsmat -> float -> dsmat
(** [sub_scalar x a] subtracts every element in [x] by a constant factor [a]. *)

val mul_scalar : dsmat -> float -> dsmat
(** [mul_scalar x a] multiplies every element in [x] by a constant factor [a]. *)

val div_scalar : dsmat -> float -> dsmat
(** [div_scalar x a] divides every element in [x] by a constant factor [a]. *)

val sum : dsmat -> float
(** [sum x] returns the summation of all the elements in [x]. *)

val average : dsmat -> float
(** [average x] returns the average value of all the elements in [x]. It is
  equivalent to calculate [sum x] divided by [numel x]
 *)

val min : dsmat -> float * int * int
(** [min x] returns the minimum value of all elements in [x]. *)

val max : dsmat -> float * int * int
(** [max x] returns the maximum value of all elements in [x]. *)

val minmax : dsmat -> float * float * int * int * int * int
(** [minmax x] returns both the minimum and minimum values in [x]. *)

val is_zero : dsmat -> bool
(** [is_zero x] returns [true] if all the elements in [x] are zeros. *)

val is_positive : dsmat -> bool
(** [is_positive x] returns [true] if all the elements in [x] are positive. *)

val is_negative : dsmat -> bool
(** [is_negative x] returns [true] if all the elements in [x] are negative. *)

val is_nonnegative : dsmat -> bool
(** [is_nonnegative] returns [true] if all the elements in [x] are non-negative. *)

val log : dsmat -> dsmat
(** [log x] applies [log] function to each element in matrix [x]. *)

val log10 : dsmat -> dsmat
(** [log10 x] applies [log10] function to each element in matrix [x]. *)

val exp : dsmat -> dsmat
(** [exp x] applies [exp] function to each element in matrix [x]. *)

val sigmoid : dsmat -> dsmat
(** [sigmoid x] applies [sigmoid] function to each element in matrix [x]. *)

val sum_rows : dsmat -> dsmat
(** [sum_rows x] returns the summation of all the row vectors in [x]. *)

val sum_cols : dsmat -> dsmat
(** [sum_cols] returns the summation of all the column vectors in [x]. *)

val average_rows : dsmat -> dsmat
(** [average_rows x] returns the average value of all row vectors in [x]. It is
  equivalent to [div_scalar (sum_rows x) (float_of_int (row_num x))].
 *)

val average_cols : dsmat -> dsmat
(** [average_cols x] returns the average value of all column vectors in [x].
  It is equivalent to [div_scalar (sum_cols x) (float_of_int (col_num x))].
 *)

val min_rows : dsmat -> (float * int * int) array
(** [min_rows x] returns the minimum value in each row along with their coordinates. *)

val min_cols : dsmat -> (float * int * int) array
(** [min_cols x] returns the minimum value in each column along with their coordinates. *)

val max_rows : dsmat -> (float * int * int) array
(** [max_rows x] returns the maximum value in each row along with their coordinates. *)

val max_cols : dsmat -> (float * int * int) array
(** [min_cols x] returns the minimum value in each column along with their coordinates. *)


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> dsmat -> int -> dsmat * int array
(** [draw_rows x m] draws [m] rows randomly from [x]. The row indices are also
  returned in an int array along with the selected rows. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val draw_cols : ?replacement:bool -> dsmat -> int -> dsmat * int array
(** [draw_cols x m] draws [m] cols randomly from [x]. The column indices are
  also returned in an int array along with the selected columns. The parameter
  [replacement] indicates whether the drawing is by replacement or not.
 *)

val shuffle_rows : dsmat -> dsmat
(** [shuffle_rows x] shuffles all the rows in matrix [x]. *)

val shuffle_cols : dsmat -> dsmat
(** [shuffle_cols x] shuffles all the columns in matrix [x]. *)

val shuffle: dsmat -> dsmat
(** [shuffle x] shuffles all the elements in [x] by first shuffling along the
  rows then shuffling along columns. It is equivalent to [shuffle_cols (shuffle_rows x)].
 *)


(** {6 Input/Output and helper functions} *)

val to_array : dsmat -> float array
(** [to_array x] flattens an [m] by [n] matrix [x] then returns [x] as an
  float array of length [(numel x)].
 *)

val to_arrays : dsmat -> float array array
(** [to arrays x] returns an array of float arrays, wherein each row in [x]
  becomes an array in the result.
 *)

val of_array : float array -> int -> int -> dsmat
(** [of_array x m n] converts a float array [x] into an [m] by [n] matrix. Note the
  length of [x] must be equal to [(m * n)].
 *)

val of_arrays : float array array -> dsmat
(** [of_arrays x] converts an array of [m] float arrays (of length [n]) in to
  an [m] by [n] matrix.
 *)

val print : dsmat -> unit
(** [print x] pretty prints matrix [x] without headings. *)

val pp_dsmat : dsmat -> unit
(** [pp_spmat x] pretty prints matrix [x] with headings. Toplevel uses this
  function to print out the matrices.
 *)

val save : dsmat -> string -> unit
(** [save x f] saves the matrix [x] to a file with the name [f]. The format
  is binary by using [Marshal] module to serialise the matrix.
 *)

val load : string -> dsmat
(** [load f] loads a sparse matrix from file [f]. The file must be previously
  saved by using [save] function.
 *)

val save_txt : dsmat -> string -> unit
(** [save_txt x f] save the matrix [x] into a text file [f]. The operation can
  be very time consuming.
 *)

val load_txt : string -> dsmat
(** [load_txt f] load a text file [f] into a matrix. *)


(** {6 Shorhand infix operators} *)

val ( >> ) : dsmat -> dsmat -> unit
(** Shorthand for [copy_to x y], i.e., x >> y *)

val ( << ) : dsmat -> dsmat -> unit
(** Shorthand for [copy_to y x], i.e., x << y *)

val ( @= ) : dsmat -> dsmat -> dsmat
(** Shorthand for [concat_vertical x y], i.e., x @= y *)

val ( @|| ) : dsmat -> dsmat -> dsmat
(** Shorthand for [concat_horizontal x y], i.e., x @|| y *)

val ( +@ ) : dsmat -> dsmat -> dsmat
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : dsmat -> dsmat -> dsmat
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : dsmat -> dsmat -> dsmat
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : dsmat -> dsmat -> dsmat
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( $@ ) : dsmat -> dsmat -> dsmat
(** Shorthand for [dot x y], i.e., [x $@ y] *)

val ( **@ ) : dsmat -> float -> dsmat
(** Shorthand for [power x a], i.e., [x **@ a] *)

val ( +$ ) : dsmat -> float -> dsmat
(** Shorthand for [add_scalar x a], i.e., [x +$ a] *)

val ( -$ ) : dsmat -> float -> dsmat
(** Shorthand for [sub_scalar x a], i.e., [x -$ a] *)

val ( *$ ) : dsmat -> float -> dsmat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : dsmat -> float -> dsmat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $+ ) : float -> dsmat -> dsmat
(** Shorthand for [add_scalar x a], i.e., [a $+ x] *)

val ( $- ) : float -> dsmat -> dsmat
(** Shorthand for [sub_scalar x a], i.e., [a -$ x] *)

val ( $* ) : float -> dsmat -> dsmat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : float -> dsmat -> dsmat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( =@ ) : dsmat -> dsmat -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : dsmat -> dsmat -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : dsmat -> dsmat -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : dsmat -> dsmat -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : dsmat -> dsmat -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : dsmat -> dsmat -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

val ( @@ ) : (float -> float) -> dsmat -> dsmat
(** Shorthand for [map f x], i.e., f @@ x *)

(* TODO: for debug purpose *)

val gsl_col : dsmat -> int -> dsmat
