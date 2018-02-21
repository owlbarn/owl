(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Alias modules of numerical differentiation. *)


(* Optimise module of Float32 type *)
module S = Owl_optimise_generic.Make (Owl_dense_ndarray.S)


(* Optimise module of Float64 type *)
module D = Owl_optimise_generic.Make (Owl_dense_ndarray.D)


(* ends here *)
