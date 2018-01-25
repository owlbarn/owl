(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Matrix module: including creation, manipulation, and various vectorised
  mathematical operations.
 *)

(**
  About the comparison of two complex numbers [x] and [y], Owl uses the
  following conventions: 1) [x] and [y] are equal iff both real and imaginary
  parts are equal; 2) [x] is less than [y] if the magnitude of [x] is less than
  the magnitude of [x]; in case both [x] and [y] have the same magnitudes, [x]
  is less than [x] if the phase of [x] is less than the phase of [y]; 3) less or
  equal, greater, greater or equal relation can be further defined atop of the
  aforementioned conventions.
 *)

open Bigarray

open Owl_types

open Owl_dense_ndarray_generic


type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t


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
(** [init_nd m n f] s almost the same as [init] but [f] receives 2D index
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

val complex : ('a, 'b) kind -> ('c, 'd) kind -> ('a, 'b) t -> ('a, 'b) t -> ('c, 'd) t
(** [complex re im] constructs a complex ndarray/matrix from [re] and [im].
  [re] and [im] contain the real and imaginary part of [x] respectively.

  Note that both [re] and [im] can be complex but must have same type. The real
  part of [re] will be the real part of [x] and the imaginary part of [im] will
  be the imaginary part of [x].
 *)

val polar : ('a, 'b) kind -> ('c, 'd) kind -> ('a, 'b) t -> ('a, 'b) t -> ('c, 'd) t
(** [complex rho theta] constructs a complex ndarray/matrix from polar
  coordinates [rho] and [theta]. [rho] contains the magnitudes and [theta]
  contains phase angles. Note that the behaviour is undefined if [rho] has
  negative elelments or [theta] has infinity elelments.
 *)

val sequential : ('a, 'b) kind -> ?a:'a -> ?step:'a -> int -> int -> ('a, 'b) t
(** [sequential ~a ~step m n] creates an [m] by [n] matrix. The elements in [x]
  are initialised sequentiallly from [~a] and is increased by [~step].

  The default value of [~a] is zero whilst the default value of [~step] is one.
 *)

val uniform : ('a, 'b) kind -> ?a:'a -> ?b:'a -> int -> int -> ('a, 'b) t
(** [uniform m n] creates an [m] by [n] matrix where all the elements
  follow a uniform distribution in [(0,1)] interval. [uniform ~scale:a m n]
  adjusts the interval to [(0,a)].
 *)

 val gaussian : ('a, 'b) kind -> ?mu:'a -> ?sigma:'a -> int -> int -> ('a, 'b) t
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

val bernoulli : ('a, 'b) kind -> ?p:float -> int -> int -> ('a, 'b) t
(** [bernoulli k ~p:0.3 m n]*)

val diagm : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** [diagm k v] creates a diagonal matrix using the elements in [v] as
  diagonal values. [k] specifies the main diagonal index. If [k > 0] then it is
  above the main diagonal, if [k < 0] then it is below the main diagonal.
  This function is the same as the [diag] function in Matlab.
 *)

val triu : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** [triu k x] returns the element on and above the [k]th diagonal of [x].
  [k = 0] is the main diagonal, [k > 0] is above the main diagonal, and
  [k < 0] is below the main diagonal.
 *)

val tril : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** [tril k x] returns the element on and below the [k]th diagonal of [x].
  [k = 0] is the main diagonal, [k > 0] is above the main diagonal, and
  [k < 0] is below the main diagonal.
 *)

val symmetric : ?upper:bool -> ('a, 'b) t -> ('a, 'b) t
(** [symmetric ~upper x] creates a symmetric matrix using either upper or lower
  triangular part of [x]. If [upper] is [true] then it uses the upper part, if
  [upper] is [false], then [symmetric] uses the lower part. By default [upper]
  is true.
 *)

val hermitian : ?upper:bool -> (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [hermitian ~upper x] creates a hermitian matrix based on [x]. By default,
  the upper triangular part is used for creating the hermitian matrix, but you
  use the lower part by setting [upper=false]
 *)

val bidiagonal : ?upper:bool -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [bidiagonal upper dv ev] creates a bidiagonal matrix using [dv] and [ev].
  Both [dv] and [ev] are row vectors. [dv] is the main diagonal. If [upper] is
  [true] then [ev] is superdiagonal; if [upper] is [false] then [ev] is
  subdiagonal. By default, [upper] is [true].

  NOTE: because the diagonal elements in a hermitian matrix must be real, the
  function set the imaginary part of the diagonal elements to zero by default.
  In other words, if the diagonal elements of [x] have non-zero imaginary parts,
  the imaginary parts will be dropped without a warning.
 *)

val toeplitz : ?c:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [toeplitz ~c r] generates a toeplitz matrix using [r] and [c]. Both [r] and
  [c] are row vectors of the same length. If the first elements of [c] is
  different from that of [r], [r]'s first element will be used.

  Note: 1) If [c] is not passed in, then [c = r] will be used. 2) If [c] is not
  passed in and [r] is complex, the [c = conj r] will be used. 3) If [r] and [c]
  have different length, then the result is a rectangular matrix.
 *)

val hankel : ?r:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [hankel ~r c] generates a hankel matrix using [r] and [c]. [c] will be the
  first column and [r] will be the last row of the returned matrix.

  Note: 1) If only [c] is passed in, the elelments below the anti-diagnoal are
  zero. 2) If the last element of [c] is different from the first element of [r]
  then the first element of [c] prevails. 3) [c] and [r] can have different
  length, the return will be an rectangular matrix.
 *)

val hadamard : ('a, 'b) kind -> int -> ('a, 'b) t
(** [hadamard k n] constructs a hadamard matrix of order [n]. For a hadamard [H],
  we have [H'*H = n*I]. Currrently, this function handles only the cases where
  [n], [n/12], or [n/20] is a power of 2.
 *)

val magic : ('a, 'b) kind -> int -> ('a, 'b) t
(** [magic k n] constructs a [n x n] magic square matrix [x]. The elements in
  [x] are consecutive numbers increasing from [1] to [n^2]. [n] must [n >= 3].

  There are three different algorithms to deal with [n] is odd, singly even,
  and doubly even respectively.
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

val get_index : ('a, 'b) t -> int array array -> 'a array
(** [get_index i x] returns an array of element values specified by the indices
  [i]. The length of array [i] equals the number of dimensions of [x]. The
  arrays in [i] must have the same length, and each represents the indices in
  that dimension.

  E.g., [ [| [|1;2|]; [|3;4|] |] ] returns the value of elements at position
  [(1,3)] and [(2,4)] respectively.
 *)

val set_index : ('a, 'b) t -> int array array -> 'a array -> unit
(** [set_index] sets the value of elements in [x] according to the indices
  specified by [i]. The length of array [i] equals the number of dimensions of
  [x]. The arrays in [i] must have the same length, and each represents the
  indices in that dimension.
 *)

val get_fancy : index list -> ('a, 'b) t -> ('a, 'b) t
(** [get_fancy s x] returns a copy of the slice in [x]. The slice is defined by
  [a] which is an [int array]. Please refer to the same function in the
  [Owl_dense_ndarray_generic] documentation for more details.
 *)

val set_fancy : index list -> ('a, 'b) t -> ('a, 'b) t -> unit
(** [set_fancy axis x y] set the slice defined by [axis] in [x] according to
  the values in [y]. [y] must have the same shape as the one defined by [axis].

  About the slice definition of [axis], please refer to [slice] function.
 *)

val get_slice : int list list -> ('a, 'b) t -> ('a, 'b) t
(** [get_slice axis x] aims to provide a simpler version of [get_fancy].
  This function assumes that every list element in the passed in [in list list]
  represents a range, i.e., [R] constructor.

  E.g., [ [[];[0;3];[0]] ] is equivalent to [ [R []; R [0;3]; R [0]] ].
 *)

val set_slice : int list list -> ('a, 'b) t -> ('a, 'b) t -> unit
(** [set_slice axis x y] aims to provide a simpler version of [set_slice].
  This function assumes that every list element in the passed in [in list list]
  represents a range, i.e., [R] constructor.

  E.g., [ [[];[0;3];[0]] ] is equivalent to [ [R []; R [0;3]; R [0]] ].
 *)

val row : ('a, 'b) t -> int -> ('a, 'b) t
(** [row x i] returns row [i] of [x].  Note: Unlike [col], the return value
  is simply a view onto the original row in [x], so modifying [row]'s
  value also alters [x]. *)

val col : ('a, 'b) t -> int -> ('a, 'b) t
(** [col x j] returns column [j] of [x].  Note: Unlike [row], the return
  value is a copy of the original row in [x]. *)

val rows : ('a, 'b) t -> int array -> ('a, 'b) t
(** [rows x a] returns the rows (defined in an int array [a]) of [x]. The
  returned rows will be combined into a new dense matrix. The order of rows in
  the new matrix is the same as that in the array [a].
 *)

val cols : ('a, 'b) t -> int array -> ('a, 'b) t
(** Similar to [rows], [cols x a] returns the columns (specified in array [a])
  of x in a new dense matrix.
 *)

val resize : ?head:bool -> ('a, 'b) t -> int array -> ('a, 'b) t
(** [resize x s] please refer to the Ndarray document.
 *)

val reshape :('a, 'b) t -> int array -> ('a, 'b) t
(** [reshape x s] returns a new [m] by [n] matrix from the [m'] by [n']
  matrix [x]. Note that [(m * n)] must be equal to [(m' * n')], and the
  returned matrix shares the same memory with the original [x].
 *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(** [flatten x] reshape [x] into a [1] by [n] row vector without making a copy.
  Therefore the returned value shares the same memory space with original [x].
 *)

val reverse : ('a, 'b) t -> ('a, 'b) t
(** [reverse x] reverse the order of all elements in the flattened [x] and
  returns the results in a new matrix. The original [x] remains intact.
 *)

val flip : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [flip ~axis x] flips a matrix/ndarray along [axis]. By default [axis = 0].
  The result is returned in a new matrix/ndarray, so the original [x] remains
  intact.
 *)

val rotate : ('a, 'b) t -> int -> ('a, 'b) t
(** [rotate x d] rotates [x] clockwise [d] degrees. [d] must be multiple times
  of [90], otherwise the function will fail. If [x] is an n-dimensional array,
  then the function rotates the plane formed by the first and second dimensions.
 *)

val reset : ('a, 'b) t -> unit
(** [reset x] resets all the elements of [x] to zero value. *)

val fill : ('a, 'b) t -> 'a -> unit
(** [fill x a] fills the [x] with value [a]. *)

val copy : ('a, 'b) t -> ('a, 'b) t
(** [copy x] returns a copy of matrix [x]. *)

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

val split : ?axis:int -> int array -> ('a, 'b) t -> ('a, 'b) t array
(** [split ~axis parts x]
 *)

val transpose : ('a, 'b) t -> ('a, 'b) t
(** [transpose x] transposes an [m] by [n] matrix to [n] by [m] one. *)

val ctranspose : ('a, 'b) t -> ('a, 'b) t
(** [ctranspose x] performs conjugate transpose of a complex matrix [x]. If [x]
  is a real matrix, then [ctranspose x] is equivalent to [transpose x].
 *)

val diag : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** [diag k x] returns the [k]th diagonal elements of [x]. [k > 0] means above
  the main diagonal and [k < 0] means the below the main diagonal.
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

val dropout : ?rate:float -> ('a, 'b) t -> ('a, 'b) t
(** [dropout ~rate:0.3 x] drops out 30% of the elements in [x], in other words,
  by setting their values to zeros.
 *)

val top : ('a, 'b) t -> int -> int array array
(** [top x n] returns the indices of [n] greatest values of [x]. The indices are
  arranged according to the corresponding elelment values, from the greatest one
  to the smallest one.
 *)

val bottom : ('a, 'b) t -> int -> int array array
(** [bottom x n] returns the indices of [n] smallest values of [x]. The indices
  are arranged according to the corresponding elelment values, from the smallest
  one to the greatest one.
 *)

val sort : ('a, 'b) t -> unit
(** [sort x] performs in-place quicksort of the elelments in [x]. *)


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

val foldi : ?axis:int -> (int -> 'a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(** [foldi ~axis f a x] folds (or reduces) the elements in [x] from left along
  the specified [axis] using passed in function [f]. [a] is the initial element
  and in [f i acc b] [acc] is the accumulater and [b] is one of the elemets in
  [x] along the same axis. Note that [i] is 1d index of [b].
 *)

val fold : ?axis:int -> ('a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(** Similar to [foldi], except that the index of an element is not passed to [f]. *)

val scani : ?axis:int -> (int -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [scan ~axis f x] scans the [x] along the specified [axis] using passed in
  function [f]. [f acc a b] returns an updated [acc] which will be passed in
  the next call to [f i acc a]. This function can be used to implement
  accumulative operations such as [sum] and [prod] functions. Note that the [i]
  is 1d index of [a] in [x].
 *)

val scan : ?axis:int -> ('a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Similar to [scani], except that the index of an element is not passed to [f]. *)

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


(** {6 Examine elements and compare two matrices} *)

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

val is_normal : ('a, 'b) t -> bool
(** [is_normal x] returns [true] if all the elelments in [x] are normal float
  numbers, i.e., not [NaN], not [INF], not [SUBNORMAL]. Please refer to

  https://www.gnu.org/software/libc/manual/html_node/Floating-Point-Classes.html
  https://www.gnu.org/software/libc/manual/html_node/Infinity-and-NaN.html#Infinity-and-NaN
 *)

val not_nan : ('a, 'b) t -> bool
(** [not_nan x] returns [false] if there is any [NaN] element in [x]. Otherwise,
  the function returns [true] indicating all the numbers in [x] are not [NaN].
 *)

val not_inf : ('a, 'b) t -> bool
(** [not_inf x] returns [false] if there is any positive or negative [INF]
  element in [x]. Otherwise, the function returns [true].
 *)

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
(** [elt_equal x y] performs element-wise [=] comparison of [x] and [y]. Assume
  that [a] is from [x] and [b] is the corresponding element of [a] from [y] of
  the same position. The function returns another binary ([0] and [1])
  ndarray/matrix wherein [1] indicates [a = b].
 *)

val elt_not_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [elt_not_equal x y] performs element-wise [!=] comparison of [x] and [y].
  Assume that [a] is from [x] and [b] is the corresponding element of [a] from
  [y] of the same position. The function returns another binary ([0] and [1])
  ndarray/matrix wherein [1] indicates [a <> b].
*)

val elt_less : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [elt_less x y] performs element-wise [<] comparison of [x] and [y]. Assume
  that [a] is from [x] and [b] is the corresponding element of [a] from [y] of
  the same position. The function returns another binary ([0] and [1])
  ndarray/matrix wherein [1] indicates [a < b].
 *)

val elt_greater : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [elt_greater x y] performs element-wise [>] comparison of [x] and [y].
  Assume that [a] is from [x] and [b] is the corresponding element of [a] from
  [y] of the same position. The function returns another binary ([0] and [1])
  ndarray/matrix wherein [1] indicates [a > b].
 *)

val elt_less_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [elt_less_equal x y] performs element-wise [<=] comparison of [x] and [y].
  Assume that [a] is from [x] and [b] is the corresponding element of [a] from
  [y] of the same position. The function returns another binary ([0] and [1])
  ndarray/matrix wherein [1] indicates [a <= b].
 *)

val elt_greater_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [elt_greater_equal x y] performs element-wise [>=] comparison of [x] and [y].
  Assume that [a] is from [x] and [b] is the corresponding element of [a] from
  [y] of the same position. The function returns another binary ([0] and [1])
  ndarray/matrix wherein [1] indicates [a >= b].
 *)

val equal_scalar : ('a, 'b) t -> 'a -> bool
(** [equal_scalar x a] checks if all the elements in [x] are equal to [a]. The
  function returns [true] iff for every element [b] in [x], [b = a].
 *)

val not_equal_scalar : ('a, 'b) t -> 'a -> bool
(** [not_equal_scalar x a] checks if all the elements in [x] are not equal to [a].
  The function returns [true] iff for every element [b] in [x], [b <> a].
 *)

val less_scalar : ('a, 'b) t -> 'a -> bool
(** [less_scalar x a] checks if all the elements in [x] are less than [a].
  The function returns [true] iff for every element [b] in [x], [b < a].
 *)

val greater_scalar : ('a, 'b) t -> 'a -> bool
(** [greater_scalar x a] checks if all the elements in [x] are greater than [a].
  The function returns [true] iff for every element [b] in [x], [b > a].
 *)

val less_equal_scalar : ('a, 'b) t -> 'a -> bool
(** [less_equal_scalar x a] checks if all the elements in [x] are less or equal
  to [a]. The function returns [true] iff for every element [b] in [x], [b <= a].
 *)

val greater_equal_scalar : ('a, 'b) t -> 'a -> bool
(** [greater_equal_scalar x a] checks if all the elements in [x] are greater or
  equal to [a]. The function returns [true] iff for every element [b] in [x],
  [b >= a].
 *)

val elt_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [elt_equal_scalar x a] performs element-wise [=] comparison of [x] and [a].
  Assume that [b] is one element from [x] The function returns another binary
  ([0] and [1]) ndarray/matrix wherein [1] of the corresponding position
  indicates [a = b], otherwise [0].
 *)

val elt_not_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [elt_not_equal_scalar x a] performs element-wise [!=] comparison of [x] and
  [a]. Assume that [b] is one element from [x] The function returns another
  binary ([0] and [1]) ndarray/matrix wherein [1] of the corresponding position
  indicates [a <> b], otherwise [0].
 *)

val elt_less_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [elt_less_scalar x a] performs element-wise [<] comparison of [x] and [a].
  Assume that [b] is one element from [x] The function returns another binary
  ([0] and [1]) ndarray/matrix wherein [1] of the corresponding position
  indicates [a < b], otherwise [0].
 *)

val elt_greater_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [elt_greater_scalar x a] performs element-wise [>] comparison of [x] and [a].
  Assume that [b] is one element from [x] The function returns another binary
  ([0] and [1]) ndarray/matrix wherein [1] of the corresponding position
  indicates [a > b], otherwise [0].
 *)

val elt_less_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [elt_less_equal_scalar x a] performs element-wise [<=] comparison of [x] and
  [a]. Assume that [b] is one element from [x] The function returns another
  binary ([0] and [1]) ndarray/matrix wherein [1] of the corresponding position
  indicates [a <= b], otherwise [0].
 *)

val elt_greater_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [elt_greater_equal_scalar x a] performs element-wise [>=] comparison of [x]
  and [a]. Assume that [b] is one element from [x] The function returns
  another binary ([0] and [1]) ndarray/matrix wherein [1] of the corresponding
  position indicates [a >= b], otherwise [0].
 *)

val approx_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> bool
(** [approx_equal ~eps x y] returns [true] if [x] and [y] are approximately
  equal, i.e., for any two elements [a] from [x] and [b] from [y], we have
  [abs (a - b) < eps].

  Note: the threshold check is exclusive for passed in [eps].
 *)

val approx_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> bool
(** [approx_equal_scalar ~eps x a] returns [true] all the elements in [x] are
  approximately equal to [a], i.e., [abs (x - a) < eps]. For complex numbers,
  the [eps] applies to both real and imaginary part.

  Note: the threshold check is exclusive for the passed in [eps].
 *)

val approx_elt_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [approx_elt_equal ~eps x y] compares the element-wise equality of [x] and
  [y], then returns another binary (i.e., [0] and [1]) ndarray/matrix wherein
  [1] indicates that two corresponding elements [a] from [x] and [b] from [y]
  are considered as approximately equal, namely [abs (a - b) < eps].
 *)

val approx_elt_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> ('a, 'b) t
(** [approx_elt_equal_scalar ~eps x a] compares all the elements of [x] to a
  scalar value [a], then returns another binary (i.e., [0] and [1])
  ndarray/matrix wherein [1] indicates that the element [b] from [x] is
  considered as approximately equal to [a], namely [abs (a - b) < eps].
 *)


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
(** [draw_rows2 x y c] is similar to [draw_rows] but applies to two matrices. *)

val draw_cols2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(** [draw_col2 x y c] is similar to [draw_cols] but applies to two matrices. *)

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

val to_rows : ('a, 'b) t -> ('a, 'b) t array

val of_rows : ('a, 'b) t array -> ('a, 'b) t

val to_cols : ('a, 'b) t -> ('a, 'b) t array

val of_cols : ('a, 'b) t array -> ('a, 'b) t

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:('a -> string) -> ('a, 'b) t -> unit
(** [print x] pretty prints matrix [x] without headings. *)

val save : ('a, 'b) t -> string -> unit
(** [save x f] saves the matrix [x] to a file with the name [f]. The format
  is binary by using [Marshal] module to serialise the matrix.
 *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** [load f] loads a matrix from file [f]. The file must be previously saved
  by using [save] function.
 *)

val save_txt : ('a, 'b) t -> string -> unit
(** [save_txt x f] save the matrix [x] into a tab-delimited text file [f].
  The operation can be very time consuming.
 *)

val load_txt : (float, 'a) kind -> string -> (float, 'a) t
(** [load_txt f] load a tab-delimited text file [f] into a matrix. *)


(** {6 Unary mathematical operations } *)

val re_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [re_c2s x] returns all the real components of [x] in a new ndarray of same shape. *)

val re_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [re_d2z x] returns all the real components of [x] in a new ndarray of same shape. *)

val im_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [im_c2s x] returns all the imaginary components of [x] in a new ndarray of same shape. *)

val im_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [im_d2z x] returns all the imaginary components of [x] in a new ndarray of same shape. *)

val min : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [min x] returns the minimum of all elements in [x] along specified [axis].
  If no axis is specified, [x] will be flattened and the minimum of all the
  elements will be returned.  For two complex numbers, the one with the smaller
  magnitude will be selected. If two magnitudes are the same, the one with the
  smaller phase will be selected.
 *)

val min' : ('a, 'b) t -> 'a
(** [min' x] is similar to [min] but returns the minimum of all elements in [x]
  in scalar value.
 *)

val max : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [max x] returns the maximum of all elements in [x] along specified [axis].
  If no axis is specified, [x] will be flattened and the maximum of all the
  elements will be returned.  For two complex numbers, the one with the greater
  magnitude will be selected. If two magnitudes are the same, the one with the
  greater phase will be selected.
 *)

val max' : ('a, 'b) t -> 'a
(** [max' x] is similar to [max] but returns the maximum of all elements in [x]
  in scalar value.
 *)

val minmax : ?axis:int -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(** [minmax' x] returns [(min_v, max_v)], [min_v] is the minimum value in [x]
  while [max_v] is the maximum.
 *)

val minmax' : ('a, 'b) t -> 'a * 'a
(** [minmax' x] returns [(min_v, max_v)], [min_v] is the minimum value in [x]
  while [max_v] is the maximum.
 *)

val min_i : ('a, 'b) t -> 'a * int array
(** [min_i x] returns the minimum of all elements in [x] as well as its index. *)

val max_i : ('a, 'b) t -> 'a * int array
(** [max_i x] returns the maximum of all elements in [x] as well as its index. *)

val minmax_i : ('a, 'b) t -> ('a * int array) * ('a * int array)
(** [minmax_i x] returns [((min_v,min_i), (max_v,max_i))] where [(min_v,min_i)]
  is the minimum value in [x] along with its index while [(max_v,max_i)] is the
  maximum value along its index.
 *)

val inv : ('a, 'b) t -> ('a, 'b) t
(** [inv x] calculates the inverse of an invertible square matrix [x]
    such that [x *@ x = I] wherein [I] is an identity matrix.  (If [x]
    is singular, [inv] will return a useless result.)
 *)

val trace : ('a, 'b) t -> 'a
(** [trace x] returns the sum of diagonal elements in [x]. *)

val sum : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [sum_ axis x] sums the elements in [x] along specified [axis]. *)

val sum': ('a, 'b) t -> 'a
(** [sum x] returns the summation of all the elements in [x]. *)

val prod : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [prod_ axis x] multiplies the elements in [x] along specified [axis]. *)

val prod' : ('a, 'b) t -> 'a
(** [prod x] returns the product of all the elements in [x]. *)

val mean : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [mean ~axis x] calculates the mean along specified [axis]. *)

val mean' : ('a, 'b) t -> 'a
(** [mean' x] calculates the mean of all the elements in [x]. *)

val var : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [var ~axis x] calculates the variance along specified [axis]. *)

val var' : ('a, 'b) t -> 'a
(** [var' x] calculates the variance of all the elements in [x]. *)

val std : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [std ~axis] calculates the standard deviation along specified [axis]. *)

val std' : ('a, 'b) t -> 'a
(** [std' x] calculates the standard deviation of all the elements in [x]. *)

val sum_rows : ('a, 'b) t -> ('a, 'b) t
(** [sum_rows x] returns the summation of all the row vectors in [x]. *)

val sum_cols : ('a, 'b) t -> ('a, 'b) t
(** [sum_cols] returns the summation of all the column vectors in [x]. *)

val mean_rows : ('a, 'b) t -> ('a, 'b) t
(** [mean_rows x] returns the mean value of all row vectors in [x]. It is
 equivalent to [div_scalar (sum_rows x) (float_of_int (row_num x))].
 *)

val mean_cols : ('a, 'b) t -> ('a, 'b) t
(** [mean_cols x] returns the mean value of all column vectors in [x].
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

val abs : ('a, 'b) t -> ('a, 'b) t
(** [abs x] returns the absolute value of all elements in [x] in a new matrix. *)

val abs_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [abs_c2s x] is similar to [abs] but takes [complex32] as input. *)

val abs_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [abs_z2d x] is similar to [abs] but takes [complex64] as input. *)

val abs2 : ('a, 'b) t -> ('a, 'b) t
(** [abs2 x] returns the square of absolute value of all elements in [x] in a new ndarray. *)

val abs2_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(** [abs2_c2s x] is similar to [abs2] but takes [complex32] as input. *)

val abs2_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(** [abs2_z2d x] is similar to [abs2] but takes [complex64] as input. *)

val conj : ('a, 'b) t -> ('a, 'b) t
(** [conj x] computes the conjugate of the elements in [x] and returns the
  result in a new matrix. If the passed in [x] is a real matrix, the function
  simply returns a copy of the original [x].
 *)

val neg : ('a, 'b) t -> ('a, 'b) t
(** [neg x] negates the elements in [x] and returns the result in a new matrix. *)

val reci : ('a, 'b) t -> ('a, 'b) t
(** [reci x] computes the reciprocal of every elements in [x] and returns the
  result in a new ndarray.
 *)

val reci_tol : ?tol:'a -> ('a, 'b) t -> ('a, 'b) t
(** [reci_tol ~tol x] computes the reciprocal of every element in [x]. Different
  from [reci], [reci_tol] sets the elements whose [abs] value smaller than [tol]
  to zeros. If [tol] is not specified, the defautl [Owl_utils.eps Float32] will
  be used. For complex numbers, refer to Owl's doc to see how to compare.
 *)

val signum : (float, 'a) t -> (float, 'a) t
(** [signum] computes the sign value ([-1] for negative numbers, [0] (or [-0])
  for zero, [1] for positive numbers, [nan] for [nan]).
 *)

val sqr : ('a, 'b) t -> ('a, 'b) t
(** [sqr x] computes the square of the elements in [x] and returns the result in
  a new matrix.
 *)

val sqrt : ('a, 'b) t -> ('a, 'b) t
(** [sqrt x] computes the square root of the elements in [x] and returns the
  result in a new matrix.
 *)

val cbrt : ('a, 'b) t -> ('a, 'b) t
(** [cbrt x] computes the cubic root of the elements in [x] and returns the
  result in a new matrix.
 *)

val exp : ('a, 'b) t -> ('a, 'b) t
(** [exp x] computes the exponential of the elements in [x] and returns the
  result in a new matrix.
 *)

val exp2 : ('a, 'b) t -> ('a, 'b) t
(** [exp2 x] computes the base-2 exponential of the elements in [x] and returns
  the result in a new matrix.
 *)

val exp10 : ('a, 'b) t -> ('a, 'b) t
(** [exp2 x] computes the base-10 exponential of the elements in [x] and returns
  the result in a new matrix.
 *)

val expm1 : ('a, 'b) t -> ('a, 'b) t
(** [expm1 x] computes [exp x -. 1.] of the elements in [x] and returns the
  result in a new matrix.
 *)

val log : ('a, 'b) t -> ('a, 'b) t
(** [log x] computes the logarithm of the elements in [x] and returns the
  result in a new matrix.
 *)

val log10 : ('a, 'b) t -> ('a, 'b) t
(** [log10 x] computes the base-10 logarithm of the elements in [x] and returns
  the result in a new matrix.
 *)

val log2 : ('a, 'b) t -> ('a, 'b) t
(** [log2 x] computes the base-2 logarithm of the elements in [x] and returns
  the result in a new matrix.
 *)

val log1p : ('a, 'b) t -> ('a, 'b) t
(** [log1p x] computes [log (1 + x)] of the elements in [x] and returns the
  result in a new matrix.
 *)

val sin : ('a, 'b) t -> ('a, 'b) t
(** [sin x] computes the sine of the elements in [x] and returns the result in
  a new matrix.
 *)

val cos : ('a, 'b) t -> ('a, 'b) t
(** [cos x] computes the cosine of the elements in [x] and returns the result in
  a new matrix.
 *)

val tan : ('a, 'b) t -> ('a, 'b) t
(** [tan x] computes the tangent of the elements in [x] and returns the result
  in a new matrix.
 *)

val asin : ('a, 'b) t -> ('a, 'b) t
(** [asin x] computes the arc sine of the elements in [x] and returns the result
  in a new matrix.
 *)

val acos : ('a, 'b) t -> ('a, 'b) t
(** [acos x] computes the arc cosine of the elements in [x] and returns the
  result in a new matrix.
 *)

val atan : ('a, 'b) t -> ('a, 'b) t
(** [atan x] computes the arc tangent of the elements in [x] and returns the
  result in a new matrix.
 *)

val sinh : ('a, 'b) t -> ('a, 'b) t
(** [sinh x] computes the hyperbolic sine of the elements in [x] and returns
  the result in a new matrix.
 *)

val cosh : ('a, 'b) t -> ('a, 'b) t
(** [cosh x] computes the hyperbolic cosine of the elements in [x] and returns
  the result in a new matrix.
 *)

val tanh : ('a, 'b) t -> ('a, 'b) t
(** [tanh x] computes the hyperbolic tangent of the elements in [x] and returns
  the result in a new matrix.
 *)

val asinh : ('a, 'b) t -> ('a, 'b) t
(** [asinh x] computes the hyperbolic arc sine of the elements in [x] and
  returns the result in a new matrix.
 *)

val acosh : ('a, 'b) t -> ('a, 'b) t
(** [acosh x] computes the hyperbolic arc cosine of the elements in [x] and
  returns the result in a new matrix.
 *)

val atanh : ('a, 'b) t -> ('a, 'b) t
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

val fix : ('a, 'b) t -> ('a, 'b) t
(** [fix x]  rounds each element of [x] to the nearest integer toward zero.
  For positive elements, the behavior is the same as [floor]. For negative ones,
  the behavior is the same as [ceil].
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

val log_sum_exp' : (float, 'a) t -> float
(** [log_sum_exp x] computes the logarithm of the sum of exponentials of all
  the elements in [x].
 *)

val l1norm : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [l1norm x] calculates the l1-norm of of [x] along specified axis. *)

val l1norm' : ('a, 'b) t -> 'a
(** [l1norm x] calculates the l1-norm of all the element in [x]. *)

val l2norm : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [l2norm x] calculates the l2-norm of of [x] along specified axis. *)

val l2norm' : ('a, 'b) t -> 'a
(** [l2norm x] calculates the l2-norm of all the element in [x]. *)

val l2norm_sqr : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [l2norm x] calculates the square l2-norm of of [x] along specified axis. *)

val l2norm_sqr' : ('a, 'b) t -> 'a
(** [l2norm_sqr x] calculates the square of l2-norm (or l2norm, Euclidean norm)
  of all elements in [x]. The function uses conjugate transpose in the product,
  hence it always returns a float number.
 *)

val max_pool : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** [] *)

val avg_pool : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** [] *)

val cumsum : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [cumsum ~axis x], refer to the documentation in [Owl_dense_ndarray_generic].
 *)

val cumprod : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [cumprod ~axis x], refer to the documentation in [Owl_dense_ndarray_generic].
 *)

val cummin : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [cummin ~axis x] : performs cumulative [min] along [axis] dimension. *)

val cummax : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** [cummax ~axis x] : performs cumulative [max] along [axis] dimension. *)

val angle : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [angle x] calculates the phase angle of all complex numbers in [x]. *)

val proj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [proj x] computes the projection on Riemann sphere of all elelments in [x]. *)

val mat2gray : ?amin:'a -> ?amax:'a -> ('a, 'b) t -> ('a, 'b) t
(** [mat2gray ~amin ~amax x] converts the matrix [x] to the intensity image.
  The elements in [x] are clipped by [amin] and [amax], and they will be between
  [0.] and [1.] after conversion to represents the intensity.
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
(** [add_scalar x a] adds a scalar value [a] to each element in [x], and
  returns the result in a new matrix.
 *)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [sub_scalar x a] subtracts a scalar value [a] from each element in [x],
  and returns the result in a new matrix.
 *)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [mul_scalar x a] multiplies each element in [x] by a scalar value [a],
  and returns the result in a new matrix.
 *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [div_scalar x a] divides each element in [x] by a scalar value [a], and
  returns the result in a new matrix.
 *)

val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_add a x] adds a scalar value [a] to each element in [x],
  and returns the result in a new matrix.
 *)

val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_sub a x] subtracts each element in [x] from a scalar value [a],
  and returns the result in a new matrix.
 *)

val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_mul a x] multiplies each element in [x] by a scalar value [a],
  and returns the result in a new matrix.
 *)

val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_div a x] divides a scalar value [a] by each element in [x],
  and returns the result in a new matrix.
 *)

val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [dot x y] returns the matrix product of matrix [x] and [y]. *)

val add_diag : ('a, 'b) t -> 'a -> ('a, 'b) t

val pow : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [pow x y] computes [pow(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val scalar_pow : 'a -> ('a, 'b) t -> ('a, 'b) t
(** [scalar_pow a x] *)

val pow_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [pow_scalar x a] *)

val mpow : ('a, 'b) t -> float -> ('a, 'b) t
(** [mpow x r] returns the dot product of square matrix [x] with
  itself [r] times, and more generally raises the matrix to the
  [r]th power.  [r] is a float that must be equal to an integer;
  it can be be negative, zero, or positive. Non-integer exponents
  are not yet implemented. (If [r] is negative, [mpow] calls [inv],
  and warnings in documentation for [inv] apply.) *)

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

val min2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [min2 x y] computes the minimum of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val max2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [max2 x y] computes the maximum of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val fmod : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** [fmod x y] performs float mod division. *)

val fmod_scalar : (float, 'a) t -> float -> (float, 'a) t
(** [fmod_scalar x a] performs mod division between [x] and scalar [a]. *)

val scalar_fmod : float -> (float, 'a) t -> (float, 'a) t
(** [scalar_fmod x a] performs mod division between scalar [a] and [x]. *)

val ssqr' : ('a, 'b) t -> 'a -> 'a
(** [ssqr x a] computes the sum of squared differences of all the elements in
  [x] from constant [a]. This function only computes the square of each element
  rather than the conjugate transpose as {!sqr_nrm2} does.
 *)

val ssqr_diff' : ('a, 'b) t -> ('a, 'b) t -> 'a
(** [ssqr_diff x y] computes the sum of squared differences of every elements in
  [x] and its corresponding element in [y].
 *)

val cross_entropy' : (float, 'a) t -> (float, 'a) t -> float
(** [cross_entropy x y] calculates the cross entropy between [x] and [y] using base [e]. *)

val clip_by_value : ?amin:'a -> ?amax:'a -> ('a, 'b) t -> ('a, 'b) t
(** [clip_by_value ~amin ~amax x] clips the elements in [x] based on [amin] and
  [amax]. The elements smaller than [amin] will be set to [amin], and the
  elements greater than [amax] will be set to [amax].
 *)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(** [clip_by_l2norm t x] clips the [x] according to the threshold set by [t]. *)

val cov : ?b:('a, 'b) t -> a:('a, 'b) t -> ('a, 'b) t
(** [cov ~a] calculates the covariance matrix of [a] wherein each row represents
  one observation and each column represents one random variable. [a] is
  normalised by the number of observations-1. If there is only one observation,
  it is normalised by [1].

  [cov ~a ~b] takes two matrices as inputs. The functions flatten [a] and [b]
  first then returns a [2 x 2] matrix, so two must have the same number of
  elements.
 *)

val kron : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [kron a b] calculates the Kronecker product between the matrices [a]
  and [b]. If [a] is an [m x n] matrix and [b] is a [p x q] matrix, then
  [kron(a,b)] is an [m*p x n*q] matrix formed by taking all possible products
  between the elements of [a] and the matrix [b].
 *)


(** {6 Cast functions to different number types} *)

val cast : ('a, 'b) kind -> ('c, 'd) t -> ('a, 'b) t
(** [cast kind x] casts [x] of type [('c, 'd) t] to type [('a, 'b) t] specify by
  the passed in [kind] parameter. This function is a generalisation of the other
  type casting functions such as [cast_s2d], [cast_c2z], and etc.
 *)

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


(** {6 Fucntions of in-place modification } *)

val add_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [add_ x y] is simiar to [add] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val sub_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [sub_ x y] is simiar to [sub] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val mul_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [mul_ x y] is simiar to [mul] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val div_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [div_ x y] is simiar to [div] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val pow_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [pow_ x y] is simiar to [pow] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val atan2_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [atan2_ x y] is simiar to [atan2] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val hypot_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [hypot_ x y] is simiar to [hypot] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val fmod_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [fmod_ x y] is simiar to [fmod] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val min2_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [min2_ x y] is simiar to [min2] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val max2_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [max2_ x y] is simiar to [max2] function but the output is written to [x].
  The broadcast operation only allows broadcasting [y] over [x], so you need to
  make sure [x] is big enough to hold the output result.
 *)

val add_scalar_ : ('a, 'b) t -> 'a -> unit
(** [add_scalar_ x y] is simiar to [add_scalar] function but the output is
  written to [x].
 *)

val sub_scalar_ : ('a, 'b) t -> 'a -> unit
(** [sub_scalar_ x y] is simiar to [sub_scalar] function but the output is
  written to [x].
 *)

val mul_scalar_ : ('a, 'b) t -> 'a -> unit
(** [mul_scalar_ x y] is simiar to [mul_scalar] function but the output is
  written to [x].
 *)

val div_scalar_ : ('a, 'b) t -> 'a -> unit
(** [div_scalar_ x y] is simiar to [div_scalar] function but the output is
  written to [x].
 *)

val pow_scalar_ : ('a, 'b) t -> 'a -> unit
(** [pow_scalar_ x y] is simiar to [pow_scalar] function but the output is
  written to [x].
 *)

val atan2_scalar_ : ('a, 'b) t -> 'a -> unit
(** [atan2_scalar_ x y] is simiar to [atan2_scalar] function but the output is
  written to [x].
 *)

val scalar_add_ : 'a -> ('a, 'b) t -> unit
(** [scalar_add_ a x] is simiar to [scalar_add] function but the output is
  written to [x].
 *)

val scalar_sub_ : 'a -> ('a, 'b) t -> unit
(** [scalar_sub_ a x] is simiar to [scalar_sub] function but the output is
  written to [x].
 *)

val scalar_mul_ : 'a -> ('a, 'b) t -> unit
(** [scalar_mul_ a x] is simiar to [scalar_mul] function but the output is
  written to [x].
 *)

val scalar_div_ : 'a -> ('a, 'b) t -> unit
(** [scalar_div_ a x] is simiar to [scalar_div] function but the output is
  written to [x].
 *)

val scalar_pow_ : 'a -> ('a, 'b) t -> unit
(** [scalar_pow_ a x] is simiar to [scalar_pow] function but the output is
  written to [x].
 *)

val scalar_atan2_ : 'a -> ('a, 'b) t -> unit
(** [scalar_atan2_ a x] is simiar to [scalar_atan2] function but the output is
  written to [x].
 *)

val conj_ : ('a, 'b) t -> unit
(** [conj_ x] is similar to [conj] but output is written to [x] *)

val neg_ : ('a, 'b) t -> unit
(** [neg_ x] is similar to [neg] but output is written to [x] *)

val reci_ : ('a, 'b) t -> unit
(** [reci_ x] is similar to [reci] but output is written to [x] *)

val signum_ : ('a, 'b) t -> unit
(** [signum_ x] is similar to [signum] but output is written to [x] *)

val sqr_ : ('a, 'b) t -> unit
(** [sqr_ x] is similar to [sqr] but output is written to [x] *)

val sqrt_ : ('a, 'b) t -> unit
(** [sqrt_ x] is similar to [sqrt] but output is written to [x] *)

val cbrt_ : ('a, 'b) t -> unit
(** [cbrt_ x] is similar to [cbrt] but output is written to [x] *)

val exp_ : ('a, 'b) t -> unit
(** [exp_ x] is similar to [exp_] but output is written to [x] *)

val exp2_ : ('a, 'b) t -> unit
(** [exp2_ x] is similar to [exp2] but output is written to [x] *)

val exp10_ : ('a, 'b) t -> unit
(** [exp2_ x] is similar to [exp2] but output is written to [x] *)

val expm1_ : ('a, 'b) t -> unit
(** [expm1_ x] is similar to [expm1] but output is written to [x] *)

val log_ : ('a, 'b) t -> unit
(** [log_ x] is similar to [log] but output is written to [x] *)

val log2_ : ('a, 'b) t -> unit
(** [log2_ x] is similar to [log2] but output is written to [x] *)

val log10_ : ('a, 'b) t -> unit
(** [log10_ x] is similar to [log10] but output is written to [x] *)

val log1p_ : ('a, 'b) t -> unit
(** [log1p_ x] is similar to [log1p] but output is written to [x] *)

val sin_ : ('a, 'b) t -> unit
(** [sin_ x] is similar to [sin] but output is written to [x] *)

val cos_ : ('a, 'b) t -> unit
(** [cos_ x] is similar to [cos] but output is written to [x] *)

val tan_ : ('a, 'b) t -> unit
(** [tan_ x] is similar to [tan] but output is written to [x] *)

val asin_ : ('a, 'b) t -> unit
(** [asin_ x] is similar to [asin] but output is written to [x] *)

val acos_ : ('a, 'b) t -> unit
(** [acos_ x] is similar to [acos] but output is written to [x] *)

val atan_ : ('a, 'b) t -> unit
(** [atan_ x] is similar to [atan] but output is written to [x] *)

val sinh_ : ('a, 'b) t -> unit
(** [sinh_ x] is similar to [sinh] but output is written to [x] *)

val cosh_ : ('a, 'b) t -> unit
(** [cosh_ x] is similar to [cosh] but output is written to [x] *)

val tanh_ : ('a, 'b) t -> unit
(** [tanh_ x] is similar to [tanh] but output is written to [x] *)

val asinh_ : ('a, 'b) t -> unit
(** [asinh_ x] is similar to [asinh] but output is written to [x] *)

val acosh_ : ('a, 'b) t -> unit
(** [acosh_ x] is similar to [acosh] but output is written to [x] *)

val atanh_ : ('a, 'b) t -> unit
(** [atanh_ x] is similar to [atanh] but output is written to [x] *)

val floor_ : ('a, 'b) t -> unit
(** [floor_ x] is similar to [floor] but output is written to [x] *)

val ceil_ : ('a, 'b) t -> unit
(** [ceil_ x] is similar to [ceil] but output is written to [x] *)

val round_ : ('a, 'b) t -> unit
(** [round_ x] is similar to [round] but output is written to [x] *)

val trunc_ : ('a, 'b) t -> unit
(** [trunc_ x] is similar to [trunc] but output is written to [x] *)

val fix_ : ('a, 'b) t -> unit
(** [fix_ x] is similar to [fix] but output is written to [x] *)

val erf_ : ('a, 'b) t -> unit
(** [erf_ x] is similar to [erf] but output is written to [x] *)

val erfc_ : ('a, 'b) t -> unit
(** [erfc_ x] is similar to [erfc] but output is written to [x] *)

val relu_ : ('a, 'b) t -> unit
(** [relu_ x] is similar to [relu] but output is written to [x] *)

val softplus_ : ('a, 'b) t -> unit
(** [softplus_ x] is similar to [softplus] but output is written to [x] *)

val softsign_ : ('a, 'b) t -> unit
(** [softsign_ x] is similar to [softsign] but output is written to [x] *)

val sigmoid_ : ('a, 'b) t -> unit
(** [sigmoid_ x] is similar to [sigmoid] but output is written to [x] *)

val softmax_ : ('a, 'b) t -> unit
(** [softmax_ x] is similar to [softmax] but output is written to [x] *)

val cumsum_ : ?axis:int -> ('a, 'b) t -> unit
(** [cumsum_ x] is similar to [cumsum] but output is written to [x] *)

val cumprod_ : ?axis:int -> ('a, 'b) t -> unit
(** [cumprod_ x] is similar to [cumprod] but output is written to [x] *)

val cummin_ : ?axis:int -> ('a, 'b) t -> unit
(** [cummin_ x] is similar to [cummin] but output is written to [x] *)

val cumprod_ : ?axis:int -> ('a, 'b) t -> unit
(** [cumprod_ x] is similar to [cumprod] but output is written to [x] *)

val elt_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [elt_equal_ x y] is simiar to [elt_equal] function but the output is written
  to [x]. The broadcast operation only allows broadcasting [y] over [x], so you
  need to make sure [x] is big enough to hold the output result.
 *)

val elt_not_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [elt_not_equal_ x y] is simiar to [elt_not_equal] function but the output is
  written to [x]. The broadcast operation only allows broadcasting [y] over [x],
  so you need to make sure [x] is big enough to hold the output result.
 *)

val elt_less_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [elt_less_ x y] is simiar to [elt_less] function but the output is written
  to [x]. The broadcast operation only allows broadcasting [y] over [x], so you
  need to make sure [x] is big enough to hold the output result.
 *)

val elt_greater_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [elt_greater_ x y] is simiar to [elt_greater] function but the output is
  written to [x]. The broadcast operation only allows broadcasting [y] over [x],
  so you need to make sure [x] is big enough to hold the output result.
 *)

val elt_less_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [elt_less_equal_ x y] is simiar to [elt_less_equal] function but the output
  is written to [x]. The broadcast operation only allows broadcasting [y] over
  [x], so you need to make sure [x] is big enough to hold the output result.
 *)

val elt_greater_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(** [elt_greater_equal_ x y] is simiar to [elt_greater_equal] function but the
  output is written to [x]. The broadcast operation only allows broadcasting [y]
  over [x], so you need to make sure [x] is big enough to hold the output result.
 *)

val elt_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(** [elt_equal_scalar_ x a] is simiar to [elt_equal_scalar] function but the
  output is written to [x].
 *)

val elt_not_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(** [elt_not_equal_scalar_ x a] is simiar to [elt_not_equal_scalar] function but
  the output is written to [x].
 *)

val elt_less_scalar_ : ('a, 'b) t -> 'a -> unit
(** [elt_less_scalar_ x a] is simiar to [elt_less_scalar] function but the
  output is written to [x].
 *)

val elt_greater_scalar_ : ('a, 'b) t -> 'a -> unit
(** [elt_greater_scalar_ x a] is simiar to [elt_greater_scalar] function but the
  output is written to [x].
 *)

val elt_less_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(** [elt_less_equal_scalar_ x a] is simiar to [elt_less_equal_scalar] function
  but the output is written to [x].
 *)

val elt_greater_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(** [elt_greater_equal_scalar_ x a] is simiar to [elt_greater_equal_scalar]
  function but the output is written to [x].
 *)
