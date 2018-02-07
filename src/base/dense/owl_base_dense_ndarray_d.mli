(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types_common

type arr

type elt = float

(* operations on scalars *)
module Scalar : sig

  val add : elt -> elt -> elt

  val sub : elt -> elt -> elt

  val mul : elt -> elt -> elt

  val div : elt -> elt -> elt

  val pow : elt -> elt -> elt

  val atan2 : elt -> elt -> elt

  val abs : elt -> elt

  val neg : elt -> elt

  val sqr : elt -> elt

  val sqrt : elt -> elt

  val exp : elt -> elt

  val log : elt -> elt

  val log2 : elt -> elt

  val log10 : elt -> elt

  val signum : elt -> elt

  val floor : elt -> elt

  val ceil : elt -> elt

  val round : elt -> elt

  val sin : elt -> elt

  val cos : elt -> elt

  val tan : elt -> elt

  val sinh : elt -> elt

  val cosh : elt -> elt

  val tanh : elt -> elt

  val asin : elt -> elt

  val acos : elt -> elt

  val atan : elt -> elt

  val asinh : elt -> elt

  val acosh : elt -> elt

  val atanh : elt -> elt

  val relu : elt -> elt

  val sigmoid : elt -> elt

end

(* creation and operation functions *)

val empty : int array -> arr

val zeros : int array -> arr

val ones : int array -> arr

val create : int array -> elt -> arr

val init : int array -> (int -> elt) -> arr

val sequential : ?a:elt -> ?step:elt -> int array -> arr

val uniform : ?a:elt -> ?b:elt -> int array -> arr

val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr

val bernoulli : ?p:float -> int array -> arr

val shape : arr -> int array

val numel : arr -> int

val get : arr -> int array -> elt

val set : arr -> int array -> elt -> unit

val get_slice : int list list -> arr -> arr

val set_slice : int list list -> arr -> arr -> unit

val copy : arr -> arr

val reset : arr -> unit

val map : (elt -> elt) -> arr -> arr

val reshape : arr -> int array -> arr

val flatten : arr -> arr

val reverse : arr -> arr

val tile : arr -> int array -> arr

val repeat : ?axis:int -> arr -> int -> arr

val concatenate : ?axis:int -> arr array -> arr

val split : ?axis:int -> int array -> arr -> arr array

val draw : ?axis:int -> arr -> int -> arr * int array

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

val sum : ?axis:int -> arr -> arr

val sum_slices : ?axis:int -> arr -> arr

val signum : arr -> arr

val sigmoid : arr -> arr

val relu : arr -> arr

val min' : arr -> elt

val max' : arr -> elt

val sum' : arr -> elt

val l1norm' : arr -> elt

val l2norm' : arr -> elt

val l2norm_sqr' : arr -> elt

val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr

val clip_by_l2norm : elt -> arr -> arr

val pow : arr -> arr -> arr

val scalar_pow : elt -> arr -> arr

val pow_scalar : arr -> elt -> arr

val atan2 : arr -> arr -> arr

val scalar_atan2 : elt -> arr -> arr

val atan2_scalar : arr -> elt -> arr

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

val equal : arr -> arr -> bool

val approx_equal : ?eps:float -> arr -> arr -> bool

val elt_greater_equal_scalar : arr -> elt -> arr

(* Neural network related functions *)

val conv1d : ?padding:padding -> arr -> arr -> int array -> arr

val conv2d : ?padding:padding -> arr -> arr -> int array -> arr

val conv3d : ?padding:padding -> arr -> arr -> int array -> arr

val max_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

val max_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

val max_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

val avg_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

val avg_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

val avg_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

val conv1d_backward_input : arr -> arr -> int array -> arr -> arr

val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv2d_backward_input : arr -> arr -> int array -> arr -> arr

val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv3d_backward_input : arr -> arr -> int array -> arr -> arr

val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr

val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

(* matrix functions *)

val row_num : arr -> int

val col_num : arr -> int

val row : arr -> int -> arr

val rows : arr -> int array -> arr

val copy_row_to : arr -> arr -> int -> unit

val copy_col_to : arr -> arr -> int -> unit

val dot : arr -> arr -> arr

val inv : arr -> arr

val trace : arr -> elt

val transpose : ?axis:int array -> arr -> arr

val to_rows : arr -> arr array

val of_rows : arr array -> arr

val of_array : elt array -> int array -> arr

val of_arrays : elt array array -> arr
