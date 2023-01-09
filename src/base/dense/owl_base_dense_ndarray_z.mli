(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type elt = Complex.t

type arr = (Complex.t, complex64_elt, c_layout) Genarray.t

include Owl_base_dense_ndarray_intf.Common with type arr := arr and type elt := elt
