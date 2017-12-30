(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module V = Owl_dense_vector_generic
include V

type vec = (Complex.t, complex64_elt) Owl_dense_matrix_generic.t
type elt = Complex.t

let empty ?typ m = V.empty ?typ Complex64 m

let create ?typ m a = V.create ?typ Complex64 m a

let zeros ?typ m = V.zeros ?typ Complex64 m

let ones ?typ m = V.ones ?typ Complex64 m

let gaussian ?typ ?mu ?sigma m = V.gaussian ?typ ?mu ?sigma Complex64 m

let uniform ?typ ?a ?b m = V.uniform ?typ ?a ?b Complex64 m

let sequential ?typ ?a ?step m = V.sequential ?typ ?a ?step Complex64 m

let unit_basis ?typ m i = V.unit_basis ?typ Complex64 m i

let linspace ?typ a b n = V.linspace ?typ Complex64 a b n

let logspace ?typ ?base a b n = V.logspace ?typ ?base Complex64 a b n

let of_array ?typ l = V.of_array Complex64 l
