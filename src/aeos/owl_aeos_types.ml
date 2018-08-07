(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type tunner =
  | Sin of Owl_aeos_tuner_sin.t
  | Cos of Owl_aeos_tuner_cos.t
