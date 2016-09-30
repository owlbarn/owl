(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Dense matrix module *)

type dsmat (* = Gsl.Matrix.matrix *)
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

val mapi : (int -> int -> float -> float) -> dsmat -> dsmat

val map : (float -> float) -> dsmat -> dsmat

val filteri : (int -> int -> float -> bool) -> dsmat -> (int * int) array

val filter : (float -> bool) -> dsmat -> (int * int) array

val fold : ('a -> float -> 'a) -> 'a -> dsmat -> 'a

val iteri_rows : (int -> dsmat -> 'a) -> dsmat -> unit

val iter_rows : (dsmat -> 'a) -> dsmat -> unit

val iteri_cols : (int -> dsmat -> 'a) -> dsmat -> unit

val iter_cols : (dsmat -> 'a) -> dsmat -> unit

val filteri_cols : (int -> dsmat -> bool) -> dsmat -> int array

val filter_cols : (dsmat -> bool) -> dsmat -> int array

val filteri_rows : (int -> dsmat -> bool) -> dsmat -> int array

val filter_rows : (dsmat -> bool) -> dsmat -> int array

val fold_rows : ('a -> dsmat -> 'a) -> 'a -> dsmat -> 'a

val fold_cols : ('a -> dsmat -> 'a) -> 'a -> dsmat -> 'a

val mapi_rows : (int -> dsmat -> 'a) -> dsmat -> 'a array

val map_rows : (dsmat -> 'a) -> dsmat -> 'a array

val mapi_cols : (int -> dsmat -> 'a) -> dsmat -> 'a array

val map_cols : (dsmat -> 'a) -> dsmat -> 'a array

val mapi_by_row : ?d:int -> (int -> dsmat -> dsmat) -> dsmat -> dsmat

val map_by_row : ?d:int -> (dsmat -> dsmat) -> dsmat -> dsmat

val mapi_by_col : ?d:int -> (int -> dsmat -> dsmat) -> dsmat -> dsmat

val map_by_col : ?d:int -> (dsmat -> dsmat) -> dsmat -> dsmat

val mapi_at_row : (int -> int -> float -> float) -> dsmat -> int -> dsmat

val map_at_row : (float -> float) -> dsmat -> int -> dsmat

val mapi_at_col : (int -> int -> float -> float) -> dsmat -> int -> dsmat

val map_at_col : (float -> float) -> dsmat -> int -> dsmat


(** {6 Examine the elements in a matrix} *)

val exists : (float -> bool) -> dsmat -> bool

val not_exists : (float -> bool) -> dsmat -> bool

val for_all : (float -> bool) -> dsmat -> bool


(** {6 Compare two matrices} *)

val is_equal : dsmat -> dsmat -> bool

val is_unequal : dsmat -> dsmat -> bool

val is_greater : dsmat -> dsmat -> bool

val is_smaller : dsmat -> dsmat -> bool

val equal_or_greater : dsmat -> dsmat -> bool

val equal_or_smaller : dsmat -> dsmat -> bool


(** {6 Basic mathematical operations of matrices} *)

val add : dsmat -> dsmat -> dsmat

val sub : dsmat -> dsmat -> dsmat

val mul : dsmat -> dsmat -> dsmat

val div : dsmat -> dsmat -> dsmat

val dot : dsmat -> dsmat -> dsmat

val abs : dsmat -> dsmat

val neg : dsmat -> dsmat

val power : dsmat -> float -> dsmat

val add_scalar : dsmat -> float -> dsmat

val sub_scalar : dsmat -> float -> dsmat

val mul_scalar : dsmat -> float -> dsmat

val div_scalar : dsmat -> float -> dsmat

val sum : dsmat -> float

val sum_rows : dsmat -> dsmat

val sum_cols : dsmat -> dsmat

val average : dsmat -> float

val average_rows : dsmat -> dsmat

val average_cols : dsmat -> dsmat

val min : dsmat -> float * int * int

val min_rows : dsmat -> (float * int * int) array

val min_cols : dsmat -> (float * int * int) array

val max : dsmat -> float * int * int

val max_rows : dsmat -> (float * int * int) array

val max_cols : dsmat -> (float * int * int) array

val minmax : dsmat -> float * float * int * int * int * int

val is_zero : dsmat -> bool

val is_positive : dsmat -> bool

val is_negative : dsmat -> bool

val is_nonnegative : dsmat -> bool

val log : dsmat -> dsmat

val log10 : dsmat -> dsmat

val exp : dsmat -> dsmat

val sigmoid : dsmat -> dsmat


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> dsmat -> int -> dsmat * int array

val draw_cols : ?replacement:bool -> dsmat -> int -> dsmat * int array

val shuffle_rows : dsmat -> dsmat

val shuffle_cols : dsmat -> dsmat

val shuffle_all: dsmat -> dsmat


(** {6 Input/Output and helper functions} *)

val to_array : dsmat -> float array
(** [ to_array x ] flatten dsmatrix x then return as an array *)

val to_arrays : dsmat -> float array array
(** [ to arrays x ] returns an array of arrays, wherein each row becomes an array *)

val of_array : float array -> int -> int -> dsmat

val of_arrays : float array array -> dsmat

val save : dsmat -> string -> unit

val load : string -> dsmat

val save_txt : dsmat -> string -> unit

val load_txt : string -> dsmat

val print : dsmat -> unit

val pp_dsmat : dsmat -> unit


(** {6 Shorhand infix operators} *)

val ( >> ) : dsmat -> dsmat -> unit

val ( << ) : dsmat -> dsmat -> unit

val ( @= ) : dsmat -> dsmat -> dsmat

val ( @|| ) : dsmat -> dsmat -> dsmat

val ( +@ ) : dsmat -> dsmat -> dsmat

val ( -@ ) : dsmat -> dsmat -> dsmat

val ( *@ ) : dsmat -> dsmat -> dsmat

val ( /@ ) : dsmat -> dsmat -> dsmat

val ( $@ ) : dsmat -> dsmat -> dsmat

val ( **@ ) : dsmat -> float -> dsmat

val ( +$ ) : dsmat -> float -> dsmat

val ( -$ ) : dsmat -> float -> dsmat

val ( *$ ) : dsmat -> float -> dsmat

val ( /$ ) : dsmat -> float -> dsmat

val ( $+ ) : float -> dsmat -> dsmat

val ( $- ) : float -> dsmat -> dsmat

val ( $* ) : float -> dsmat -> dsmat

val ( $/ ) : float -> dsmat -> dsmat

val ( =@ ) : dsmat -> dsmat -> bool

val ( >@ ) : dsmat -> dsmat -> bool

val ( <@ ) : dsmat -> dsmat -> bool

val ( <>@ ) : dsmat -> dsmat -> bool

val ( >=@ ) : dsmat -> dsmat -> bool

val ( <=@ ) : dsmat -> dsmat -> bool

val ( @@ ) : (float -> float) -> dsmat -> dsmat

(* TODO: for debug purpose *)

val gsl_col : dsmat -> int -> dsmat
