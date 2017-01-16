(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Array2.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type mat_d = (float, Bigarray.float64_elt) t


(** {6 Create dense matrices} *)

val empty : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val create : ('a, 'b) kind -> int -> int -> 'a -> ('a, 'b) t

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val eye : ('a, 'b) kind -> int -> ('a, 'b) t

val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val uniform : ?scale:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t

val gaussian : ?sigma:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t

val semidef : (float, 'b) kind -> int -> (float, 'b) t

val linspace : float -> float -> int -> mat_d

val meshgrid : float -> float -> float -> float -> int -> int -> mat_d * mat_d

val meshup : mat_d -> mat_d -> mat_d * mat_d


(** {6 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int

val row_num : ('a, 'b) t -> int

val col_num : ('a, 'b) t -> int

val numel : ('a, 'b) t -> int

val size_in_bytes : ('a, 'b) t -> int
(** [size_in_bytes x] returns the size of [x] in bytes in memory. *)

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool

val kind : ('a, 'b) t -> ('a, 'b) kind
(** [kind x] returns the type of matrix [x]. *)


(** {6 Manipulate a matrix} *)

val get : ('a, 'b) t -> int -> int -> 'a

val set : ('a, 'b) t -> int -> int -> 'a -> unit

val row : ('a, 'b) t -> int -> ('a, 'b) t

val col : ('a, 'b) t -> int -> ('a, 'b) t

val rows : ('a, 'b) t -> int array -> ('a, 'b) t

val cols : ('a, 'b) t -> int array -> ('a, 'b) t

val reshape : int -> int -> ('a, 'b) t -> ('a, 'b) t

val fill : ('a, 'b) t -> 'a -> unit

val clone : ('a, 'b) t -> ('a, 'b) t

val copy_to : ('a, 'b) t -> ('a, 'b) t -> unit

val copy_row_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit

val copy_col_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit

val concat_vertical : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val concat_horizontal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val transpose : ('a, 'b) t -> ('a, 'b) t

val diag : ('a, 'b) t -> ('a, 'b) t

val trace : ('a, 'b) t -> 'a

val add_diag : ('a, 'b) t -> 'a -> ('a, 'b) t

val replace_row : ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t

val replace_col : ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t

val swap_rows : ('a, 'b) t -> int -> int -> ('a, 'b) t

val swap_cols : ('a, 'b) t -> int -> int -> ('a, 'b) t


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit

val iter : ('a -> unit) -> ('a, 'b) t -> unit

val mapi : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val foldi : (int -> int -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val fold : ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val filteri : (int -> int -> 'a -> bool) -> ('a, 'b) t -> (int * int) array

val filter : ('a -> bool) -> ('a, 'b) t -> (int * int) array

val iteri_rows : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_rows : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iteri_cols : (int -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_cols : (('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val filteri_rows : (int -> ('a, 'b) t -> bool) -> ('a, 'b) t -> int array

val filter_rows : (('a, 'b) t -> bool) -> ('a, 'b) t -> int array

val filteri_cols : (int -> ('a, 'b) t -> bool) -> ('a, 'b) t -> int array

val filter_cols : (('a, 'b) t -> bool) -> ('a, 'b) t -> int array

val fold_rows : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c

val fold_cols : ('c -> ('a, 'b) t -> 'c) -> 'c -> ('a, 'b) t -> 'c

val mapi_rows : (int -> ('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array

val map_rows : (('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array

val mapi_cols : (int -> ('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array

val map_cols : (('a, 'b) t -> 'c) -> ('a, 'b) t -> 'c array

val mapi_by_row : int -> (int -> ('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t

val map_by_row : int -> (('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t

val mapi_by_col : int -> (int -> ('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t

val map_by_col : int -> (('a, 'b) t -> ('a, 'b) t) -> ('a, 'b) t -> ('a, 'b) t

val mapi_at_row : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t

val map_at_row : ('a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t

val mapi_at_col : (int -> int -> 'a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t

val map_at_col : ('a -> 'a) -> ('a, 'b) t -> int -> ('a, 'b) t


(** {6 Examin elements and compare two matrices} *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool

val for_all : ('a -> bool) -> ('a, 'b) t -> bool

val is_zero : ('a, 'b) t -> bool

val is_positive : ('a, 'b) t -> bool

val is_negative : ('a, 'b) t -> bool

val is_nonpositive : ('a, 'b) t -> bool

val is_nonnegative : ('a, 'b) t -> bool

val is_equal : ('a, 'b) t -> ('a, 'b) t -> bool

val is_unequal : ('a, 'b) t -> ('a, 'b) t -> bool

val is_greater : ('a, 'b) t -> ('a, 'b) t -> bool

val is_smaller : ('a, 'b) t -> ('a, 'b) t -> bool

val equal_or_greater : ('a, 'b) t -> ('a, 'b) t -> bool

val equal_or_smaller : ('a, 'b) t -> ('a, 'b) t -> bool


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array

val draw_cols : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array

val shuffle_rows : ('a, 'b) t -> ('a, 'b) t

val shuffle_cols : ('a, 'b) t -> ('a, 'b) t

val shuffle: ('a, 'b) t -> ('a, 'b) t


(** {6 Input/Output functions} *)

val to_array : ('a, 'b) t -> 'a array

val of_array : ('a, 'b) kind -> 'a array -> int -> int -> ('a, 'b) t

val to_arrays : ('a, 'b) t -> 'a array array

val of_arrays : ('a, 'b) kind -> 'a array array -> ('a, 'b) t

val to_ndarray : ('a, 'b) t -> ('a, 'b) Owl_dense_ndarray.t

val of_ndarray : ('a, 'b) Owl_dense_ndarray.t -> ('a, 'b) t

val print : ('a, 'b) t -> unit

val pp_dsmat : ('a, 'b) t -> unit

val save : ('a, 'b) t -> string -> unit

val load : ('a, 'b) kind -> string -> ('a, 'b) t

val save_txt : ('a, 'b) t -> string -> unit

val load_txt : string -> mat_d


(** {6 Unary mathematical operations } *)

val re : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t
(** If [x] is a matrix of complex numbers, [re x] returns all the real
  components in a new matrix of the same shape as that of [x].
 *)

val im : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t
(** If [x] is a matrix of complex numbers, [re x] returns all the imaginary
  components in a new matrix of the same shape as that of [x].
 *)

val min : ('a, 'b) t -> 'a

val max : ('a, 'b) t -> 'a

val minmax : ('a, 'b) t -> 'a * 'a

val min_i : (float, 'b) t -> float * int * int

val max_i : (float, 'b) t -> float * int * int

val minmax_i : (float, 'b) t -> (float * int * int) * (float * int * int)

val sum : ('a, 'b) t -> 'a

val average : ('a, 'b) t -> 'a

val sum_rows : ('a, 'b) t -> ('a, 'b) t

val sum_cols : ('a, 'b) t -> ('a, 'b) t

val average_rows : ('a, 'b) t -> ('a, 'b) t

val average_cols : ('a, 'b) t -> ('a, 'b) t

val min_rows : (float, 'b) t -> (float * int * int) array

val min_cols : (float, 'b) t -> (float * int * int) array

val max_rows : (float, 'b) t -> (float * int * int) array

val max_cols : (float, 'b) t -> (float * int * int) array

val abs : ('a, 'b) t -> ('a, 'b) t
(** [abs x] returns the absolute value of all elements in [x] in a new matrix. *)

val neg : ('a, 'b) t -> ('a, 'b) t
(** [neg x] negates the elements in [x] and returns the result in a new matrix. *)

val signum : ('a, 'b) t -> ('a, 'b) t
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

val erf : ('a, 'b) t -> ('a, 'b) t
(** [erf x] computes the error function of the elements in [x] and returns the
  result in a new matrix.
 *)

val erfc : ('a, 'b) t -> ('a, 'b) t
(** [erfc x] computes the complementary error function of the elements in [x]
  and returns the result in a new matrix.
 *)

val logistic : ('a, 'b) t -> ('a, 'b) t
(** [logistic x] computes the logistic function [1/(1 + exp(-a)] of the elements
  in [x] and returns the result in a new matrix.
 *)

val relu : ('a, 'b) t -> ('a, 'b) t
(** [relu x] computes the rectified linear unit function [max(x, 0)] of the
  elements in [x] and returns the result in a new matrix.
 *)

val softplus : ('a, 'b) t -> ('a, 'b) t
(** [softplus x] computes the softplus function [log(1 + exp(x)] of the elements
  in [x] and returns the result in a new matrix.
 *)

val softsign : ('a, 'b) t -> ('a, 'b) t
(** [softsign x] computes the softsign function [x / (1 + abs(x))] of the
  elements in [x] and returns the result in a new matrix.
 *)

val conj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [conj x] computes the conjugate of the elements in [x] and returns the
  result in a new matrix.
 *)

val sigmoid : mat_d -> mat_d


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

val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [dot x y] returns the dot product of matrix [x] and [y]. *)

val power : (float, 'b) t -> float -> (float, 'b) t

val pow : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [pow x y] computes [pow(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val atan2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [atan2 x y] computes [atan2(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new matrix.
 *)

val hypot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
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


(** {6 Shorhand infix operators} *)

val ( >> ) : ('a, 'b) t -> ('a, 'b) t -> unit
(** Shorthand for [copy_to x y], i.e., x >> y *)

val ( << ) : ('a, 'b) t -> ('a, 'b) t -> unit
(** Shorthand for [copy_to y x], i.e., x << y *)

val ( @= ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [concat_vertical x y], i.e., x @= y *)

val ( @|| ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [concat_horizontal x y], i.e., x @|| y *)

val ( +@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( +$ ) : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Shorthand for [add_scalar x a], i.e., [x +$ a] *)

val ( -$ ) : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Shorthand for [sub_scalar x a], i.e., [x -$ a] *)

val ( *$ ) : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $+ ) : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [add_scalar x a], i.e., [a $+ x] *)

val ( $- ) : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [sub_scalar x a], i.e., [a -$ x] *)

val ( $* ) : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( $@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [dot x y], i.e., [x $@ y] *)

val ( **@ ) : (float, 'b) t -> float -> (float, 'b) t
(** Shorthand for [power x a], i.e., [x **@ a] *)

val ( =@ ) : ('a, 'b) t -> ('a, 'b) t -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : ('a, 'b) t -> ('a, 'b) t -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : ('a, 'b) t -> ('a, 'b) t -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : ('a, 'b) t -> ('a, 'b) t -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : ('a, 'b) t -> ('a, 'b) t -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : ('a, 'b) t -> ('a, 'b) t -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

val ( @@ ) : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [map f x], i.e., f @@ x *)
