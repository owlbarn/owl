(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t
type arr = (Complex.t, complex32_elt, c_layout) Genarray.t
type cast_arr = (float, float32_elt, c_layout) Genarray.t


(** {6 Create N-dimensional array} *)

val empty : int array -> arr

val create : int array -> elt -> arr

val init : int array -> (int -> elt) -> arr

val init_nd : int array -> (int array -> elt) -> arr

val zeros : int array -> arr

val ones : int array -> arr

val uniform : ?scale:float -> int array -> arr

val gaussian : ?sigma:float -> int array -> arr

val sequential : ?a:elt -> ?step:elt -> int array -> arr

val linspace : elt -> elt -> int -> arr

val logspace : ?base:float -> elt -> elt -> int -> arr

val bernoulli : ?p:float -> ?seed:int -> int array -> arr


(** {6 Obtain basic properties} *)

val shape : arr -> int array

val num_dims : arr -> int

val nth_dim : arr -> int -> int

val numel : arr -> int

val nnz : arr -> int

val density : arr -> float

val size_in_bytes : arr -> int

val same_shape : arr -> arr -> bool

val strides : arr -> int array

val slice_size : arr -> int array

val index_1d_nd : int -> int array -> int array

val index_nd_1d : int array -> int array -> int


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

val resize : ?head:bool -> arr -> int array -> arr

val reshape : arr -> int array -> arr

val flatten : arr -> arr

val reverse : arr -> arr

val transpose : ?axis:int array -> arr -> arr

val swap : int -> int -> arr -> arr

val tile : arr -> int array -> arr

val repeat : ?axis:int -> arr -> int -> arr

val concatenate : ?axis:int -> arr array -> arr

val squeeze : ?axis:int array -> arr -> arr

val expand : arr -> int -> arr

val pad : ?v:elt -> int list list -> arr -> arr

val dropout : ?rate:float -> ?seed:int -> arr -> arr

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

val is_normal : arr -> bool

val not_nan : arr -> bool

val not_inf : arr -> bool

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

val approx_equal : ?eps:float -> arr -> arr -> bool

val approx_equal_scalar : ?eps:float -> arr -> elt -> bool

val approx_elt_equal : ?eps:float -> arr -> arr -> arr


(** {6 Input/Output functions} *)

val of_array : elt array -> int array -> arr

val to_array : arr -> elt array

val print : arr -> unit

val save : arr -> string -> unit

val load : string -> arr


(** {6 Unary mathematical operations } *)

val re : arr -> cast_arr

val im : arr -> cast_arr

val sum : arr -> elt

val prod : ?axis:int option array -> arr -> elt

val abs : arr -> cast_arr

val abs2 : arr -> cast_arr

val conj : arr -> arr

val neg : arr -> arr

val reci : arr -> arr

val l1norm : arr -> float

val l2norm : arr -> float

val l2norm_sqr : arr -> float

val cumsum : ?axis:int -> arr -> arr

val cumprod : ?axis:int -> arr -> arr

val floor : arr -> arr

val ceil : arr -> arr

val round : arr -> arr

val trunc : arr -> arr

val modf : arr -> arr * arr


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

val ssqr : arr -> elt -> elt

val ssqr_diff : arr -> arr -> elt


(** {6 Experimental functions} *)

val sum_slices : ?axis:int -> arr -> arr
