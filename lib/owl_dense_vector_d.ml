(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module V = Owl_dense_vector_generic
include V

type elt = float

let empty ?typ m = V.empty ?typ Float64 m

let create ?typ m a = V.create ?typ Float64 m a

let zeros ?typ m = V.zeros ?typ Float64 m

let ones ?typ m = V.ones ?typ Float64 m

let uniform ?typ ?scale m = V.uniform ?typ ?scale Float64 m
