(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module Make (Core : Owl_algodiff_core_sig.Sig) :
  Owl_algodiff_graph_convert_sig.Sig with type t := Core.t
