(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module Make (Core : Owl_algodiff_core_sig.Sig) :
  Owl_algodiff_ops_builder_sig.Sig
    with type t := Core.t
     and type elt := Core.A.elt
     and type arr := Core.A.arr
     and type op := Core.op
