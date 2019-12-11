(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type elt = Complex.t

type arr = (Complex.t, complex64_elt, c_layout) Genarray.t

include Owl_base_dense_ndarray_intf.Common with type arr := arr and type elt := elt
