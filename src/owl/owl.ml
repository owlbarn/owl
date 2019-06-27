(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

include Owl_types


let version = "%%VERSION%%"

(* So we don't have to open Bigarray all the time. *)

let float32 = Bigarray.float32

let float64 = Bigarray.float64

let complex32 = Bigarray.complex32

let complex64 = Bigarray.complex64


(** Make alias of the modules in Owl for your convenience. *)

module Const = Owl_const

module Exception = Owl_exception

module Dense = Owl_dense

module Sparse = Owl_sparse

module Maths = Owl_maths

module Stats = Owl_stats

module Linalg = Owl_linalg

module Algodiff = Owl_algodiff

module Optimise = Owl_optimise

module Regression = Owl_regression

module Neural = Owl_neural

module Fft = Owl_fft

module Cluster = Owl_cluster

module Utils = Owl_utils

module Ext = Owl_ext

module Dataset = Owl_dataset

module Dataframe = Owl_dataframe

module Lazy = Owl_lazy

module Graph = Owl_graph

module Nlp = Owl_nlp

module Log = Owl_log

module Computation = Owl_computation


(* backend modules *)

module Cblas = Owl_cblas

module Lapacke = Owl_lapacke


(* shortcuts to 64-bit precision modules *)

module Arr = struct
  include Owl_dense.Ndarray.D
end

module Mat = struct
  include Owl_dense.Matrix.D
end
