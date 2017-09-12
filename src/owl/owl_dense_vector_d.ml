(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module V = Owl_dense_vector_generic
include V

type vec = (float, float64_elt) Owl_dense_matrix_generic.t
type elt = float

let empty ?typ m = V.empty ?typ Float64 m

let create ?typ m a = V.create ?typ Float64 m a

let zeros ?typ m = V.zeros ?typ Float64 m

let ones ?typ m = V.ones ?typ Float64 m

let gaussian ?typ ?sigma m = V.gaussian ?typ ?sigma Float64 m

let uniform ?typ ?scale m = V.uniform ?typ ?scale Float64 m

let sequential ?typ ?a ?step m = V.sequential ?typ ?a ?step Float64 m

let unit_basis ?typ m i = V.unit_basis ?typ Float64 m i

let linspace ?typ a b n = V.linspace ?typ Float64 a b n

let logspace ?typ ?base a b n = V.logspace ?typ ?base Float64 a b n

let of_array ?typ l = V.of_array Float64 l
