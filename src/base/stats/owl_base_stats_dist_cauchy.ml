(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_base_stats_dist_gaussian


let std_cauchy_rvs () =
  let a = std_gaussian_rvs () in
  let b = std_gaussian_rvs () in
  a /. b


let cauchy_rvs ~loc ~scale =
  loc +. scale *. (std_cauchy_rvs ())
