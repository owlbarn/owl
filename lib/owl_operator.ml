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

  val pow : (float, 'a) t -> (float, 'a) t -> (float, 'a) t

  val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

  val add_scalar0 : 'a -> ('a, 'b) t -> ('a, 'b) t

  val sub_scalar0 : 'a -> ('a, 'b) t -> ('a, 'b) t

  val mul_scalar0 : 'a -> ('a, 'b) t -> ('a, 'b) t

  val div_scalar0 : 'a -> ('a, 'b) t -> ('a, 'b) t

  val equal : ('a, 'b) t -> ('a, 'b) t -> bool

  val not_equal : ('a, 'b) t -> ('a, 'b) t -> bool

  val greater : ('a, 'b) t -> ('a, 'b) t -> bool

  val less : ('a, 'b) t -> ('a, 'b) t -> bool

  val greater_equal : ('a, 'b) t -> ('a, 'b) t -> bool

  val less_equal : ('a, 'b) t -> ('a, 'b) t -> bool

end


module type ExtSig = sig

  type ('a, 'b) t

  val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

end

(* define basic operators *)

module Make_Basic (M : BasicSig) = struct

  type ('a, 'b) t = ('a, 'b) M.t

  let ( + ) = M.add

  let ( - ) = M.sub

  let ( * ) = M.mul

  let ( / ) = M.div

  let ( ** ) = M.pow

  let ( +$ ) = M.add_scalar

  let ( -$ ) = M.sub_scalar

  let ( *$ ) = M.mul_scalar

  let ( /$ ) = M.div_scalar

  let ( $+ ) = M.add_scalar0

  let ( $- ) = M.sub_scalar0

  let ( $* ) = M.mul_scalar0

  let ( $/ ) = M.div_scalar0

  let ( = ) = M.equal

  let ( <> ) = M.not_equal

  let ( > ) = M.greater

  let ( < ) = M.less

  let ( >= ) = M.greater_equal

  let ( <= ) = M.less_equal

end



module Make_Ext (M : ExtSig) = struct

  type ('a, 'b) ext_t = ('a, 'b) M.t

  let ( *@ ) = M.dot

end


(* ends here *)
