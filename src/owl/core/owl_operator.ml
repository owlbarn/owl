(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Operator definition such add, sub, mul, and div. *)


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

  val approx_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> bool

  val approx_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> bool

  val approx_elt_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val approx_elt_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> ('a, 'b) t

  val add_ : ('a, 'b) t -> ('a, 'b) t -> unit

  val sub_ : ('a, 'b) t -> ('a, 'b) t -> unit

  val mul_ : ('a, 'b) t -> ('a, 'b) t -> unit

  val div_ : ('a, 'b) t -> ('a, 'b) t -> unit

  val add_scalar_ : ('a, 'b) t -> 'a -> unit

  val sub_scalar_ : ('a, 'b) t -> 'a -> unit

  val mul_scalar_ : ('a, 'b) t -> 'a -> unit

  val div_scalar_ : ('a, 'b) t -> 'a -> unit

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

  val concat_vertical : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

  val concat_horizontal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

end


module type NdarraySig = sig

  type ('a, 'b) t

  val get : ('a, 'b) t -> int array -> 'a

  val set : ('a, 'b) t -> int array -> 'a -> unit

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

  let ( =~ ) = M.approx_equal

  let ( =~$ ) = M.approx_equal_scalar

  let ( =~. ) = M.approx_elt_equal

  let ( =~.$ ) = M.approx_elt_equal_scalar

  let ( % ) = M.fmod

  let ( %$ ) = M.fmod_scalar

  let ( ** ) = M.pow

  let ( $** ) = M.scalar_pow

  let ( **$ ) = M.pow_scalar

  let ( += ) = M.add_

  let ( -= ) = M.sub_

  let ( *= ) = M.mul_

  let ( /= ) = M.div_

  let ( +$= ) = M.add_scalar_

  let ( -$= ) = M.sub_scalar_

  let ( *$= ) = M.mul_scalar_

  let ( /$= ) = M.div_scalar_

  let ( .!{ } ) x s = M.get_fancy s x

  let ( .!{ }<- ) x s = M.set_fancy s x

  let ( .${ } ) x s = M.get_slice s x

  let ( .${ }<- ) x s = M.set_slice s x

end


module Make_Matrix (M : MatrixSig) = struct

  type ('a, 'b) op_t2 = ('a, 'b) M.t

  let ( *@ ) = M.dot

  let ( @= ) = M.concat_vertical

  let ( @|| ) = M.concat_horizontal

  let ( .%{ } ) x i = M.get x i.(0) i.(1)

  let ( .%{ }<- ) x i = M.set x i.(0) i.(1)

end


module Make_Ndarray (M : NdarraySig) = struct

  type ('a, 'b) op_t3 = ('a, 'b) M.t

  let ( .%{ } ) x i = M.get x i

  let ( .%{ }<- ) x i = M.set x i

end


(* ends here *)
