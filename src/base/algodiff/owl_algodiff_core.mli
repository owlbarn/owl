(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module Make (A : Owl_types_ndarray_algodiff.Sig) :
  Owl_algodiff_core_sig.Sig with type A.arr = A.arr and type A.elt = A.elt
