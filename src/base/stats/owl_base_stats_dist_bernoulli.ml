(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let bernoulli_rvs ~p =
  assert (p >= 0. && p <= 1.);
  if (Random.float 1.) <= p then 1.
  else 0.
