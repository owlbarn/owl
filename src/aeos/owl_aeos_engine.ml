(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_types


let eval tuners =
  Array.iter (function
    | Sin t -> Owl_aeos_tuner_sin.tune t
    | Cos t -> Owl_aeos_tuner_cos.tune t
  ) tuners
