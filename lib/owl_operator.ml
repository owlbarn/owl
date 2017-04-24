(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* define the functions need to be implemented *)

module type Computable = sig

  type mat

  type elt

  val add : mat -> mat -> mat

  val sub : mat -> mat -> mat

  val mul : mat -> mat -> mat

  val div : mat -> mat -> mat

(*
  val elt_mul : mat -> mat -> t

  val elt_div : mat -> mat -> t
*)

  val add_scalar : mat -> elt -> mat

  val sub_scalar : mat -> elt -> mat

  val mul_scalar : mat -> elt -> mat

  val div_scalar : mat -> elt -> mat

  val equal : mat -> mat -> bool

  val not_equal : mat -> mat -> bool

  val greater : mat -> mat -> bool

  val less : mat -> mat -> bool

  val greater_equal : mat -> mat -> bool

  val less_equal : mat -> mat -> bool

  val elt_equal : mat -> mat -> (float, float32_elt) Owl_dense_matrix_generic.t

  val elt_not_equal : mat -> mat -> (float, float32_elt) Owl_dense_matrix_generic.t

  val elt_greater : mat -> mat -> (float, float32_elt) Owl_dense_matrix_generic.t

  val elt_less : mat -> mat -> (float, float32_elt) Owl_dense_matrix_generic.t

  val elt_greater_equal : mat -> mat -> (float, float32_elt) Owl_dense_matrix_generic.t

  val elt_less_equal : mat -> mat -> (float, float32_elt) Owl_dense_matrix_generic.t

end


(* define the operators *)

module Make (C : Computable) = struct

  type mat = C.mat

  type elt = C.elt

  let ( + ) = C.add

  let ( - ) = C.sub

  let ( * ) = C.mul

  let ( / ) = C.div

  let ( +$ ) = C.add_scalar

  let ( -$ ) = C.sub_scalar

  let ( *$ ) = C.mul_scalar

  let ( /$ ) = C.div_scalar

  let ( = ) = C.equal

  let ( <> ) = C.not_equal

  let ( > ) = C.greater

  let ( < ) = C.less

  let ( >= ) = C.greater_equal

  let ( <= ) = C.less_equal

  let ( =. ) = C.elt_equal

  let ( <>. ) = C.elt_not_equal

  let ( >. ) = C.elt_greater

  let ( <. ) = C.elt_less

  let ( >=. ) = C.elt_greater_equal

  let ( <=. ) = C.elt_less_equal

end


(* ends here *)
