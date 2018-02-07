(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
   N-dimensional array module: including creation, manipulation, and various
   vectorised mathematical operations.
*)

(**
   About the comparison of two complex numbers ``x`` and ``y``, Owl uses the
   following conventions: 1) ``x`` and ``y`` are equal iff both real and imaginary
   parts are equal; 2) ``x`` is less than ``y`` if the magnitude of ``x`` is less than
   the magnitude of ``x``; in case both ``x`` and ``y`` have the same magnitudes, ``x``
   is less than ``x`` if the phase of ``x`` is less than the phase of ``y``; 3) less or
   equal, greater, greater or equal relation can be further defined atop of the
   aforementioned conventions.
*)

open Bigarray

open Owl_types


(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t
(**
   N-dimensional array type, i.e. Bigarray Genarray type.
*)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(**
   Type of the ndarray, e.g., Bigarray.Float32, Bigarray.Complex64, and etc.
*)


(** {6 Create Ndarrays}  *)

val empty : ('a, 'b) kind -> int array -> ('a, 'b) t
(**
   ``empty Bigarray.Float64 [|3;4;5|]`` creates a three diemensional array of
   ``Bigarray.Float64`` type. Each dimension has the following size: 3, 4, and 5.
   The elements in the array are not initialised, they can be any value. ``empty``
   is faster than ``zeros`` to create a ndarray.

   The module only supports the following four types of ndarray: ``Bigarray.Float32``,
   ``Bigarray.Float64``, ``Bigarray.Complex32``, and ``Bigarray.Complex64``.
*)


val create : ('a, 'b) kind -> int array -> 'a -> ('a, 'b) t
(**
   ``create Bigarray.Float64 [|3;4;5|] 2.`` creates a three-diemensional array of
   ``Bigarray.Float64`` type. Each dimension has the following size: 3, 4, and 5.
   The elements in the array are initialised to ``2.``
*)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(**
   ``zeros Bigarray.Complex32 [|3;4;5|]`` creates a three-diemensional array of
   ``Bigarray.Complex32`` type. Each dimension has the following size: 3, 4, and 5.
   The elements in the array are initialised to "zero". Depending on the ``kind``,
   zero can be ``0.`` or ``Complex.zero``.
*)

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t
(**
   ``ones Bigarray.Complex32 [|3;4;5|]`` creates a three-diemensional array of
   ``Bigarray.Complex32`` type. Each dimension has the following size: 3, 4, and 5.
   The elements in the array are initialised to "one". Depending on the ``kind``,
   one can be ``1.`` or ``Complex.one``.
*)

(* TODO: change float to 'a *)
val uniform : (float, 'b) kind -> ?a:float -> ?b:float -> int array -> (float, 'b) t
(**
   ``uniform Bigarray.Float64 [|3;4;5|]`` creates a three-diemensional array
   of type ``Bigarray.Float64``. Each dimension has the following size: 3, 4,
   and 5. The elements in the array follow a uniform distribution ``0,1``.
*)

(* TODO: change float to 'a *)
val gaussian : (float, 'b) kind -> ?mu:float -> ?sigma:float -> int array -> (float, 'b) t
(**
   ``gaussian Float64 [|3;4;5|]`` ...
*)

(* TODO: change float to 'a *)
val sequential : (float, 'b) kind -> ?a:float -> ?step:float -> int array -> (float, 'b) t
(**
   ``sequential Bigarray.Float64 [|3;4;5|] 2.`` creates a three-diemensional
   array of type ``Bigarray.Float64``. Each dimension has the following size: 3, 4,
   and 5. The elements in the array are assigned sequential values.

   ``?a`` specifies the starting value and the default value is zero; whilst
   ``?step`` specifies the step size with default value one.
*)

(* TODO: change float to 'a  (except p) *)
val bernoulli : (float, 'b) kind -> ?p:float -> int array -> (float, 'b) t
(**
   ``bernoulli k ~p:0.3 [|2;3;4|]``
*)

(** {6 Obtain basic properties}  *)

val shape : ('a, 'b) t -> int array
(**
   ``shape x`` returns the shape of ndarray ``x``.
*)

val num_dims : ('a, 'b) t -> int
(**
   ``num_dims x`` returns the number of dimensions of ndarray ``x``.
*)

val numel : ('a, 'b) t -> int
(**
   ``numel x`` returns the number of elements in ``x``.
*)

val kind : ('a, 'b) t -> ('a, 'b) kind
(**
   ``kind x`` returns the type of ndarray ``x``. It is one of the four possible
   values: ``Bigarray.Float32``, ``Bigarray.Float64``, ``Bigarray.Complex32``, and
   ``Bigarray.Complex64``.
*)


(** {6 Manipulate Ndarrays}  *)

val get : ('a, 'b) t -> int array -> 'a
(**
   ``get x i`` returns the value at ``i`` in ``x``. E.g., ``get x [|0;2;1|]`` returns
   the value at ``[|0;2;1|]`` in ``x``.
*)

val set : ('a, 'b) t -> int array -> 'a -> unit
(**
   ``set x i a`` sets the value at ``i`` to ``a`` in ``x``.
*)

val get_slice : int list list -> ('a, 'b) t -> ('a, 'b) t
(**
   ``get_slice axis x`` aims to provide a simpler version of ``get_fancy``.
   This function assumes that every list element in the passed in ``int list list``
   represents a range, i.e., ``R`` constructor.

   E.g., ``[[];[0;3];[0]]`` is equivalent to ``[R []; R [0;3]; R [0]]``.
*)

val set_slice : int list list -> ('a, 'b) t -> ('a, 'b) t -> unit
(**
   ``set_slice axis x y`` aims to provide a simpler version of ``set_fancy``.
   This function assumes that every list element in the passed in ``int list list``
   represents a range, i.e., ``R`` constructor.

   E.g., ``[[];[0;3];[0]]`` is equivalent to ``[R []; R [0;3]; R [0]]``.
*)

(* TODO: change float to 'a *)
val reset : (float, 'b) t -> unit
(**
   ``reset x`` resets all the elements in ``x`` to zero.
*)

val copy : ('a, 'b) t -> ('a, 'b) t
(**
   ``copy x`` makes a copy of ``x``.
*)

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t
(**
   ``reshape x d`` transforms ``x`` into a new shape definted by ``d``. Note the
   ``reshape`` function will not make a copy of ``x``, the returned ndarray shares
   the same memory with the original ``x``.
*)

val flatten : ('a, 'b) t -> ('a, 'b) t
(**
   ``flatten x`` transforms ``x`` into a one-dimsonal array without making a copy.
   Therefore the returned value shares the same memory space with original ``x``.
*)

val reverse : ('a, 'b) t -> ('a, 'b) t
(**
   ``reverse x`` reverse the order of all elements in the flattened ``x`` and
   returns the results in a new ndarray. The original ``x`` remains intact.
*)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(**
   ``transpose ~axis x`` makes a copy of ``x``, then transpose it according to
   ``~axis``. ``~axis`` must be a valid permutation of ``x`` dimension indices. E.g.,
   for a three-dimensional ndarray, it can be ``[2;1;0]``, ``[0;2;1]``, ``[1;2;0]``, and etc.
*)

val tile : ('a, 'b) t -> int array -> ('a, 'b) t
(**
   ``tile x a`` tiles the data in ``x`` according the repitition specified by ``a``.
   This function provides the exact behaviour as ``numpy.tile``, please refer to
   the numpy's online documentation for details.
*)

val repeat : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t
(**
   ``repeat ~axis x a`` repeats the elements along ``axis`` for ``a`` times. The default
   value of ``?axis`` is the highest dimension of ``x``. This function is similar to
   ``numpy.repeat`` except that ``a`` is an integer instead of an array.
*)

val concatenate : ?axis:int -> ('a, 'b) t array -> ('a, 'b) t
(**
   ``concatenate ~axis:2 x`` concatenates an array of ndarrays along the third
   dimension. For the ndarrays in ``x``, they must have the same shape except the
   dimension specified by ``axis``. The default value of ``axis`` is 0, i.e., the
   lowest dimension of a matrix/ndarray.
*)

val split : ?axis:int -> int array -> ('a, 'b) t -> ('a, 'b) t array
(**
   ``split ~axis parts x``
*)

val draw : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(**
   ``draw ~axis x n`` draws ``n`` samples from ``x`` along the specified ``axis``,
   with replacement. ``axis`` is set to zero by default. The return is a tuple
   of both samples and the indices of the selected samples.
*)

(** {6 Iterate array elements}  *)

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(**
   ``map f x`` is similar to ``mapi f x`` except the index is not passed.
*)

(** {6 Examination & Comparison}  *)

val equal : (float, 'b) t -> (float, 'b) t -> bool
(**
   ``equal x y`` returns ``true`` if two ('a, 'b) trices ``x`` and ``y`` are equal.
*)

(* TODO: change float to 'a *)
val elt_equal : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(**
   ``elt_equal x y`` performs element-wise ``=`` comparison of ``x`` and ``y``. Assume
   that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from ``y`` of
   the same position. The function returns another binary (``0`` and ``1``)
   ndarray/matrix wherein ``1`` indicates ``a = b``.

   The function supports broadcast operation.
*)

(* TODO: change float to 'a *)
val elt_greater_equal_scalar : (float, 'b) t -> float -> (float, 'b) t
(**
   ``elt_greater_equal_scalar x a`` performs element-wise ``>=`` comparison of ``x``
   and ``a``. Assume that ``b`` is one element from ``x`` The function returns
   another binary (``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding
   position indicates ``a >= b``, otherwise ``0``.
*)

(** {6 Input/Output functions}  *)

val of_array : ('a, 'b) kind -> 'a array -> int array -> ('a, 'b) t
(**
   ``of_array k x d`` takes an array ``x`` and converts it into an ndarray of type
   ``k`` and shape ``d``.
*)

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:('a -> string) -> ('a, 'b) t -> unit
(**
   ``print x`` prints all the elements in ``x`` as well as their indices. ``max_row``
   and ``max_col`` specify the maximum number of rows and columns to display.
   ``header`` specifies whether or not to print out the headers. ``fmt`` is the
   function to format every element into string.
*)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(**
   ``load k s`` loads previously serialised ndarray from file ``s`` into memory.
   It is necesssary to specify the type of the ndarray with paramater ``k``.
*)


(** {6 Unary math operators }  *)

(* TODO: change float to 'a *)
val sum : ?axis:int -> (float, 'b) t -> (float, 'b) t
(**
   ``sum ~axis x`` sums the elements in ``x`` along specified ``axis``.
*)

(* TODO: change float to 'a *)
val sum' : (float, 'b) t -> float
(**
   ``sum' x`` returns the sumtion of all elements in ``x``.
*)

(* TODO: change float to 'a *)
val min' : (float, 'b) t -> float
(**
   ``min' x`` is similar to ``min`` but returns the minimum of all elements in ``x``
   in scalar value.
*)

(* TODO: change float to 'a *)
val max' : (float, 'b) t -> float
(**
   ``max' x`` is similar to ``max`` but returns the maximum of all elements in ``x``
   in scalar value.
*)

(* TODO: change float to 'a *)
val abs : (float, 'b) t -> (float, 'b) t
(**
   ``abs x`` returns the absolute value of all elements in ``x`` in a new ndarray.
*)

(* TODO: change float to 'a *)
val neg : (float, 'b) t -> (float, 'b) t
(**
   ``neg x`` negates the elements in ``x`` and returns the result in a new ndarray.
*)

val signum : (float, 'a) t -> (float, 'a) t
(**
   ``signum`` computes the sign value (``-1`` for negative numbers, ``0`` (or ``-0``)
   for zero, ``1`` for positive numbers, ``nan`` for ``nan``).
*)

(* TODO: change float to 'a *)
val sqr : (float, 'b) t -> (float, 'b) t
(**
   ``sqr x`` computes the square of the elements in ``x`` and returns the result in
   a new ndarray.
*)

(* TODO: change float to 'a *)
val sqrt : (float, 'b) t -> (float, 'b) t
(**
   ``sqrt x`` computes the square root of the elements in ``x`` and returns the
   result in a new ndarray.
*)

(* TODO: change float to 'a *)
val exp : (float, 'b) t -> (float, 'b) t
(**
   ``exp x`` computes the exponential of the elements in ``x`` and returns the
   result in a new ndarray.
*)

(* TODO: change float to 'a *)
val log : (float, 'b) t -> (float, 'b) t
(**
   ``log x`` computes the logarithm of the elements in ``x`` and returns the
   result in a new ndarray.
*)

(* TODO: change float to 'a *)
val log10 : (float, 'b) t -> (float, 'b) t
(**
   ``log10 x`` computes the base-10 logarithm of the elements in ``x`` and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val log2 : (float, 'b) t -> (float, 'b) t
(**
   ``log2 x`` computes the base-2 logarithm of the elements in ``x`` and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val sin : (float, 'b) t -> (float, 'b) t
(**
   ``sin x`` computes the sine of the elements in ``x`` and returns the result in
   a new ndarray.
*)

(* TODO: change float to 'a *)
val cos : (float, 'b) t -> (float, 'b) t
(**
   ``cos x`` computes the cosine of the elements in ``x`` and returns the result in
   a new ndarray.
*)

(* TODO: change float to 'a *)
val tan : (float, 'b) t -> (float, 'b) t
(**
   ``tan x`` computes the tangent of the elements in ``x`` and returns the result
   in a new ndarray.
*)

(* TODO: change float to 'a *)
val asin : (float, 'b) t -> (float, 'b) t
(**
   ``asin x`` computes the arc sine of the elements in ``x`` and returns the result
   in a new ndarray.
*)

(* TODO: change float to 'a *)
val acos : (float, 'b) t -> (float, 'b) t
(**
   ``acos x`` computes the arc cosine of the elements in ``x`` and returns the
   result in a new ndarray.
*)

(* TODO: change float to 'a *)
val atan : (float, 'b) t -> (float, 'b) t
(**
   ``atan x`` computes the arc tangent of the elements in ``x`` and returns the
   result in a new ndarray.
*)

(* TODO: change float to 'a *)
val sinh : (float, 'b) t -> (float, 'b) t
(**
   ``sinh x`` computes the hyperbolic sine of the elements in ``x`` and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val cosh : (float, 'b) t -> (float, 'b) t
(**
   ``cosh x`` computes the hyperbolic cosine of the elements in ``x`` and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val tanh : (float, 'b) t -> (float, 'b) t
(**
   ``tanh x`` computes the hyperbolic tangent of the elements in ``x`` and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val asinh : (float, 'b) t -> (float, 'b) t
(**
   ``asinh x`` computes the hyperbolic arc sine of the elements in ``x`` and
   returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val acosh : (float, 'b) t -> (float, 'b) t
(**
   ``acosh x`` computes the hyperbolic arc cosine of the elements in ``x`` and
   returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val atanh : (float, 'b) t -> (float, 'b) t
(**
   ``atanh x`` computes the hyperbolic arc tangent of the elements in ``x`` and
   returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val floor : (float, 'b) t -> (float, 'b) t
(**
   ``floor x`` computes the floor of the elements in ``x`` and returns the result
   in a new ndarray.
*)

(* TODO: change float to 'a *)
val ceil : (float, 'b) t -> (float, 'b) t
(**
   ``ceil x`` computes the ceiling of the elements in ``x`` and returns the result
   in a new ndarray.
*)

(* TODO: change float to 'a *)
val round : (float, 'b) t -> (float, 'b) t
(**
   ``round x`` rounds the elements in ``x`` and returns the result in a new ndarray.
*)

val relu : (float, 'a) t -> (float, 'a) t
(**
   ``relu x`` computes the rectified linear unit function ``max(x, 0)`` of the
   elements in ``x`` and returns the result in a new ndarray.
*)

val sigmoid : (float, 'a) t -> (float, 'a) t
(**
   ``sigmoid x`` computes the sigmoid function ``1 / (1 + exp (-x))`` for each
   element in ``x``.
*)

(* TODO: change float to 'a *)
val l1norm' : (float, 'b) t -> float
(**
   ``l1norm x`` calculates the l1-norm of all the element in ``x``.
*)

(* TODO: change float to 'a *)
val l2norm' : (float, 'b) t -> float
(**
   ``l2norm x`` calculates the l2-norm of all the element in ``x``.
*)

val l2norm_sqr' : (float, 'b) t -> float
(**
   ``l2norm_sqr x`` calculates the square of l2-norm (or l2norm, Euclidean norm)
   of all elements in ``x``. The function uses conjugate transpose in the product,
   hence it always returns a float number.
*)

(** {6 Binary math operators}  *)

(* TODO: change float to 'a *)
val add : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(**
   ``add x y`` adds all the elements in ``x`` and ``y`` elementwise, and returns the
   result in a new ndarray.

   General broadcast operation is automatically applied to add/sub/mul/div, etc.
   The function compares the dimension element-wise from the highest to the
   lowest with the following broadcast rules (same as numpy):
   1. equal; 2. either is 1.
*)

(* TODO: change float to 'a *)
val sub : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(**
   ``sub x y`` subtracts all the elements in ``x`` and ``y`` elementwise, and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val mul : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(**
   ``mul x y`` multiplies all the elements in ``x`` and ``y`` elementwise, and
   returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val div : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(**
   ``div x y`` divides all the elements in ``x`` and ``y`` elementwise, and returns
   the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val add_scalar : (float, 'b) t -> float -> (float, 'b) t
(**
   ``add_scalar x a`` adds a scalar value ``a`` to each element in ``x``, and
   returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val sub_scalar : (float, 'b) t -> float -> (float, 'b) t
(**
   ``sub_scalar x a`` subtracts a scalar value ``a`` from each element in ``x``,
   and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val mul_scalar : (float, 'b) t -> float -> (float, 'b) t
(**
   ``mul_scalar x a`` multiplies each element in ``x`` by a scalar value ``a``,
   and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val div_scalar : (float, 'b) t -> float -> (float, 'b) t
(**
   ``div_scalar x a`` divides each element in ``x`` by a scalar value ``a``, and
   returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val scalar_add : float -> (float, 'b) t -> (float, 'b) t
(**
   ``scalar_add a x`` adds a scalar value ``a`` to each element in ``x``,
   and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val scalar_sub : float -> (float, 'b) t -> (float, 'b) t
(**
   ``scalar_sub a x`` subtracts each element in ``x`` from a scalar value ``a``,
   and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val scalar_mul : float -> (float, 'b) t -> (float, 'b) t
(**
   ``scalar_mul a x`` multiplies each element in ``x`` by a scalar value ``a``,
   and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val scalar_div : float -> (float, 'b) t -> (float, 'b) t
(**
   ``scalar_div a x`` divides a scalar value ``a`` by each element in ``x``,
   and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val pow : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(**
   ``pow x y`` computes ``pow(a, b)`` of all the elements in ``x`` and ``y``
   elementwise, and returns the result in a new ndarray.
*)

(* TODO: change float to 'a *)
val scalar_pow : float -> (float, 'b) t -> (float, 'b) t
(**
   ``scalar_pow a x`` computes the power value of a scalar value ``a`` using the elements
   in a ndarray ``x``.
*)

(* TODO: change float to 'a *)
val pow_scalar : (float, 'b) t -> float -> (float, 'b) t
(**
   ``pow_scalar x a`` computes each element in ``x`` power to ``a``.
*)

val atan2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(**
   ``atan2 x y`` computes ``atan2(a, b)`` of all the elements in ``x`` and ``y``
   elementwise, and returns the result in a new ndarray.
*)

val scalar_atan2 : float -> (float, 'a) t -> (float, 'a) t
(**
   ``scalar_atan2 a x``
*)

val atan2_scalar : (float, 'a) t -> float -> (float, 'a) t
(**
   ``scalar_atan2 x a``
*)

(* TODO: change float to 'a *)
val clip_by_value : ?amin:float -> ?amax:float -> (float, 'b) t -> (float, 'b) t
(**
   ``clip_by_value ~amin ~amax x`` clips the elements in ``x`` based on ``amin`` and
   ``amax``. The elements smaller than ``amin`` will be set to ``amin``, and the
   elements greater than ``amax`` will be set to ``amax``.
*)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(**
   ``clip_by_l2norm t x`` clips the ``x`` according to the threshold set by ``t``.
*)


(** {6 Neural network related}  *)

val conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(**
   []
*)

val conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(**
   []
*)

val conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(**
   []
*)

val max_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
   []
*)

val max_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
   []
*)

val max_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
   []
*)

val avg_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
   []
*)

val avg_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
   []
*)

val avg_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
   []
*)

val conv1d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val conv1d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val conv2d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val conv2d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val conv3d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val conv3d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val max_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val max_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val avg_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)

val avg_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
   []
*)


(** {6 Helper functions }  *)

(**
   The following functions are helper functions for some other functions in
   both Ndarray and Ndview modules. In general, you are not supposed to use
   these functions directly.
*)

(* TODO: change float to 'a *)
val sum_slices : ?axis:int -> (float, 'b) t -> (float, 'b) t
(**
   ``sum_slices ~axis:2 x`` for ``x`` of ``[|2;3;4;5|]``, it returns an ndarray of
   shape ``[|4;5|]``. Currently, the operation is done using ``gemm``, fast but uses
   more memory.
*)

(** {6 Matrix functions}  *)

val row_num : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_matrix_generic` *)

val col_num : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_matrix_generic` *)

val row : ('a, 'b) t -> int -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val rows : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_row_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_col_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

(* TODO: change float to 'a *)
val dot : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

(* TODO: change float to 'a *)
val inv : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val trace : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_matrix_generic` *)

val to_rows : ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_rows : ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_arrays : ('a, 'b) kind -> 'a array array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_rows : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_rows2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)

(* ends here *)
