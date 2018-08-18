(*
 * OWL - OCaml Scientific and Engineering Computing
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

val copy_ : out:('a, 'b) t -> ('a, 'b) t -> unit
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

val repeat : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val concatenate : ?axis:int -> ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val split : ?axis:int -> int array -> ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val draw : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val one_hot : int -> ('a, 'b) t -> ('a, 'b) t
(** TODO: not implemented *)


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

val min : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sum : ?axis:int -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sum' : ('a, 'b) t -> 'a
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sum_reduce : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val min' : ('a, 'b) t -> 'a
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val max' : ('a, 'b) t -> 'a
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val abs : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conj : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val neg : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val reci : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val signum : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sqr : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sqrt : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val cbrt : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val exp : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val exp2 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val exp10 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val expm1 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log2 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log10 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log1p : (float, 'b) t -> (float, 'b) t
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

val trunc : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val fix : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val erf : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val erfc : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val relu : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val softsign : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val softplus : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sigmoid : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val softmax : ?axis:int -> (float, 'a) t -> (float, 'a) t
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

val min2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val fmod : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val fmod_scalar : (float, 'a) t -> float -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_fmod : float -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val clip_by_value : ?amin:float -> ?amax:float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val fma : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Neural network related}  *)

val conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
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

val dilated_conv1d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv1d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv2d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv2d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv3d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val dilated_conv3d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv1d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv1d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv2d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv2d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv3d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose_conv3d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
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

(*
(** {6 In-place modification}  *)

val create_ : out:('a, 'b) t -> 'a -> unit
(** TODO *)

val uniform_ : ?a:'a -> ?b:'a -> out:('a, 'b) t -> unit
(** TODO *)

val gaussian_ : ?mu:'a -> ?sigma:'a -> out:('a, 'b) t -> unit
(** TODO *)

val sequential_ :?a:'a -> ?step:'a -> out:('a, 'b) t -> unit
(** TODO *)

val bernoulli_ : ?p:float -> out:('a, 'b) t -> unit
(** TODO *)

val zeros_ : out:('a, 'b) t -> unit
(** TODO *)

val ones_ : out:('a, 'b) t -> unit
(** TODO *)

val one_hot_ : out:('a, 'b) t -> int -> ('a, 'b) t -> unit
(** TODO *)

val sort_ : ('a, 'b) t -> unit
(** TODO *)

val get_fancy_ : out:('a, 'b) t -> index list -> ('a, 'b) t -> unit
(** TODO *)

val set_fancy_ : out:('a, 'b) t -> index list -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val get_slice_ : out:('a, 'b) t -> int list list -> ('a, 'b) t -> unit
(** TODO *)

val set_slice_ : out:('a, 'b) t -> int list list -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val copy_ : out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val reshape_ : out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val reverse_ : out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val transpose_ : out:('a, 'b) t -> ?axis:int array -> ('a, 'b) t -> unit
(** TODO *)

val repeat_ : out:('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val tile_ : out:('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val sum_ : out:('a, 'b) t -> axis:int -> ('a, 'b) t -> unit
(** TODO *)

val min_ : out:('a, 'b) t -> axis:int -> ('a, 'b) t -> unit
(** TODO *)

val max_ : out:('a, 'b) t -> axis:int -> ('a, 'b) t -> unit
(** TODO *)

val add_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val sub_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val mul_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val div_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val pow_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val atan2_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val hypot_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val fmod_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val min2_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val max2_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val add_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val sub_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val mul_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val div_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val pow_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val atan2_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val fmod_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val scalar_add_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val scalar_sub_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val scalar_mul_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val scalar_div_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val scalar_pow_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val scalar_atan2_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val scalar_fmod_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val clip_by_value_ : ?out:('a, 'b) t -> ?amin:'a -> ?amax:'a -> ('a, 'b) t -> unit
(** TODO *)

val clip_by_l2norm_ : ?out:('a, 'b) t -> 'a -> ('a, 'b) t -> unit
(** TODO *)

val fma_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val dot_ : ?transa:bool -> ?transb:bool -> ?alpha:'a -> ?beta:'a -> c:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val conj_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val abs_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val neg_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val reci_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val signum_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val sqr_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val sqrt_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val cbrt_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val exp_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val exp2_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val exp10_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val expm1_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val log_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val log2_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val log10_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val log1p_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val sin_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val cos_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val tan_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val asin_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val acos_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val atan_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val sinh_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val cosh_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val tanh_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val asinh_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val acosh_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val atanh_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val floor_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val ceil_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val round_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val trunc_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val fix_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val erf_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val erfc_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val relu_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val softplus_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val softsign_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val sigmoid_ : ?out:('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val softmax_ : ?out:('a, 'b) t -> ?axis:int -> ('a, 'b) t -> unit
(** TODO *)

val cumsum_ : ?out:('a, 'b) t -> ?axis:int -> ('a, 'b) t -> unit
(** TODO *)

val cumprod_ : ?out:('a, 'b) t -> ?axis:int -> ('a, 'b) t -> unit
(** TODO *)

val cummin_ : ?out:('a, 'b) t -> ?axis:int -> ('a, 'b) t -> unit
(** TODO *)

val cummax_ : ?out:('a, 'b) t -> ?axis:int -> ('a, 'b) t -> unit
(** TODO *)

val dropout_ : ?out:('a, 'b) t -> ?rate:float -> ('a, 'b) t -> unit
(** TODO *)

val elt_equal_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val elt_not_equal_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val elt_less_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val elt_greater_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val elt_less_equal_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val elt_greater_equal_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit
(** TODO *)

val elt_equal_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val elt_not_equal_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val elt_less_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val elt_greater_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val elt_less_equal_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val elt_greater_equal_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit
(** TODO *)

val conv1d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val conv2d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val conv3d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val dilated_conv1d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val dilated_conv2d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val dilated_conv3d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val transpose_conv1d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val transpose_conv2d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val transpose_conv3d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> ('a, 'b) t -> int array -> unit
(** TODO *)

val max_pool1d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val max_pool2d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val max_pool3d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val avg_pool1d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val avg_pool2d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val avg_pool3d_ : out:('a, 'b) t -> ?padding:padding -> ('a, 'b) t -> int array -> int array -> unit
(** TODO *)

val conv1d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val conv1d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val conv2d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val conv2d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val conv3d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val conv3d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val dilated_conv1d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val dilated_conv1d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val dilated_conv2d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val dilated_conv2d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val dilated_conv3d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val dilated_conv3d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val transpose_conv1d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val transpose_conv1d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val transpose_conv2d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val transpose_conv2d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val transpose_conv3d_backward_input_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val transpose_conv3d_backward_kernel_ : out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> int array -> ('a, 'b) t -> unit
(** TODO *)

val max_pool1d_backward_ : out:('a, 'b) t -> padding -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val max_pool2d_backward_ : out:('a, 'b) t -> padding -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val max_pool3d_backward_ : out:('a, 'b) t -> padding -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val avg_pool1d_backward_ : out:('a, 'b) t -> padding -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val avg_pool2d_backward_ : out:('a, 'b) t -> padding -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val avg_pool3d_backward_ : out:('a, 'b) t -> padding -> ('a, 'b) t -> int array -> int array -> ('a, 'b) t -> unit
(** TODO *)

val fused_adagrad_ : ?out:('a, 'b) t -> rate:'a -> eps:'a -> ('a, 'b) t -> unit
(** TODO *)
*)

(** {6 Helper functions}  *)

val float_to_elt : 'a -> 'a
(** Identity function to deal with the type conversion required by other functors. *)

val elt_to_float : 'a -> 'a
(** Identity function to deal with the type conversion required by other functors. *)


(* ends here *)
