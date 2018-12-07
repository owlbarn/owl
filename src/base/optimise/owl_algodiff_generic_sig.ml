(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module type Sig = sig

  module A : Owl_types_ndarray_algodiff.Sig


  (** {6 Type definition} *)


  type trace_op
  (** Trace type *)

  type t =
    | F   of A.elt                                  (* constructor of float numbers *)
    | Arr of A.arr                                  (* constructor of ndarrays *)
    | Pair of t * t
    | DF  of t * t * int                            (* primal, tangent, tag *)
    | DR  of t * t ref * trace_op * int ref * int   (* primal, adjoint, op, fanout, tag *)
  (** Abstract number type *)


  (** {6 Supported Maths functions} *)

  module Maths : sig

    val ( + )  : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( - )  : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( * )  : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( / )  : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( *@ )  : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( ** )  : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val add : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sub : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val mul : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val div : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dot : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val pow : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val atan2 : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val min2 : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max2 : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val cross_entropy : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val inv : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val qr : t -> t 
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val neg : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val abs : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val signum : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val floor : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ceil : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val round : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sqr : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sqrt : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val log : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val log2 : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val log10 : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val exp : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sin : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val cos : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val tan : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sinh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val cosh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val tanh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val asin : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val acos : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val atan : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val asinh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val acosh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val atanh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sum' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sum : ?axis:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sum_reduce : ?axis:int array -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val mean : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val l1norm' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val l2norm' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val l2norm_sqr' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sigmoid : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val relu : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val softplus : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val softsign: t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val softmax : ?axis:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dropout : ?rate:float -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val conv1d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val conv2d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val conv3d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dilated_conv1d : ?padding:padding -> t -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dilated_conv2d : ?padding:padding -> t -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dilated_conv3d : ?padding:padding -> t -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose_conv1d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose_conv2d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose_conv3d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max_pool1d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max_pool2d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max_pool3d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val avg_pool1d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val avg_pool2d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val avg_pool3d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val upsampling2d : t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val pad : ?v:A.elt -> int list list -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val reshape : t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val flatten : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val concat : int -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val get_slice : int list list -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val set_slice : int list list -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val diag : ?k:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val trace : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

  end


  (* Simple wrappers of matrix and ndarray module, so you don't have to pack
    and unpack stuff all the time. Some operations just interface to those
    already defined in the Maths module. *)

  module Mat : sig

    val empty : int -> int -> t

    val zeros : int -> int -> t

    val ones : int -> int -> t

    val uniform : ?a:A.elt -> ?b:A.elt -> int -> int -> t

    val gaussian : ?mu:A.elt -> ?sigma:A.elt -> int -> int -> t

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

    val map_by_row : (t -> t) -> t -> t

    val of_arrays : A.elt array array -> t

    val print : t -> unit

  end


  module Arr : sig

    val empty : int array -> t

    val zeros : int array -> t

    val ones : int array -> t

    val uniform : ?a:A.elt -> ?b:A.elt -> int array -> t

    val gaussian : ?mu:A.elt -> ?sigma:A.elt -> int array -> t

    val shape : t -> int array

    val numel : t -> int

    val reset : t -> unit

    val reshape : t -> int array -> t

    val add : t -> t -> t

    val sub : t -> t -> t

    val mul : t -> t -> t

    val div : t -> t -> t

  end


  (** {6 Core functions} *)

  val diff : (t -> t) -> t -> t
  (**
``diff f x`` returns the exat derivative of a function ``f : scalar -> scalar``
at point ``x``. Simply calling ``diff f`` will return its derivative function ``g``
of the same type, i.e. ``g : scalar -> scalar``.

Keep calling this function will give you higher-order derivatives of ``f``, i.e.
``f |> diff |> diff |> diff |> ...``
   *)

  val diff' : (t -> t) -> t -> t * t
  (** similar to ``diff``, but return ``(f x, diff f x)``. *)

  val grad : (t -> t) -> t -> t
  (** gradient of ``f`` : (vector -> scalar) at ``x``, reverse ad. *)

  val grad' : (t -> t) -> t -> t * t
  (** similar to ``grad``, but return ``(f x, grad f x)``. *)

  val jacobian : (t -> t) -> t -> t
  (** jacobian of ``f`` : (vector -> vector) at ``x``, both ``x`` and ``y`` are row vectors. *)

  val jacobian' : (t -> t) -> t -> t * t
  (** similar to ``jacobian``, but return ``(f x, jacobian f x)`` *)

  val jacobianv : (t -> t) -> t -> t -> t
  (**
jacobian vector product of ``f`` : (vector -> vector) at ``x`` along ``v``,
forward ad. Namely, it calcultes ``(jacobian x) v``
  *)

  val jacobianv' : (t -> t) -> t -> t -> t * t
  (** similar to ``jacobianv'``, but return ``(f x, jacobianv f x v)`` *)

  val jacobianTv : (t -> t) -> t -> t -> t
  (**
transposed jacobian vector product of ``f : (vector -> vector)`` at ``x``
along ``v``, backward ad. Namely, it calculates ``transpose ((jacobianv f x v))``.
  *)

  val jacobianTv' : (t -> t) -> t -> t -> t * t
  (** similar to ``jacobianTv``, but return ``(f x, transpose (jacobianv f x v))`` *)

  val hessian : (t -> t) -> t -> t
  (** hessian of ``f`` : (scalar -> scalar) at ``x``. *)

  val hessian' : (t -> t) -> t -> t * t
  (** simiarl to ``hessian``, but return ``(f x, hessian f x)`` *)

  val hessianv : (t -> t) -> t -> t -> t
  (**
hessian vector product of ``f`` : (scalar -> scalar) at ``x`` along ``v``.
Namely, it calculates ``(hessian x) v``.
   *)

  val hessianv' : (t -> t) -> t -> t -> t * t
  (** similar to ``hessianv``, but return ``(f x, hessianv f x v)``. *)

  val laplacian : (t -> t) -> t -> t
  (** laplacian of ``f : (scalar -> scalar)`` at ``x``. *)

  val laplacian' : (t -> t) -> t -> t * t
  (** simiar to ``laplacian``, but return ``(f x, laplacian f x)``. *)

  val gradhessian : (t -> t) -> t -> t * t
  (** return ``(grad f x, hessian f x)``, ``f : (scalar -> scalar)`` *)

  val gradhessian' : (t -> t) -> t -> t * t * t
  (** return ``(f x, grad f x, hessian f x)`` *)

  val gradhessianv : (t -> t) -> t -> t -> t * t
  (** return ``(grad f x v, hessian f x v)`` *)

  val gradhessianv' : (t -> t) -> t -> t -> t * t * t
  (** return ``(f x, grad f x v, hessian f x v)`` *)


  (** {6 Low-level functions} *)

  (* low-level functions, only use them if you know what you are doing. *)

  val pack_elt : A.elt -> t
  (** convert from ``elt`` type to ``t`` type. *)

  val unpack_elt : t -> A.elt
  (** convert from ``t`` type to ``elt`` type. *)

  val pack_flt : float -> t
  (** convert from ``float`` type to ``t`` type. *)

  val unpack_flt : t -> float
  (** convert from ``t`` type to ``float`` type. *)

  val pack_arr : A.arr -> t
  (** convert from ``arr`` type to ``t`` type. *)

  val unpack_arr : t -> A.arr
  (** convert from ``t`` type to ``arr`` type. *)

  val tag : unit -> int
  (** TODO *)

  val primal : t -> t
  (** TODO *)

  val primal' : t -> t
  (** TODO *)

  val adjval : t -> t
  (** TODO *)

  val adjref : t -> t ref
  (** TODO *)

  val tangent : t -> t
  (** TODO *)

  val make_forward : t -> t -> int -> t
  (** TODO *)

  val make_reverse : t -> int -> t
  (** TODO *)

  val reverse_prop : t -> t -> unit
  (** TODO *)

  val type_info : t -> string
  (** TODO *)

  val shape : t -> int array
  (** TODO *)

  val copy_primal' : t -> t
  (** TODO *)

  val _f : float -> t
  (** A shortcut function for ``F A.(float_to_elt x)``. *)

  val clip_by_value : amin:A.elt -> amax:A.elt -> t -> t
  (** other functions, without tracking gradient *)

  val clip_by_l2norm : A.elt -> t -> t
  (** other functions, without tracking gradient *)


  (** {6 Helper functions} *)

  val to_trace : t list -> string
  (**
``to_trace [t0; t1; ...]`` outputs the trace of computation graph on the
terminal in a human-readable format.
   *)

  val to_dot : t list -> string
  (**
``to_dot [t0; t1; ...]`` outputs the trace of computation graph in the dot
file format which you can use other tools further visualisation, such as
Graphviz.
   *)

  val pp_num : Format.formatter -> t -> unit
  (** ``pp_num t`` pretty prints the abstract number used in ``Algodiff``. *)


end
