(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make (A : Owl_types_ndarray_algodiff.Sig) :
  Owl_algodiff_types_sig.Sig with type elt := A.elt and type arr := A.arr
