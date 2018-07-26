(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** AEOS: Automatic Empirical Optimisation of Software *)


let start_tuning fname =
  let tuners = Owl_aeos_tuners.all in
  Owl_aeos_engine.eval tuners;
  Owl_aeos_writer.c_header_file fname tuners
