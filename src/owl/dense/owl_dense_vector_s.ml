(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module V = Owl_dense_vector_generic
include V

type vec = (float, float32_elt) Owl_dense_matrix_generic.t
type elt = float

let empty ?typ m = V.empty ?typ Float32 m

let create ?typ m a = V.create ?typ Float32 m a

let zeros ?typ m = V.zeros ?typ Float32 m

let ones ?typ m = V.ones ?typ Float32 m

let gaussian ?typ ?mu ?sigma m = V.gaussian ?typ ?mu ?sigma Float32 m

let uniform ?typ ?a ?b m = V.uniform ?typ ?a ?b Float32 m

let sequential ?typ ?a ?step m = V.sequential ?typ ?a ?step Float32 m

let unit_basis ?typ m i = V.unit_basis ?typ Float32 m i

let linspace ?typ a b n = V.linspace ?typ Float32 a b n

let logspace ?typ ?base a b n = V.logspace ?typ ?base Float32 a b n

let of_array ?typ l = V.of_array Float32 l
