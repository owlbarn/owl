(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let () =
  let prefix = "owl_aeos_params_generated" in
  let fname_tune = prefix ^ ".h" in
  let fname_default = prefix ^ ".h" in
  let enable_openmp = Sys.getenv "ENABLE_OPENMP" in
  if enable_openmp = "0" then (
    Owl_aeos.tune_default fname_default
  ) else Owl_aeos.tune_all fname_tune
