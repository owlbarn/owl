(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module Make (A : Owl_types_ndarray_algodiff.Sig) :
  Owl_algodiff_types_sig.Sig with type elt := A.elt and type arr := A.arr
