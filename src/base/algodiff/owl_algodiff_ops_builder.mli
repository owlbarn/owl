(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make (Core : Owl_algodiff_core_sig.Sig) :
  Owl_algodiff_ops_builder_sig.Sig
    with type t := Core.t
     and type elt := Core.A.elt
     and type arr := Core.A.arr
     and type op := Core.op
