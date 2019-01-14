(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types_common


(* types and constants *)

type arr = (Complex.t, complex32_elt, c_layout) Genarray.t

type elt = Complex.t

val number : number


(* creation and operation functions *)

val empty : int array -> arr

val zeros : int array -> arr

val ones : int array -> arr

val create : int array -> elt -> arr

val init : int array -> (int -> elt) -> arr

val init_nd : int array -> (int array -> elt) -> arr

val sequential : ?a:elt -> ?step:elt -> int array -> arr

val uniform : ?a:elt -> ?b:elt -> int array -> arr

val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr

val bernoulli : ?p:float -> int array -> arr

val shape : arr -> int array

val numel : arr -> int

val strides : arr -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val slice_size : arr -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val get : arr -> int array -> elt

val set : arr -> int array -> elt -> unit

val get_slice : int list list -> arr -> arr

val set_slice : int list list -> arr -> arr -> unit

val copy : arr -> arr

val copy_ : out:arr -> arr -> unit

val reset : arr -> unit

val reshape : arr -> int array -> arr

val flatten : arr -> arr

val reverse : arr -> arr

val tile : arr -> int array -> arr

val repeat : arr -> int array -> arr

val concatenate : ?axis:int -> arr array -> arr

val split : ?axis:int -> int array -> arr -> arr array

val draw : ?axis:int -> arr -> int -> arr * int array

val pad : ?v:elt -> int list list -> arr -> arr

val one_hot : int -> arr -> arr

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> arr -> unit

(* mathematical functions *)

val abs : arr -> arr

val neg : arr -> arr

val floor : arr -> arr

val ceil : arr -> arr

val round : arr -> arr

val sqr : arr -> arr

val sqrt : arr -> arr

val log : arr -> arr

val log2 : arr -> arr

val log10 : arr -> arr

val exp : arr -> arr

val sin : arr -> arr

val cos : arr -> arr

val tan : arr -> arr

val sinh : arr -> arr

val cosh : arr -> arr

val tanh : arr -> arr

val asin : arr -> arr

val acos : arr -> arr

val atan : arr -> arr

val asinh : arr -> arr

val acosh : arr -> arr

val atanh : arr -> arr

val min : ?axis:int -> arr -> arr

val max : ?axis:int -> arr -> arr

val sum : ?axis:int -> arr -> arr

val sum_reduce : ?axis:int array -> arr -> arr

val min' : arr -> elt

val max' : arr -> elt

val sum' : arr -> elt

val pow : arr -> arr -> arr

val scalar_pow : elt -> arr -> arr

val pow_scalar : arr -> elt -> arr

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

val fma : arr -> arr -> arr -> arr


(** {6 Iterate array elements}  *)

val iteri : (int -> elt -> unit) -> arr -> unit

val iter : (elt -> unit) -> arr -> unit

val mapi : (int -> elt -> elt) -> arr -> arr

val map : (elt -> elt) -> arr -> arr

val filteri : (int -> elt -> bool) -> arr -> int array

val filter : (elt -> bool) -> arr -> int array

val foldi : ?axis:int -> (int -> elt -> elt -> elt) -> elt -> arr -> arr

val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> arr -> arr

val scani : ?axis:int -> (int -> elt -> elt -> elt) -> arr -> arr

val scan : ?axis:int -> (elt -> elt -> elt) -> arr -> arr


(** {6 Examination & Comparison}  *)

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


(** {6 Helper functions}  *)

val of_array : elt array -> int array -> arr

val of_arrays : elt array array -> arr
