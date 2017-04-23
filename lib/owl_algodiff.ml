(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Algorithmic differentiation *)

(* Alias of modules of algorithmic differentiation. *)

module S = Owl_algodiff_generic.Make (Owl_dense_matrix_s)

module D = Owl_algodiff_generic.Make (Owl_dense_matrix_d)

module Numerical = Owl_algodiff_numerical
