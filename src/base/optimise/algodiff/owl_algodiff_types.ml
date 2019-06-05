module Make (A : Owl_types_ndarray_algodiff.Sig) = struct
  module A = A
  type t =
    | F of A.elt
    | Arr of A.arr
    (* primal, tangent, tag *)
    | DF of t * t * int
    (* primal, adjoint, op, fanout, tag, tracker *)
    | DR of t * t ref * (reverse * inputs * label) * int ref * int * int ref

  and reverse = t -> t ref -> (t * t) list -> (t * t) list

  and inputs = t list -> t list

  and label = string * t list
end
 
