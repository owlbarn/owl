module Make : functor (Core: Owl_algodiff_core_sig.Sig) -> Owl_algodiff_ops_sig.Sig with type t:= Core.t and type elt := Core.A.elt
