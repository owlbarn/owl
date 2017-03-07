(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Algorithmic differentiation
  Currently, only Forward mode is implemented. Backward mode will be
  implemented in the future.
 *)

(* Alias of modules of algorithmic differentiation. *)

module AD = Owl_algodiff_ad

module Numerical = Owl_algodiff_numerical
