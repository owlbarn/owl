(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Sig = sig
  module A : Owl_types_ndarray_algodiff.Sig

  (** {6 Type definition} *)

  include Owl_algodiff_types_sig.Sig with type elt := A.elt and type arr := A.arr

  (** Abstract number type *)

  (** {6 Supported Maths functions} *)

  include Owl_algodiff_ops_sig.Sig with type t := t and type elt := A.elt
 
  (** {6 Core functions} *)

  (** ``diff f x`` returns the exat derivative of a function ``f : scalar -> scalar`` at
      point ``x``. Simply calling ``diff f`` will return its derivative function ``g`` of
      the same type, i.e. ``g : scalar -> scalar``.

      Keep calling this function will give you higher-order derivatives of ``f``, i.e.
      ``f |> diff |> diff |> diff |> ...`` *)
  val diff : (t -> t) -> t -> t

  (** similar to ``diff``, but return ``(f x, diff f x)``. *)
  val diff' : (t -> t) -> t -> t * t

  (** gradient of ``f`` : (vector -> scalar) at ``x``, reverse ad. *)
  val grad : (t -> t) -> t -> t

  (** similar to ``grad``, but return ``(f x, grad f x)``. *)
  val grad' : (t -> t) -> t -> t * t

  (** jacobian of ``f`` : (vector -> vector) at ``x``, both ``x`` and ``y`` are row
      vectors. *)
  val jacobian : (t -> t) -> t -> t

  (** similar to ``jacobian``, but return ``(f x, jacobian f x)`` *)
  val jacobian' : (t -> t) -> t -> t * t

  (** jacobian vector product of ``f`` : (vector -> vector) at ``x`` along ``v``, forward
      ad. Namely, it calcultes ``(jacobian x) v`` *)
  val jacobianv : (t -> t) -> t -> t -> t

  (** similar to ``jacobianv'``, but return ``(f x, jacobianv f x v)`` *)
  val jacobianv' : (t -> t) -> t -> t -> t * t

  (** transposed jacobian vector product of ``f : (vector -> vector)`` at ``x`` along
      ``v``, backward ad. Namely, it calculates ``transpose ((jacobianv f x v))``. *)
  val jacobianTv : (t -> t) -> t -> t -> t

  (** similar to ``jacobianTv``, but return ``(f x, transpose (jacobianv f x v))`` *)
  val jacobianTv' : (t -> t) -> t -> t -> t * t

  (** hessian of ``f`` : (scalar -> scalar) at ``x``. *)
  val hessian : (t -> t) -> t -> t

  (** simiarl to ``hessian``, but return ``(f x, hessian f x)`` *)
  val hessian' : (t -> t) -> t -> t * t

  (** hessian vector product of ``f`` : (scalar -> scalar) at ``x`` along ``v``. Namely,
      it calculates ``(hessian x) v``. *)
  val hessianv : (t -> t) -> t -> t -> t

  (** similar to ``hessianv``, but return ``(f x, hessianv f x v)``. *)
  val hessianv' : (t -> t) -> t -> t -> t * t

  (** laplacian of ``f : (scalar -> scalar)`` at ``x``. *)
  val laplacian : (t -> t) -> t -> t

  (** simiar to ``laplacian``, but return ``(f x, laplacian f x)``. *)
  val laplacian' : (t -> t) -> t -> t * t

  (** return ``(grad f x, hessian f x)``, ``f : (scalar -> scalar)`` *)
  val gradhessian : (t -> t) -> t -> t * t

  (** return ``(f x, grad f x, hessian f x)`` *)
  val gradhessian' : (t -> t) -> t -> t * t * t

  (** return ``(grad f x v, hessian f x v)`` *)
  val gradhessianv : (t -> t) -> t -> t -> t * t

  (** return ``(f x, grad f x v, hessian f x v)`` *)
  val gradhessianv' : (t -> t) -> t -> t -> t * t * t

  (** {6 Low-level functions} *)

  (* low-level functions, only use them if you know what you are doing. *)

  (** convert from ``elt`` type to ``t`` type. *)
  val pack_elt : A.elt -> t

  (** convert from ``t`` type to ``elt`` type. *)
  val unpack_elt : t -> A.elt

  (** convert from ``float`` type to ``t`` type. *)
  val pack_flt : float -> t

  (** convert from ``t`` type to ``float`` type. *)
  val unpack_flt : t -> float

  (** convert from ``arr`` type to ``t`` type. *)
  val pack_arr : A.arr -> t

  (** convert from ``t`` type to ``arr`` type. *)
  val unpack_arr : t -> A.arr

  (** TODO *)
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

  (** A shortcut function for ``F A.(float_to_elt x)``. *)
  val _f : float -> t

  (** other functions, without tracking gradient *)
  val clip_by_value : amin:A.elt -> amax:A.elt -> t -> t

  (** other functions, without tracking gradient *)
  val clip_by_l2norm : A.elt -> t -> t

  (** {6 Helper functions} *)

  (** ``to_trace [t0; t1; ...]`` outputs the trace of computation graph on the terminal
      in a human-readable format. *)
  val to_trace : t list -> string

  (** ``to_dot [t0; t1; ...]`` outputs the trace of computation graph in the dot file
      format which you can use other tools further visualisation, such as Graphviz. *)
  val to_dot : t list -> string

  (** ``pp_num t`` pretty prints the abstract number used in ``Algodiff``. *)
  val pp_num : Format.formatter -> t -> unit
    [@@ocaml.toplevel_printer]
end
