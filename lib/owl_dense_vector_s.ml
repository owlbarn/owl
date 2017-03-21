(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module V = Owl_dense_vector_generic
include V

type vec = (float, float32_elt) Owl_dense_matrix.t
type elt = float

let empty ?typ m = V.empty ?typ Float32 m

let create ?typ m a = V.create ?typ Float32 m a

let zeros ?typ m = V.zeros ?typ Float32 m

let ones ?typ m = V.ones ?typ Float32 m

let uniform ?typ ?scale m = V.uniform ?typ ?scale Float32 m

let sequential ?typ m = V.sequential ?typ Float32 m

let unit_basis ?typ m i = V.unit_basis ?typ Float32 m i

let linspace ?typ a b n = V.linspace ?typ Float32 a b n

let logspace ?typ ?base a b n = V.logspace ?typ ?base Float32 a b n
