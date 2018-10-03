(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Symbol : Owl_computation_symbol_sig.Sig

  open Symbol.Shape.Type


  (** {6 Vectorised functions} *)

  val noop : arr -> arr
  (** TODO *)

  val empty : int array -> arr
  (** TODO *)

  val zeros : int array -> arr
  (** TODO *)

  val ones : int array -> arr
  (** TODO *)

  val create : int array -> elt -> arr
  (** TODO *)

  val sequential : ?a:elt -> ?step:elt -> int array -> arr
  (** TODO *)

  val uniform : ?a:elt -> ?b:elt -> int array -> arr
  (** TODO *)

  val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr
  (** TODO *)

  val bernoulli : ?p:elt -> int array -> arr
  (** TODO *)

  val init : int array -> (int -> elt) -> arr
  (** TODO *)

  val shape : arr -> int array
  (** TODO *)

  val numel : arr -> int
  (** TODO *)

  val get : arr -> int array -> elt
  (** TODO *)

  val set : arr -> int array -> elt -> unit
  (** TODO *)

  val get_slice : int list list -> arr -> arr
  (** TODO *)

  val set_slice : int list list -> arr -> arr -> unit
  (** TODO *)

  val copy : arr -> arr
  (** TODO *)

  val copy_ : out:'a -> 'b -> 'c
  (** TODO *)

  val reset : arr -> unit
  (** TODO *)

  val reshape : arr -> int array -> arr
  (** TODO *)

  val reverse : arr -> arr
  (** TODO *)

  val tile : arr -> int array -> arr
  (** TODO *)

  val repeat : arr -> int array -> arr
  (** TODO *)

  val pad : ?v:elt -> int list list -> arr -> arr
  (** TODO *)

  val concatenate : ?axis:int -> arr array -> arr
  (** TODO *)

  val split : ?axis:int -> 'a -> 'b -> 'c
  (** TODO *)

  val draw : ?axis:int -> arr -> int -> arr * 'a array
  (** TODO *)

  val map : (elt -> elt) -> arr -> arr
  (** TODO *)

  val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> arr -> arr
  (** TODO *)

  val scan : ?axis:int -> (elt -> elt -> elt) -> arr -> arr
  (** TODO *)

  val one_hot : int -> arr -> arr
  (** TODO *)

  val delay : (Device.A.arr -> Device.A.arr) -> arr -> arr
  (**
``delay f x`` returns ``f x``. It allows to use a function that is not tracked
by the computation graph and delay its evaluation. The output must have the
same shape as the input.
  *)

  val delay_array : int array -> (Device.A.arr array -> Device.A.arr) ->
                    arr array -> arr
  (**
``delay_array out_shape f x`` works in the same way as ``delay`` but is applied
on an array of ndarrays. Needs the shape of the output as an argument.
  *)

  val print : ?max_row:'a -> ?max_col:'b -> ?header:'c -> ?fmt:'d -> 'e -> unit
  (** TODO *)

  val abs : arr -> arr
  (** TODO *)

  val neg : arr -> arr
  (** TODO *)

  val floor : arr -> arr
  (** TODO *)

  val ceil : arr -> arr
  (** TODO *)

  val round : arr -> arr
  (** TODO *)

  val sqr : arr -> arr
  (** TODO *)

  val sqrt : arr -> arr
  (** TODO *)

  val log : arr -> arr
  (** TODO *)

  val log2 : arr -> arr
  (** TODO *)

  val log10 : arr -> arr
  (** TODO *)

  val exp : arr -> arr
  (** TODO *)

  val sin : arr -> arr
  (** TODO *)

  val cos : arr -> arr
  (** TODO *)

  val tan : arr -> arr
  (** TODO *)

  val sinh : arr -> arr
  (** TODO *)

  val cosh : arr -> arr
  (** TODO *)

  val tanh : arr -> arr
  (** TODO *)

  val asin : arr -> arr
  (** TODO *)

  val acos : arr -> arr
  (** TODO *)

  val atan : arr -> arr
  (** TODO *)

  val asinh : arr -> arr
  (** TODO *)

  val acosh : arr -> arr
  (** TODO *)

  val atanh : arr -> arr
  (** TODO *)

  val min : ?axis:int -> arr -> arr
  (** TODO *)

  val max : ?axis:int -> arr -> arr
  (** TODO *)

  val sum : ?axis:int -> arr -> arr
  (** TODO *)

  val sum_reduce : ?axis:int array -> arr -> arr
  (** TODO *)

  val signum : arr -> arr
  (** TODO *)

  val sigmoid : arr -> arr
  (** TODO *)

  val relu : arr -> arr
  (** TODO *)

  val min' : arr -> elt
  (** TODO *)

  val max' : arr -> elt
  (** TODO *)

  val sum' : arr -> elt
  (** TODO *)

  val l1norm' : arr -> elt
  (** TODO *)

  val l2norm' : arr -> elt
  (** TODO *)

  val l2norm_sqr' : arr -> elt
  (** TODO *)

  val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr
  (** TODO *)

  val clip_by_l2norm : elt -> arr -> arr
  (** TODO *)

  val pow : arr -> arr -> arr
  (** TODO *)

  val scalar_pow : elt -> arr -> arr
  (** TODO *)

  val pow_scalar : arr -> elt -> arr
  (** TODO *)

  val atan2 : arr -> arr -> arr
  (** TODO *)

  val scalar_atan2 : elt -> arr -> arr
  (** TODO *)

  val atan2_scalar : arr -> elt -> arr
  (** TODO *)

  val hypot : arr -> arr -> arr
  (** TODO *)

  val min2 : arr -> arr -> arr
  (** TODO *)

  val max2 : arr -> arr -> arr
  (** TODO *)

  val add : arr -> arr -> arr
  (** TODO *)

  val sub : arr -> arr -> arr
  (** TODO *)

  val mul : arr -> arr -> arr
  (** TODO *)

  val div : arr -> arr -> arr
  (** TODO *)

  val add_scalar : arr -> elt -> arr
  (** TODO *)

  val sub_scalar : arr -> elt -> arr
  (** TODO *)

  val mul_scalar : arr -> elt -> arr
  (** TODO *)

  val div_scalar : arr -> elt -> arr
  (** TODO *)

  val scalar_add : elt -> arr -> arr
  (** TODO *)

  val scalar_sub : elt -> arr -> arr
  (** TODO *)

  val scalar_mul : elt -> arr -> arr
  (** TODO *)

  val scalar_div : elt -> arr -> arr
  (** TODO *)

  val fma : arr -> arr -> arr -> arr
  (** TODO *)

  val elt_equal : arr -> arr -> arr
  (** TODO *)

  val elt_not_equal : arr -> arr -> arr
  (** TODO *)

  val elt_less : arr -> arr -> arr
  (** TODO *)

  val elt_greater : arr -> arr -> arr
  (** TODO *)

  val elt_less_equal : arr -> arr -> arr
  (** TODO *)

  val elt_greater_equal : arr -> arr -> arr
  (** TODO *)

  val elt_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_not_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_less_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_greater_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_less_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val elt_greater_equal_scalar : arr -> elt -> arr
  (** TODO *)

  val conv1d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val conv2d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val conv3d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val transpose_conv1d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val transpose_conv2d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val transpose_conv3d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
  (** TODO *)

  val dilated_conv1d : ?padding:Owl_types.padding -> arr -> arr -> int array -> int array -> arr
  (** TODO *)

  val dilated_conv2d : ?padding:Owl_types.padding -> arr -> arr -> int array -> int array -> arr
  (** TODO *)

  val dilated_conv3d : ?padding:Owl_types.padding -> arr -> arr -> int array -> int array -> arr
  (** TODO *)

  val max_pool1d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val max_pool2d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val max_pool3d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val avg_pool1d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val avg_pool2d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val avg_pool3d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
  (** TODO *)

  val upsampling2d : arr -> int array -> arr
  (** TODO *)

  val conv1d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv2d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv3d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv1d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv2d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv3d_backward_input : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val transpose_conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** TODO *)

  val dilated_conv1d_backward_input : arr -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val dilated_conv1d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val dilated_conv2d_backward_input : arr -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val dilated_conv2d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val dilated_conv3d_backward_input : arr -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val dilated_conv3d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val max_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val avg_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** TODO *)

  val upsampling2d_backward : arr -> int array -> arr -> arr
  (** TODO *)

  val row_num : arr -> int
  (** TODO *)

  val col_num : arr -> int
  (** TODO *)

  val row : arr -> 'a -> arr
  (** TODO *)

  val rows : arr -> int array -> arr
  (** TODO *)

  val copy_row_to : arr -> 'a -> 'b -> unit
  (** TODO *)

  val copy_col_to : arr -> 'a -> 'b -> unit
  (** TODO *)

  val inv : arr -> arr
  (** TODO *)

  val trace : arr -> elt
  (** TODO *)

  val dot : arr -> arr -> arr
  (** TODO *)

  val transpose : ?axis:int array -> arr -> arr
  (** TODO *)

  val to_rows : arr -> 'a array
  (** TODO *)

  val of_rows : arr array -> arr
  (** TODO *)

  val of_array : 'a -> 'b -> 'c
  (** TODO *)

  val of_arrays : 'a -> 'b
  (** TODO *)


  (** {6 Scalar functions} *)

  module Scalar : sig
    val add : elt -> elt -> elt
  (** TODO *)

    val sub : elt -> elt -> elt
  (** TODO *)

    val mul : elt -> elt -> elt
  (** TODO *)

    val div : elt -> elt -> elt
  (** TODO *)

    val pow : elt -> elt -> elt
  (** TODO *)

    val atan2 : elt -> elt -> elt
  (** TODO *)

    val abs : elt -> elt
  (** TODO *)

    val neg : elt -> elt
  (** TODO *)

    val sqr : elt -> elt
  (** TODO *)

    val sqrt : elt -> elt
  (** TODO *)

    val exp : elt -> elt
  (** TODO *)

    val log : elt -> elt
  (** TODO *)

    val log2 : elt -> elt
  (** TODO *)

    val log10 : elt -> elt
  (** TODO *)

    val signum : elt -> elt
  (** TODO *)

    val floor : elt -> elt
  (** TODO *)

    val ceil : elt -> elt
  (** TODO *)

    val round : elt -> elt
  (** TODO *)

    val sin : elt -> elt
  (** TODO *)

    val cos : elt -> elt
  (** TODO *)

    val tan : elt -> elt
  (** TODO *)

    val sinh : elt -> elt
  (** TODO *)

    val cosh : elt -> elt
  (** TODO *)

    val tanh : elt -> elt
  (** TODO *)

    val asin : elt -> elt
  (** TODO *)

    val acos : elt -> elt
  (** TODO *)

    val atan : elt -> elt
  (** TODO *)

    val asinh : elt -> elt
  (** TODO *)

    val acosh : elt -> elt
  (** TODO *)

    val atanh : elt -> elt
  (** TODO *)

    val relu : elt -> elt
  (** TODO *)

    val sigmoid : elt -> elt
  (** TODO *)

  end

end
