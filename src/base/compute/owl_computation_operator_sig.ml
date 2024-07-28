(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_types

(* Functor of making the symbols of a computation graph. *)

module type Sig = sig
  module Symbol : Owl_computation_symbol_sig.Sig

  open Symbol.Shape.Type

  (** {5 Vectorised functions} *)

  val noop : arr -> arr
(** 
    [noop arr] performs no operation on the array [arr] and returns it as is.
    This can be useful as a placeholder function.
    Returns the input array [arr].
*)

val empty : int array -> arr
(** 
    [empty shape] creates an uninitialized array with the specified [shape].
    The contents of the array are undefined.
    Returns a new array with the given shape.
*)

val zeros : int array -> arr
(** 
    [zeros shape] creates an array with the specified [shape], filled with zeros.
    Returns a new array with all elements initialized to zero.
*)

val ones : int array -> arr
(** 
    [ones shape] creates an array with the specified [shape], filled with ones.
    Returns a new array with all elements initialized to one.
*)

val create : int array -> elt -> arr
(** 
    [create shape value] creates an array with the specified [shape], filled with the given [value].
    Returns a new array with all elements initialized to [value].
*)

val sequential : ?a:elt -> ?step:elt -> int array -> arr
(** 
    [sequential ?a ?step shape] creates an array with the specified [shape], filled with a sequence of values starting from [a] with a step of [step].
    If [a] is not provided, the sequence starts from 0.
    If [step] is not provided, the step size is 1.
    Returns a new array with sequential values.
*)

val uniform : ?a:elt -> ?b:elt -> int array -> arr
(** 
    [uniform ?a ?b shape] creates an array with the specified [shape], filled with random values drawn from a uniform distribution over \[a, b\).
    If [a] and [b] are not provided, the default range is \[0, 1\) .
    Returns a new array with uniform random values.
*)

val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr
(** 
    [gaussian ?mu ?sigma shape] creates an array with the specified [shape], filled with random values drawn from a Gaussian distribution with mean [mu] and standard deviation [sigma].
    If [mu] is not provided, the default mean is 0.
    If [sigma] is not provided, the default standard deviation is 1.
    Returns a new array with Gaussian random values.
*)

val bernoulli : ?p:elt -> int array -> arr
(** 
    [bernoulli ?p shape] creates an array with the specified [shape], filled with random values drawn from a Bernoulli distribution with probability [p] of being 1.
    If [p] is not provided, the default probability is 0.5.
    Returns a new array with Bernoulli random values.
*)

val init : int array -> (int -> elt) -> arr
(** 
    [init shape f] creates an array with the specified [shape], where each element is initialized using the function [f].
    The function [f] takes the linear index of the element as input.
    Returns a new array with elements initialized by the function [f].
*)

val init_nd : int array -> (int array -> elt) -> arr
(** 
    [init_nd shape f] creates an array with the specified [shape], where each element is initialized using the function [f].
    The function [f] takes the multidimensional index of the element as input.
    Returns a new array with elements initialized by the function [f].
*)

val shape : arr -> int array
(** 
    [shape arr] returns the shape of the array [arr] as an array of integers, each representing the size of the corresponding dimension.
*)

val numel : arr -> int
(** 
    [numel arr] returns the total number of elements in the array [arr].
*)

val get : arr -> int array -> elt
(** 
    [get arr index] retrieves the element at the specified multidimensional [index] in the array [arr].
    Returns the value of the element at the given index.
*)

val set : arr -> int array -> elt -> unit
(** 
    [set arr index value] sets the element at the specified multidimensional [index] in the array [arr] to the given [value].
*)

val get_slice : int list list -> arr -> arr
(** 
    [get_slice slices arr] extracts a slice from the array [arr] according to the list of [slices].
    Each element in [slices] specifies the range for the corresponding dimension.
    Returns a new array with the extracted slice.
*)

val set_slice : int list list -> arr -> arr -> unit
(** 
    [set_slice slices src dest] sets the slice in [dest] defined by [slices] with the values from the source array [src].
*)

val get_fancy : index list -> arr -> arr
(** 
    [get_fancy indices arr] extracts elements from the array [arr] according to the list of [indices].
    Each element in [indices] specifies an advanced indexing method.
    Returns a new array with the extracted elements.
*)

val set_fancy : index list -> arr -> arr -> unit
(** 
    [set_fancy indices src dest] sets the elements in [dest] defined by [indices] with the values from the source array [src].
*)

val copy : arr -> arr
(** 
    [copy arr] creates a deep copy of the array [arr].
    Returns a new array that is a copy of [arr].
*)

val copy_ : out:'a -> 'b -> 'c
(** 
    [copy_ ~out src] copies the contents of the array [src] into the pre-allocated array [out].
*)

val reset : arr -> unit
(** 
    [reset arr] sets all elements of the array [arr] to zero.
*)

val reshape : arr -> int array -> arr
(** 
    [reshape arr shape] reshapes the array [arr] into the new [shape].
    The total number of elements must remain the same.
    Returns a new array with the specified shape.
*)

val reverse : arr -> arr
(** 
    [reverse arr] reverses the elements of the array [arr] along each dimension.
    Returns a new array with the elements reversed.
*)

val tile : arr -> int array -> arr
(** 
    [tile arr reps] replicates the array [arr] according to the number of repetitions specified in [reps] for each dimension.
    Returns a new array with the tiled data.
*)

val repeat : arr -> int array -> arr
(** 
    [repeat arr reps] repeats the elements of the array [arr] according to the number of repetitions specified in [reps] for each dimension.
    Returns a new array with the repeated data.
*)

val pad : ?v:elt -> int list list -> arr -> arr
(** 
    [pad ?v padding arr] pads the array [arr] with the value [v] according to the [padding] specification for each dimension.
    If [v] is not provided, the default padding value is zero.
    Returns a new array with the padded data.
*)

val expand : ?hi:bool -> arr -> int -> arr
(** 
    [expand ?hi arr n] expands the dimensions of the array [arr] by inserting a new dimension of size [n].
    If [hi] is true, the new dimension is added at the beginning; otherwise, it is added at the end.
    Returns a new array with the expanded dimensions.
*)

val squeeze : ?axis:int array -> arr -> arr
(** 
    [squeeze ?axis arr] removes single-dimensional entries from the shape of the array [arr].
    If [axis] is provided, only the specified dimensions are removed.
    Returns a new array with the squeezed shape.
*)

val concatenate : ?axis:int -> arr array -> arr
(** 
    [concatenate ?axis arrays] concatenates a sequence of arrays along the specified [axis].
    If [axis] is not provided, the arrays are concatenated along the first axis.
    Returns a new array with the concatenated data.
*)

val stack : ?axis:int -> arr array -> arr
(** 
    [stack ?axis arrays] stacks a sequence of arrays along a new dimension at the specified [axis].
    If [axis] is not provided, the arrays are stacked along the first axis.
    Returns a new array with the stacked data.
*)

val concat : axis:int -> arr -> arr -> arr
(** 
    [concat ~axis a b] concatenates the arrays [a] and [b] along the specified [axis].
    Returns a new array with the concatenated data.
*)

val split : ?axis:int -> 'a -> 'b -> 'c
(** 
    [split ?axis src num_or_sections] splits the array [src] into multiple sub-arrays along the specified [axis].
    - [num_or_sections] specifies the number of equal-sized sub-arrays or the indices where to split.
    Returns an array of sub-arrays.
*)

val draw : ?axis:int -> arr -> int -> arr * 'a array
(** 
    [draw ?axis arr n] randomly draws [n] samples from the array [arr] along the specified [axis].
    Returns a tuple containing the sampled array and an array of indices from which the samples were drawn.
*)

val map : (elt -> elt) -> arr -> arr
(** 
    [map f arr] applies the function [f] to each element of the array [arr].
    Returns a new array with the results of applying [f].
*)

val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> arr -> arr
(** 
    [fold ?axis f init arr] reduces the array [arr] along the specified [axis] using the function [f] and an initial value [init].
    If [axis] is not provided, the reduction is performed on all elements.
    Returns a new array with the reduced values.
*)

val scan : ?axis:int -> (elt -> elt -> elt) -> arr -> arr
(** 
    [scan ?axis f arr] performs a cumulative reduction of the array [arr] along the specified [axis] using the function [f].
    Returns a new array with the cumulative results.
*)

val one_hot : int -> arr -> arr
(** 
    [one_hot depth arr] converts the array [arr] into a one-hot encoded array with a specified [depth].
    Returns a new array with one-hot encoding.
*)


  val delay : (Device.A.arr -> Device.A.arr) -> arr -> arr
  (**
     [delay f x] returns [f x]. It allows to use a function that is not tracked
     by the computation graph and delay its evaluation. The output must have the
     same shape as the input.
  *)

  val delay_array : int array -> (Device.A.arr array -> Device.A.arr) -> arr array -> arr
  (**
     [delay_array out_shape f x] works in the same way as [delay] but is applied
     on an array of ndarrays. Needs the shape of the output as an argument.
  *)

  val lazy_print
    :  ?max_row:int
    -> ?max_col:int
    -> ?header:bool
    -> ?fmt:(Device.A.elt -> string)
    -> arr
    -> arr
  (**
     [lazy_print x] prints the output of [x] when it is evaluated. Is implemented
     as an identity node. For information about the optional parameters, refer to the
     [print] function of the [Ndarray] module.
  *)


  val print : ?max_row:'a -> ?max_col:'b -> ?header:'c -> ?fmt:'d -> 'e -> unit
  (** 
      [print ?max_row ?max_col ?header ?fmt data] prints a representation of the given [data].
      - [max_row] is an optional parameter specifying the maximum number of rows to print.
      - [max_col] is an optional parameter specifying the maximum number of columns to print.
      - [header] is an optional parameter to include a header in the output.
      - [fmt] is an optional parameter to specify the format of the output.
  *)
  
  val abs : arr -> arr
  (** 
      [abs arr] computes the absolute value of each element in the array [arr].
      Returns a new array with the absolute values.
  *)
  
  val neg : arr -> arr
  (** 
      [neg arr] negates each element in the array [arr].
      Returns a new array with each element negated.
  *)
  
  val floor : arr -> arr
  (** 
      [floor arr] applies the floor function to each element in the array [arr].
      Returns a new array with the floor of each element.
  *)
  
  val ceil : arr -> arr
  (** 
      [ceil arr] applies the ceiling function to each element in the array [arr].
      Returns a new array with the ceiling of each element.
  *)
  
  val round : arr -> arr
  (** 
      [round arr] rounds each element in the array [arr] to the nearest integer.
      Returns a new array with each element rounded to the nearest integer.
  *)
  
  val sqr : arr -> arr
  (** 
      [sqr arr] computes the square of each element in the array [arr].
      Returns a new array with the square of each element.
  *)
  
  val sqrt : arr -> arr
  (** 
      [sqrt arr] computes the square root of each element in the array [arr].
      Returns a new array with the square roots of the elements.
  *)
  
  val log : arr -> arr
  (** 
      [log arr] computes the natural logarithm of each element in the array [arr].
      Returns a new array with the natural logarithms of the elements.
  *)
  
  val log2 : arr -> arr
  (** 
      [log2 arr] computes the base-2 logarithm of each element in the array [arr].
      Returns a new array with the base-2 logarithms of the elements.
  *)
  
  val log10 : arr -> arr
  (** 
      [log10 arr] computes the base-10 logarithm of each element in the array [arr].
      Returns a new array with the base-10 logarithms of the elements.
  *)
  
  val exp : arr -> arr
  (** 
      [exp arr] computes the exponential function of each element in the array [arr].
      Returns a new array with the exponentials of the elements.
  *)
  
  val sin : arr -> arr
  (** 
      [sin arr] computes the sine of each element in the array [arr].
      Returns a new array with the sines of the elements.
  *)
  
  val cos : arr -> arr
  (** 
      [cos arr] computes the cosine of each element in the array [arr].
      Returns a new array with the cosines of the elements.
  *)
  
  val tan : arr -> arr
  (** 
      [tan arr] computes the tangent of each element in the array [arr].
      Returns a new array with the tangents of the elements.
  *)
  
  val sinh : arr -> arr
  (** 
      [sinh arr] computes the hyperbolic sine of each element in the array [arr].
      Returns a new array with the hyperbolic sines of the elements.
  *)
  
  val cosh : arr -> arr
  (** 
      [cosh arr] computes the hyperbolic cosine of each element in the array [arr].
      Returns a new array with the hyperbolic cosines of the elements.
  *)
  
  val tanh : arr -> arr
  (** 
      [tanh arr] computes the hyperbolic tangent of each element in the array [arr].
      Returns a new array with the hyperbolic tangents of the elements.
  *)
  
  val asin : arr -> arr
  (** 
      [asin arr] computes the arcsine of each element in the array [arr].
      Returns a new array with the arcsines of the elements.
  *)
  
  val acos : arr -> arr
  (** 
      [acos arr] computes the arccosine of each element in the array [arr].
      Returns a new array with the arccosines of the elements.
  *)
  
  val atan : arr -> arr
  (** 
      [atan arr] computes the arctangent of each element in the array [arr].
      Returns a new array with the arctangents of the elements.
  *)
  
  val asinh : arr -> arr
  (** 
      [asinh arr] computes the inverse hyperbolic sine of each element in the array [arr].
      Returns a new array with the inverse hyperbolic sines of the elements.
  *)
  
  val acosh : arr -> arr
  (** 
      [acosh arr] computes the inverse hyperbolic cosine of each element in the array [arr].
      Returns a new array with the inverse hyperbolic cosines of the elements.
  *)
  
  val atanh : arr -> arr
  (** 
      [atanh arr] computes the inverse hyperbolic tangent of each element in the array [arr].
      Returns a new array with the inverse hyperbolic tangents of the elements.
  *)
  
  val min : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** 
      [min ?axis ?keep_dims arr] computes the minimum value along the specified axis of the array [arr].
      - [axis] specifies the axis along which to compute the minimum.
      - [keep_dims] specifies whether to keep the reduced dimensions.
      Returns a new array with the minimum values.
  *)
  
  val max : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** 
      [max ?axis ?keep_dims arr] computes the maximum value along the specified axis of the array [arr].
      - [axis] specifies the axis along which to compute the maximum.
      - [keep_dims] specifies whether to keep the reduced dimensions.
      Returns a new array with the maximum values.
  *)
  
  val sum : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** 
      [sum ?axis ?keep_dims arr] computes the sum of elements along the specified axis of the array [arr].
      - [axis] specifies the axis along which to compute the sum.
      - [keep_dims] specifies whether to keep the reduced dimensions.
      Returns a new array with the sum of elements.
  *)
  
  val sum_reduce : ?axis:int array -> arr -> arr
  (** 
      [sum_reduce ?axis arr] computes the sum of elements along the specified axes of the array [arr].
      - [axis] specifies the axes along which to compute the sum.
      Returns a new array with the sum of elements.
  *)
  
  val signum : arr -> arr
  (** 
      [signum arr] computes the signum function of each element in the array [arr].
      Returns a new array where each element is -1, 0, or 1, depending on the sign of the corresponding element in [arr].
  *)
  
  val sigmoid : arr -> arr
  (** 
      [sigmoid arr] computes the sigmoid function of each element in the array [arr].
      Returns a new array with the sigmoid values.
  *)
  
  val relu : arr -> arr
  (** 
      [relu arr] applies the Rectified Linear Unit (ReLU) function to each element in the array [arr].
      Returns a new array where each element is the maximum of 0 and the corresponding element in [arr].
  *)
  
  val dawsn : arr -> arr
  (** 
      [dawsn arr] computes Dawson's function of each element in the array [arr].
      Returns a new array with Dawson's function values.
  *)
  
  val min' : arr -> elt
  (** 
      [min' arr] computes the minimum value in the array [arr].
      Returns the minimum value as an element.
  *)
  
  val max' : arr -> elt
  (** 
      [max' arr] computes the maximum value in the array [arr].
      Returns the maximum value as an element.
  *)
  
  val sum' : arr -> elt
  (** 
      [sum' arr] computes the sum of all elements in the array [arr].
      Returns the sum as an element.
  *)
  
  val log_sum_exp' : arr -> elt
  (** 
      [log_sum_exp' arr] computes the log-sum-exp of all elements in the array [arr].
      Returns the log-sum-exp as an element.
  *)
  
  val log_sum_exp : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** 
      [log_sum_exp ?axis ?keep_dims arr] computes the log of the sum of exponentials of elements along the specified [axis] of the array [arr].
      - [axis] specifies the axis along which to compute the log-sum-exp. If not specified, computes over all elements.
      - [keep_dims] if true, retains reduced dimensions with size 1.
      Returns a new array with the log-sum-exp values.
  *)
  
  val l1norm' : arr -> elt
  (** 
      [l1norm' arr] computes the L1 norm (sum of absolute values) of all elements in the array [arr].
      Returns the L1 norm as an element.
  *)
  
  val l2norm' : arr -> elt
  (** 
      [l2norm' arr] computes the L2 norm (Euclidean norm) of all elements in the array [arr].
      Returns the L2 norm as an element.
  *)
  
  val l2norm_sqr' : arr -> elt
  (** 
      [l2norm_sqr' arr] computes the squared L2 norm (sum of squared values) of all elements in the array [arr].
      Returns the squared L2 norm as an element.
  *)
  
  val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr
  (** 
      [clip_by_value ?amin ?amax arr] clips the values in the array [arr] to the range [amin, amax].
      - [amin] specifies the minimum value to clip to.
      - [amax] specifies the maximum value to clip to.
      Returns a new array with the values clipped to the specified range.
  *)
  
  val clip_by_l2norm : elt -> arr -> arr
  (** 
      [clip_by_l2norm max_norm arr] clips the values in the array [arr] so that the L2 norm does not exceed [max_norm].
      Returns a new array with the values clipped by the specified L2 norm.
  *)
  
  val pow : arr -> arr -> arr
  (** 
      [pow base exp] computes each element of the array [base] raised to the power of the corresponding element in [exp].
      Returns a new array with the power values.
  *)
  
  val scalar_pow : elt -> arr -> arr
  (** 
      [scalar_pow scalar arr] raises the scalar value [scalar] to the power of each element in the array [arr].
      Returns a new array with the power values.
  *)
  
  val pow_scalar : arr -> elt -> arr
  (** 
      [pow_scalar arr scalar] raises each element in the array [arr] to the power of the scalar value [scalar].
      Returns a new array with the power values.
  *)
  
  val atan2 : arr -> arr -> arr
  (** 
      [atan2 y x] computes the element-wise arctangent of [y] / [x], using the signs of the elements to determine the correct quadrant.
      Returns a new array with the arctangent values.
  *)
  
  val scalar_atan2 : elt -> arr -> arr
  (** 
      [scalar_atan2 scalar arr] computes the element-wise arctangent of [scalar] / each element in the array [arr].
      Returns a new array with the arctangent values.
  *)
  
  val atan2_scalar : arr -> elt -> arr
  (** 
      [atan2_scalar arr scalar] computes the element-wise arctangent of each element in the array [arr] / [scalar].
      Returns a new array with the arctangent values.
  *)
  
  val hypot : arr -> arr -> arr
  (** 
      [hypot x y] computes the hypotenuse (sqrt(x^2 + y^2)) for each element in the arrays [x] and [y].
      Returns a new array with the hypotenuse values.
  *)
  
  val min2 : arr -> arr -> arr
  (** 
      [min2 a b] computes the element-wise minimum of arrays [a] and [b].
      Returns a new array with the minimum values.
  *)
  
  val max2 : arr -> arr -> arr
  (** 
      [max2 a b] computes the element-wise maximum of arrays [a] and [b].
      Returns a new array with the maximum values.
  *)
  
  val add : arr -> arr -> arr
  (** 
      [add a b] computes the element-wise addition of arrays [a] and [b].
      Returns a new array with the sum of elements.
  *)
  
  val sub : arr -> arr -> arr
  (** 
      [sub a b] computes the element-wise subtraction of arrays [a] and [b].
      Returns a new array with the difference of elements.
  *)
  
  val mul : arr -> arr -> arr
  (** 
      [mul a b] computes the element-wise multiplication of arrays [a] and [b].
      Returns a new array with the product of elements.
  *)
  
  val div : arr -> arr -> arr
  (** 
      [div a b] computes the element-wise division of arrays [a] and [b].
      Returns a new array with the quotient of elements.
  *)
  
  val add_scalar : arr -> elt -> arr
  (** 
      [add_scalar arr scalar] adds the scalar value [scalar] to each element in the array [arr].
      Returns a new array with the resulting values.
  *)
  
  val sub_scalar : arr -> elt -> arr
  (** 
      [sub_scalar arr scalar] subtracts the scalar value [scalar] from each element in the array [arr].
      Returns a new array with the resulting values.
  *)
  
  val mul_scalar : arr -> elt -> arr
  (** 
      [mul_scalar arr scalar] multiplies each element in the array [arr] by the scalar value [scalar].
      Returns a new array with the resulting values.
  *)
  
  val div_scalar : arr -> elt -> arr
  (** 
      [div_scalar arr scalar] divides each element in the array [arr] by the scalar value [scalar].
      Returns a new array with the resulting values.
  *)
  
  val scalar_add : elt -> arr -> arr
  (** 
      [scalar_add scalar arr] adds the scalar value [scalar] to each element in the array [arr].
      Returns a new array with the resulting values.
  *)
  
  val scalar_sub : elt -> arr -> arr
  (** 
      [scalar_sub scalar arr] subtracts each element in the array [arr] from the scalar value [scalar].
      Returns a new array with the resulting values.
  *)
  
  val scalar_mul : elt -> arr -> arr
  (** 
      [scalar_mul scalar arr] multiplies each element in the array [arr] by the scalar value [scalar].
      Returns a new array with the resulting values.
  *)
  
  val scalar_div : elt -> arr -> arr
  (** 
      [scalar_div scalar arr] divides the scalar value [scalar] by each element in the array [arr].
      Returns a new array with the resulting values.
  *)
  
  val fma : arr -> arr -> arr -> arr
  (** 
      [fma a b c] computes the fused multiply-add operation, multiplying arrays [a] and [b], then adding array [c].
      Returns a new array with the resulting values.
  *)

  val elt_equal : arr -> arr -> arr
(** 
    [elt_equal a b] performs element-wise equality comparison between arrays [a] and [b].
    Returns a new array where each element is [true] if the corresponding elements in [a] and [b] are equal, and [false] otherwise.
*)

val elt_not_equal : arr -> arr -> arr
(** 
    [elt_not_equal a b] performs element-wise inequality comparison between arrays [a] and [b].
    Returns a new array where each element is [true] if the corresponding elements in [a] and [b] are not equal, and [false] otherwise.
*)

val elt_less : arr -> arr -> arr
(** 
    [elt_less a b] performs element-wise less-than comparison between arrays [a] and [b].
    Returns a new array where each element is [true] if the corresponding element in [a] is less than that in [b], and [false] otherwise.
*)

val elt_greater : arr -> arr -> arr
(** 
    [elt_greater a b] performs element-wise greater-than comparison between arrays [a] and [b].
    Returns a new array where each element is [true] if the corresponding element in [a] is greater than that in [b], and [false] otherwise.
*)

val elt_less_equal : arr -> arr -> arr
(** 
    [elt_less_equal a b] performs element-wise less-than-or-equal-to comparison between arrays [a] and [b].
    Returns a new array where each element is [true] if the corresponding element in [a] is less than or equal to that in [b], and [false] otherwise.
*)

val elt_greater_equal : arr -> arr -> arr
(** 
    [elt_greater_equal a b] performs element-wise greater-than-or-equal-to comparison between arrays [a] and [b].
    Returns a new array where each element is [true] if the corresponding element in [a] is greater than or equal to that in [b], and [false] otherwise.
*)

val elt_equal_scalar : arr -> elt -> arr
(** 
    [elt_equal_scalar arr scalar] performs element-wise equality comparison between each element in the array [arr] and the scalar value [scalar].
    Returns a new array where each element is [true] if it equals [scalar], and [false] otherwise.
*)

val elt_not_equal_scalar : arr -> elt -> arr
(** 
    [elt_not_equal_scalar arr scalar] performs element-wise inequality comparison between each element in the array [arr] and the scalar value [scalar].
    Returns a new array where each element is [true] if it does not equal [scalar], and [false] otherwise.
*)

val elt_less_scalar : arr -> elt -> arr
(** 
    [elt_less_scalar arr scalar] performs element-wise less-than comparison between each element in the array [arr] and the scalar value [scalar].
    Returns a new array where each element is [true] if it is less than [scalar], and [false] otherwise.
*)

val elt_greater_scalar : arr -> elt -> arr
(** 
    [elt_greater_scalar arr scalar] performs element-wise greater-than comparison between each element in the array [arr] and the scalar value [scalar].
    Returns a new array where each element is [true] if it is greater than [scalar], and [false] otherwise.
*)

val elt_less_equal_scalar : arr -> elt -> arr
(** 
    [elt_less_equal_scalar arr scalar] performs element-wise less-than-or-equal-to comparison between each element in the array [arr] and the scalar value [scalar].
    Returns a new array where each element is [true] if it is less than or equal to [scalar], and [false] otherwise.
*)

val elt_greater_equal_scalar : arr -> elt -> arr
(** 
    [elt_greater_equal_scalar arr scalar] performs element-wise greater-than-or-equal-to comparison between each element in the array [arr] and the scalar value [scalar].
    Returns a new array where each element is [true] if it is greater than or equal to [scalar], and [false] otherwise.
*)

val conv1d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
(** 
    [conv1d ?padding input kernel strides] performs a 1-dimensional convolution on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    Returns a new array with the result of the convolution.
*)

val conv2d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
(** 
    [conv2d ?padding input kernel strides] performs a 2-dimensional convolution on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    Returns a new array with the result of the convolution.
*)

val conv3d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
(** 
    [conv3d ?padding input kernel strides] performs a 3-dimensional convolution on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    Returns a new array with the result of the convolution.
*)

val transpose_conv1d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
(** 
    [transpose_conv1d ?padding input kernel strides] performs a 1-dimensional transposed convolution (also known as deconvolution) on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    Returns a new array with the result of the transposed convolution.
*)

val transpose_conv2d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
(** 
    [transpose_conv2d ?padding input kernel strides] performs a 2-dimensional transposed convolution (also known as deconvolution) on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    Returns a new array with the result of the transposed convolution.
*)

val transpose_conv3d : ?padding:Owl_types.padding -> arr -> arr -> int array -> arr
(** 
    [transpose_conv3d ?padding input kernel strides] performs a 3-dimensional transposed convolution (also known as deconvolution) on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    Returns a new array with the result of the transposed convolution.
*)

val dilated_conv1d
  :  ?padding:Owl_types.padding
  -> arr
  -> arr
  -> int array
  -> int array
  -> arr
(** 
    [dilated_conv1d ?padding input kernel strides dilations] performs a 1-dimensional dilated convolution on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    Returns a new array with the result of the dilated convolution.
*)

val dilated_conv2d
  :  ?padding:Owl_types.padding
  -> arr
  -> arr
  -> int array
  -> int array
  -> arr
(** 
    [dilated_conv2d ?padding input kernel strides dilations] performs a 2-dimensional dilated convolution on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    Returns a new array with the result of the dilated convolution.
*)

val dilated_conv3d
  :  ?padding:Owl_types.padding
  -> arr
  -> arr
  -> int array
  -> int array
  -> arr
(** 
    [dilated_conv3d ?padding input kernel strides dilations] performs a 3-dimensional dilated convolution on the [input] array using the specified [kernel].
    - [padding] specifies the padding strategy (default is "valid").
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    Returns a new array with the result of the dilated convolution.
*)

val max_pool1d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
(** 
    [max_pool1d ?padding input pool_size strides] applies a 1-dimensional max pooling operation on the [input] array.
    - [padding] specifies the padding strategy (default is "valid").
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    Returns a new array with the result of the max pooling.
*)

val max_pool2d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
(** 
    [max_pool2d ?padding input pool_size strides] applies a 2-dimensional max pooling operation on the [input] array.
    - [padding] specifies the padding strategy (default is "valid").
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    Returns a new array with the result of the max pooling.
*)

val max_pool3d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
(** 
    [max_pool3d ?padding input pool_size strides] applies a 3-dimensional max pooling operation on the [input] array.
    - [padding] specifies the padding strategy (default is "valid").
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    Returns a new array with the result of the max pooling.
*)

val avg_pool1d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
(** 
    [avg_pool1d ?padding input pool_size strides] applies a 1-dimensional average pooling operation on the [input] array.
    - [padding] specifies the padding strategy (default is "valid").
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    Returns a new array with the result of the average pooling.
*)

val avg_pool2d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
(** 
    [avg_pool2d ?padding input pool_size strides] applies a 2-dimensional average pooling operation on the [input] array.
    - [padding] specifies the padding strategy (default is "valid").
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    Returns a new array with the result of the average pooling.
*)

val avg_pool3d : ?padding:Owl_types.padding -> arr -> int array -> int array -> arr
(** 
    [avg_pool3d ?padding input pool_size strides] applies a 3-dimensional average pooling operation on the [input] array.
    - [padding] specifies the padding strategy (default is "valid").
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    Returns a new array with the result of the average pooling.
*)

val upsampling2d : arr -> int array -> arr
(** 
    [upsampling2d input size] performs a 2-dimensional upsampling on the [input] array.
    - [size] specifies the upsampling factors for each dimension.
    Returns a new array with the upsampled data.
*)

val conv1d_backward_input : arr -> arr -> int array -> arr -> arr
(** 
    [conv1d_backward_input input kernel strides grad_output] computes the gradient of the loss with respect to the 1-dimensional [input] array.
    - [input] is the original input array.
    - [kernel] is the convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the convolutional layer.
    Returns a new array with the gradients of the input.
*)

val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr
(** 
    [conv1d_backward_kernel input kernel strides grad_output] computes the gradient of the loss with respect to the 1-dimensional convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val conv2d_backward_input : arr -> arr -> int array -> arr -> arr
(** 
    [conv2d_backward_input input kernel strides grad_output] computes the gradient of the loss with respect to the 2-dimensional [input] array.
    - [input] is the original input array.
    - [kernel] is the convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the convolutional layer.
    Returns a new array with the gradients of the input.
*)

val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
(** 
    [conv2d_backward_kernel input kernel strides grad_output] computes the gradient of the loss with respect to the 2-dimensional convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val conv3d_backward_input : arr -> arr -> int array -> arr -> arr
(** 
    [conv3d_backward_input input kernel strides grad_output] computes the gradient of the loss with respect to the 3-dimensional [input] array.
    - [input] is the original input array.
    - [kernel] is the convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the convolutional layer.
    Returns a new array with the gradients of the input.
*)

val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
(** 
    [conv3d_backward_kernel input kernel strides grad_output] computes the gradient of the loss with respect to the 3-dimensional convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val transpose_conv1d_backward_input : arr -> arr -> int array -> arr -> arr
(** 
    [transpose_conv1d_backward_input input kernel strides grad_output] computes the gradient of the loss with respect to the 1-dimensional [input] array for the transposed convolution operation.
    - [input] is the original input array.
    - [kernel] is the transposed convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the transposed convolutional layer.
    Returns a new array with the gradients of the input.
*)

val transpose_conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr
(** 
    [transpose_conv1d_backward_kernel input kernel strides grad_output] computes the gradient of the loss with respect to the 1-dimensional transposed convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the transposed convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the transposed convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val transpose_conv2d_backward_input : arr -> arr -> int array -> arr -> arr
(** 
    [transpose_conv2d_backward_input input kernel strides grad_output] computes the gradient of the loss with respect to the 2-dimensional [input] array for the transposed convolution operation.
    - [input] is the original input array.
    - [kernel] is the transposed convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the transposed convolutional layer.
    Returns a new array with the gradients of the input.
*)

val transpose_conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
(** 
    [transpose_conv2d_backward_kernel input kernel strides grad_output] computes the gradient of the loss with respect to the 2-dimensional transposed convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the transposed convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the transposed convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val transpose_conv3d_backward_input : arr -> arr -> int array -> arr -> arr
(** 
    [transpose_conv3d_backward_input input kernel strides grad_output] computes the gradient of the loss with respect to the 3-dimensional [input] array for the transposed convolution operation.
    - [input] is the original input array.
    - [kernel] is the transposed convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the transposed convolutional layer.
    Returns a new array with the gradients of the input.
*)

val transpose_conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
(** 
    [transpose_conv3d_backward_kernel input kernel strides grad_output] computes the gradient of the loss with respect to the 3-dimensional transposed convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the transposed convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the transposed convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val dilated_conv1d_backward_input : arr -> arr -> int array -> int array -> arr -> arr
(** 
    [dilated_conv1d_backward_input input kernel strides dilations grad_output] computes the gradient of the loss with respect to the 1-dimensional [input] array for the dilated convolution operation.
    - [input] is the original input array.
    - [kernel] is the dilated convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    - [grad_output] is the gradient of the loss with respect to the output of the dilated convolutional layer.
    Returns a new array with the gradients of the input.
*)

val dilated_conv1d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr
(** 
    [dilated_conv1d_backward_kernel input kernel strides dilations grad_output] computes the gradient of the loss with respect to the 1-dimensional dilated convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the dilated convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    - [grad_output] is the gradient of the loss with respect to the output of the dilated convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val dilated_conv2d_backward_input : arr -> arr -> int array -> int array -> arr -> arr
(** 
    [dilated_conv2d_backward_input input kernel strides dilations grad_output] computes the gradient of the loss with respect to the 2-dimensional [input] array for the dilated convolution operation.
    - [input] is the original input array.
    - [kernel] is the dilated convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    - [grad_output] is the gradient of the loss with respect to the output of the dilated convolutional layer.
    Returns a new array with the gradients of the input.
*)

val dilated_conv2d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr
(** 
    [dilated_conv2d_backward_kernel input kernel strides dilations grad_output] computes the gradient of the loss with respect to the 2-dimensional dilated convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the dilated convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    - [grad_output] is the gradient of the loss with respect to the output of the dilated convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val dilated_conv3d_backward_input : arr -> arr -> int array -> int array -> arr -> arr
(** 
    [dilated_conv3d_backward_input input kernel strides dilations grad_output] computes the gradient of the loss with respect to the 3-dimensional [input] array for the dilated convolution operation.
    - [input] is the original input array.
    - [kernel] is the dilated convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    - [grad_output] is the gradient of the loss with respect to the output of the dilated convolutional layer.
    Returns a new array with the gradients of the input.
*)

val dilated_conv3d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr
(** 
    [dilated_conv3d_backward_kernel input kernel strides dilations grad_output] computes the gradient of the loss with respect to the 3-dimensional dilated convolutional [kernel].
    - [input] is the original input array.
    - [kernel] is the dilated convolutional kernel used during the forward pass.
    - [strides] specifies the stride length.
    - [dilations] specifies the dilation rate.
    - [grad_output] is the gradient of the loss with respect to the output of the dilated convolutional layer.
    Returns a new array with the gradients of the kernel.
*)

val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
(** 
    [max_pool1d_backward padding input pool_size strides grad_output] computes the gradient of the loss with respect to the 1-dimensional [input] array after max pooling.
    - [padding] specifies the padding strategy used during the forward pass.
    - [input] is the original input array.
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the max pooling layer.
    Returns a new array with the gradients of the input.
*)

val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
(** 
    [max_pool2d_backward padding input pool_size strides grad_output] computes the gradient of the loss with respect to the 2-dimensional [input] array after max pooling.
    - [padding] specifies the padding strategy used during the forward pass.
    - [input] is the original input array.
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the max pooling layer.
    Returns a new array with the gradients of the input.
*)

val max_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
(** 
    [max_pool3d_backward padding input pool_size strides grad_output] computes the gradient of the loss with respect to the 3-dimensional [input] array after max pooling.
    - [padding] specifies the padding strategy used during the forward pass.
    - [input] is the original input array.
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the max pooling layer.
    Returns a new array with the gradients of the input.
*)

val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
(** 
    [avg_pool1d_backward padding input pool_size strides grad_output] computes the gradient of the loss with respect to the 1-dimensional [input] array after average pooling.
    - [padding] specifies the padding strategy used during the forward pass.
    - [input] is the original input array.
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the average pooling layer.
    Returns a new array with the gradients of the input.
*)

val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
(** 
    [avg_pool2d_backward padding input pool_size strides grad_output] computes the gradient of the loss with respect to the 2-dimensional [input] array after average pooling.
    - [padding] specifies the padding strategy used during the forward pass.
    - [input] is the original input array.
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the average pooling layer.
    Returns a new array with the gradients of the input.
*)

val avg_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
(** 
    [avg_pool3d_backward padding input pool_size strides grad_output] computes the gradient of the loss with respect to the 3-dimensional [input] array after average pooling.
    - [padding] specifies the padding strategy used during the forward pass.
    - [input] is the original input array.
    - [pool_size] specifies the size of the pooling window.
    - [strides] specifies the stride length.
    - [grad_output] is the gradient of the loss with respect to the output of the average pooling layer.
    Returns a new array with the gradients of the input.
*)

val upsampling2d_backward : arr -> int array -> arr -> arr
(** 
    [upsampling2d_backward input size grad_output] computes the gradient of the loss with respect to the [input] array after 2-dimensional upsampling.
    - [input] is the original input array.
    - [size] specifies the upsampling factors for each dimension.
    - [grad_output] is the gradient of the loss with respect to the output of the upsampling layer.
    Returns a new array with the gradients of the input.
*)

val row_num : arr -> int
(** 
    [row_num arr] returns the number of rows in the array [arr].
*)

val col_num : arr -> int
(** 
    [col_num arr] returns the number of columns in the array [arr].
*)

val row : arr -> 'a -> arr
(** 
    [row arr idx] extracts the row at index [idx] from the array [arr].
    Returns a new array containing the specified row.
*)

val rows : arr -> int array -> arr
(** 
    [rows arr indices] extracts multiple rows specified by [indices] from the array [arr].
    Returns a new array containing the selected rows.
*)

val copy_row_to : arr -> 'a -> 'b -> unit
(** 
    [copy_row_to src src_idx dest_idx] copies the row at index [src_idx] in the array [src] to the row at index [dest_idx].
*)

val copy_col_to : arr -> 'a -> 'b -> unit
(** 
    [copy_col_to src src_idx dest_idx] copies the column at index [src_idx] in the array [src] to the column at index [dest_idx].
*)

val diag : ?k:int -> arr -> arr
(** 
    [diag ?k arr] extracts the k-th diagonal from the array [arr]. If [k] is not provided, the main diagonal is extracted.
    Returns a new array containing the diagonal elements.
*)

val trace : arr -> elt
(** 
    [trace arr] computes the sum of the elements on the main diagonal of the array [arr].
    Returns the trace as an element.
*)

val dot : arr -> arr -> arr
(** 
    [dot a b] computes the dot product of the arrays [a] and [b].
    Returns a new array with the result of the dot product.
*)

val transpose : ?axis:int array -> arr -> arr
(** 
    [transpose ?axis arr] transposes the array [arr]. If [axis] is provided, the transpose is performed according to the specified axes.
    Returns a new array with the transposed data.
*)

val to_rows : arr -> 'a array
(** 
    [to_rows arr] converts the array [arr] into an array of row vectors.
    Returns an array where each element is a row from the original array.
*)

val of_rows : arr array -> arr
(** 
    [of_rows rows] creates an array by stacking the row vectors in [rows].
    Returns a new array constructed from the row vectors.
*)

val to_cols : arr -> 'a array
(** 
    [to_cols arr] converts the array [arr] into an array of column vectors.
    Returns an array where each element is a column from the original array.
*)

val of_cols : arr array -> arr
(** 
    [of_cols cols] creates an array by stacking the column vectors in [cols].
    Returns a new array constructed from the column vectors.
*)

val of_array : elt array -> int array -> arr
(** 
    [of_array data shape] creates an array from a flat array [data] with the specified [shape].
    Returns a new array with the data arranged according to the shape.
*)

val of_arrays : elt array array -> arr
(** 
    [of_arrays data] creates an array from a 2D array [data], where each sub-array represents a row.
    Returns a new array with the data from the 2D array.
*)

val to_arrays : arr -> elt array array
(** 
    [to_arrays arr] converts the array [arr] into a 2D array where each sub-array represents a row.
    Returns a 2D array with the data from the original array.
*)

  (** {5 Scalar functions} *)

  module Scalar : sig
    val add : elt -> elt -> elt
    (** 
        [add a b] returns the sum of the scalars [a] and [b].
    *)
  
    val sub : elt -> elt -> elt
    (** 
        [sub a b] returns the difference of the scalars [a] and [b].
    *)
  
    val mul : elt -> elt -> elt
    (** 
        [mul a b] returns the product of the scalars [a] and [b].
    *)
  
    val div : elt -> elt -> elt
    (** 
        [div a b] returns the quotient of the scalars [a] and [b].
    *)
  
    val pow : elt -> elt -> elt
    (** 
        [pow a b] returns the scalar [a] raised to the power of [b].
    *)
  
    val atan2 : elt -> elt -> elt
    (** 
        [atan2 y x] returns the arctangent of [y / x], considering the signs of [x] and [y] to determine the correct quadrant.
    *)
  
    val abs : elt -> elt
    (** 
        [abs a] returns the absolute value of the scalar [a].
    *)
  
    val neg : elt -> elt
    (** 
        [neg a] returns the negation of the scalar [a].
    *)
  
    val sqr : elt -> elt
    (** 
        [sqr a] returns the square of the scalar [a].
    *)
  
    val sqrt : elt -> elt
    (** 
        [sqrt a] returns the square root of the scalar [a].
    *)
  
    val exp : elt -> elt
    (** 
        [exp a] returns the exponential of the scalar [a].
    *)
  
    val log : elt -> elt
    (** 
        [log a] returns the natural logarithm of the scalar [a].
    *)
  
    val log2 : elt -> elt
    (** 
        [log2 a] returns the base-2 logarithm of the scalar [a].
    *)
  
    val log10 : elt -> elt
    (** 
        [log10 a] returns the base-10 logarithm of the scalar [a].
    *)
  
    val signum : elt -> elt
    (** 
        [signum a] returns the signum function of the scalar [a], which is -1 for negative, 0 for zero, and 1 for positive values.
    *)
  
    val floor : elt -> elt
    (** 
        [floor a] returns the greatest integer less than or equal to the scalar [a].
    *)
  
    val ceil : elt -> elt
    (** 
        [ceil a] returns the smallest integer greater than or equal to the scalar [a].
    *)
  
    val round : elt -> elt
    (** 
        [round a] returns the nearest integer to the scalar [a].
    *)
  
    val sin : elt -> elt
    (** 
        [sin a] returns the sine of the scalar [a].
    *)
  
    val cos : elt -> elt
    (** 
        [cos a] returns the cosine of the scalar [a].
    *)
  
    val tan : elt -> elt
    (** 
        [tan a] returns the tangent of the scalar [a].
    *)
  
    val sinh : elt -> elt
    (** 
        [sinh a] returns the hyperbolic sine of the scalar [a].
    *)
  
    val cosh : elt -> elt
    (** 
        [cosh a] returns the hyperbolic cosine of the scalar [a].
    *)
  
    val tanh : elt -> elt
    (** 
        [tanh a] returns the hyperbolic tangent of the scalar [a].
    *)
  
    val asin : elt -> elt
    (** 
        [asin a] returns the arcsine of the scalar [a].
    *)
  
    val acos : elt -> elt
    (** 
        [acos a] returns the arccosine of the scalar [a].
    *)
  
    val atan : elt -> elt
    (** 
        [atan a] returns the arctangent of the scalar [a].
    *)
  
    val asinh : elt -> elt
    (** 
        [asinh a] returns the inverse hyperbolic sine of the scalar [a].
    *)
  
    val acosh : elt -> elt
    (** 
        [acosh a] returns the inverse hyperbolic cosine of the scalar [a].
    *)
  
    val atanh : elt -> elt
    (** 
        [atanh a] returns the inverse hyperbolic tangent of the scalar [a].
    *)
  
    val relu : elt -> elt
    (** 
        [relu a] applies the Rectified Linear Unit (ReLU) function to the scalar [a], returning [max(0, a)].
    *)
  
    val dawsn : elt -> elt
    (** 
        [dawsn a] returns Dawson's function of the scalar [a].
    *)
  
    val sigmoid : elt -> elt
    (** 
        [sigmoid a] returns the sigmoid function of the scalar [a].
    *)
  end
  

  module Mat : sig
    val eye : int -> arr
    (** 
        [eye n] creates an [n] x [n] identity matrix, where all the elements on the main diagonal are 1, and all other elements are 0.
        Returns a new array representing the identity matrix.
    *)
  
    val diagm : ?k:int -> arr -> arr
    (** 
        [diagm ?k v] creates a diagonal matrix from the array [v].
        - [k] specifies the diagonal to fill. The main diagonal is 0, positive values refer to diagonals above the main, and negative values refer to diagonals below the main.
        Returns a new array representing the diagonal matrix.
    *)
  
    val triu : ?k:int -> arr -> arr
    (** 
        [triu ?k a] returns the upper triangular part of the array [a], with elements below the k-th diagonal zeroed. 
        The main diagonal is 0, positive values refer to diagonals above the main, and negative values refer to diagonals below the main.
        Returns a new array with the upper triangular part.
    *)
  
    val tril : ?k:int -> arr -> arr
    (** 
        [tril ?k a] returns the lower triangular part of the array [a], with elements above the k-th diagonal zeroed. 
        The main diagonal is 0, positive values refer to diagonals above the main, and negative values refer to diagonals below the main.
        Returns a new array with the lower triangular part.
    *)
  end

  module Linalg : sig
    val inv : arr -> arr
    (** 
        [inv a] computes the inverse of the matrix [a].
        Returns a new array representing the inverse matrix.
    *)
  
    val logdet : arr -> elt
    (** 
        [logdet a] computes the natural logarithm of the determinant of the matrix [a].
        Returns the logarithm of the determinant as a scalar.
    *)
  
    val chol : ?upper:bool -> arr -> arr
    (** 
        [chol ?upper a] performs the Cholesky decomposition of the positive-definite matrix [a].
        - [upper] specifies whether to return the upper or lower triangular matrix. If [upper] is true, returns the upper triangular matrix, otherwise the lower triangular matrix.
        Returns a new array representing the Cholesky factor.
    *)
  
    val qr : arr -> arr * arr
    (** 
        [qr a] performs the QR decomposition of the matrix [a].
        Returns a tuple of two arrays (Q, R), where [Q] is an orthogonal matrix and [R] is an upper triangular matrix.
    *)
  
    val lq : arr -> arr * arr
    (** 
        [lq a] performs the LQ decomposition of the matrix [a].
        Returns a tuple of two arrays (L, Q), where [L] is a lower triangular matrix and [Q] is an orthogonal matrix.
    *)
  
    val svd : ?thin:bool -> arr -> arr * arr * arr
    (** 
        [svd ?thin a] performs the Singular Value Decomposition (SVD) of the matrix [a].
        - [thin] specifies whether to return the reduced form of the SVD.
        Returns a tuple of three arrays (U, S, V), where [U] and [V] are orthogonal matrices, and [S] is a diagonal matrix containing the singular values.
    *)
  
    val sylvester : arr -> arr -> arr -> arr
    (** 
        [sylvester a b c] solves the Sylvester equation A*X + X*B = C for the unknown matrix X.
        Returns a new array representing the solution matrix X.
    *)
  
    val lyapunov : arr -> arr -> arr
    (** 
        [lyapunov a q] solves the continuous Lyapunov equation A*X + X*A^T = Q for the unknown matrix X.
        Returns a new array representing the solution matrix X.
    *)
  
    val discrete_lyapunov
      :  ?solver:[ `default | `bilinear | `direct ]
      -> arr
      -> arr
      -> arr
    (** 
        [discrete_lyapunov ?solver a q] solves the discrete Lyapunov equation A*X*A^T - X + Q = 0 for the unknown matrix X.
        - [solver] specifies the method to use: `default`, `bilinear`, or `direct`.
        Returns a new array representing the solution matrix X.
    *)
  
    val linsolve : ?trans:bool -> ?typ:[ `n | `u | `l ] -> arr -> arr -> arr
    (** 
        [linsolve ?trans ?typ a b] solves the linear system A*X = B for the unknown matrix X.
        - [trans] specifies whether to transpose the matrix A.
        - [typ] specifies the type of matrix A: `n` for normal, `u` for upper triangular, and `l` for lower triangular.
        Returns a new array representing the solution matrix X.
    *)
  
    val care : ?diag_r:bool -> arr -> arr -> arr -> arr -> arr
    (** 
        [care ?diag_r a b q r] solves the Continuous-time Algebraic Riccati Equation (CARE) A*X + X*A^T - X*B*R^-1*B^T*X + Q = 0 for the unknown matrix X.
        - [diag_r] if true, [R] is assumed to be diagonal.
        Returns a new array representing the solution matrix X.
    *)
  
    val dare : ?diag_r:bool -> arr -> arr -> arr -> arr -> arr
    (** 
        [dare ?diag_r a b q r] solves the Discrete-time Algebraic Riccati Equation (DARE) A*X*A^T - X - (A*X*B^T)*inv(B*X*B^T + R)*(A*X*B^T)^T + Q = 0 for the unknown matrix X.
        - [diag_r] if true, [R] is assumed to be diagonal.
        Returns a new array representing the solution matrix X.
    *)
  end
  
end
