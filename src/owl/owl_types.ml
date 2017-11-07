(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Define the types shared by various modules *)

open Bigarray

(* configure the logger *)
let _ = Log.color_on (); Log.(set_log_level INFO)


(* type of slice definition *)

type index =
  | I of int       (* single index *)
  | L of int list  (* list of indices *)
  | R of int list  (* index range *)

type slice = index list

(* type of slice definition for internal use in owl_slicing module *)

type index_ =
  | I_ of int
  | L_ of int array
  | R_ of int array

type slice_ = index_ array

(* type of padding in conv?d and maxpool operations *)

type padding = SAME | VALID


(* define some constants *)

let _zero : type a b. (a, b) kind -> a = function
  | Float32 -> 0.0 | Complex32 -> Complex.zero
  | Float64 -> 0.0 | Complex64 -> Complex.zero
  | Int8_signed -> 0 | Int8_unsigned -> 0
  | Int16_signed -> 0 | Int16_unsigned -> 0
  | Int32 -> 0l | Int64 -> 0L
  | Int -> 0 | Nativeint -> 0n
  | Char -> '\000'

let _one : type a b. (a, b) kind -> a = function
  | Float32 -> 1.0 | Complex32 -> Complex.one
  | Float64 -> 1.0 | Complex64 -> Complex.one
  | Int8_signed -> 1 | Int8_unsigned -> 1
  | Int16_signed -> 1 | Int16_unsigned -> 1
  | Int32 -> 1l | Int64 -> 1L
  | Int -> 1 | Nativeint -> 1n
  | Char -> '\001'

let _pos_inf : type a b. (a, b) kind -> a = function
  | Float32   -> infinity
  | Float64   -> infinity
  | Complex32 -> Complex.({re = infinity; im = infinity})
  | Complex64 -> Complex.({re = infinity; im = infinity})
  | _         -> failwith "_pos_inf: unsupported operation"

let _neg_inf : type a b. (a, b) kind -> a = function
  | Float32   -> neg_infinity
  | Float64   -> neg_infinity
  | Complex32 -> Complex.({re = neg_infinity; im = neg_infinity})
  | Complex64 -> Complex.({re = neg_infinity; im = neg_infinity})
  | _         -> failwith "_neg_inf: unsupported operation"


(* Module Signature for Ndarray *)

module type NdarraySig = sig

  type arr

  type elt = float

  (* creation and operation functions *)

  val empty : int array -> arr

  val zeros : int array -> arr

  val ones : int array -> arr

  val uniform : ?scale:elt -> int array -> arr

  val gaussian : ?sigma:elt -> int array -> arr

  val bernoulli : ?p:float -> ?seed:int -> int array -> arr

  val shape : arr -> int array

  val numel : arr -> int

  val get : arr -> int array -> elt

  val set : arr -> int array -> elt -> unit

  val get_slice : index list -> arr -> arr

  val set_slice : index list -> arr -> arr -> unit

  val copy : arr -> arr

  val reset : arr -> unit

  val reshape : arr -> int array -> arr

  val tile : arr -> int array -> arr

  val repeat : ?axis:int -> arr -> int -> arr

  val concatenate : ?axis:int -> arr array -> arr

  val split : ?axis:int -> int array -> arr -> arr array

  val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> arr -> unit

  val draw_along_dim0 : arr -> int -> arr * int array

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

  val min' : arr -> elt

  val max' : arr -> elt

  val sum' : arr -> elt

  val sum : ?axis:int -> arr -> arr

  val sum_slices : ?axis:int -> arr -> arr

  val signum : arr -> arr

  val l1norm' : arr -> elt

  val l2norm' : arr -> elt

  val l2norm_sqr' : arr -> elt

  val sigmoid : arr -> arr

  val relu : arr -> arr

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

  val of_arrays : elt array array -> arr

  val draw_rows : ?replacement:bool -> arr -> int -> arr * int array

  val draw_rows2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array

end


module type InpureSig = sig

  include NdarraySig

  val hypot : arr -> arr -> arr

  val fmod : arr -> arr -> arr

  val min2 : arr -> arr -> arr

  val max2 : arr -> arr -> arr

  val add_ : arr -> arr -> unit

  val sub_ : arr -> arr -> unit

  val mul_ : arr -> arr -> unit

  val div_ : arr -> arr -> unit

  val pow_ : arr -> arr -> unit

  val atan2_ : arr -> arr -> unit

  val hypot_ : arr -> arr -> unit

  val fmod_ : arr -> arr -> unit

  val min2_ : arr -> arr -> unit

  val max2_ : arr -> arr -> unit

  val add_scalar_ : arr -> elt -> unit

  val sub_scalar_ : arr -> elt -> unit

  val mul_scalar_ : arr -> elt -> unit

  val div_scalar_ : arr -> elt -> unit

  val pow_scalar_ : arr -> elt -> unit

  val atan2_scalar_ : arr -> elt -> unit

  val fmod_scalar_ : arr -> elt -> unit

  val scalar_add_ : elt -> arr -> unit

  val scalar_sub_ : elt -> arr -> unit

  val scalar_mul_ : elt -> arr -> unit

  val scalar_div_ : elt -> arr -> unit

  val scalar_pow_ : elt -> arr -> unit

  val scalar_atan2_ : elt -> arr -> unit

  val scalar_fmod_ : elt -> arr -> unit

  val neg_ : arr -> unit

  val conj_ : arr -> unit

  val reci_ : arr -> unit

  val signum_ : arr -> unit

  val sqr_ : arr -> unit

  val sqrt_ : arr -> unit

  val cbrt_ : arr -> unit

  val exp_ : arr -> unit

  val exp2_ : arr -> unit

  val exp10_ : arr -> unit

  val expm1_ : arr -> unit

  val log_ : arr -> unit

  val log2_ : arr -> unit

  val log10_ : arr -> unit

  val log1p_ : arr -> unit

  val sin_ : arr -> unit

  val cos_ : arr -> unit

  val tan_ : arr -> unit

  val asin_ : arr -> unit

  val acos_ : arr -> unit

  val atan_ : arr -> unit

  val sinh_ : arr -> unit

  val cosh_ : arr -> unit

  val tanh_ : arr -> unit

  val asinh_ : arr -> unit

  val acosh_ : arr -> unit

  val atanh_ : arr -> unit

  val floor_ : arr -> unit

  val ceil_ : arr -> unit

  val round_ : arr -> unit

  val trunc_ : arr -> unit

  val fix_ : arr -> unit

  val erf_ : arr -> unit

  val erfc_ : arr -> unit

  val relu_ : arr -> unit

  val softplus_ : arr -> unit

  val softsign_ : arr -> unit

  val softmax_ : arr -> unit

  val sigmoid_ : arr -> unit

  val sum : ?axis:int -> arr -> arr

  val prod : ?axis:int -> arr -> arr

  val min : ?axis:int -> arr -> arr

  val max : ?axis:int -> arr -> arr

  val mean : ?axis:int -> arr -> arr

  val var : ?axis:int -> arr -> arr

  val std : ?axis:int -> arr -> arr

  val l1norm : ?axis:int -> arr -> arr

  val l2norm : ?axis:int -> arr -> arr

  val cumsum_ : ?axis:int -> arr -> unit

  val cumprod_ : ?axis:int -> arr -> unit

  val cummin_ : ?axis:int -> arr -> unit

  val cummax_ : ?axis:int -> arr -> unit

end




(* ends here *)
