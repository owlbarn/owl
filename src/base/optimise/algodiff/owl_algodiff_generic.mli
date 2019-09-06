module Make (A : Owl_types_ndarray_algodiff.Sig) :
  Owl_algodiff_generic_sig.Sig with type A.arr = A.arr and type A.elt = A.elt
