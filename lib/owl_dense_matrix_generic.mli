(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b, c_layout) Array2.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(** {6 Create dense matrices} *)

val empty : ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [empty m n] creates an [m] by [n] matrix without initialising the values of
  elements in [x].
 *)

val create : ('a, 'b) kind -> int -> int -> 'a -> ('a, 'b) t
(** [create m n a] creates an [m] by [n] matrix and all the elements of [x] are
  initialised with the value [a].
*)

val init : ('a, 'b) kind -> int -> int -> (int -> 'a) -> ('a, 'b) t
(** [init m n f] creates a matrix [x] of shape [m x n], then using
  [f] to initialise the elements in [x]. The input of [f] is 1-dimensional
  index of the matrix. You need to explicitly convert it if you need 2D
  index. The function [Owl_utils._index_1d_nd] can help you.
 *)

val init_nd : ('a, 'b) kind -> int -> int -> (int -> int -> 'a) -> ('a, 'b) t
(* [init_nd m n f] s almost the same as [init] but [f] receives 2D index
  as input. It is more convenient since you don't have to convert the index by
  yourself, but this also means [init_nd] is slower than [init]. *)

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [zeros m n] creates an [m] by [n] matrix where all the elements are
  initialised to zeros.
 *)

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [ones m n] creates an [m] by [n] matrix where all the elements are ones. *)

val eye : ('a, 'b) kind -> int -> ('a, 'b) t
(** [eye m] creates an [m] by [m] identity matrix. *)

val sequential : ('a, 'b) kind -> ?a:'a -> ?step:'a -> int -> int -> ('a, 'b) t
(** [sequential ~a ~step m n] creates an [m] by [n] matrix. The elements in [x]
  are initialised sequentiallly from [~a] and is increased by [~step].

  The default value of [~a] is zero whilst the default value of [~step] is one.
 *)

val uniform : ?scale:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [uniform m n] creates an [m] by [n] matrix where all the elements
  follow a uniform distribution in [(0,1)] interval. [uniform ~scale:a m n]
  adjusts the interval to [(0,a)].
 *)

val gaussian : ?sigma:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t
(** [gaussian m n] creates an [m] by [n] matrix where all the elements in [x]
  follow a Gaussian distribution with specified sigma. By default [sigma = 1].
 *)

val semidef : (float, 'b) kind -> int -> (float, 'b) t
(** [ semidef n ] returns an random [n] by [n] positive semi-definite matrix. *)

val linspace : ('a, 'b) kind -> 'a -> 'a -> int -> ('a, 'b) t
(** [linspace a b n] linearly divides the interval [[a,b]] into [n] pieces by
  creating an [m] by [1] row vector. E.g., [linspace 0. 5. 5] will create a
  row vector [[0;1;2;3;4;5]].
 *)

val logspace : ('a, 'b) kind -> ?base:float -> 'a -> 'a -> int -> ('a, 'b) t
(** [logspace base a b n] ... the default value of base is [e]. *)

val meshgrid : ('a, 'b) kind -> 'a -> 'a -> 'a -> 'a -> int -> int -> ('a, 'b) t * ('a, 'b) t
(** [meshgrid a1 b1 a2 b2 n1 n2] is similar to the [meshgrid] function in
  Matlab. It returns two matrices [x] and [y] where the row vectors in [x] are
  linearly spaced between [[a1,b1]] by [n1] whilst the column vectors in [y]
  are linearly spaced between [(a2,b2)] by [n2].
 *)

val meshup : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(** [meshup x y] creates mesh grids by using two row vectors [x] and [y]. *)

val bernoulli : ('a, 'b) kind -> ?p:float -> ?seed:int -> int -> int -> ('a, 'b) t
(** [bernoulli k ~p:0.3 m n]*)

val diagmat : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** [diagmat k v] creates a diagonal matrix using the elements in [v] as
  diagonal values. [k] specifies the main diagonal index. If [k > 0] then it is
  above the main diagonal, if [k < 0] then it is below the main diagonal.
  This function is the same as the [diag] function in Matlab.
 *)


(** {6 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int
(** If [x] is an [m] by [n] matrix, [shape x] returns [(m,n)], i.e., the size
  of two dimensions of [x].
 *)

val row_num : ('a, 'b) t -> int
(** [row_num x] returns the number of rows in matrix [x]. *)

val col_num : ('a, 'b) t -> int
(** [col_num x] returns the number of columns in matrix [x]. *)

val numel : ('a, 'b) t -> int
(** [numel x] returns the number of elements in matrix [x]. It is equivalent
  to [(row_num x) * (col_num x)].
 *)

val nnz : ('a, 'b) t -> int
(** [nnz x] returns the number of non-zero elements in [x]. *)

val density : ('a, 'b) t -> float
(** [density x] returns the percentage of non-zero elements in [x]. *)

val size_in_bytes : ('a, 'b) t -> int
(** [size_in_bytes x] returns the size of [x] in bytes in memory. *)

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool
(** [same_shape x y] returns [true] if two matrics have the same shape. *)

val kind : ('a, 'b) t -> ('a, 'b) kind
(** [kind x] returns the type of matrix [x]. *)


(** {6 Manipulate a matrix} *)

val get : ('a, 'b) t -> int -> int -> 'a
(** [get x i j] returns the value of element [(i,j)] of [x]. The shorthand
  for [get x i j] is [x.{i,j}]
 *)

val set : ('a, 'b) t -> int -> int -> 'a -> unit
(** [set x i j a] sets the element [(i,j)] of [x] to value [a]. The shorthand
  for [set x i j a] is [x.{i,j} <- a]
 *)

val row : ('a, 'b) t -> int -> ('a, 'b) t
(** [row x i] returns the row [i] of [x]. *)

val col : ('a, 'b) t -> int -> ('a, 'b) t
(** [col x j] returns the column [j] of [x]. *)

val rows : ('a, 'b) t -> int array -> ('a, 'b) t
(** [rows x a] returns the rows (defined in an int array [a]) of [x]. The
  returned rows will be combined into a new dense matrix. The order of rows in
  the new matrix is the same as that in the array [a].
 *)

val cols : ('a, 'b) t -> int array -> ('a, 'b) t
(** Similar to [rows], [cols x a] returns the columns (specified in array [a])
  of x in a new dense matrix.
 *)

val reshape : int -> int -> ('a, 'b) t -> ('a, 'b) t
(** [reshape m n x] returns a new [m] by [n] matrix from the [m'] by [n']
  matrix [x]. Note that [(m * n)] must be equal to [(m' * n')], and the
  returned matrix shares the same memory with the original [x].
 *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(** [flatten x] reshape [x] into a [1] by [n] row vector without making a copy.
  Therefore the returned value shares the same memory space with original [x].
 *)

val slice : int list list -> ('a, 'b) t -> ('a, 'b) t
(** [slice s x] returns a copy of the slice in [x]. The slice is defined by [a]
  which is an [int array]. Please refer to the same function in the
  [Owl_dense_ndarray_generic] documentation for more details.
 *)

val reverse : ('a, 'b) t -> ('a, 'b) t
(** [reverse x] reverse the order of all elements in the flattened [x] and
  returns the results in a new matrix. The original [x] remains intact.
 *)

val reset : ('a, 'b) t -> unit
(* [reset x] resets all the elements of [x] to zero value. *)

val fill : ('a, 'b) t -> 'a -> unit
(** [fill x a] fills the [x] with value [a]. *)

val clone : ('a, 'b) t -> ('a, 'b) t
(** [clone x] returns a copy of matrix [x]. *)

val copy_to : ('a, 'b) t -> ('a, 'b) t -> unit
(** [copy_to x y] copies the elements of [x] to [y]. [x] and [y] must have
  the same demensions.
 *)

val copy_row_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** [copy_row_to v x i] copies an [1] by [n] row vector [v] to the [i]th row
  in an [m] by [n] matrix [x].
 *)

val copy_col_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** [copy_col_to v x j] copies an [1] by [n] column vector [v] to the [j]th
  column in an [m] by [n] matrix [x].
 *)

val concat_vertical : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [concat_vertical x y] concats two matrices [x] and [y] vertically,
  therefore their column numbers must be the same.
 *)

val concat_horizontal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [concat_horizontal x y] concats two matrices [x] and [y] horizontally,
  therefore their row numbers must be the same.
 *)

val concatenate : ?axis:int -> ('a, 'b) t array -> ('a, 'b) t
(** [concatenate ~axis:1 x] concatenates an array of matrices along the second
  dimension. For the matrices in [x], they must have the same shape except the
  dimension specified by [axis]. The default value of [axis] is 0, i.e., the
  lowest dimension on a marix, i.e., rows.
 *)

val transpose : ('a, 'b) t -> ('a, 'b) t
(** [transpose x] transposes an [m] by [n] matrix to [n] by [m] one. *)

val diag : ('a, 'b) t -> ('a, 'b) t
(** [diag x] returns the diagonal elements of [x]. *)

val replace_row : ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t
(** [replace_row v x i] uses the row vector [v] to replace the [i]th row in
  the matrix [x].
 *)

val replace_col : ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t
(** [replace_col v x j] uses the column vector [v] to replace the [j]th column
  in the matrix [x].
 *)

val swap_rows : ('a, 'b) t -> int -> int -> unit
(** [swap_rows x i i'] swaps the row [i] with row [i'] of [x]. *)

val swap_cols : ('a, 'b) t -> int -> int -> unit
(** [swap_cols x j j'] swaps the column [j] with column [j'] of [x]. *)

val tile : ('a, 'b) t -> int array -> ('a, 'b) t
(** [tile x a] provides the exact behaviour as [numpy.tile] function. *)

val repeat : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t
(** [repeat ~axis x a] repeats the elements along [~axis] for [a] times. *)

val pad : ?v:'a -> int list list -> ('a, 'b) t -> ('a, 'b) t
(** [padd ~v:0. [[1;1]] x] *)

val dropout : ?rate:float -> ?seed:int -> ('a, 'b) t -> ('a, 'b) t
(** [dropout ~rate:0.3 x] drops out 30% of the elements in [x], in other words,
  by setting their values to zeros.
 *)


(** {6 Iterate elements, columns, and rows.} *)

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

val map2i : (int -> int -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val map2 : ('a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

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

val iter2i_rows : (int -> ('a, 'b) t -> ('a, 'b) t -> unit) -> ('a, 'b) t -> ('a, 'b) t -> unit

val iter2_rows : (('a, 'b) t -> ('a, 'b) t -> unit) -> ('a, 'b) t -> ('a, 'b) t -> unit

val iteri_cols : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** [iteri_cols f x] iterates every column in [x] and applies function
  [f : int -> mat -> unit] to each of them. Column number is passed to [f] as
  the first parameter.
 *)

val iter_cols : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** Similar to [iteri_cols] except col number is not passed to [f]. *)

val filteri_rows : (int -> ('a, 'b) t -> bool) -> ('a, 'b) t -> int array
(** [filteri_rows f x] uses function [f : int -> mat -> bool] to check each
  row in [x], then returns an int array containing the indices of those rows
  which satisfy the function [f].
 *)

val filter_rows : (('a, 'b) t -> bool) -> ('a, 'b) t -> int array
(** Similar to [filteri_rows] except that the row indices are not passed to [f]. *)

val filteri_cols : (int -> ('a, 'b) t -> bool) -> ('a, 'b) t -> int array
(** [filteri_cols f x] uses function [f : int -> mat -> bool] to check each
  column in [x], then returns an int array containing the indices of those
  columns which satisfy the function [f].
 *)

val filter_cols : (('a, 'b) t -> bool) -> ('a, 'b) t -> int array
(** Similar to [filteri_cols] except that the column indices are not passed to [f]. *)

val fold_rows : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_rows f a x] folds all the rows in [x] using function [f]. The order
  of folding is from the first row to the last one.
 *)

val fold_cols : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** [fold_cols f a x] folds all the columns in [x] using function [f]. The
  order of folding is from the first column to the last one.
 *)

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

val mapi_by_row : int -> (int -> ('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t
(** [mapi_by_row d f x] applies [f] to each row of a [m] by [n] matrix [x],
  then uses the returned [d] dimensional row vectors to assemble a new
  [m] by [d] matrix.
 *)

val map_by_row : int -> (('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t
(** [map_by_row d f x] is similar to [mapi_by_row] except that the row indices
  are not passed to [f].
 *)

val mapi_by_col : int -> (int -> ('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t
(** [mapi_by_col d f x] applies [f] to each column of a [m] by [n] matrix [x],
  then uses the returned [d] dimensional column vectors to assemble a new
  [d] by [n] matrix.
 *)

val map_by_col : int -> (('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t
(** [map_by_col d f x] is similar to [mapi_by_col] except that the column
  indices are not passed to [f].
 *)

val mapi_at_row : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t
(** [mapi_at_row f x i] creates a new matrix by applying function [f] only to
  the [i]th row in matrix [x].
 *)

val map_at_row : ('a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t
(** [map_at_row f x i] is similar to [mapi_at_row] except that the coordinates
  of an element is not passed to [f].
 *)

val mapi_at_col : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t
(** [mapi_at_col f x j] creates a new matrix by applying function [f] only to
  the [j]th column in matrix [x].
 *)

val map_at_col : ('a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t
(** [map_at_col f x i] is similar to [mapi_at_col] except that the coordinates
  of an element is not passed to [f].
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

val elt_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(* [elt_equal x y] performs element-wise [=] comparison of [x] and [y]. *)

val elt_not_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(* [elt_not_equal x y] performs element-wise [!=] comparison of [x] and [y]. *)

val elt_less : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(* [elt_less x y] performs element-wise [<] comparison of [x] and [y]. *)

val elt_greater : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(* [elt_greater x y] performs element-wise [>] comparison of [x] and [y]. *)

val elt_less_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(* [elt_less_equal x y] performs element-wise [<=] comparison of [x] and [y]. *)

val elt_greater_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(* [elt_greater_equal x y] performs element-wise [>=] comparison of [x] and [y]. *)

val equal_scalar : ('a, 'b) t -> 'a -> bool
(* [equal_scalar x a] checks if all the elements in [x] are equal to [a]. *)

val not_equal_scalar : ('a, 'b) t -> 'a -> bool
(* [not_equal_scalar x a] checks if all the elements in [x] are not equal to [a]. *)

val less_scalar : ('a, 'b) t -> 'a -> bool
(* [less_scalar x a] checks if all the elements in [x] are less than [a]. *)

val greater_scalar : ('a, 'b) t -> 'a -> bool
(* [greater_scalar x a] checks if all the elements in [x] are greater than [a]. *)

val less_equal_scalar : ('a, 'b) t -> 'a -> bool
(* [less_equal_scalar x a] checks if all the elements in [x] are less or equal to [a]. *)

val greater_equal_scalar : ('a, 'b) t -> 'a -> bool
(* [greater_equal_scalar x a] checks if all the elements in [x] are greater or equal to [a]. *)

val elt_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [elt_equal_scalar x a] performs element-wise [=] comparison of [x] and [a]. *)

val elt_not_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [elt_not_equal_scalar x a] performs element-wise [!=] comparison of [x] and [a]. *)

val elt_less_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [elt_less_scalar x a] performs element-wise [<] comparison of [x] and [a]. *)

val elt_greater_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [elt_greater_scalar x a] performs element-wise [>] comparison of [x] and [a]. *)

val elt_less_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [elt_less_equal_scalar x a] performs element-wise [<=] comparison of [x] and [a]. *)

val elt_greater_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(* [elt_greater_equal_scalar x a] performs element-wise [>=] comparison of [x] and [a]. *)


(** {6 Randomisation functions} *)

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

val draw_rows2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(* [draw_rows2 x y c] is similar to [draw_rows] but applies to two matrices. *)

val draw_cols2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(* [draw_col2 x y c] is similar to [draw_cols] but applies to two matrices. *)

val shuffle_rows : ('a, 'b) t -> ('a, 'b) t
(** [shuffle_rows x] shuffles all the rows in matrix [x]. *)

val shuffle_cols : ('a, 'b) t -> ('a, 'b) t
(** [shuffle_cols x] shuffles all the columns in matrix [x]. *)

val shuffle: ('a, 'b) t -> ('a, 'b) t
(** [shuffle x] shuffles all the elements in [x] by first shuffling along the
  rows then shuffling along columns. It is equivalent to [shuffle_cols (shuffle_rows x)].
 *)


(** {6 Input/Output functions} *)

val to_array : ('a, 'b) t -> 'a array
(** [to_array x] flattens an [m] by [n] matrix [x] then returns [x] as an
  float array of length [(numel x)].
 *)

val of_array : ('a, 'b) kind -> 'a array -> int -> int -> ('a, 'b) t
(** [of_array x m n] converts a float array [x] into an [m] by [n] matrix. Note the
  length of [x] must be equal to [(m * n)].
 *)

val to_arrays : ('a, 'b) t -> 'a array array
(** [to arrays x] returns an array of float arrays, wherein each row in [x]
  becomes an array in the result.
 *)

val of_arrays : ('a, 'b) kind -> 'a array array -> ('a, 'b) t
(** [of_arrays x] converts an array of [m] float arrays (of length [n]) in to
  an [m] by [n] matrix.
 *)

val to_ndarray : ('a, 'b) t -> ('a, 'b) Owl_dense_ndarray_generic.t
(** [to_ndarray x] transforms a dense real matrix to [Bigarray.Genarray.t] type.
  No copy is made by calling this function.
 *)

val of_ndarray : ('a, 'b) Owl_dense_ndarray_generic.t -> ('a, 'b) t
(** [of_ndarray x] transforms a ndarray of type [Bigarray.Genarray.t] to a dense
  real matrix type. No copy is made by calling this function.
 *)

val to_rows : ('a, 'b) t -> ('a, 'b) t array

val of_rows : ('a, 'b) t array -> ('a, 'b) t

val to_cols : ('a, 'b) t -> ('a, 'b) t array

val of_cols : ('a, 'b) t array -> ('a, 'b) t

val print : ('a, 'b) t -> unit
(** [print x] pretty prints matrix [x] without headings. *)

val pp_dsmat : ('a, 'b) t -> unit
(** [pp_spmat x] pretty prints matrix [x] with headings. Toplevel uses this
  function to print out the matrices.
 *)

val save : ('a, 'b) t -> string -> unit
(** [save x f] saves the matrix [x] to a file with the name [f]. The format
  is binary by using [Marshal] module to serialise the matrix.
 *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** [load f] loads a sparse matrix from file [f]. The file must be previously
  saved by using [save] function.
 *)

val save_txt : ('a, 'b) t -> string -> unit
(** [save_txt x f] save the matrix [x] into a text file [f]. The operation can
  be very time consuming.
 *)

val load_txt : (float, 'a) kind -> string -> (float, 'a) t
(** [load_txt f] load a text file [f] into a matrix. *)


(** {6 Unary mathematical operations } *)

val re_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [re_c2s x] returns all the real components of [x] in a new ndarray of same shape. *)

val re_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [re_d2z x] returns all the real components of [x] in a new ndarray of same shape. *)

val im_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [im_c2s x] returns all the imaginary components of [x] in a new ndarray of same shape. *)

val im_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [im_d2z x] returns all the imaginary components of [x] in a new ndarray of same shape. *)

val conj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [conj x] computes the conjugate of the elements in [x] and returns the
  result in a new matrix.
 *)

val min : (float, 'a) t -> float
(** [min x] returns the minimum value of all elements in [x]. *)

val max : (float, 'a) t -> float
(** [max x] returns the maximum value of all elements in [x]. *)

val minmax : (float, 'a) t -> float * float
(** [minmax x] returns both the minimum and minimum values in [x]. *)

val min_i : (float, 'a) t -> float * int * int

val max_i : (float, 'a) t -> float * int * int

val minmax_i : (float, 'a) t -> (float * int * int) * (float * int * int)

val inv : ('a, 'b) t -> ('a, 'b) t
(** [inv x] returns the inverse of a square matrix [x]. *)

val trace : ('a, 'b) t -> 'a
(** [trace x] returns the sum of diagonal elements in [x]. *)

val sum : ('a, 'b) t -> 'a
(** [sum x] returns the summation of all the elements in [x]. *)

val prod : ('a, 'b) t -> 'a
(** [prod x] returns the product of all the elements in [x]. *)

val average : ('a, 'b) t -> 'a
(** [average x] returns the average value of all the elements in [x]. It is
  equivalent to calculate [sum x] divided by [numel x]
 *)

val sum_rows : ('a, 'b) t -> ('a, 'b) t
(** [sum_rows x] returns the summation of all the row vectors in [x]. *)

val sum_cols : ('a, 'b) t -> ('a, 'b) t
(** [sum_cols] returns the summation of all the column vectors in [x]. *)

val average_rows : ('a, 'b) t -> ('a, 'b) t
(** [average_rows x] returns the average value of all row vectors in [x]. It is
 equivalent to [div_scalar (sum_rows x) (float_of_int (row_num x))].
 *)

val average_cols : ('a, 'b) t -> ('a, 'b) t
(** [average_cols x] returns the average value of all column vectors in [x].
 It is equivalent to [div_scalar (sum_cols x) (float_of_int (col_num x))].
 *)

val min_rows : (float, 'b) t -> (float * int * int) array
(** [min_rows x] returns the minimum value in each row along with their coordinates. *)

val min_cols : (float, 'b) t -> (float * int * int) array
(** [min_cols x] returns the minimum value in each column along with their coordinates. *)

val max_rows : (float, 'b) t -> (float * int * int) array
(** [max_rows x] returns the maximum value in each row along with their coordinates. *)

val max_cols : (float, 'b) t -> (float * int * int) array
(** [max_cols x] returns the maximum value in each column along with their coordinates. *)

val abs : (float, 'a) t -> (float, 'a) t
(** [abs x] returns the absolute value of all elements in [x] in a new matrix. *)

val abs_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [abs_c2s x] is similar to [abs] but takes [complex32] as input. *)

val abs_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [abs_z2d x] is similar to [abs] but takes [complex64] as input. *)

val abs2 : (float, 'a) t -> (float, 'a) t
(** [abs2 x] returns the square of absolute value of all elements in [x] in a new ndarray. *)

val abs2_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [abs2_c2s x] is similar to [abs2] but takes [complex32] as input. *)

val abs2_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [abs2_z2d x] is similar to [abs2] but takes [complex64] as input. *)

val conj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [conj x] returns the conjugate of the complex [x]. *)

val neg : ('a, 'b) t -> ('a, 'b) t
(** [neg x] negates the elements in [x] and returns the result in a new matrix. *)

val reci : ('a, 'b) t -> ('a, 'b) t
(** [reci x] computes the reciprocal of every elements in [x] and returns the
  result in a new ndarray.
 *)

val signum : (float, 'a) t -> (float, 'a) t
(** [signum] computes the sign value ([-1] for negative numbers, [0] (or [-0])
  for zero, [1] for positive numbers, [nan] for [nan]).
 *)

val sqr : (float, 'a) t -> (float, 'a) t
(** [sqr x] computes the square of the elements in [x] and returns the result in
  a new matrix.
 *)

val sqrt : (float, 'a) t -> (float, 'a) t
(** [sqrt x] computes the square root of the elements in [x] and returns the
  result in a new matrix.
 *)

val cbrt : (float, 'a) t -> (float, 'a) t
(** [cbrt x] computes the cubic root of the elements in [x] and returns the
  result in a new matrix.
 *)

val exp : (float, 'a) t -> (float, 'a) t
(** [exp x] computes the exponential of the elements in [x] and returns the
  result in a new matrix.
 *)

val exp2 : (float, 'a) t -> (float, 'a) t
(** [exp2 x] computes the base-2 exponential of the elements in [x] and returns
  the result in a new matrix.
 *)

val exp10 : (float, 'a) t -> (float, 'a) t
(** [exp2 x] computes the base-10 exponential of the elements in [x] and returns
  the result in a new matrix.
 *)

val expm1 : (float, 'a) t -> (float, 'a) t
(** [expm1 x] computes [exp x -. 1.] of the elements in [x] and returns the
  result in a new matrix.
 *)

val log : (float, 'a) t -> (float, 'a) t
(** [log x] computes the logarithm of the elements in [x] and returns the
  result in a new matrix.
 *)

val log10 : (float, 'a) t -> (float, 'a) t
(** [log10 x] computes the base-10 logarithm of the elements in [x] and returns
  the result in a new matrix.
 *)

val log2 : (float, 'a) t -> (float, 'a) t
(** [log2 x] computes the base-2 logarithm of the elements in [x] and returns
  the result in a new matrix.
 *)

val log1p : (float, 'a) t -> (float, 'a) t
(** [log1p x] computes [log (1 + x)] of the elements in [x] and returns the
  result in a new matrix.
 *)

val sin : (float, 'a) t -> (float, 'a) t
(** [sin x] computes the sine of the elements in [x] and returns the result in
  a new matrix.
 *)

val cos : (float, 'a) t -> (float, 'a) t
(** [cos x] computes the cosine of the elements in [x] and returns the result in
  a new matrix.
 *)

val tan : (float, 'a) t -> (float, 'a) t
(** [tan x] computes the tangent of the elements in [x] and returns the result
  in a new matrix.
 *)

val asin : (float, 'a) t -> (float, 'a) t
(** [asin x] computes the arc sine of the elements in [x] and returns the result
  in a new matrix.
 *)

val acos : (float, 'a) t -> (float, 'a) t
(** [acos x] computes the arc cosine of the elements in [x] and returns the
  result in a new matrix.
 *)

val atan : (float, 'a) t -> (float, 'a) t
(** [atan x] computes the arc tangent of the elements in [x] and returns the
  result in a new matrix.
 *)

val sinh : (float, 'a) t -> (float, 'a) t
(** [sinh x] computes the hyperbolic sine of the elements in [x] and returns
  the result in a new matrix.
 *)

val cosh : (float, 'a) t -> (float, 'a) t
(** [cosh x] computes the hyperbolic cosine of the elements in [x] and returns
  the result in a new matrix.
 *)

val tanh : (float, 'a) t -> (float, 'a) t
(** [tanh x] computes the hyperbolic tangent of the elements in [x] and returns
  the result in a new matrix.
 *)

val asinh : (float, 'a) t -> (float, 'a) t
(** [asinh x] computes the hyperbolic arc sine of the elements in [x] and
  returns the result in a new matrix.
 *)

val acosh : (float, 'a) t -> (float, 'a) t
(** [acosh x] computes the hyperbolic arc cosine of the elements in [x] and
  returns the result in a new matrix.
 *)

val atanh : (float, 'a) t -> (float, 'a) t
(** [atanh x] computes the hyperbolic arc tangent of the elements in [x] and
  returns the result in a new matrix.
 *)

val floor : ('a, 'b) t -> ('a, 'b) t
(** [floor x] computes the floor of the elements in [x] and returns the result
  in a new matrix.
 *)

val ceil : ('a, 'b) t -> ('a, 'b) t
(** [ceil x] computes the ceiling of the elements in [x] and returns the result
  in a new matrix.
 *)

val round : ('a, 'b) t -> ('a, 'b) t
(** [round x] rounds the elements in [x] and returns the result in a new matrix. *)

val trunc : ('a, 'b) t -> ('a, 'b) t
(** [trunc x] computes the truncation of the elements in [x] and returns the
  result in a new matrix.
 *)

val modf : ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(** [modf x] performs [modf] over all the elements in [x], the fractal part is
  saved in the first element of the returned tuple whereas the integer part is
  saved in the second element.
 *)

val erf : (float, 'a) t -> (float, 'a) t
(** [erf x] computes the error function of the elements in [x] and returns the
  result in a new matrix.
 *)

val erfc : (float, 'a) t -> (float, 'a) t
(** [erfc x] computes the complementary error function of the elements in [x]
  and returns the result in a new matrix.
 *)

val logistic : (float, 'a) t -> (float, 'a) t
(** [logistic x] computes the logistic function [1/(1 + exp(-a)] of the elements
  in [x] and returns the result in a new matrix.
 *)

val relu : (float, 'a) t -> (float, 'a) t
(** [relu x] computes the rectified linear unit function [max(x, 0)] of the
  elements in [x] and returns the result in a new matrix.
 *)

val elu : ?alpha:float -> (float, 'a) t -> (float, 'a) t
(** refer to [Owl_dense_ndarray_generic.elu] *)

val leaky_relu : ?alpha:float -> (float, 'a) t -> (float, 'a) t
(** refer to [Owl_dense_ndarray_generic.leaky_relu] *)

val softplus : (float, 'a) t -> (float, 'a) t
(** [softplus x] computes the softplus function [log(1 + exp(x)] of the elements
  in [x] and returns the result in a new matrix.
 *)

val softsign : (float, 'a) t -> (float, 'a) t
(** [softsign x] computes the softsign function [x / (1 + abs(x))] of the
  elements in [x] and returns the result in a new matrix.
 *)

val softmax : (float, 'a) t -> (float, 'a) t
(** [softmax x] computes the softmax functions [(exp x) / (sum (exp x))] of
  all the elements in [x] and returns the result in a new array.
 *)

val sigmoid : (float, 'a) t -> (float, 'a) t
(** [sigmoid x] computes the sigmoid function [1 / (1 + exp (-x))] for each
  element in [x].
 *)

val log_sum_exp : (float, 'a) t -> float
(** [log_sum_exp x] computes the logarithm of the sum of exponentials of all
  the elements in [x].
 *)

val l1norm : ('a, 'b) t -> float
(** [l1norm x] calculates the l1-norm of all the element in [x]. *)

val l2norm : ('a, 'b) t -> float
(** [l2norm x] calculates the l2-norm of all the element in [x]. *)

val l2norm_sqr : ('a, 'b) t -> float
(** [l2norm_sqr x] calculates the sum of 2-norm (or l2norm, Euclidean norm) of all
  elements in [x]. The function uses conjugate transpose in the product, hence
  it always returns a float number.
 *)

val max_pool : ?padding:Owl_dense_ndarray_generic.padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** [] *)

val avg_pool : ?padding:Owl_dense_ndarray_generic.padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** [] *)

val cumsum : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(* [cumsum ~axis x], refer to the documentation in [Owl_dense_ndarray_generic].
 *)

val cumprod : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(* [cumprod ~axis x], refer to the documentation in [Owl_dense_ndarray_generic].
 *)


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [add x y] adds all the elements in [x] and [y] elementwise, and returns the
  result in a new matrix.
 *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [sub x y] subtracts all the elements in [x] and [y] elementwise, and returns
  the result in a new matrix.
 *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [mul x y] multiplies all the elements in [x] and [y] elementwise, and
  returns the result in a new matrix.
 *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [div x y] divides all the elements in [x] and [y] elementwise, and returns
  the result in a new matrix.
 *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [add_scalar x a] adds a scalar value [a] to all the elements in [x], and
  returns the result in a new matrix.
 *)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [sub_scalar x a] subtracts a scalar value [a] to all the elements in [x],
  and returns the result in a new matrix.
 *)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [mul_scalar x a] multiplies a scalar value [a] to all the elements in [x],
  and returns the result in a new matrix.
 *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [div_scalar x a] divides a scalar value [a] to all the elements in [x], and
  returns the result in a new matrix.
 *)

val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_add a x] is similar to [add_scalar] but with scalar as the first parameter. *)

val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_sub a x] is similar to [sub_scalar] but with scalar as the first parameter. *)

val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_mul a x] is similar to [mul_scalar] but with scalar as the first parameter. *)

val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_div a x] is similar to [div_scalar] but with scalar as the first parameter. *)

val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [dot x y] returns the dot product of matrix [x] and [y]. *)

val add_diag : ('a, 'b) t -> 'a -> ('a, 'b) t

val pow : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [pow x y] computes [pow(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val scalar_pow : float -> (float, 'a) t -> (float, 'a) t
(** [scalar_pow a x] *)

val pow_scalar : (float, 'a) t -> float -> (float, 'a) t
(** [pow_scalar x a] *)

val atan2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [atan2 x y] computes [atan2(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val scalar_atan2 : float -> (float, 'a) t -> (float, 'a) t
(** [scalar_atan2 a x] *)

val atan2_scalar : (float, 'a) t -> float -> (float, 'a) t
(** [scalar_atan2 x a] *)

val hypot : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [hypot x y] computes [sqrt(x*x + y*y)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val min2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [min2 x y] computes the minimum of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val max2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [max2 x y] computes the maximum of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val fmod : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [fmod x y] performs float mod division. *)

val fmod_scalar : (float, 'a) t -> float -> (float, 'a) t
(** [fmod_scalar x a] performs mod division between [x] and scalar [a]. *)

val scalar_fmod : float -> (float, 'a) t -> (float, 'a) t
(** [scalar_fmod x a] performs mod division between scalar [a] and [x]. *)

val ssqr : ('a, 'b) t -> 'a -> 'a
(** [ssqr x a] computes the sum of squared differences of all the elements in
  [x] from constant [a]. This function only computes the square of each element
  rather than the conjugate transpose as {!sqr_nrm2} does.
 *)

val ssqr_diff : ('a, 'b) t -> ('a, 'b) t -> 'a
(** [ssqr_diff x y] computes the sum of squared differences of every elements in
  [x] and its corresponding element in [y].
 *)

val cross_entropy : (float, 'a) t -> (float, 'a) t -> float
(** [cross_entropy x y] calculates the cross entropy between [x] and [y] using base [e]. *)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(** [clip_by_l2norm t x] clips the [x] according to the threshold set by [t]. *)


(** {6 Shorhand infix operators} *)

val cast_s2d : (float, float32_elt) t -> (float, float64_elt) t
(** [cast_s2d x] casts [x] from [float32] to [float64]. *)

val cast_d2s : (float, float64_elt) t -> (float, float32_elt) t
(** [cast_d2s x] casts [x] from [float64] to [float32]. *)

val cast_c2z : (Complex.t, complex32_elt) t -> (Complex.t, complex64_elt) t
(** [cast_c2z x] casts [x] from [complex32] to [complex64]. *)

val cast_z2c : (Complex.t, complex64_elt) t -> (Complex.t, complex32_elt) t
(** [cast_z2c x] casts [x] from [complex64] to [complex32]. *)

val cast_s2c : (float, float32_elt) t -> (Complex.t, complex32_elt) t
(** [cast_s2c x] casts [x] from [float32] to [complex32]. *)

val cast_d2z : (float, float64_elt) t -> (Complex.t, complex64_elt) t
(** [cast_d2z x] casts [x] from [float64] to [complex64]. *)

val cast_s2z : (float, float32_elt) t -> (Complex.t, complex64_elt) t
(** [cast_s2z x] casts [x] from [float32] to [complex64]. *)

val cast_d2c : (float, float64_elt) t -> (Complex.t, complex32_elt) t
(** [cast_d2c x] casts [x] from [float64] to [complex32]. *)
