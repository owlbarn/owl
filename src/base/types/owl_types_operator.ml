(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(**
Operator definitions such as add, sub, mul, and div.
This signature defines the functions need to be implemented.
*)


module type BasicSig = sig

  type ('a, 'b) t

  val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t

  val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t

  val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t

  val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t

  val equal : ('a, 'b) t -> ('a, 'b) t -> bool

  val not_equal : ('a, 'b) t -> ('a, 'b) t -> bool

  val greater : ('a, 'b) t -> ('a, 'b) t -> bool

  val less : ('a, 'b) t -> ('a, 'b) t -> bool

  val greater_equal : ('a, 'b) t -> ('a, 'b) t -> bool

  val less_equal : ('a, 'b) t -> ('a, 'b) t -> bool

end


module type ExtendSig = sig

  type ('a, 'b) t

  val equal_scalar : ('a, 'b) t -> 'a -> bool

  val not_equal_scalar : ('a, 'b) t -> 'a -> bool

  val less_scalar : ('a, 'b) t -> 'a -> bool

  val greater_scalar : ('a, 'b) t -> 'a -> bool

  val less_equal_scalar : ('a, 'b) t -> 'a -> bool

  val greater_equal_scalar : ('a, 'b) t -> 'a -> bool

  val elt_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val elt_not_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val elt_less : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val elt_greater : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val elt_less_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val elt_greater_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val elt_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val elt_not_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val elt_less_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val elt_greater_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val elt_less_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val elt_greater_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val fmod : (float, 'a) t -> (float, 'a) t -> (float, 'a) t

  val fmod_scalar : (float, 'a) t -> float -> (float, 'a) t

  val pow : (float, 'a) t -> (float, 'a) t -> (float, 'a) t

  val scalar_pow : float -> (float, 'a) t -> (float, 'a) t

  val pow_scalar : (float, 'a) t -> float -> (float, 'a) t

  val approx_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> bool

  val approx_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> bool

  val approx_elt_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val approx_elt_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> ('a, 'b) t

  val add_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit

  val sub_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit

  val mul_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit

  val div_ : ?out:('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t -> unit

  val add_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit

  val sub_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit

  val mul_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit

  val div_scalar_ : ?out:('a, 'b) t -> ('a, 'b) t -> 'a -> unit

  val concat_vertical : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val concat_horizontal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val get_fancy : Owl_types.index list -> ('a, 'b) t -> ('a, 'b) t

  val set_fancy : Owl_types.index list -> ('a, 'b) t -> ('a, 'b) t -> unit

  val get_slice : int list list -> ('a, 'b) t -> ('a, 'b) t

  val set_slice : int list list -> ('a, 'b) t -> ('a, 'b) t -> unit

end


module type MatrixSig = sig

  type ('a, 'b) t

  val get : ('a, 'b) t -> int -> int -> 'a

  val set : ('a, 'b) t -> int -> int -> 'a -> unit

  val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

end


module type NdarraySig = sig

  type ('a, 'b) t

  val get : ('a, 'b) t -> int array -> 'a

  val set : ('a, 'b) t -> int array -> 'a -> unit

end


module type LinalgSig = sig

  type ('a, 'b) t

  val mpow : ('a, 'b) t -> float -> ('a, 'b) t

  val linsolve : ?trans:bool -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

end


(* ends here *)
