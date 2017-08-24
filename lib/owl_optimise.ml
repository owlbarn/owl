(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* FIXME: this module should be removed! *)

module S = Owl_optimise_generic.Make (Owl_dense_matrix.S) (Owl_dense_ndarray.S)

module D = Owl_optimise_generic.Make (Owl_dense_matrix.D) (Owl_dense_ndarray.D)



(* ends here *)
