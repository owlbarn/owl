(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = float
type arr = (float, float64_elt, c_layout) Genarray.t


(** {6 Create N-dimensional array} *)

val empty : int array -> arr

val create : int array -> elt -> arr

val zeros : int array -> arr

val ones : int array -> arr

val uniform : ?scale:float -> int array -> arr

val sequential : int array -> arr

val linspace : elt -> elt -> int -> arr

val logspace : ?base:float -> elt -> elt -> int -> arr


(** {6 Obtain basic properties} *)

val shape : arr -> int array

val num_dims : arr -> int

val nth_dim : arr -> int -> int

val numel : arr -> int

val nnz : arr -> int

val density : arr -> float

val size_in_bytes : arr -> int

val same_shape : arr -> arr -> bool


(** {6 Manipulate a N-dimensional array} *)

val get : arr -> int array -> elt

val set : arr -> int array -> elt -> unit

val sub_left : arr -> int -> int -> arr

val slice_left : arr -> int array -> arr

val slice : int list list -> arr -> arr

val copy : arr -> arr -> unit

val reset : arr -> unit

val fill : arr -> elt -> unit

val clone : arr -> arr

val reshape : arr -> int array -> arr

val flatten : arr -> arr

val reverse : arr -> arr

val transpose : ?axis:int array -> arr -> arr

val swap : int -> int -> arr -> arr

val tile : arr -> int array -> arr

val repeat : ?axis:int -> arr -> int -> arr

val squeeze : ?axis:int array -> arr -> arr

val pad : ?v:elt -> int list list -> arr -> arr

val mmap : Unix.file_descr -> ?pos:int64 -> bool -> int array -> arr


(** {6 Iterate array elements} *)

val iteri : ?axis:int option array -> (int array -> elt -> unit) -> arr -> unit

val iter : ?axis:int option array -> (elt -> unit) -> arr -> unit

val mapi : ?axis:int option array -> (int array -> elt -> elt) -> arr -> arr

val map : ?axis:int option array -> (elt -> elt) -> arr -> arr

val map2i : ?axis:int option array -> (int array -> elt -> elt -> elt) -> arr -> arr -> arr

val map2 : ?axis:int option array -> (elt -> elt -> elt) -> arr -> arr -> arr

val filteri : ?axis:int option array -> (int array -> elt -> bool) -> arr -> int array array

val filter : ?axis:int option array -> (elt -> bool) -> arr -> int array array

val foldi : ?axis:int option array -> (int array -> 'c -> elt -> 'c) -> 'c -> arr -> 'c

val fold : ?axis:int option array -> ('a -> elt -> 'a) -> 'a -> arr -> 'a

val iteri_slice : int array -> (int array array -> arr -> unit) -> arr -> unit

val iter_slice : int array -> (arr -> unit) -> arr -> unit

val iter2i : (int array -> elt -> elt -> unit) -> arr -> arr -> unit

val iter2 : (elt -> elt -> unit) -> arr -> arr -> unit


(** {6 Examine array elements or compare two arrays } *)

val exists : (elt -> bool) -> arr -> bool

val not_exists : (elt -> bool) -> arr -> bool

val for_all : (elt -> bool) -> arr -> bool

val is_zero : arr -> bool

val is_positive : arr -> bool

val is_negative : arr -> bool

val is_nonpositive : arr -> bool

val is_nonnegative : arr -> bool

val equal : arr -> arr -> bool

val not_equal : arr -> arr -> bool

val greater : arr -> arr -> bool

val less : arr -> arr -> bool

val greater_equal : arr -> arr -> bool

val less_equal : arr -> arr -> bool

val elt_equal : arr -> arr -> arr

val elt_not_equal : arr -> arr -> arr

val elt_less : arr -> arr -> arr

val elt_greater : arr -> arr -> arr

val elt_less_equal : arr -> arr -> arr

val elt_greater_equal : arr -> arr -> arr

val equal_scalar : arr -> elt -> bool

val not_equal_scalar : arr -> elt -> bool

val less_scalar : arr -> elt -> bool

val greater_scalar : arr -> elt -> bool

val less_equal_scalar : arr -> elt -> bool

val greater_equal_scalar : arr -> elt -> bool

val elt_equal_scalar : arr -> elt -> arr

val elt_not_equal_scalar : arr -> elt -> arr

val elt_less_scalar : arr -> elt -> arr

val elt_greater_scalar : arr -> elt -> arr

val elt_less_equal_scalar : arr -> elt -> arr

val elt_greater_equal_scalar : arr -> elt -> arr


(** {6 Input/Output functions} *)

val print : arr -> unit

val save : arr -> string -> unit

val load : string -> arr


(** {6 Unary mathematical operations } *)

val sum : arr -> elt

val prod : ?axis:int option array -> arr -> elt

val min : arr -> float

val max : arr -> float

val minmax : arr -> float * float

val min_i : arr -> float * int array

val max_i : arr -> float * int array

val minmax_i : arr -> (float * (int array)) * (float * (int array))

val abs : arr -> arr

val abs2 : arr -> arr

val neg : arr -> arr

val reci : arr -> arr

val signum : arr -> arr

val sqr : arr -> arr

val sqrt : arr -> arr

val cbrt : arr -> arr

val exp : arr -> arr

val exp2 : arr -> arr

val expm1 : arr -> arr

val log : arr -> arr

val log10 : arr -> arr

val log2 : arr -> arr

val log1p : arr -> arr

val sin : arr -> arr

val cos : arr -> arr

val tan : arr -> arr

val asin : arr -> arr

val acos : arr -> arr

val atan : arr -> arr

val sinh : arr -> arr

val cosh : arr -> arr

val tanh : arr -> arr

val asinh : arr -> arr

val acosh : arr -> arr

val atanh : arr -> arr

val floor : arr -> arr

val ceil : arr -> arr

val round : arr -> arr

val trunc : arr -> arr

val erf : arr -> arr

val erfc : arr -> arr

val logistic : arr -> arr

val relu : arr -> arr

val elu : ?alpha:elt -> arr -> arr

val leaky_relu : ?alpha:elt -> arr -> arr

val softplus : arr -> arr

val softsign : arr -> arr

val softmax : arr -> arr

val sigmoid : arr -> arr

val log_sum_exp : arr -> float

val l1norm : arr -> float

val l2norm : arr -> float

val l2norm_sqr : arr -> float


(** {6 Binary mathematical operations } *)

val add : arr -> arr -> arr

val sub : arr -> arr -> arr

val mul : arr -> arr -> arr

val div : arr -> arr -> arr

val add_scalar : arr -> elt -> arr

val sub_scalar : arr -> elt -> arr

val mul_scalar : arr -> elt -> arr

val div_scalar : arr -> elt -> arr

val scalar_add : elt -> arr -> arr

val scalar_sub : elt -> arr -> arr

val scalar_mul : elt -> arr -> arr

val scalar_div : elt -> arr -> arr

val pow : arr -> arr -> arr

val pow0 : elt -> arr -> arr

val pow1 : arr -> elt -> arr

val atan2 : arr -> arr -> arr

val atan20 : elt -> arr -> arr

val atan21 : arr -> elt -> arr

val hypot : arr -> arr -> arr

val min2 : arr -> arr -> arr

val max2 : arr -> arr -> arr

val fmod : arr -> arr -> arr

val fmod_scalar : arr -> elt -> arr

val scalar_fmod : elt -> arr -> arr

val ssqr : arr -> elt -> elt

val ssqr_diff : arr -> arr -> elt

val cross_entropy : arr -> arr -> float

val clip_by_l2norm : float -> arr -> arr


(** {6 Neural network related functions} *)

type padding = SAME | VALID

val conv2d : ?padding:padding -> arr -> arr -> int array -> arr

val conv2d_backward_input : arr -> arr -> int array -> arr -> arr

val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv3d : ?padding:padding -> arr -> arr -> int array -> arr

val conv3d_backward_input : arr -> arr -> int array -> arr -> arr

val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
