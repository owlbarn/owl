(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let gumbel2_rvs ~a ~b =
  let x = Random.float 1. in
  ((-.b) /. log x) ** (1. /. a)
