(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** N-dimensional array module
  This module is built atop of Genarray module in OCaml Bigarray. The module also
  heavily relies on Lacaml to call native BLAS/LAPACK to improve the performance.
  The documentation of some math functions is copied directly from Lacaml.
 *)

type ('a, 'b) t
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
(** [create Bigarray.Float64 [|3;4;5|] 2.] creates a three diemensional array of
  type [Bigarray.Float64]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are initialised to [2.]
 *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(** [zeros Bigarray.Complex32 [|3;4;5|]] creates a three diemensional array of
  type [Bigarray.Complex32]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are initialised to "zero". Depending on the [kind],
  zero can be [0.] or [Complex.zero].
 *)

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t
(** [ones Bigarray.Complex32 [|3;4;5|]] creates a three diemensional array of
  type [Bigarray.Complex32]. Each dimension has the following size: 3, 4, and 5.
  The elements in the array are initialised to "one". Depending on the [kind],
  one can be [1.] or [Complex.one].
 *)


(** {6 Obtain basic properties of an array} *)

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

val kind : ('a, 'b) t -> ('a, 'b) kind
(** [kind] returns the type of ndarray [x]. It is one of the four possible
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

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool
(** [same_shape x y] checks whether [x] and [y] has the same shape or not. *)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(** [transpose ~axis x] makes a copy of [x], then transpose it according to
  [~axis]. [~axis] must be a valid permutation of [x] dimension indices. E.g.,
  for a three-dimensional ndarray, it can be [2;1;0], [0;2;1], [1;2;0], and etc.
 *)

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t
(** [swap i j x] makes a copy of [x], then swaps the data on axis [i] and [j]. *)

(* TODO: mmap *)


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
(** [iteri_slice s f x] iterates the slices along the passed in axises [s], and
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
(** [is_equal x y] returns [true] if two matrices [x] and [y] are equal. *)

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


(** {6 Input and output functions } *)

val save : ('a, 'b) t -> string -> unit
(** [] *)

val load : string -> ('a, 'b) t
(** [] *)

val print : ('a, 'b) t -> unit
(** [] *)


(** {6 Unary mathematical operations } *)

val re : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t
(** [] *)

val im : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t
(** [] *)

val sum : ('a, 'b) t -> 'a
(** [] *)

val min : ('a, 'b) t -> 'a
(** [] *)

val max : ('a, 'b) t -> 'a
(** [] *)

val minmax : ('a, 'b) t -> ('a * (int array) * 'a * (int array))
(** [] *)

val abs : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val neg : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val signum : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val sqr : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val sqrt : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val cbrt : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val exp : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val exp2 : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val expm1 : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val log : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val log10 : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val log2 : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val log1p : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val sin : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val cos : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val tan : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val asin : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val acos : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val atan : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val sinh : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val cosh : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val tanh : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val asinh : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val acosh : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val atanh : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val floor : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val ceil : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val round : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val trunc : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val erf : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val erfc : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val logistic : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val relu : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val softplus : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val softsign : ('a, 'b) t -> ('a, 'b) t
(** [] *)

val conj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [] *)


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [] *)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [] *)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [] *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** [] *)

val pow : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val atan2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val hypot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val min2: ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)

val max2: ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** [] *)


(** {6 Some helper functions } *)

val print_element : ('a, 'b) kind -> 'a -> unit
(** [] *)

val print_index : int array -> unit
(** [] *)

val _check_transpose_axis : int array -> int -> unit
(** [] *)

val _check_slice_axis : int option array -> int array -> unit
(** [] *)
