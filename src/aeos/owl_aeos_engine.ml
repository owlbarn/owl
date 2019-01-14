(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let eval tuners =
  Array.iter Owl_aeos_tuners.tuning tuners
