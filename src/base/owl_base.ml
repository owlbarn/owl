(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module Const = Owl_const


module Maths = Owl_base_maths


module Stats = Owl_base_stats


module Complex = Owl_base_complex


module Quadrature = Owl_maths_quadrature


module Root = Owl_maths_root


module Graph = Owl_graph


module Lazy = Owl_lazy


module View = Owl_view


module Log = Owl_log


module Utils = Owl_utils


module Computation = Owl_computation


(* initialise base library *)
let _ = Owl_base_stats_prng.self_init ()
