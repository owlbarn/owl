(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(* Alias modules of algorithmic differentiation. *)

(* AD module of Float32 type *)
module S = Owl_algodiff_generic.Make (Owl_algodiff_primal_ops.S)

(* AD module of Float64 type *)
module D = Owl_algodiff_generic.Make (Owl_algodiff_primal_ops.D)
