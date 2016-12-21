(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** N-dimensional array module
  This module is built atop of Genarray module in OCaml Bigarray. The module also
  heavily relies on Lacaml to call native BLAS/LAPACK to improve the performance.
  The documentation of some math functions is copied directly from Lacaml.
 *)

type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Genarray.t
(** N-dimensional array abstract type *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(** Type of the ndarray, e.g., Bigarray.Float32, Bigarray.Complex64, and etc. *)


(** {6 Create N-dimensional array} *)

val empty : ('a, 'b) kind -> int array -> ('a, 'b) t
(** [empty Bigarray.Float64 [|3;4;5|]] creates a three diemensional array of
  type [Bigarray.Float64]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are not initialised.

  The module only support the following four types of ndarray: [Bigarray.Float32],
  [Bigarray.Float64], [Bigarray.Complex32], and [Bigarray.Complex64].
 *)


val create : ('a, 'b) kind -> int array -> 'a -> ('a, 'b) t
(** [create Bigarray.Float64 [|3;4;5|] 2.] creates a three-diemensional array of
  type [Bigarray.Float64]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are initialised to [2.]
 *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(** [zeros Bigarray.Complex32 [|3;4;5|]] creates a three-diemensional array of
  type [Bigarray.Complex32]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are initialised to "zero". Depending on the [kind],
  zero can be [0.] or [Complex.zero].
 *)

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t
(** [ones Bigarray.Complex32 [|3;4;5|]] creates a three-diemensional array of
  type [Bigarray.Complex32]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are initialised to "one". Depending on the [kind],
  one can be [1.] or [Complex.one].
 *)

val uniform : ?scale:float -> ('a, 'b) kind -> int array -> ('a, 'b) t
(** [uniform Bigarray.Float64 [|3;4;5|] 2.] creates a three-diemensional array
  of type [Bigarray.Float64]. Each dimension has the following size: 3, 4,
  and 5. The elements in the array follow a uniform distribution [0,1].
 *)

val sequential : ('a, 'b) kind -> int array -> ('a, 'b) t
(** [sequential Bigarray.Float64 [|3;4;5|] 2.] creates a three-diemensional
  array of type [Bigarray.Float64]. Each dimension has the following size: 3, 4,
  and 5. The elements in the array are assigned sequential values.
 *)


(** {6 Obtain basic properties} *)

val shape : ('a, 'b) t -> int array
(** [shape x] returns the shape of ndarray [x]. *)

val num_dims : ('a, 'b) t -> int
(** [num_dims x] returns the number of dimensions of ndarray [x]. *)

val nth_dim : ('a, 'b) t -> int -> int
(** [nth_dim x] returns the size of the nth dimension of [x]. *)

val numel : ('a, 'b) t -> int
(** [numel x] returns the number of elements in [x]. *)

val nnz : ('a, 'b) t -> int
(** [nnz x] returns the number of non-zero elements in [x]. *)

val density : ('a, 'b) t -> float
(** [density x] returns the percentage of non-zero elements in [x]. *)

val size_in_bytes : ('a, 'b) t -> int
(** [size_in_bytes x] returns the size of [x] in bytes in memory. *)

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool
(** [same_shape x y] checks whether [x] and [y] has the same shape or not. *)

val kind : ('a, 'b) t -> ('a, 'b) kind
(** [kind x] returns the type of ndarray [x]. It is one of the four possible
  values: [Bigarray.Float32], [Bigarray.Float64], [Bigarray.Complex32], and
  [Bigarray.Complex64].
 *)


(** {6 Manipulate a N-dimensional array} *)

val get : ('a, 'b) t -> int array -> 'a
(** [get x i] returns the value at [i] in [x]. E.g., [get x [|0;2;1|]] returns
  the value at [[|0;2;1|]] in [x].
 *)

val set : ('a, 'b) t -> int array -> 'a -> unit
(** [set x i a] sets the value at [i] to [a] in [x]. *)

val sub_left : ('a, 'b) t -> int -> int -> ('a, 'b) t
(** Some as [Bigarray.sub_left], please refer to Bigarray documentation. *)

val slice_left : ('a, 'b) t -> int array -> ('a, 'b) t
(** Same as [Bigarray.slice_left], please refer to Bigarray documentation. *)

val slice : int option array -> ('a, 'b) t -> ('a, 'b) t
(** [slice s x] returns a copy of the slice in [x]. The slice is defined by [a]
  which is an [int option array]. E.g., for a ndarray [x] of dimension
  [[|2; 2; 3|]], [slice [|Some 0; None; None|] x] takes the following elements
  of index [\(0,*,*\)], i.e., [[|0;0;0|]], [[|0;0;1|]], [[|0;0;2|]] ...

  There are two differences between [slice_left] and [slice]: [slice_left] does
  not make a copy but simply moving the pointer; [slice_left] can only make a
  slice from left-most axis whereas [slice] is much more flexible and can work
  on arbitrary axis which need not start from left-most side.
 *)

val copy_slice : int option array -> ('a, 'b) t -> ('a, 'b) t -> unit
(** [copy_slice s src dst] copies a slice defined by [s] from [src] to [dst]. *)

val copy : ('a, 'b) t -> ('a, 'b) t -> unit
(** [copy src dst] copies the data from ndarray [src] to [dst]. *)

val fill : ('a, 'b) t -> 'a -> unit
(** [fill x a] assigns the value [a] to the elements in [x]. *)

val clone : ('a, 'b) t -> ('a, 'b) t
(** [clone x] makes a copy of [x]. *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(** [flatten x] makes a copy of [x] and transforms it into a one-dimsonal array. *)

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t
(** [reshape x d] makes a copy of [x], then transforms it into the shape definted by [d]. *)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(** [transpose ~axis x] makes a copy of [x], then transpose it according to
  [~axis]. [~axis] must be a valid permutation of [x] dimension indices. E.g.,
  for a three-dimensional ndarray, it can be [2;1;0], [0;2;1], [1;2;0], and etc.
 *)

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t
(** [swap i j x] makes a copy of [x], then swaps the data on axis [i] and [j]. *)

val mmap : Unix.file_descr -> ?pos:int64 -> ('a, 'b) kind -> bool -> int array -> ('a, 'b) t
(** [mmap fd kind layout shared dims] ... *)


(** {6 Iterate array elements} *)

val iteri : ?axis:int option array -> (int array -> 'a -> unit) -> ('a, 'b) t -> unit
(** [iteri ~axis f x] applies function [f] to each element in a slice defined by
  [~axis]. If [~axis] is not passed in, then [iteri] simply iterates all the
  elements in [x].
 *)

val iter : ?axis:int option array -> ('a -> unit) -> ('a, 'b) t -> unit
(** [iter ~axis f x] is similar to [iteri ~axis f x], excpet the index [i] of
  an element is not passed in [f]. Note that [iter] is much faster than [iteri].
 *)

val mapi : ?axis:int option array -> (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [mapi ~axis f x] makes a copy of [x], then applies [f] to each element in a
  slice defined by [~axis].  If [~axis] is not passed in, then [mapi] simply
  iterates all the elements in [x].
 *)

val map : ?axis:int option array -> ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [map ~axis f x] is similar to [mapi ~axis f x] except the index of the
  current element is not passed to the function [f]. Note that [map] is much
  faster than [mapi].
 *)

val filteri : ?axis:int option array -> (int array -> 'a -> bool) -> ('a, 'b) t -> int array array
(** [filteri ~axis f x] uses [f] to filter out certain elements in a slice
  defined by [~axis]. An element will be included if [f] returns [true]. The
  returned result is a list of indices of the selected elements.
 *)

val filter : ?axis:int option array -> ('a -> bool) -> ('a, 'b) t -> int array array
(** Similar to [filteri], but the indices of the elements are not passed to [f]. *)

val foldi : ?axis:int option array -> (int array -> 'a -> 'b -> 'b) -> 'b -> ('a, 'c) t -> 'b
(** [foldi ~axis f a x] folds all the elements in a slice defined by [~axis]
  with the function [f]. If [~axis] is not passed in, then [foldi] simply
  folds all the elements in [x].
 *)

val fold : ?axis:int option array -> ('a -> 'b -> 'b) -> 'b -> ('a, 'c) t -> 'b
(** Similar to [foldi], except that the index of an element is not passed to [f]. *)

val iteri_slice : int array -> (int option array -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** [iteri_slice s f x] iterates the slices along the passed in axes [s], and
  applies the function [f] to each of them. The order of iterating slices is
  based on the order of axis in [s].

  E.g., for a three-dimensional ndarray of shape [[|2;2;2|]], [iteri_slice [|1;0|] f x]
  will access the slices in the following order: [[|Some 0; Some 0; None|]],
  [[|Some 1; Some 0; None|]], [[|Some 1; Some 1; None|]]. Also note the slice
  passed in [f] is a copy of the original data.
 *)

val iter_slice : int array -> (('a, 'b) t -> unit) -> ('a, 'b) t -> unit
(** Similar to [iteri_slice], except that the index of a slice is not passed to [f]. *)

val iter2i : (int array -> 'a -> 'b -> unit) -> ('a, 'c) t -> ('b, 'd) t -> unit
(** Similar to [iteri] but applies to two N-dimensional arrays [x] and [y]. Both
  [x] and [y] must have the same shape.
 *)

val iter2 : ('a -> 'b -> unit) -> ('a, 'c) t -> ('b, 'd) t -> unit
(** Similar to [iter2i], except that the index of a slice is not passed to [f]. *)

val pmap : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** [pmap f x] is similar to [map f x] but runs in parallel on multiple cores. *)


(** {6 Examine array elements or compare two arrays } *)

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

val is_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** [is_equal x y] returns [true] if two ('a, 'b) trices [x] and [y] are equal. *)

val is_unequal : ('a, 'b) t -> ('a, 'b) t -> bool
(** [is_unequal x y] returns [true] if there is at least one element in [x] is
  not equal to that in [y].
 *)

val is_greater : ('a, 'b) t -> ('a, 'b) t -> bool
(** [is_greater x y] returns [true] if all the elements in [x] are greater than
  the corresponding elements in [y].
 *)

val is_smaller : ('a, 'b) t -> ('a, 'b) t -> bool
(** [is_smaller x y] returns [true] if all the elements in [x] are smaller than
  the corresponding elements in [y].
 *)

val equal_or_greater : ('a, 'b) t -> ('a, 'b) t -> bool
(** [equal_or_greater x y] returns [true] if all the elements in [x] are not
  smaller than the corresponding elements in [y].
 *)

val equal_or_smaller : ('a, 'b) t -> ('a, 'b) t -> bool
(** [equal_or_smaller x y] returns [true] if all the elements in [x] are not
  greater than the corresponding elements in [y].
 *)


(** {6 Input/Output functions} *)

val save : ('a, 'b) t -> string -> unit
(** [save x s] serialises a ndarray [x] to a file of name [s]. *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** [load k s] loads previously serialised ndarray from file [s] into memory.
  It is necesssary to specify the type of the ndarray with paramater [k].
*)

val print : ('a, 'b) t -> unit
(** [print x] prints all the elements in [x] as well as their indices. *)

val pp_dsnda : ('a, 'b) t -> unit
(** [pp_dsnda x] prints [x] in OCaml toplevel. If the ndarray is too long,
  [pp_dsnda] only prints out parts of the ndarray.
 *)


(** {6 Unary mathematical operations } *)

val re : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t
(** If [x] is a ndarray of complex numbers, [re x] returns all the real
  components in a new ndarray of the same shape as that of [x].
 *)

val im : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t
(** If [x] is a ndarray of complex numbers, [re x] returns all the imaginary
  components in a new ndarray of the same shape as that of [x].
 *)

val sum : ('a, 'b) t -> 'a
(** [sum x] returns the sum('a, 'b) tion of all elements in [x]. *)

val min : ('a, 'b) t -> 'a
(** [min x] returns the minimum of all elements in [x]. *)

val max : ('a, 'b) t -> 'a
(** [max x] returns the maximum of all elements in [x]. *)

val minmax : ('a, 'b) t -> 'a * 'a
(** [minmax x] returns [(min_v, max_v)], [min_v] is the minimum value in [x]
  while [max_v] is the maximum.
 *)

val min_i : ('a, 'b) t -> 'a * int array
(** [min_i x] returns the minimum of all elements in [x] along with its index. *)

val max_i : ('a, 'b) t -> 'a * int array
(** [max_i x] returns the maximum of all elements in [x] along with its index. *)

val minmax_i : ('a, 'b) t -> ('a * (int array)) * ('a * (int array))
(** [minmax_i x] returns [((min_v,min_i), (max_v,max_i))] where [(min_v,min_i)]
  is the minimum value in [x] along with its index while [(max_v,max_i)] is the
  maximum value along its index.
 *)

val abs : ('a, 'b) t -> ('a, 'b) t
(** [abs x] returns the absolute value of all elements in [x] in a new ndarray. *)

val neg : ('a, 'b) t -> ('a, 'b) t
(** [neg x] negates the elements in [x] and returns the result in a new ndarray. *)

val signum : ('a, 'b) t -> ('a, 'b) t
(** [signum] computes the sign value ([-1] for negative numbers, [0] (or [-0])
  for zero, [1] for positive numbers, [nan] for [nan]).
 *)

val sqr : ('a, 'b) t -> ('a, 'b) t
(** [sqr x] computes the square of the elements in [x] and returns the result in
  a new ndarray.
 *)

val sqrt : ('a, 'b) t -> ('a, 'b) t
(** [sqrt x] computes the square root of the elements in [x] and returns the
  result in a new ndarray.
 *)

val cbrt : ('a, 'b) t -> ('a, 'b) t
(** [cbrt x] computes the cubic root of the elements in [x] and returns the
  result in a new ndarray.
 *)

val exp : ('a, 'b) t -> ('a, 'b) t
(** [exp x] computes the exponential of the elements in [x] and returns the
  result in a new ndarray.
 *)

val exp2 : ('a, 'b) t -> ('a, 'b) t
(** [exp2 x] computes the base-2 exponential of the elements in [x] and returns
  the result in a new ndarray.
 *)

val expm1 : ('a, 'b) t -> ('a, 'b) t
(** [expm1 x] computes [exp x -. 1.] of the elements in [x] and returns the
  result in a new ndarray.
 *)

val log : ('a, 'b) t -> ('a, 'b) t
(** [log x] computes the logarithm of the elements in [x] and returns the
  result in a new ndarray.
 *)

val log10 : ('a, 'b) t -> ('a, 'b) t
(** [log10 x] computes the base-10 logarithm of the elements in [x] and returns
  the result in a new ndarray.
 *)

val log2 : ('a, 'b) t -> ('a, 'b) t
(** [log2 x] computes the base-2 logarithm of the elements in [x] and returns
  the result in a new ndarray.
 *)

val log1p : ('a, 'b) t -> ('a, 'b) t
(** [log1p x] computes [log (1 + x)] of the elements in [x] and returns the
  result in a new ndarray.
 *)

val sin : ('a, 'b) t -> ('a, 'b) t
(** [sin x] computes the sine of the elements in [x] and returns the result in
  a new ndarray.
 *)

val cos : ('a, 'b) t -> ('a, 'b) t
(** [cos x] computes the cosine of the elements in [x] and returns the result in
  a new ndarray.
 *)

val tan : ('a, 'b) t -> ('a, 'b) t
(** [tan x] computes the tangent of the elements in [x] and returns the result
  in a new ndarray.
 *)

val asin : ('a, 'b) t -> ('a, 'b) t
(** [asin x] computes the arc sine of the elements in [x] and returns the result
  in a new ndarray.
 *)

val acos : ('a, 'b) t -> ('a, 'b) t
(** [acos x] computes the arc cosine of the elements in [x] and returns the
  result in a new ndarray.
 *)

val atan : ('a, 'b) t -> ('a, 'b) t
(** [atan x] computes the arc tangent of the elements in [x] and returns the
  result in a new ndarray.
 *)

val sinh : ('a, 'b) t -> ('a, 'b) t
(** [sinh x] computes the hyperbolic sine of the elements in [x] and returns
  the result in a new ndarray.
 *)

val cosh : ('a, 'b) t -> ('a, 'b) t
(** [cosh x] computes the hyperbolic cosine of the elements in [x] and returns
  the result in a new ndarray.
 *)

val tanh : ('a, 'b) t -> ('a, 'b) t
(** [tanh x] computes the hyperbolic tangent of the elements in [x] and returns
  the result in a new ndarray.
 *)

val asinh : ('a, 'b) t -> ('a, 'b) t
(** [asinh x] computes the hyperbolic arc sine of the elements in [x] and
  returns the result in a new ndarray.
 *)

val acosh : ('a, 'b) t -> ('a, 'b) t
(** [acosh x] computes the hyperbolic arc cosine of the elements in [x] and
  returns the result in a new ndarray.
 *)

val atanh : ('a, 'b) t -> ('a, 'b) t
(** [atanh x] computes the hyperbolic arc tangent of the elements in [x] and
  returns the result in a new ndarray.
 *)

val floor : ('a, 'b) t -> ('a, 'b) t
(** [floor x] computes the floor of the elements in [x] and returns the result
  in a new ndarray.
 *)

val ceil : ('a, 'b) t -> ('a, 'b) t
(** [ceil x] computes the ceiling of the elements in [x] and returns the result
  in a new ndarray.
 *)

val round : ('a, 'b) t -> ('a, 'b) t
(** [round x] rounds the elements in [x] and returns the result in a new ndarray. *)

val trunc : ('a, 'b) t -> ('a, 'b) t
(** [trunc x] computes the truncation of the elements in [x] and returns the
  result in a new ndarray.
 *)

val erf : ('a, 'b) t -> ('a, 'b) t
(** [erf x] computes the error function of the elements in [x] and returns the
  result in a new ndarray.
 *)

val erfc : ('a, 'b) t -> ('a, 'b) t
(** [erfc x] computes the complementary error function of the elements in [x]
  and returns the result in a new ndarray.
 *)

val logistic : ('a, 'b) t -> ('a, 'b) t
(** [logistic x] computes the logistic function [1/(1 + exp(-a)] of the elements
  in [x] and returns the result in a new ndarray.
 *)

val relu : ('a, 'b) t -> ('a, 'b) t
(** [relu x] computes the rectified linear unit function [max(x, 0)] of the
  elements in [x] and returns the result in a new ndarray.
 *)

val softplus : ('a, 'b) t -> ('a, 'b) t
(** [softplus x] computes the softplus function [log(1 + exp(x)] of the elements
  in [x] and returns the result in a new ndarray.
 *)

val softsign : ('a, 'b) t -> ('a, 'b) t
(** [softsign x] computes the softsign function [x / (1 + abs(x))] of the
  elements in [x] and returns the result in a new ndarray.
 *)

val conj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [conj x] computes the conjugate of the elements in [x] and returns the
  result in a new ndarray.
 *)


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [add x y] adds all the elements in [x] and [y] elementwise, and returns the
  result in a new ndarray.
 *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [sub x y] subtracts all the elements in [x] and [y] elementwise, and returns
  the result in a new ndarray.
 *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [mul x y] multiplies all the elements in [x] and [y] elementwise, and
  returns the result in a new ndarray.
 *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [div x y] divides all the elements in [x] and [y] elementwise, and returns
  the result in a new ndarray.
 *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [add_scalar x a] adds a scalar value [a] to all the elements in [x], and
  returns the result in a new ndarray.
 *)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [sub_scalar x a] subtracts a scalar value [a] to all the elements in [x],
  and returns the result in a new ndarray.
 *)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [mul_scalar x a] multiplies a scalar value [a] to all the elements in [x],
  and returns the result in a new ndarray.
 *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [div_scalar x a] divides a scalar value [a] to all the elements in [x], and
  returns the result in a new ndarray.
 *)

val pow : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [pow x y] computes [pow(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new ndarray.
 *)

val atan2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [atan2 x y] computes [atan2(a, b)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new ndarray.
 *)

val hypot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [hypot x y] computes [sqrt(x*x + y*y)] of all the elements in [x] and [y]
  elementwise, and returns the result in a new ndarray.
 *)

val min2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [min2 x y] computes the minimum of all the elements in [x] and [y]
  elementwise, and returns the result in a new ndarray.
 *)

val max2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [max2 x y] computes the maximum of all the elements in [x] and [y]
  elementwise, and returns the result in a new ndarray.
 *)


(** {6 Shorhand infix operators} *)

val ( >> ) : ('a, 'b) t -> ('a, 'b) t -> unit
(** Shorthand for [copy_to x y], i.e., x >> y *)

val ( << ) : ('a, 'b) t -> ('a, 'b) t -> unit
(** Shorthand for [copy_to y x], i.e., x << y *)

val ( +@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( **@ ) : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Shorthand for [power x a], i.e., [x **@ a] *)

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


(** {6 Some helper functions } *)

(** The following functions are helper functions for some other functions in
  both Ndarray and Ndview modules. In general, you are not supposed to use
  these functions directly.
 *)

val print_element : ('a, 'b) kind -> 'a -> unit
(** [print_element kind a] prints the value of a single element. *)

val print_index : int array -> unit
(** [print_index i] prints out the index of an element. *)

val _check_transpose_axis : int array -> int -> unit
(** [_check_transpose_axis a d] checks whether [a] is a legiti('a, 'b) te transpose index. *)

val _check_slice_axis : int option array -> int array -> unit
(** [_check_slice_axis axis shape] checks whether [axis] is a legiti('a, 'b) te slice definition. *)
