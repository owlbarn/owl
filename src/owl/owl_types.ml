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

  val sum' : arr -> elt

  val sum : ?axis:int -> arr -> arr

  val sum_slices : ?axis:int -> arr -> arr

  val signum : arr -> arr

  val l1norm : arr -> elt

  val l2norm : arr -> elt

  val l2norm_sqr : arr -> elt

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

  (** {6 Neural network related functions} *)

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

end


(* Module Signature Matirx *)

module type MatrixSig = sig

  type mat
  type elt = float

  (* creation and operation functions *)

  val create : int -> int -> elt -> mat

  val empty : int -> int -> mat

  val zeros : int -> int -> mat

  val ones : int -> int -> mat

  val uniform : ?scale:elt -> int -> int -> mat

  val gaussian : ?sigma:elt -> int -> int -> mat

  val bernoulli : ?p:float -> ?seed:int -> int -> int -> mat

  val shape : mat -> int * int

  val row_num : mat -> int

  val col_num : mat -> int

  val numel : mat -> int

  val get : mat -> int -> int -> elt

  val set : mat -> int -> int -> elt -> unit

  val get_slice : index list -> mat -> mat

  val set_slice : index list -> mat -> mat -> unit

  val row : mat -> int -> mat

  val rows : mat -> int array -> mat

  val copy : mat -> mat

  val reset : mat -> unit

  val reshape : mat -> int array -> mat

  val tile : mat -> int array -> mat

  val repeat : ?axis:int -> mat -> int -> mat

  val concatenate : ?axis:int -> mat array -> mat

  val split : ?axis:int -> int array -> mat -> mat array

  val copy_row_to : mat -> mat -> int -> unit

  val copy_col_to : mat -> mat -> int -> unit

  val iteri : (int -> int -> elt -> unit) -> mat -> unit

  val mapi : (int -> int -> elt -> elt) -> mat -> mat

  val iteri_rows : (int -> mat -> unit) -> mat -> unit

  val iter2_rows : (mat -> mat -> unit) -> mat -> mat -> unit

  val draw_rows : ?replacement:bool -> mat -> int -> mat * int array

  val draw_rows2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

  val of_arrays : elt array array -> mat

  val of_rows: mat array -> mat

  val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> mat -> unit

  (* mathematical functions *)

  val min' : mat -> elt

  val max' : mat -> elt

  val abs : mat -> mat

  val neg : mat -> mat

  val floor : mat -> mat

  val ceil : mat -> mat

  val round : mat -> mat

  val sqr : mat -> mat

  val sqrt : mat -> mat

  val log : mat -> mat

  val log2 : mat -> mat

  val log10 : mat -> mat

  val exp : mat -> mat

  val sin : mat -> mat

  val cos : mat -> mat

  val tan : mat -> mat

  val sinh : mat -> mat

  val cosh : mat -> mat

  val tanh : mat -> mat

  val asin : mat -> mat

  val acos : mat -> mat

  val atan : mat -> mat

  val asinh : mat -> mat

  val acosh : mat -> mat

  val atanh : mat -> mat

  val inv : mat -> mat

  val trace : mat -> elt

  val sum' : mat -> elt

  val sum : ?axis:int -> mat -> mat

  val sum_rows : mat -> mat

  val signum : mat -> mat

  val transpose : mat -> mat

  val l1norm : mat -> elt

  val l2norm : mat -> elt

  val l2norm_sqr : mat -> elt

  val sigmoid : mat -> mat

  val relu : mat -> mat

  val clip_by_l2norm : elt -> mat -> mat

  val pow : mat -> mat -> mat

  val scalar_pow : elt -> mat -> mat

  val pow_scalar : mat -> elt -> mat

  val atan2 : mat -> mat -> mat

  val scalar_atan2 : elt -> mat -> mat

  val atan2_scalar : mat -> elt -> mat

  val add : mat -> mat -> mat

  val sub : mat -> mat -> mat

  val mul : mat -> mat -> mat

  val div : mat -> mat -> mat

  val add_scalar : mat -> elt -> mat

  val sub_scalar : mat -> elt -> mat

  val mul_scalar : mat -> elt -> mat

  val div_scalar : mat -> elt -> mat

  val scalar_add : elt -> mat -> mat

  val scalar_sub : elt -> mat -> mat

  val scalar_mul : elt -> mat -> mat

  val scalar_div : elt -> mat -> mat

  val dot : mat -> mat -> mat

  val elt_greater_equal_scalar : mat -> elt -> mat

end



module type InpureSig = sig

  type arr

  type elt

  val shape : arr -> int array

  val copy : arr -> arr

  val add : arr -> arr -> arr

  val sub : arr -> arr -> arr

  val mul : arr -> arr -> arr

  val div : arr -> arr -> arr

  val add_ : arr -> arr -> unit

  val sub_ : arr -> arr -> unit

  val mul_ : arr -> arr -> unit

  val div_ : arr -> arr -> unit

  val sin_ : arr -> unit

  val cos_ : arr -> unit

end




(* ends here *)
