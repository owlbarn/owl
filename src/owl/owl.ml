(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
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

module Dense = Owl_dense

module Sparse = Owl_sparse

module Maths = Owl_maths

module Stats = Owl_stats

module Linalg = Owl_linalg

module Algodiff = Owl_algodiff

module Optimise = Owl_optimise

module Regression = Owl_regression

module Neural = Owl_neural

module Plot = Owl_plot

module Fft = Owl_fft

module Cluster = Owl_cluster

module Utils = Owl_utils

module Ext = Owl_ext

module Dataset = Owl_dataset

module Lazy = Owl_lazy

module Graph = Owl_graph

module Common = Owl_common


(* backend modules *)

module Cblas = Owl_cblas


(* shortcuts to 64-bit precision modules *)

module Arr = struct
  include Owl_dense.Ndarray.D
end

module Mat = struct
  include Owl_dense.Matrix.D
end

module Vec = struct
  include Owl_dense.Vector.D
end


(* initialise owl's working environment *)

let _ =
  (* FIXME: need to unify with the Stats module in the future *)
  Random.State.make_self_init () |> ignore;
  (* init the internal state of PRNG *)
  Owl_common.PRNG.init ();
  (* set up owl's folder *)
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
