(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* define the functions need to be implemented *)

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

end


module type MatrixSig = sig

  type ('a, 'b) t

  val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

end


(* define basic operators *)

module Make_Basic (M : BasicSig) = struct

  type ('a, 'b) op_t0 = ('a, 'b) M.t

  let ( + ) = M.add

  let ( - ) = M.sub

  let ( * ) = M.mul

  let ( / ) = M.div

  let ( +$ ) = M.add_scalar

  let ( -$ ) = M.sub_scalar

  let ( *$ ) = M.mul_scalar

  let ( /$ ) = M.div_scalar

  let ( $+ ) = M.scalar_add

  let ( $- ) = M.scalar_sub

  let ( $* ) = M.scalar_mul

  let ( $/ ) = M.scalar_div

  let ( = ) = M.equal

  let ( != ) = M.not_equal

  let ( <> ) = M.not_equal

  let ( > ) = M.greater

  let ( < ) = M.less

  let ( >= ) = M.greater_equal

  let ( <= ) = M.less_equal

end



module Make_Extend (M : ExtendSig) = struct

  type ('a, 'b) op_t1 = ('a, 'b) M.t

  let ( =$ ) = M.equal_scalar

  let ( !=$ ) = M.not_equal_scalar

  let ( <>$ ) = M.not_equal_scalar

  let ( <$ ) = M.less_scalar

  let ( >$ ) = M.greater_scalar

  let ( <=$ ) = M.less_equal_scalar

  let ( >=$ ) = M.greater_equal_scalar

  let ( =. ) = M.elt_equal

  let ( !=. ) = M.elt_not_equal

  let ( <>. ) = M.elt_not_equal

  let ( <. ) = M.elt_less

  let ( >. ) = M.elt_greater

  let ( <=. ) = M.elt_less_equal

  let ( >=. ) = M.elt_greater_equal

  let ( =.$ ) = M.elt_equal_scalar

  let ( !=.$ ) = M.elt_not_equal_scalar

  let ( <>.$ ) = M.elt_not_equal_scalar

  let ( <.$ ) = M.elt_less_scalar

  let ( >.$ ) = M.elt_greater_scalar

  let ( <=.$ ) = M.elt_less_equal_scalar

  let ( >=.$ ) = M.elt_greater_equal_scalar

  let ( % ) = M.fmod

  let ( %$ ) = M.fmod_scalar

  let ( ** ) = M.pow

  let ( $** ) = M.scalar_pow

  let ( **$ ) = M.pow_scalar

end


module Make_Matrix (M : MatrixSig) = struct

  type ('a, 'b) op_t2 = ('a, 'b) M.t

  let ( *@ ) = M.dot

end


(* ends here *)
