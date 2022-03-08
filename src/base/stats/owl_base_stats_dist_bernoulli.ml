(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

let bernoulli_rvs ~p =
  assert (p >= 0. && p <= 1.);
  if Random.float 1. <= p then 1. else 0.
