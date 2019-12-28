(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Complex dense matrix module: this module supports operations on dense
  matrices of complex numbers. The complex number has a record type of
  [{re = float; im = float}].

  This page only contains detailed explanations for the operations specific to
  Dense.Complex module. Most of the other operations are the same to those in
  Dense.Real module, therefore please refer to the documentation of Dense.Real
  for more information.
 *)

open Bigarray

type elt = Complex.t

type mat = (Complex.t, complex32_elt) Owl_dense_matrix_generic.t

type cast_mat = (float, float32_elt) Owl_dense_matrix_generic.t

include Owl_dense_matrix_intf.Common with type elt := elt and type mat := mat

include Owl_dense_matrix_intf.Complex with type mat := mat and type cast_mat := cast_mat
