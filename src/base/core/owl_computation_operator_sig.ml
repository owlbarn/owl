(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Symbol : Owl_computation_symbol_sig.Sig

  open Symbol

  open Symbol.Shape.Type


  val noop : arr -> arr
      val empty : int array -> arr
      val zeros : int array -> arr
      val ones : int array -> arr
      val create : int array -> elt -> arr
      val sequential :
        ?a:elt -> ?step:elt -> int array -> arr
      val uniform : ?a:elt -> ?b:elt -> int array -> arr
      val gaussian :
        ?mu:elt -> ?sigma:elt -> int array -> arr
      val bernoulli : ?p:float -> int array -> arr
      val init : int array -> (int -> elt) -> arr
      val shape : arr -> int array
      val numel : arr -> int
      val get : arr -> int array -> elt
      val set : arr -> int array -> elt -> unit
      val get_slice : int list list -> arr -> arr
      val set_slice : int list list -> arr -> arr -> unit
      val copy : arr -> arr
      val copy_ : out:'a -> 'b -> 'c
      val reset : arr -> unit
      val reshape : arr -> int array -> arr
      val reverse : arr -> arr
      val tile : arr -> int array -> arr
      val repeat : ?axis:int -> arr -> int -> arr
      val concatenate : ?axis:int -> arr array -> arr
      val split : ?axis:int -> 'a -> 'b -> 'c
      val draw : ?axis:int -> arr -> int -> arr * 'a array
      val map : (elt -> elt) -> arr -> arr
      val fold :
        ?axis:int ->
        (elt -> elt -> elt) ->
        elt -> arr -> arr
      val scan :
        ?axis:int ->
        (elt -> elt -> elt) -> arr -> arr
      val one_hot : int -> arr -> arr
      val print :
        ?max_row:'a -> ?max_col:'b -> ?header:'c -> ?fmt:'d -> 'e -> unit
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
      val signum : arr -> arr
      val sigmoid : arr -> arr
      val relu : arr -> arr
      val min' : arr -> elt
      val max' : arr -> elt
      val sum' : arr -> elt
      val l1norm' : arr -> elt
      val l2norm' : arr -> elt
      val l2norm_sqr' : arr -> elt
      val clip_by_value :
        ?amin:elt -> ?amax:elt -> arr -> arr
      val clip_by_l2norm : elt -> arr -> arr
      val pow : arr -> arr -> arr
      val scalar_pow : elt -> arr -> arr
      val pow_scalar : arr -> elt -> arr
      val atan2 : arr -> arr -> arr
      val scalar_atan2 : elt -> arr -> arr
      val atan2_scalar : arr -> elt -> arr
      val hypot : arr -> arr -> arr
      val min2 : arr -> arr -> arr
      val max2 : arr -> arr -> arr
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
      val elt_equal : arr -> arr -> arr
      val elt_not_equal : arr -> arr -> arr
      val elt_less : arr -> arr -> arr
      val elt_greater : arr -> arr -> arr
      val elt_less_equal : arr -> arr -> arr
      val elt_greater_equal : arr -> arr -> arr
      val elt_equal_scalar : arr -> elt -> arr
      val elt_not_equal_scalar : arr -> elt -> arr
      val elt_less_scalar : arr -> elt -> arr
      val elt_greater_scalar : arr -> elt -> arr
      val elt_less_equal_scalar : arr -> elt -> arr
      val elt_greater_equal_scalar : arr -> elt -> arr
      val conv1d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> arr
      val conv2d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> arr
      val conv3d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> arr
      val transpose_conv1d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> arr
      val transpose_conv2d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> arr
      val transpose_conv3d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> arr
      val dilated_conv1d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> int array -> arr
      val dilated_conv2d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> int array -> arr
      val dilated_conv3d :
        ?padding:Owl_types.padding ->
        arr -> arr -> int array -> int array -> arr
      val max_pool1d :
        ?padding:Owl_types.padding ->
        arr -> int array -> int array -> arr
      val max_pool2d :
        ?padding:Owl_types.padding ->
        arr -> int array -> int array -> arr
      val max_pool3d :
        ?padding:Owl_types.padding ->
        arr -> int array -> int array -> arr
      val avg_pool1d :
        ?padding:Owl_types.padding ->
        arr -> int array -> int array -> arr
      val avg_pool2d :
        ?padding:Owl_types.padding ->
        arr -> int array -> int array -> arr
      val avg_pool3d :
        ?padding:Owl_types.padding ->
        arr -> int array -> int array -> arr
      val conv1d_backward_input :
        arr -> arr -> int array -> arr -> arr
      val conv1d_backward_kernel :
        arr -> arr -> int array -> arr -> arr
      val conv2d_backward_input :
        arr -> arr -> int array -> arr -> arr
      val conv2d_backward_kernel :
        arr -> arr -> int array -> arr -> arr
      val conv3d_backward_input :
        arr -> arr -> int array -> arr -> arr
      val conv3d_backward_kernel :
        arr -> arr -> int array -> arr -> arr
      val transpose_conv1d_backward_input :
        arr -> arr -> int array -> arr -> arr
      val transpose_conv1d_backward_kernel :
        arr -> arr -> int array -> arr -> arr
      val transpose_conv2d_backward_input :
        arr -> arr -> int array -> arr -> arr
      val transpose_conv2d_backward_kernel :
        arr -> arr -> int array -> arr -> arr
      val transpose_conv3d_backward_input :
        arr -> arr -> int array -> arr -> arr
      val transpose_conv3d_backward_kernel :
        arr -> arr -> int array -> arr -> arr
      val dilated_conv1d_backward_input :
        arr ->
        arr -> int array -> int array -> arr -> arr
      val dilated_conv1d_backward_kernel :
        arr ->
        arr -> int array -> int array -> arr -> arr
      val dilated_conv2d_backward_input :
        arr ->
        arr -> int array -> int array -> arr -> arr
      val dilated_conv2d_backward_kernel :
        arr ->
        arr -> int array -> int array -> arr -> arr
      val dilated_conv3d_backward_input :
        arr ->
        arr -> int array -> int array -> arr -> arr
      val dilated_conv3d_backward_kernel :
        arr ->
        arr -> int array -> int array -> arr -> arr
      val max_pool1d_backward :
        Owl_types.padding ->
        arr -> int array -> int array -> arr -> arr
      val max_pool2d_backward :
        Owl_types.padding ->
        arr -> int array -> int array -> arr -> arr
      val max_pool3d_backward :
        Owl_types.padding ->
        arr -> int array -> int array -> arr -> arr
      val avg_pool1d_backward :
        Owl_types.padding ->
        arr -> int array -> int array -> arr -> arr
      val avg_pool2d_backward :
        Owl_types.padding ->
        arr -> int array -> int array -> arr -> arr
      val avg_pool3d_backward :
        Owl_types.padding ->
        arr -> int array -> int array -> arr -> arr
      val row_num : arr -> int
      val col_num : arr -> int
      val row : arr -> 'a -> arr
      val rows : arr -> int array -> arr
      val copy_row_to : arr -> 'a -> 'b -> unit
      val copy_col_to : arr -> 'a -> 'b -> unit
      val inv : arr -> arr
      val trace : arr -> elt
      val dot : arr -> arr -> arr
      val transpose : ?axis:int array -> arr -> arr
      val to_rows : arr -> 'a array
      val of_rows : arr array -> arr
      val of_array : 'a -> 'b -> 'c
      val of_arrays : 'a -> 'b
      module Scalar :
        sig
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

end
