(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* So we don't have to open Bigarray all the time. *)

let float32 = Bigarray.float32

let float64 = Bigarray.float64

let complex32 = Bigarray.complex32

let complex64 = Bigarray.complex64


(** Make alias of the modules in Owl for your convenience. *)

module Const = Owl_const

module Dense = Owl_dense

module Sparse = Owl_sparse

module Maths = Owl_maths

module Stats = Owl_stats

module Linalg = Owl_linalg

module Regression = Owl_regression

module Plot = Owl_plot

module Fft = Owl_fft

module Cluster = Owl_cluster

module Algodiff = Owl_algodiff

module Utils = Owl_utils

module Ext = Owl_ext

module Neural = Owl_neural

module Dataset = Owl_dataset


(* backend modules *)

module Cblas = Owl_cblas


(* shortcuts to 64-bit precision modules *)

module Arr = Owl_dense_ndarray.D

module Mat = Owl_dense_matrix.D

module Vec = Owl_dense_vector.D


(* set up owl's folder *)

let _ =
  let home = Sys.getenv "HOME" ^ "/.owl" in
  let dir_dataset = home ^ "/dataset" in
  let dir_zoo = home ^ "/zoo" in
  if Sys.file_exists home = false then
    Unix.mkdir home 0o755;
  if Sys.file_exists dir_dataset = false then
    Unix.mkdir dir_dataset 0o755;
  if Sys.file_exists dir_zoo = false then
    Unix.mkdir dir_zoo 0o755



(* ends here *)
