module type Sig = sig
  module A : Owl_types_ndarray_algodiff.Sig

  type t =
    | F of A.elt
    | Arr of A.arr
    (* primal, tangent, tag *)
    | DF of t * t * int
    (* primal, adjoint, op, fanout, tag, tracker *)
    | DR of t * t ref * op * int ref * int * int ref

  and adjoint = t -> t ref -> (t * t) list -> (t * t) list

  and register = t list -> t list

  and label = string * t list

  and op = adjoint * register * label
end
