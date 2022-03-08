(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_base_stats_dist_gaussian

let std_cauchy_rvs () =
  let a = std_gaussian_rvs () in
  let b = std_gaussian_rvs () in
  a /. b


let cauchy_rvs ~loc ~scale = loc +. (scale *. std_cauchy_rvs ())
