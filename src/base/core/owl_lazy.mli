(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_types
open Owl_graph

(*
  Lazy functor: this module is an alias of the CPU-based engine for Owl's
  computation graph.
 *)

module Make (A : Ndarray_Mutable) : sig
  (** {5 Type definition} *)

  type arr
  (** TODO *)

  type elt
  (** TODO *)

  type value
  (** TODO *)

  type attr
  (** TODO *)

  type graph
  (** TODO *)

  (** {5 Type conversion functions} *)

  val arr_to_value : A.arr -> value
  (** TODO *)

  val value_to_arr : value -> A.arr
  (** TODO *)

  val elt_to_value : A.elt -> value
  (** TODO *)

  val value_to_elt : value -> A.elt
  (** TODO *)

  val value_to_float : value -> float
  (** TODO *)

  val node_to_arr : attr node -> arr
  (** TODO *)

  val arr_to_node : arr -> attr node
  (** TODO *)

  val node_to_elt : attr node -> elt
  (** TODO *)

  val elt_to_node : elt -> attr node
  (** TODO *)

  val pack_arr : A.arr -> arr
  (** TODO *)

  val unpack_arr : arr -> A.arr
  (** TODO *)

  val pack_elt : A.elt -> elt
  (** TODO *)

  val unpack_elt : elt -> A.elt
  (** TODO *)

  val float_to_elt : float -> elt
  (** TODO *)

  val elt_to_float : elt -> float
  (** TODO *)

  (** {5 Utility functions} *)

  val graph_to_dot : graph -> string
  (** TODO *)

  val graph_to_trace : graph -> string
  (** TODO *)

  (** {5 Create variables} *)

  val var_arr : ?shape:int array -> string -> arr
  (** TODO *)

  val var_elt : string -> elt
  (** TODO *)

  val const_arr : string -> A.arr -> arr
  (** TODO *)

  val const_elt : string -> A.elt -> elt
  (** TODO *)

  val assign_arr : arr -> A.arr -> unit
  (** TODO *)

  val assign_elt : elt -> A.elt -> unit
  (** TODO *)

  val unsafe_assign_arr : arr -> A.arr -> unit
  (** TODO *)

  (** {5 Maths functions} *)

  val noop : arr -> arr
  (** [noop arr] returns the array [arr] unchanged. *)

  val empty : int array -> arr
  (** [empty shape] creates an uninitialized array with the specified [shape]. *)

  val zeros : int array -> arr
  (** [zeros shape] creates an array of the specified [shape] filled with zeros. *)

  val ones : int array -> arr
  (** [ones shape] creates an array of the specified [shape] filled with ones. *)

  val create : int array -> elt -> arr
  (** [create shape value] creates an array of the specified [shape] filled with the given [value]. *)

  val sequential : ?a:elt -> ?step:elt -> int array -> arr
  (** [sequential ?a ?step shape] creates an array of the specified [shape] filled with sequential values 
      starting from [a] and incremented by [step]. *)

  val uniform : ?a:elt -> ?b:elt -> int array -> arr
  (** [uniform ?a ?b shape] creates an array of the specified [shape] filled with values drawn 
      from a uniform distribution between [a] and [b]. *)

  val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr
  (** [gaussian ?mu ?sigma shape] creates an array of the specified [shape] filled with values 
      drawn from a Gaussian distribution with mean [mu] and standard deviation [sigma]. *)

  val bernoulli : ?p:elt -> int array -> arr
  (** [bernoulli ?p shape] creates an array of the specified [shape] filled with values drawn 
      from a Bernoulli distribution with probability [p]. *)

  val init : int array -> (int -> elt) -> arr
  (** [init shape f] creates an array of the specified [shape] where each element is initialized 
      by the function [f], which takes the index of the element as input. *)

  val shape : arr -> int array
  (** [shape arr] returns the shape of the array [arr]. *)

  val numel : arr -> int
  (** [numel arr] returns the total number of elements in the array [arr]. *)

  val get : arr -> int array -> elt
  (** [get arr indices] retrieves the value at the specified [indices] from the array [arr]. *)

  val set : arr -> int array -> elt -> unit
  (** [set arr indices value] sets the value at the specified [indices] in the array [arr] to [value]. *)

  val get_slice : int list list -> arr -> arr
  (** [get_slice slice_spec arr] extracts a slice from the array [arr] according to the slice specification [slice_spec]. *)

  val set_slice : int list list -> arr -> arr -> unit
  (** [set_slice slice_spec src dst] sets the specified slice in the array [dst] to the values from [src] 
      according to the slice specification [slice_spec]. *)

  val copy : arr -> arr
  (** [copy arr] creates a deep copy of the array [arr]. *)

  val reset : arr -> unit
  (** [reset arr] resets all elements in the array [arr] to zero. *)

  val reshape : arr -> int array -> arr
  (** [reshape arr shape] returns a new array with the elements of [arr] rearranged into the specified [shape]. *)

  val reverse : arr -> arr
  (** [reverse arr] returns a new array with the elements of [arr] reversed along all axes. *)

  val tile : arr -> int array -> arr
  (** [tile arr reps] creates a new array by repeating the array [arr] according to the repetition pattern [reps]. *)

  val repeat : arr -> int array -> arr
  (** [repeat arr reps] repeats the elements of [arr] along each axis according to the repetition pattern [reps]. *)

  val concatenate : ?axis:int -> arr array -> arr
  (** [concatenate ?axis arrs] concatenates the arrays in [arrs] along the specified [axis]. *)

  val split : ?axis:int -> int array -> arr -> arr array
  (** [split ?axis indices arr] splits the array [arr] into multiple sub-arrays along the specified [axis] 
      at the given [indices]. *)

  val draw : ?axis:int -> arr -> int -> arr * 'a array
  (** [draw ?axis arr n] randomly selects [n] elements from the array [arr] along the specified [axis], 
      returning the selected elements and their corresponding indices. *)

  val map : (elt -> elt) -> arr -> arr
  (** [map f arr] applies the function [f] to each element of the array [arr], returning a new array 
      with the results. *)

  val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> arr -> arr
  (** [fold ?axis f init arr] reduces the array [arr] along the specified [axis] using the function [f], 
      starting with the initial value [init]. *)

  val scan : ?axis:int -> (elt -> elt -> elt) -> arr -> arr
  (** [scan ?axis f arr] performs a cumulative reduction of the array [arr] along the specified [axis] 
      using the function [f]. *)

  val one_hot : int -> arr -> arr
  (** [one_hot depth arr] converts the array [arr] into a one-hot encoded array with the specified depth. *)


  val lazy_print
    :  ?max_row:int
    -> ?max_col:int
    -> ?header:bool
    -> ?fmt:(A.elt -> string)
    -> arr
    -> arr
  (** [lazy_print ?max_row ?max_col ?header ?fmt arr] returns a formatted string 
      representation of the array [arr], potentially truncated based on [max_row] 
      and [max_col], with an optional [header] and custom formatting function [fmt]. 
      The array itself is returned unchanged. *)

  val print : ?max_row:'a -> ?max_col:'b -> ?header:'c -> ?fmt:'d -> 'e -> unit
  (** [print ?max_row ?max_col ?header ?fmt arr] prints a formatted string 
      representation of the array [arr] to the standard output, potentially truncated 
      based on [max_row] and [max_col], with an optional [header] and custom formatting function [fmt]. *)

  val abs : arr -> arr
  (** [abs arr] returns a new array where each element is the absolute value of the corresponding element in [arr]. *)

  val neg : arr -> arr
  (** [neg arr] returns a new array where each element is the negation of the corresponding element in [arr]. *)

  val floor : arr -> arr
  (** [floor arr] returns a new array where each element is the floor of the corresponding element in [arr]. *)

  val ceil : arr -> arr
  (** [ceil arr] returns a new array where each element is the ceiling of the corresponding element in [arr]. *)

  val round : arr -> arr
  (** [round arr] returns a new array where each element is rounded to the nearest integer. *)

  val sqr : arr -> arr
  (** [sqr arr] returns a new array where each element is the square of the corresponding element in [arr]. *)

  val sqrt : arr -> arr
  (** [sqrt arr] returns a new array where each element is the square root of the corresponding element in [arr]. *)

  val log : arr -> arr
  (** [log arr] returns a new array where each element is the natural logarithm of the corresponding element in [arr]. *)

  val log2 : arr -> arr
  (** [log2 arr] returns a new array where each element is the base-2 logarithm of the corresponding element in [arr]. *)

  val log10 : arr -> arr
  (** [log10 arr] returns a new array where each element is the base-10 logarithm of the corresponding element in [arr]. *)

  val exp : arr -> arr
  (** [exp arr] returns a new array where each element is the exponential of the corresponding element in [arr]. *)

  val sin : arr -> arr
  (** [sin arr] returns a new array where each element is the sine of the corresponding element in [arr]. *)

  val cos : arr -> arr
  (** [cos arr] returns a new array where each element is the cosine of the corresponding element in [arr]. *)

  val tan : arr -> arr
  (** [tan arr] returns a new array where each element is the tangent of the corresponding element in [arr]. *)

  val sinh : arr -> arr
  (** [sinh arr] returns a new array where each element is the hyperbolic sine of the corresponding element in [arr]. *)

  val cosh : arr -> arr
  (** [cosh arr] returns a new array where each element is the hyperbolic cosine of the corresponding element in [arr]. *)

  val tanh : arr -> arr
  (** [tanh arr] returns a new array where each element is the hyperbolic tangent of the corresponding element in [arr]. *)

  val asin : arr -> arr
  (** [asin arr] returns a new array where each element is the arc sine of the corresponding element in [arr]. *)

  val acos : arr -> arr
  (** [acos arr] returns a new array where each element is the arc cosine of the corresponding element in [arr]. *)

  val atan : arr -> arr
  (** [atan arr] returns a new array where each element is the arc tangent of the corresponding element in [arr]. *)

  val asinh : arr -> arr
  (** [asinh arr] returns a new array where each element is the inverse hyperbolic sine of the corresponding element in [arr]. *)

  val acosh : arr -> arr
  (** [acosh arr] returns a new array where each element is the inverse hyperbolic cosine of the corresponding element in [arr]. *)

  val atanh : arr -> arr
  (** [atanh arr] returns a new array where each element is the inverse hyperbolic tangent of the corresponding element in [arr]. *)

  val min : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** [min ?axis ?keep_dims arr] returns the minimum value along the specified axis in the array [arr]. *)

  val max : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** [max ?axis ?keep_dims arr] returns the maximum value along the specified axis in the array [arr]. *)

  val sum : ?axis:int -> ?keep_dims:bool -> arr -> arr
  (** [sum ?axis ?keep_dims arr] returns the sum of elements along the specified axis in the array [arr]. *)

  val sum_reduce : ?axis:int array -> arr -> arr
  (** [sum_reduce ?axis arr] reduces the array [arr] by summing along the specified axes. *)

  val signum : arr -> arr
  (** [signum arr] returns a new array where each element is the sign of the corresponding element in [arr]. *)

  val sigmoid : arr -> arr
  (** [sigmoid arr] returns a new array where each element is the sigmoid function applied to the corresponding element in [arr]. *)

  val relu : arr -> arr
  (** [relu arr] returns a new array where each element is the result of applying the ReLU (Rectified Linear Unit) function to the corresponding element in [arr]. *)

  val min' : arr -> elt
  (** [min' arr] returns the minimum value in the array [arr]. *)

  val max' : arr -> elt
  (** [max' arr] returns the maximum value in the array [arr]. *)

  val sum' : arr -> elt
  (** [sum' arr] returns the sum of all elements in the array [arr]. *)

  val l1norm' : arr -> elt
  (** [l1norm' arr] returns the L1 norm (sum of absolute values) of all elements in the array [arr]. *)

  val l2norm' : arr -> elt
  (** [l2norm' arr] returns the L2 norm (Euclidean norm) of all elements in the array [arr]. *)

  val l2norm_sqr' : arr -> elt
  (** [l2norm_sqr' arr] returns the squared L2 norm of all elements in the array [arr]. *)

  val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr
  (** [clip_by_value ?amin ?amax arr] clips the values in the array [arr] to be within the range [amin, amax]. *)

  val clip_by_l2norm : elt -> arr -> arr
  (** [clip_by_l2norm max_norm arr] clips the values in the array [arr] so that its L2 norm does not exceed [max_norm]. *)

  val pow : arr -> arr -> arr
  (** [pow arr1 arr2] returns a new array where each element is the result of raising the corresponding element in [arr1] to the power of the corresponding element in [arr2]. *)

  val scalar_pow : elt -> arr -> arr
  (** [scalar_pow scalar arr] returns a new array where each element in [arr] is raised to the power of [scalar]. *)

  val pow_scalar : arr -> elt -> arr
  (** [pow_scalar arr scalar] returns a new array where each element in [arr] is raised to the power of [scalar]. *)

  val atan2 : arr -> arr -> arr
  (** [atan2 arr1 arr2] returns a new array where each element is the result of applying the two-argument arctangent function to the corresponding elements in [arr1] and [arr2]. *)

  val scalar_atan2 : elt -> arr -> arr
  (** [scalar_atan2 scalar arr] returns a new array where each element is the result of applying the two-argument arctangent function to [scalar] and the corresponding element in [arr]. *)

  val atan2_scalar : arr -> elt -> arr
  (** [atan2_scalar arr scalar] returns a new array where each element is the result of applying the two-argument arctangent function to the corresponding element in [arr] and [scalar]. *)

  val hypot : arr -> arr -> arr
  (** [hypot arr1 arr2] returns a new array where each element is the result of applying the hypotenuse function to the corresponding elements in [arr1] and [arr2]. *)

  val min2 : arr -> arr -> arr
  (** [min2 arr1 arr2] returns a new array where each element is the minimum of the corresponding elements in [arr1] and [arr2]. *)

  val max2 : arr -> arr -> arr
  (** [max2 arr1 arr2] returns a new array where each element is the maximum of the corresponding elements in [arr1] and [arr2]. *)

  val add : arr -> arr -> arr
  (** [add arr1 arr2] returns a new array where each element is the sum of the corresponding elements in [arr1] and [arr2]. *)

  val sub : arr -> arr -> arr
  (** [sub arr1 arr2] returns a new array where each element is the difference between the corresponding elements in [arr1] and [arr2]. *)

  val mul : arr -> arr -> arr
  (** [mul arr1 arr2] returns a new array where each element is the product of the corresponding elements in [arr1] and [arr2]. *)

  val div : arr -> arr -> arr
  (** [div arr1 arr2] returns a new array where each element is the quotient of the corresponding elements in [arr1] and [arr2]. *)

  val add_scalar : arr -> elt -> arr
  (** [add_scalar arr scalar] returns a new array where each element in [arr] is incremented by [scalar]. *)

  val sub_scalar : arr -> elt -> arr
  (** [sub_scalar arr scalar] returns a new array where each element in [arr] is decremented by [scalar]. *)

  val mul_scalar : arr -> elt -> arr
  (** [mul_scalar arr scalar] returns a new array where each element in [arr] is multiplied by [scalar]. *)

  val div_scalar : arr -> elt -> arr
  (** [div_scalar arr scalar] returns a new array where each element in [arr] is divided by [scalar]. *)

  val scalar_add : elt -> arr -> arr
  (** [scalar_add scalar arr] returns a new array where [scalar] is added to each element in [arr]. *)

  val scalar_sub : elt -> arr -> arr
  (** [scalar_sub scalar arr] returns a new array where [scalar] is subtracted from each element in [arr]. *)

  val scalar_mul : elt -> arr -> arr
  (** [scalar_mul scalar arr] returns a new array where each element in [arr] is multiplied by [scalar]. *)

  val scalar_div : elt -> arr -> arr
  (** [scalar_div scalar arr] returns a new array where [scalar] is divided by each element in [arr]. *)

  val fma : arr -> arr -> arr -> arr
  (** [fma arr1 arr2 arr3] returns a new array where each element is the result of a fused multiply-add operation 
      applied to the corresponding elements in [arr1], [arr2], and [arr3]. *)

  val elt_equal : arr -> arr -> arr
  (** [elt_equal arr1 arr2] returns a new array where each element is [1] if the corresponding elements in [arr1] and [arr2] are equal, otherwise [0]. *)

  val elt_not_equal : arr -> arr -> arr
  (** [elt_not_equal arr1 arr2] returns a new array where each element is [1] if the corresponding elements in [arr1] and [arr2] are not equal, otherwise [0]. *)

  val elt_less : arr -> arr -> arr
  (** [elt_less arr1 arr2] returns a new array where each element is [1] if the corresponding element in [arr1] is less than the corresponding element in [arr2], otherwise [0]. *)

  val elt_greater : arr -> arr -> arr
  (** [elt_greater arr1 arr2] returns a new array where each element is [1] if the corresponding element in [arr1] is greater than the corresponding element in [arr2], otherwise [0]. *)

  val elt_less_equal : arr -> arr -> arr
  (** [elt_less_equal arr1 arr2] returns a new array where each element is [1] if the corresponding element in [arr1] is less than or equal to the corresponding element in [arr2], otherwise [0]. *)

  val elt_greater_equal : arr -> arr -> arr
  (** [elt_greater_equal arr1 arr2] returns a new array where each element is [1] if the corresponding element in [arr1] is greater than or equal to the corresponding element in [arr2], otherwise [0]. *)

  val elt_equal_scalar : arr -> elt -> arr
  (** [elt_equal_scalar arr scalar] returns a new array where each element is [1] if the corresponding element in [arr] is equal to [scalar], otherwise [0]. *)

  val elt_not_equal_scalar : arr -> elt -> arr
  (** [elt_not_equal_scalar arr scalar] returns a new array where each element is [1] if the corresponding element in [arr] is not equal to [scalar], otherwise [0]. *)

  val elt_less_scalar : arr -> elt -> arr
  (** [elt_less_scalar arr scalar] returns a new array where each element is [1] if the corresponding element in [arr] is less than [scalar], otherwise [0]. *)

  val elt_greater_scalar : arr -> elt -> arr
  (** [elt_greater_scalar arr scalar] returns a new array where each element is [1] if the corresponding element in [arr] is greater than [scalar], otherwise [0]. *)

  val elt_less_equal_scalar : arr -> elt -> arr
  (** [elt_less_equal_scalar arr scalar] returns a new array where each element is [1] if the corresponding element in [arr] is less than or equal to [scalar], otherwise [0]. *)

  val elt_greater_equal_scalar : arr -> elt -> arr
  (** [elt_greater_equal_scalar arr scalar] returns a new array where each element is [1] if the corresponding element in [arr] is greater than or equal to [scalar], otherwise [0]. *)

  val conv1d : ?padding:padding -> arr -> arr -> int array -> arr
  (** [conv1d ?padding kernel arr stride] performs a 1D convolution of the array [arr] with the kernel [kernel], 
      using the specified stride and optional padding. *)

  val conv2d : ?padding:padding -> arr -> arr -> int array -> arr
  (** [conv2d ?padding kernel arr stride] performs a 2D convolution of the array [arr] with the kernel [kernel], 
      using the specified stride and optional padding. *)

  val conv3d : ?padding:padding -> arr -> arr -> int array -> arr
  (** [conv3d ?padding kernel arr stride] performs a 3D convolution of the array [arr] with the kernel [kernel], 
      using the specified stride and optional padding. *)

  val transpose_conv2d : ?padding:padding -> arr -> arr -> int array -> arr
  (** [transpose_conv2d ?padding kernel arr stride] performs a 2D transposed convolution (also known as a deconvolution) 
      of the array [arr] with the kernel [kernel], using the specified stride and optional padding. *)

  val max_pool1d : ?padding:padding -> arr -> int array -> int array -> arr
  (** [max_pool1d ?padding arr size stride] performs a 1D max pooling operation on the array [arr] 
      using the specified size and stride, with optional padding. *)

  val max_pool2d : ?padding:padding -> arr -> int array -> int array -> arr
  (** [max_pool2d ?padding arr size stride] performs a 2D max pooling operation on the array [arr] 
      using the specified size and stride, with optional padding. *)

  val max_pool3d : ?padding:padding -> arr -> int array -> int array -> arr
  (** [max_pool3d ?padding arr size stride] performs a 3D max pooling operation on the array [arr] 
      using the specified size and stride, with optional padding. *)

  val avg_pool1d : ?padding:padding -> arr -> int array -> int array -> arr
  (** [avg_pool1d ?padding arr size stride] performs a 1D average pooling operation on the array [arr] 
      using the specified size and stride, with optional padding. *)

  val avg_pool2d : ?padding:padding -> arr -> int array -> int array -> arr
  (** [avg_pool2d ?padding arr size stride] performs a 2D average pooling operation on the array [arr] 
      using the specified size and stride, with optional padding. *)

  val avg_pool3d : ?padding:padding -> arr -> int array -> int array -> arr
  (** [avg_pool3d ?padding arr size stride] performs a 3D average pooling operation on the array [arr] 
      using the specified size and stride, with optional padding. *)

  val conv1d_backward_input : arr -> arr -> int array -> arr -> arr
  (** [conv1d_backward_input kernel output_grad stride input_grad] computes the gradient of the input 
      with respect to the 1D convolution, given the kernel, output gradient, and stride. *)

  val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** [conv1d_backward_kernel input output_grad stride kernel_grad] computes the gradient of the kernel 
      with respect to the 1D convolution, given the input, output gradient, and stride. *)

  val conv2d_backward_input : arr -> arr -> int array -> arr -> arr
  (** [conv2d_backward_input kernel output_grad stride input_grad] computes the gradient of the input 
      with respect to the 2D convolution, given the kernel, output gradient, and stride. *)

  val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** [conv2d_backward_kernel input output_grad stride kernel_grad] computes the gradient of the kernel 
      with respect to the 2D convolution, given the input, output gradient, and stride. *)

  val conv3d_backward_input : arr -> arr -> int array -> arr -> arr
  (** [conv3d_backward_input kernel output_grad stride input_grad] computes the gradient of the input 
      with respect to the 3D convolution, given the kernel, output gradient, and stride. *)

  val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** [conv3d_backward_kernel input output_grad stride kernel_grad] computes the gradient of the kernel 
      with respect to the 3D convolution, given the input, output gradient, and stride. *)

  val transpose_conv2d_backward_input : arr -> arr -> int array -> arr -> arr
  (** [transpose_conv2d_backward_input kernel output_grad stride input_grad] computes the gradient of the input 
      with respect to the 2D transposed convolution, given the kernel, output gradient, and stride. *)

  val transpose_conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr
  (** [transpose_conv2d_backward_kernel input output_grad stride kernel_grad] computes the gradient of the kernel 
      with respect to the 2D transposed convolution, given the input, output gradient, and stride. *)

  val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** [max_pool1d_backward padding input size stride output_grad] computes the gradient of the input 
      with respect to the 1D max pooling operation, given the padding, input, size, stride, and output gradient. *)

  val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** [max_pool2d_backward padding input size stride output_grad] computes the gradient of the input 
      with respect to the 2D max pooling operation, given the padding, input, size, stride, and output gradient. *)

  val max_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** [max_pool3d_backward padding input size stride output_grad] computes the gradient of the input 
      with respect to the 3D max pooling operation, given the padding, input, size, stride, and output gradient. *)

  val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** [avg_pool1d_backward padding input size stride output_grad] computes the gradient of the input 
      with respect to the 1D average pooling operation, given the padding, input, size, stride, and output gradient. *)

  val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** [avg_pool2d_backward padding input size stride output_grad] computes the gradient of the input 
      with respect to the 2D average pooling operation, given the padding, input, size, stride, and output gradient. *)

  val avg_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr
  (** [avg_pool3d_backward padding input size stride output_grad] computes the gradient of the input 
      with respect to the 3D average pooling operation, given the padding, input, size, stride, and output gradient. *)

  val row_num : arr -> int
  (** [row_num arr] returns the number of rows in the array [arr]. *)

  val col_num : arr -> int
  (** [col_num arr] returns the number of columns in the array [arr]. *)

  val row : arr -> 'a -> arr
  (** [row arr i] returns the [i]-th row of the array [arr]. *)

  val rows : arr -> int array -> arr
  (** [rows arr indices] returns the rows of the array [arr] specified by [indices]. *)

  val copy_row_to : arr -> 'a -> 'b -> unit
  (** [copy_row_to src src_index dst] copies the row at index [src_index] in the array [src] to the array [dst]. *)

  val copy_col_to : arr -> 'a -> 'b -> unit
  (** [copy_col_to src src_index dst] copies the column at index [src_index] in the array [src] to the array [dst]. *)

  val trace : arr -> elt
  (** [trace arr] returns the trace (sum of the diagonal elements) of the array [arr]. *)

  val dot : arr -> arr -> arr
  (** [dot arr1 arr2] returns the dot product of the arrays [arr1] and [arr2]. *)

  val transpose : ?axis:int array -> arr -> arr
  (** [transpose ?axis arr] returns a new array where the axes of the array [arr] are transposed according to [axis]. *)

  val to_rows : arr -> 'a array
  (** [to_rows arr] converts the array [arr] into an array of rows. *)

  val of_rows : arr array -> arr
  (** [of_rows rows] creates an array by stacking the input array of rows. *)

  val to_cols : arr -> 'a array
  (** [to_cols arr] converts the array [arr] into an array of columns. *)

  val of_cols : arr array -> arr
  (** [of_cols cols] creates an array by stacking the input array of columns. *)

  val of_array : elt array -> int array -> arr
  (** [of_array data shape] creates an array of the specified [shape] from the 1D array [data]. *)

  val of_arrays : elt array array -> arr
  (** [of_arrays data] creates an array from the 2D array [data]. *)


  (** {5 Evaluation functions} *)

  val make_graph : input:attr node array -> output:attr node array -> string -> graph
  (** TODO *)

  val get_inputs : graph -> attr node array
  (** TODO *)

  val get_outputs : graph -> attr node array
  (** TODO *)

  val make_iopair : graph -> attr node array -> attr node array -> unit
  (** TODO *)

  val update_iopair : graph -> unit
  (** TODO *)

  val init_inputs : (attr node -> value) -> graph -> unit
  (** TODO *)

  val optimise : graph -> unit
  (** TODO *)

  val eval_elt : elt array -> unit
  (** TODO *)

  val eval_arr : arr array -> unit
  (** TODO *)

  val eval_graph : graph -> unit
  (** TODO *)
end
