module Make (A : Owl_types_ndarray_algodiff.Sig) :
  Owl_algodiff_core_sig.Sig with type A.arr = A.arr and type A.elt = A.elt
