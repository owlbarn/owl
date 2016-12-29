(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type ComputableSig = sig

  type ('a, 'b) t

  val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val add_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

  val sub_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

  val mul_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

  val div_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

end


module Make (Computable: ComputableSig) = struct

  type ('a, 'b) t = ('a, 'b) Computable.t

  let ( +@ ) = Computable.add

  let ( -@ ) = Computable.sub

  let ( *@ ) = Computable.mul

  let ( /@ ) = Computable.div

  let ( +$ ) = Computable.add_scalar

  let ( -$ ) = Computable.sub_scalar

  let ( *$ ) = Computable.mul_scalar

  let ( /$ ) = Computable.div_scalar

end
