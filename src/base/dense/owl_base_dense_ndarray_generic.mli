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
(** Refer to :doc:`owl_dense_ndarray_generic` *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Create Ndarrays}  *)

val empty : ('a, 'b) kind -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val create : ('a, 'b) kind -> int array -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val init : ('a, 'b) kind -> int array -> (int -> 'a) -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val uniform : (float, 'b) kind -> ?a:float -> ?b:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val gaussian : (float, 'b) kind -> ?mu:float -> ?sigma:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sequential : (float, 'b) kind -> ?a:float -> ?step:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a  (except p) *)
val bernoulli : (float, 'b) kind -> ?p:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Obtain basic properties}  *)

val shape : ('a, 'b) t -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val num_dims : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val numel : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val kind : ('a, 'b) t -> ('a, 'b) kind
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val strides : ('a, 'b) t -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val slice_size : ('a, 'b) t -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Manipulate Ndarrays}  *)

val get : ('a, 'b) t -> int array -> 'a
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val set : ('a, 'b) t -> int array -> 'a -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val get_slice : int list list -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val set_slice : int list list -> ('a, 'b) t -> ('a, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val reset : (float, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val copy : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val reverse : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val tile : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val repeat : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val concatenate : ?axis:int -> ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val split : ?axis:int -> int array -> ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val draw : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(** {6 Iterate array elements}  *)

val iteri : (int -> 'a -> unit) -> ('a, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val iter : ('a -> unit) -> ('a, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val mapi : (int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val filteri : (int -> 'a -> bool) -> ('a, 'b) t -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val filter : ('a -> bool) -> ('a, 'b) t -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val foldi : ?axis:int -> (int -> 'a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val fold : ?axis:int -> ('a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scani : ?axis:int -> (int -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scan : ?axis:int -> ('a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Examination & Comparison}  *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val for_all : ('a -> bool) -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val is_zero : ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val is_positive : ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val is_negative : ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val is_nonpositive : ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val is_nonnegative : ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val is_normal : (float, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val not_nan : (float, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val not_inf : (float, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val not_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val greater : ('a, 'b) t -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val less : ('a, 'b) t -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val greater_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val less_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_not_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_less : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_greater : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_less_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_greater_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val equal_scalar : ('a, 'b) t -> 'a -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val not_equal_scalar : ('a, 'b) t -> 'a -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val less_scalar : ('a, 'b) t -> 'a -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val greater_scalar : ('a, 'b) t -> 'a -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val less_equal_scalar : ('a, 'b) t -> 'a -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val greater_equal_scalar : ('a, 'b) t -> 'a -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_not_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_less_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_greater_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_less_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val elt_greater_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a, except for eps *)
val approx_equal : ?eps:float -> (float, 'b) t -> (float, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a, except for eps *)
val approx_equal_scalar : ?eps:float -> (float, 'b) t -> float -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a, except for eps *)
val approx_elt_equal : ?eps:float -> (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a, except for eps *)
val approx_elt_equal_scalar : ?eps:float -> (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Input/Output functions}  *)

val of_array : ('a, 'b) kind -> 'a array -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:('a -> string) -> ('a, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Unary math operators }  *)

(* TODO: change float to 'a *)
val sum : ?axis:int -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sum' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val min' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val max' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val abs : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val neg : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val signum : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sqr : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sqrt : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val exp : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log10 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log2 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sin : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val cos : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val tan : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val asin : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val acos : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val atan : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sinh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val cosh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val tanh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val asinh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val acosh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val atanh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val floor : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val ceil : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val round : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val relu : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sigmoid : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val l1norm' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val l2norm' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val l2norm_sqr' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Binary math operators}  *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val pow : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val scalar_pow : float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val pow_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val atan2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_atan2 : float -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val atan2_scalar : (float, 'a) t -> float -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val clip_by_value : ?amin:float -> ?amax:float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Neural network related}  *)

val conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv1d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv1d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool3d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool3d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Helper functions }  *)

(* TODO: change float to 'a *)
val sum_slices : ?axis:int -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


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
