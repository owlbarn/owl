(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Algodiff: algorithmic differentiation module *)

open Owl_types


(** {The functor used to generate Algodiff module of various precisions.
  Currently, Dense.Matrix.S and Dense.Matrix.D can be plugged in to suppport
  32-bit and 64-bit two precisions.} *)

module Make
  (M : MatrixSig)
  (A : NdarraySig with type elt = M.elt and type arr = M.arr)
  : sig

  type arr = A.arr
  type mat = M.mat
  type elt = M.elt

  type trace_op

  type t =
    | F   of float                                  (* constructor of float numbers *)
    | Arr of arr                                    (* constructor of ndarrays *)
    | Mat of mat                                    (* constructor of matrices *)
    | DF  of t * t * int                            (* primal, tangent, tag *)
    | DR  of t * t ref * trace_op * int ref * int   (* primal, adjoint, op, fanout, tag *)


  (* mathematical functions supported by Algodiff *)

  module Maths : sig

    val ( + )  : t -> t -> t

    val ( - )  : t -> t -> t

    val ( * )  : t -> t -> t

    val ( / )  : t -> t -> t

    val ( *@ )  : t -> t -> t

    val ( ** )  : t -> t -> t

    val add : t -> t -> t

    val sub : t -> t -> t

    val mul : t -> t -> t

    val div : t -> t -> t

    val dot : t -> t -> t

    val pow : t -> t -> t

    val atan2 : t -> t -> t

    val min2 : t -> t -> t

    val max2 : t -> t -> t

    val cross_entropy : t -> t -> t

    val inv : t -> t

    val neg : t -> t

    val abs : t -> t

    val signum : t -> t

    val floor : t -> t

    val ceil : t -> t

    val round : t -> t

    val sqr : t -> t

    val sqrt : t -> t

    val log : t -> t

    val log2 : t -> t

    val log10 : t -> t

    val exp : t -> t

    val sin : t -> t

    val cos : t -> t

    val tan : t -> t

    val sinh : t -> t

    val cosh : t -> t

    val tanh : t -> t

    val asin : t -> t

    val acos : t -> t

    val atan : t -> t

    val asinh : t -> t

    val acosh : t -> t

    val atanh : t -> t

    val sum : t -> t

    val sum_ : ?axis:int -> t -> t

    val average : t -> t

    val transpose : t -> t

    val l1norm : t -> t

    val l2norm : t -> t

    val l2norm_sqr : t -> t

    val sigmoid : t -> t

    val relu : t -> t

    val softplus : t -> t

    val softsign: t -> t

    val softmax : t -> t

    val dropout : ?rate:float -> ?seed:int -> t -> t

    val conv1d : ?padding:padding -> t -> t -> int array -> t

    val conv2d : ?padding:padding -> t -> t -> int array -> t

    val conv3d : ?padding:padding -> t -> t -> int array -> t

    val max_pool1d : padding -> t -> int array -> int array -> t

    val max_pool2d : padding -> t -> int array -> int array -> t

    val avg_pool1d : padding -> t -> int array -> int array -> t

    val avg_pool2d : padding -> t -> int array -> int array -> t

    val reshape : t -> int array -> t

    val flatten : t -> t

    val concat : int -> t -> t -> t

    val mat_to_arr : t -> t

    val arr_to_mat : t -> t

    val get_slice: index list -> t -> t

    val set_slice : index list -> t -> t -> t

  end


  (** {Simple wrappers of matrix and ndarray module, so you don't have to pack
    and unpack stuff all the time. Some operations just interface to those
    already defined in the Maths module.} *)

  module Mat : sig

    val empty : int -> int -> t

    val zeros : int -> int -> t

    val ones : int -> int -> t

    val uniform : ?scale:float -> int -> int -> t

    val gaussian : ?sigma:float -> int -> int -> t

    val shape : t -> int * int

    val numel : t -> int

    val row_num : t -> int

    val col_num : t -> int

    val reset : t -> unit

    val reshape : int -> int -> t -> t

    val get : t -> int -> int -> t

    val set : t -> int -> int -> t -> t

    val row : t -> int -> t

    val add : t -> t -> t

    val sub : t -> t -> t

    val mul : t -> t -> t

    val div : t -> t -> t

    val dot : t -> t -> t

    val clip_by_l2norm : t -> t -> t

    val iteri : (int -> int -> elt -> unit) -> t -> unit

    val mapi : (int -> int -> elt -> elt) -> t -> t

    val iter2_rows : (t -> t -> unit) -> t -> t -> unit

    val map_by_row : (t -> t) -> t -> t

    val draw_rows2 : ?replacement:bool -> t -> t -> int -> t * t * int array

    val of_arrays : elt array array -> t

    val print : t -> unit

  end


  module Arr : sig

    val empty : int array -> t

    val zeros : int array -> t

    val ones : int array -> t

    val uniform : ?scale:float -> int array -> t

    val gaussian : ?sigma:float -> int array -> t

    val shape : t -> int array

    val numel : t -> int

    val reset : t -> unit

    val reshape : t -> int array -> t

    val add : t -> t -> t

    val sub : t -> t -> t

    val mul : t -> t -> t

    val div : t -> t -> t

    val print : t -> unit 

  end


  (* core Algodiff functions for algorithmic differentiation *)

  val diff : (t -> t) -> t -> t
  (** [diff f x] returns the exat derivative of a function [f : scalar -> scalar]
    at point [x]. Simply calling [diff f] will return its derivative function [g]
    of the same type, i.e. [g : scalar -> scalar].

    Keep calling this function will give you higher-order derivatives of [f], i.e.
    [f |> diff |> diff |> diff |> ...] *)

  val diff' : (t -> t) -> t -> t * t
  (** similar to [diff], but return [(f x, diff f x)]. *)

  val grad : (t -> t) -> t -> t
  (** gradient of [f] : (vector -> scalar) at [x], reverse ad. *)

  val grad' : (t -> t) -> t -> t * t
  (** similar to [grad], but return [(f x, grad f x)]. *)

  val jacobian : (t -> t) -> t -> t
  (** jacobian of [f] : (vector -> vector) at [x], both [x] and [y] are row vectors. *)

  val jacobian' : (t -> t) -> t -> t * t
  (** similar to [jacobian], but return [(f x, jacobian f x)] *)

  val jacobianv : (t -> t) -> t -> t -> t
  (** jacobian vector product of [f] : (vector -> vector) at [x] along [v],
    forward ad. Namely, it calcultes [(jacobian x) v] *)

  val jacobianv' : (t -> t) -> t -> t -> t * t
  (** similar to [jacobianv'], but return [(f x, jacobianv f x v)] *)

  val jacobianTv : (t -> t) -> t -> t -> t
  (** transposed jacobian vector product of [f] : (vector -> vector) at [x]
    along [v], backward ad. Namely, it calculates [transpose ((jacobianv f x v))]. *)

  val jacobianTv' : (t -> t) -> t -> t -> t * t
  (** similar to [jacobianTv], but return [(f x, transpose (jacobianv f x v))] *)

  val hessian : (t -> t) -> t -> t
  (** hessian of [f] : (scalar -> scalar) at [x]. *)

  val hessian' : (t -> t) -> t -> t * t
  (** simiarl to [hessian], but return [(f x, hessian f x)] *)

  val hessianv : (t -> t) -> t -> t -> t
  (** hessian vector product of [f] : (scalar -> scalar) at [x] along [v].
    Namely, it calculates [(hessian x) v]. *)

  val hessianv' : (t -> t) -> t -> t -> t * t
  (** similar to [hessianv], but return [(f x, hessianv f x v)]. *)

  val laplacian : (t -> t) -> t -> t
  (** laplacian of [f] : (scalar -> scalar) at [x]. *)

  val laplacian' : (t -> t) -> t -> t * t
  (** simiar to [laplacian], but return [(f x, laplacian f x)]. *)

  val gradhessian : (t -> t) -> t -> t * t
  (** return [(grad f x, hessian f x)], [f] : (scalar -> scalar) *)

  val gradhessian' : (t -> t) -> t -> t * t * t
  (** return [(f x, grad f x, hessian f x)] *)

  val gradhessianv : (t -> t) -> t -> t -> t * t
  (** return [(grad f x v, hessian f x v)] *)

  val gradhessianv' : (t -> t) -> t -> t -> t * t * t
  (** return [(f x, grad f x v, hessian f x v)] *)


  (* low-level functions, only use them if you know what you are doing. *)

  val pack_flt : elt -> t

  val unpack_flt : t -> elt

  val pack_arr : arr -> t

  val unpack_arr : t -> arr

  val pack_mat : mat -> t

  val unpack_mat : t -> mat

  val tag : unit -> int

  val primal : t -> t

  val primal' : t -> t

  val adjval : t -> t

  val adjref : t -> t ref

  val tangent : t -> t

  val make_forward : t -> t -> int -> t

  val make_reverse : t -> int -> t

  val reverse_prop : t -> t -> unit

  val type_info : t -> string

  val shape : t -> int array


  (* other functions, without tracking gradient *)

  val clip_by_l2norm : elt -> t -> t


end
