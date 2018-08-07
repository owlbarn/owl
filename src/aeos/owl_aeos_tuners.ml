(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_types


let all = [|
  Sin (Owl_aeos_tuner_sin.make ());
  Cos (Owl_aeos_tuner_cos.make ());
|]
