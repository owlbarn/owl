(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Sig = sig
  include Owl_algodiff_core_sig.Sig

  val make_forward : t -> t -> int -> t
  (** TODO *)

  val make_reverse : t -> int -> t
  (** TODO *)

  val reverse_prop : t -> t -> unit
  (** TODO *)

  val diff : (t -> t) -> t -> t
  (** ``diff f x`` returns the exat derivative of a function ``f : scalar -> scalar`` at
      point ``x``. Simply calling ``diff f`` will return its derivative function ``g`` of
      the same type, i.e. ``g : scalar -> scalar``.

      Keep calling this function will give you higher-order derivatives of ``f``, i.e.
      ``f |> diff |> diff |> diff |> ...`` *)

  val diff' : (t -> t) -> t -> t * t
  (** similar to ``diff``, but return ``(f x, diff f x)``. *)

  val grad : (t -> t) -> t -> t
  (** gradient of ``f`` : (vector -> scalar) at ``x``, reverse ad. *)

  val grad' : (t -> t) -> t -> t * t
  (** similar to ``grad``, but return ``(f x, grad f x)``. *)

  val jacobian : (t -> t) -> t -> t
  (** jacobian of ``f`` : (vector -> vector) at ``x``, both ``x`` and ``y`` are row
      vectors. *)

  val jacobian' : (t -> t) -> t -> t * t
  (** similar to ``jacobian``, but return ``(f x, jacobian f x)`` *)

  val jacobianv : (t -> t) -> t -> t -> t
  (** jacobian vector product of ``f`` : (vector -> vector) at ``x`` along ``v``, forward
      ad. Namely, it calcultes ``(jacobian x) v`` *)

  val jacobianv' : (t -> t) -> t -> t -> t * t
  (** similar to ``jacobianv'``, but return ``(f x, jacobianv f x v)`` *)

  val jacobianTv : (t -> t) -> t -> t -> t
  (** transposed jacobian vector product of ``f : (vector -> vector)`` at ``x`` along
      ``v``, backward ad. Namely, it calculates ``transpose ((jacobianv f x v))``. *)

  val jacobianTv' : (t -> t) -> t -> t -> t * t
  (** similar to ``jacobianTv``, but return ``(f x, transpose (jacobianv f x v))`` *)

  val hessian : (t -> t) -> t -> t
  (** hessian of ``f`` : (scalar -> scalar) at ``x``. *)

  val hessian' : (t -> t) -> t -> t * t
  (** simiarl to ``hessian``, but return ``(f x, hessian f x)`` *)

  val hessianv : (t -> t) -> t -> t -> t
  (** hessian vector product of ``f`` : (scalar -> scalar) at ``x`` along ``v``. Namely,
      it calculates ``(hessian x) v``. *)

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

  (* Operations *)
  include
    Owl_algodiff_ops_sig.Sig
      with type t := t
       and type elt := A.elt
       and type arr := A.arr
       and type op := op

  (** {6 Helper functions} *)

  include Owl_algodiff_graph_convert_sig.Sig with type t := t
end
