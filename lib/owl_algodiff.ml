(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Algorithmic & numerical differentiation *)

(* Alias modules of algorithmic differentiation. *)


(* AD module of Float32 type *)
module S = Owl_algodiff_generic.Make (Owl_dense_matrix_s) (Owl_dense_ndarray_s)


(* AD module of Float64 type *)
module D = Owl_algodiff_generic.Make (Owl_dense_matrix_d) (Owl_dense_ndarray_d)


(* Numerical differentiation *)
module Numerical = Owl_algodiff_numerical
