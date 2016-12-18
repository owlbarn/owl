(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type ('a, 'b) mat = ('a, 'b, Bigarray.c_layout) Bigarray.Array2.t
type ('a, 'b) kind = ('a, 'b) Bigarray.kind
type mat_d = (float, Bigarray.float64_elt) mat

(** {6 Create dense matrices} *)

val empty : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val create : ('a, 'b) kind -> int -> int -> 'a -> ('a, 'b) mat

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val eye : ('a, 'b) kind -> int -> ('a, 'b) mat

val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val uniform : ?scale:float -> (float, 'b) kind -> int -> int -> (float, 'b) mat

val gaussian : ?sigma:float -> (float, 'b) kind -> int -> int -> (float, 'b) mat

(* val semidef : (float, 'b) kind -> int -> (float, 'b) mat *)


(** {7 Dense vectors and meshgrids} *)

val vector : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_zeros : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_ones : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_uniform : (float, 'b) kind -> int -> (float, 'b) mat

val linspace : float -> float -> int -> mat_d

val meshgrid : float -> float -> float -> float -> int -> int -> mat_d * mat_d

val meshup : mat_d -> mat_d -> mat_d * mat_d


(** {6 Obtain the basic properties of a matrix} *)

val shape : ('a, 'b) mat -> int * int

val row_num : ('a, 'b) mat -> int

val col_num : ('a, 'b) mat -> int

val numel : ('a, 'b) mat -> int

val same_shape : ('a, 'b) mat -> ('a, 'b) mat -> bool

val reshape : int -> int -> ('a, 'b) mat -> ('a, 'b) mat


(** {6 Manipulate a matrix} *)

val get : ('a, 'b) mat -> int -> int -> 'a

val set : ('a, 'b) mat -> int -> int -> 'a -> unit

val row : ('a, 'b) mat -> int -> ('a, 'b) mat

val col : ('a, 'b) mat -> int -> ('a, 'b) mat

val rows : ('a, 'b) mat -> int array -> ('a, 'b) mat

val cols : ('a, 'b) mat -> int array -> ('a, 'b) mat

val fill : ('a, 'b) mat -> 'a -> unit

val clone : ('a, 'b) mat -> ('a, 'b) mat

val copy_to : ('a, 'b) mat -> ('a, 'b) mat -> unit

val copy_row_to : ('a, 'b) mat -> ('a, 'b) mat -> int -> unit

val copy_col_to : ('a, 'b) mat -> ('a, 'b) mat -> int -> unit

val concat_vertical : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val concat_horizontal : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val transpose : ('a, 'b) mat -> ('a, 'b) mat

val diag : ('a, 'b) mat -> ('a, 'b) mat

val trace : ('a, 'b) mat -> 'a

val add_diag : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val replace_row : ('a, 'b) mat -> ('a, 'b) mat -> int -> ('a, 'b) mat

val replace_col : ('a, 'b) mat -> ('a, 'b) mat -> int -> ('a, 'b) mat

val swap_rows : ('a, 'b) mat -> int -> int -> ('a, 'b) mat

val swap_cols : ('a, 'b) mat -> int -> int -> ('a, 'b) mat


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> 'a -> unit) -> ('a, 'b) mat -> unit

val iter : ('a -> unit) -> ('a, 'b) mat -> unit

val mapi : (int -> int -> 'a -> 'a) -> ('a, 'b) mat -> ('a, 'b) mat

val map : ('a -> 'a) -> ('a, 'b) mat -> ('a, 'b) mat

val fold : ('c -> 'a -> 'c) -> 'c -> ('a, 'b) mat -> 'c

val filteri : (int -> int -> 'a -> bool) -> ('a, 'b) mat -> (int * int) array

val filter : ('a -> bool) -> ('a, 'b) mat -> (int * int) array

val iteri_rows : (int -> ('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val iter_rows : (('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val iteri_cols : (int -> ('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val iter_cols : (('a, 'b) mat -> unit) -> ('a, 'b) mat -> unit

val filteri_rows : (int -> ('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val filter_rows : (('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val filteri_cols : (int -> ('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val filter_cols : (('a, 'b) mat -> bool) -> ('a, 'b) mat -> int array

val fold_rows : ('c -> ('a, 'b) mat -> 'c) -> 'c -> ('a, 'b) mat -> 'c

val fold_cols : ('c -> ('a, 'b) mat -> 'c) -> 'c -> ('a, 'b) mat -> 'c

val mapi_rows : (int -> ('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val map_rows : (('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val mapi_cols : (int -> ('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val map_cols : (('a, 'b) mat -> 'c) -> ('a, 'b) mat -> 'c array

val mapi_by_row : int -> (int -> ('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val map_by_row : int -> (('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val mapi_by_col : int -> (int -> ('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val map_by_col : int -> (('a, 'b) mat -> ('a, 'b) mat) -> ('a, 'b) mat -> ('a, 'b) mat

val mapi_at_row : (int -> int -> 'a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat

val map_at_row : ('a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat

val mapi_at_col : (int -> int -> 'a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat

val map_at_col : ('a -> 'a) -> ('a, 'b) mat -> int -> ('a, 'b) mat


(** {6 Examin elements and compare two matrices} *)

val exists : ('a -> bool) -> ('a, 'b) mat -> bool

val not_exists : ('a -> bool) -> ('a, 'b) mat -> bool

val for_all : ('a -> bool) -> ('a, 'b) mat -> bool

val is_zero : ('a, 'b) mat -> bool

val is_positive : ('a, 'b) mat -> bool

val is_negative : ('a, 'b) mat -> bool

val is_nonpositive : ('a, 'b) mat -> bool

val is_nonnegative : ('a, 'b) mat -> bool

val is_equal : ('a, 'b) mat -> ('a, 'b) mat -> bool

val is_unequal : ('a, 'b) mat -> ('a, 'b) mat -> bool

val is_greater : ('a, 'b) mat -> ('a, 'b) mat -> bool

val is_smaller : ('a, 'b) mat -> ('a, 'b) mat -> bool

val equal_or_greater : ('a, 'b) mat -> ('a, 'b) mat -> bool

val equal_or_smaller : ('a, 'b) mat -> ('a, 'b) mat -> bool


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> ('a, 'b) mat -> int -> ('a, 'b) mat * int array

val draw_cols : ?replacement:bool -> ('a, 'b) mat -> int -> ('a, 'b) mat * int array

val shuffle_rows : ('a, 'b) mat -> ('a, 'b) mat

val shuffle_cols : ('a, 'b) mat -> ('a, 'b) mat

val shuffle: ('a, 'b) mat -> ('a, 'b) mat


(** {6 Input/Output and helper functions} *)

val to_array : mat_d -> float array

val of_array : float array -> int -> int -> mat_d

val to_arrays : mat_d -> float array array

val of_arrays : float array array -> mat_d

val to_ndarray : ('a, 'b) mat -> ('a, 'b) Owl_dense_ndarray.t

val of_ndarray : ('a, 'b) Owl_dense_ndarray.t -> ('a, 'b) mat

val print : ('a, 'b) mat -> unit

val pp_dsmat : ('a, 'b) mat -> unit

val save : (float, 'b) mat -> string -> unit

val load : string -> (float, 'b) mat

val save_txt : mat_d -> string -> unit

val load_txt : string -> mat_d


(** {6 Unary mathematical operations } *)

val re : (Complex.t, 'a) mat -> (float, Bigarray.float64_elt) mat
(** If [x] is a matrix of complex numbers, [re x] returns all the real
  components in a new matrix of the same shape as that of [x].
 *)

val im : (Complex.t, 'a) mat -> (float, Bigarray.float64_elt) mat
(** If [x] is a matrix of complex numbers, [re x] returns all the imaginary
  components in a new matrix of the same shape as that of [x].
 *)

val min : ('a, 'b) mat -> 'a

val max : ('a, 'b) mat -> 'a

val minmax : ('a, 'b) mat -> 'a * 'a

val min_i : ('a, 'b) mat -> 'a * int * int

val max_i : ('a, 'b) mat -> 'a * int * int

val minmax_i : ('a, 'b) mat -> ('a * int * int) * ('a * int * int)

val sum : ('a, 'b) mat -> 'a

val average : (float, 'b) mat -> float

val sum_rows : ('a, 'b) mat -> ('a, 'b) mat

val sum_cols : ('a, 'b) mat -> ('a, 'b) mat

val average_rows : mat_d -> mat_d

val average_cols : mat_d -> mat_d

val min_rows : (float, 'b) mat -> (float * int * int) array

val min_cols : (float, 'b) mat -> (float * int * int) array

val max_rows : (float, 'b) mat -> (float * int * int) array

val max_cols : (float, 'b) mat -> (float * int * int) array

val abs : ('a, 'b) mat -> ('a, 'b) mat
(** [abs x] returns the absolute value of all elements in [x] in a new matrix. *)

val neg : ('a, 'b) mat -> ('a, 'b) mat
(** [neg x] negates the elements in [x] and returns the result in a new matrix. *)

val signum : ('a, 'b) mat -> ('a, 'b) mat
(** [signum] computes the sign value ([-1] for negative numbers, [0] (or [-0])
  for zero, [1] for positive numbers, [nan] for [nan]).
 *)

val sqr : ('a, 'b) mat -> ('a, 'b) mat
(** [sqr x] computes the square of the elements in [x] and returns the result in
  a new matrix.
 *)

val sqrt : ('a, 'b) mat -> ('a, 'b) mat
(** [sqrt x] computes the square root of the elements in [x] and returns the
  result in a new matrix.
 *)

val cbrt : ('a, 'b) mat -> ('a, 'b) mat
(** [cbrt x] computes the cubic root of the elements in [x] and returns the
  result in a new matrix.
 *)

val exp : ('a, 'b) mat -> ('a, 'b) mat
(** [exp x] computes the exponential of the elements in [x] and returns the
  result in a new matrix.
 *)

val exp2 : ('a, 'b) mat -> ('a, 'b) mat
(** [exp2 x] computes the base-2 exponential of the elements in [x] and returns
  the result in a new matrix.
 *)

val expm1 : ('a, 'b) mat -> ('a, 'b) mat
(** [expm1 x] computes [exp x -. 1.] of the elements in [x] and returns the
  result in a new matrix.
 *)

val log : ('a, 'b) mat -> ('a, 'b) mat
(** [log x] computes the logarithm of the elements in [x] and returns the
  result in a new matrix.
 *)

val log10 : ('a, 'b) mat -> ('a, 'b) mat
(** [log10 x] computes the base-10 logarithm of the elements in [x] and returns
  the result in a new matrix.
 *)

val log2 : ('a, 'b) mat -> ('a, 'b) mat
(** [log2 x] computes the base-2 logarithm of the elements in [x] and returns
  the result in a new matrix.
 *)

val log1p : ('a, 'b) mat -> ('a, 'b) mat
(** [log1p x] computes [log (1 + x)] of the elements in [x] and returns the
  result in a new matrix.
 *)

val sin : ('a, 'b) mat -> ('a, 'b) mat
(** [sin x] computes the sine of the elements in [x] and returns the result in
  a new matrix.
 *)

val cos : ('a, 'b) mat -> ('a, 'b) mat
(** [cos x] computes the cosine of the elements in [x] and returns the result in
  a new matrix.
 *)

val tan : ('a, 'b) mat -> ('a, 'b) mat
(** [tan x] computes the tangent of the elements in [x] and returns the result
  in a new matrix.
 *)

val asin : ('a, 'b) mat -> ('a, 'b) mat
(** [asin x] computes the arc sine of the elements in [x] and returns the result
  in a new matrix.
 *)

val acos : ('a, 'b) mat -> ('a, 'b) mat
(** [acos x] computes the arc cosine of the elements in [x] and returns the
  result in a new matrix.
 *)

val atan : ('a, 'b) mat -> ('a, 'b) mat
(** [atan x] computes the arc tangent of the elements in [x] and returns the
  result in a new matrix.
 *)

val sinh : ('a, 'b) mat -> ('a, 'b) mat
(** [sinh x] computes the hyperbolic sine of the elements in [x] and returns
  the result in a new matrix.
 *)

val cosh : ('a, 'b) mat -> ('a, 'b) mat
(** [cosh x] computes the hyperbolic cosine of the elements in [x] and returns
  the result in a new matrix.
 *)

val tanh : ('a, 'b) mat -> ('a, 'b) mat
(** [tanh x] computes the hyperbolic tangent of the elements in [x] and returns
  the result in a new matrix.
 *)

val asinh : ('a, 'b) mat -> ('a, 'b) mat
(** [asinh x] computes the hyperbolic arc sine of the elements in [x] and
  returns the result in a new matrix.
 *)

val acosh : ('a, 'b) mat -> ('a, 'b) mat
(** [acosh x] computes the hyperbolic arc cosine of the elements in [x] and
  returns the result in a new matrix.
 *)

val atanh : ('a, 'b) mat -> ('a, 'b) mat
(** [atanh x] computes the hyperbolic arc tangent of the elements in [x] and
  returns the result in a new matrix.
 *)

val floor : ('a, 'b) mat -> ('a, 'b) mat
(** [floor x] computes the floor of the elements in [x] and returns the result
  in a new matrix.
 *)

val ceil : ('a, 'b) mat -> ('a, 'b) mat
(** [ceil x] computes the ceiling of the elements in [x] and returns the result
  in a new matrix.
 *)

val round : ('a, 'b) mat -> ('a, 'b) mat
(** [round x] rounds the elements in [x] and returns the result in a new matrix. *)

val trunc : ('a, 'b) mat -> ('a, 'b) mat
(** [trunc x] computes the truncation of the elements in [x] and returns the
  result in a new matrix.
 *)

val erf : ('a, 'b) mat -> ('a, 'b) mat
(** [erf x] computes the error function of the elements in [x] and returns the
  result in a new matrix.
 *)

val erfc : ('a, 'b) mat -> ('a, 'b) mat
(** [erfc x] computes the complementary error function of the elements in [x]
  and returns the result in a new matrix.
 *)

val logistic : ('a, 'b) mat -> ('a, 'b) mat
(** [logistic x] computes the logistic function [1/(1 + exp(-a)] of the elements
  in [x] and returns the result in a new matrix.
 *)

val relu : ('a, 'b) mat -> ('a, 'b) mat
(** [relu x] computes the rectified linear unit function [max(x, 0)] of the
  elements in [x] and returns the result in a new matrix.
 *)

val softplus : ('a, 'b) mat -> ('a, 'b) mat
(** [softplus x] computes the softplus function [log(1 + exp(x)] of the elements
  in [x] and returns the result in a new matrix.
 *)

val softsign : ('a, 'b) mat -> ('a, 'b) mat
(** [softsign x] computes the softsign function [x / (1 + abs(x))] of the
  elements in [x] and returns the result in a new matrix.
 *)

val conj : (Complex.t, 'a) mat -> (Complex.t, 'a) mat
(** [conj x] computes the conjugate of the elements in [x] and returns the
  result in a new matrix.
 *)

val sigmoid : mat_d -> mat_d


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [add x y] adds all the elements in [x] and [y] elementwise, and returns the
  result in a new matrix.
 *)

val sub : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [sub x y] subtracts all the elements in [x] and [y] elementwise, and returns
  the result in a new matrix.
 *)

val mul : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [mul x y] multiplies all the elements in [x] and [y] elementwise, and
  returns the result in a new matrix.
 *)

val div : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [div x y] divides all the elements in [x] and [y] elementwise, and returns
  the result in a new matrix.
 *)

val add_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** [add_scalar x a] adds a scalar value [a] to all the elements in [x], and
  returns the result in a new matrix.
 *)

val sub_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** [sub_scalar x a] subtracts a scalar value [a] to all the elements in [x],
  and returns the result in a new matrix.
 *)

val mul_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** [mul_scalar x a] multiplies a scalar value [a] to all the elements in [x],
  and returns the result in a new matrix.
 *)

val div_scalar : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** [div_scalar x a] divides a scalar value [a] to all the elements in [x], and
  returns the result in a new matrix.
 *)

val dot : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [dot x y] returns the dot product of matrix [x] and [y]. *)

val pow : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [pow x y] computes [pow(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val atan2 : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [atan2 x y] computes [atan2(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val hypot : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [hypot x y] computes [sqrt(x*x + y*y)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val min2 : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [min2 x y] computes the minimum of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val max2 : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** [max2 x y] computes the maximum of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)


(** {6 Shorhand infix operators} *)

val ( >> ) : ('a, 'b) mat -> ('a, 'b) mat -> unit
(** Shorthand for [copy_to x y], i.e., x >> y *)

val ( << ) : ('a, 'b) mat -> ('a, 'b) mat -> unit
(** Shorthand for [copy_to y x], i.e., x << y *)

val ( @= ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [concat_vertical x y], i.e., x @= y *)

val ( @|| ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [concat_horizontal x y], i.e., x @|| y *)

val ( +@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( +$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [add_scalar x a], i.e., [x +$ a] *)

val ( -$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [sub_scalar x a], i.e., [x -$ a] *)

val ( *$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : ('a, 'b) mat -> 'a -> ('a, 'b) mat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $+ ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [add_scalar x a], i.e., [a $+ x] *)

val ( $- ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [sub_scalar x a], i.e., [a -$ x] *)

val ( $* ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : 'a -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( =@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : ('a, 'b) mat -> ('a, 'b) mat -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

val ( @@ ) : ('a -> 'a) -> ('a, 'b) mat -> ('a, 'b) mat
(** Shorthand for [map f x], i.e., f @@ x *)
