module Make (Core : Owl_algodiff_core_sig.Sig) :
  Owl_algodiff_ops_builder_sig.Sig
    with type t := Core.t
     and type elt := Core.A.elt
     and type arr := Core.A.arr
     and type op := Core.op
