(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let gumbel1_rvs ~a ~b =
  let x = Random.float 1. in
  ((log b) -. (log (-.(log x)))) /. a
