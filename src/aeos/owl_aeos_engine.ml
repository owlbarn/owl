(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(*
let eval tuners =
  Array.iter (function
    | Sin t -> Owl_aeos_tuner_sin.tuning t
  ) tuners
*)

let eval tuners =
  Array.iter Owl_aeos_tuners.tuning tuners
