(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Regression Module ]
  This module implements a set of regression functions. S module provides
  supports for single precision float numbers whilst D module provides supports
  for double precision float numbers.
*)


module S = Owl_regression_generic.Make (Owl_dense_matrix.S) (Owl_dense_ndarray.S)

module D = Owl_regression_generic.Make (Owl_dense_matrix.D) (Owl_dense_ndarray.D)



(* ends here *)
