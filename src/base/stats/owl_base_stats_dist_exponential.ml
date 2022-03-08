(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

let std_exponential_rvs () =
  let u = Random.float 1. in
  -.log1p (-.u)


let exponential_rvs ~lambda =
  let u = Random.float 1. in
  let s = -1. /. lambda in
  s *. log1p (-.u)
